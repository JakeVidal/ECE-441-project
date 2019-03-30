-- CORDIC loop controller
-- Written by Alexander Cote

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CORDIC is
    port (
           ----------------------INPUTS-----------------------------------------------
           in_clock                        : in STD_LOGIC;
           in_reset                        : in STD_LOGIC;
           in_x_initial                    : in SIGNED ( 15 downto 0 );
           in_y_initial                    : in SIGNED ( 15 downto 0 );
           in_z_initial                    : in SIGNED ( 15 downto 0 );
           in_cordic_mode                  : in STD_LOGIC;
           in_start                        : in STD_LOGIC;
           
           ----------------------OUTPUTS----------------------------------------------                                
           out_x_result                    : out SIGNED   ( 15 downto 0 )  := (others => '0');
           out_y_result                    : out SIGNED   ( 15 downto 0 )  := (others => '0');
           out_z_result                    : out SIGNED   ( 15 downto 0 )  := (others => '0');
           out_iteration                   : out UNSIGNED (  3 downto 0 )  := (others => '0');
           out_mu                          : out STD_LOGIC                 := '0';
           out_iteration_complete          : out STD_LOGIC                 := '0'
        );
end CORDIC;
    
architecture behaviour of CORDIC is
    
    -- Xilinx IP ROM module used to store theta values
    component Theta_LUT_dist_mem_gen is
        port (
            a                              : in  STD_LOGIC_VECTOR (  3 downto 0 );     -- Input address
            spo                            : out STD_LOGIC_VECTOR ( 15 downto 0 )      -- Output value
        );
    end component;
    
    ----------------------CURRENT ITERATION SIGNALS-----------------------------------
    signal iteration                       : UNSIGNED (  3 downto 0 )      := (others => '0'); 
    signal x_current                       : SIGNED ( 15 downto 0 )        := (others => '0');
    signal y_current                       : SIGNED ( 15 downto 0 )        := (others => '0');
    signal z_current                       : SIGNED ( 15 downto 0 )        := (others => '0');
    
    -------------------------ALU INTERFACE SIGNALS------------------------------------
    signal alu_x_input                     : SIGNED ( 15 downto 0 )        := (others => '0');
    signal alu_y_input                     : SIGNED ( 15 downto 0 )        := (others => '0');
    signal alu_z_input                     : SIGNED ( 15 downto 0 )        := (others => '0');
    signal theta                           : SIGNED ( 15 downto 0 )        := (others => '0');
    signal alu_mu                          : STD_LOGIC                     := '0';
    
    ----------------------------INTERNAL STATE--------------------------------------
    type state_type is (mode_idle, mode_calculate, mode_output, mode_completed);
    signal state : state_type := mode_idle;
    
begin
    
    --------------------------------MEMORY PORT MAPS----------------------------------
    theta_LUT: Theta_LUT_dist_mem_gen port map (a => STD_LOGIC_VECTOR(iteration), signed(spo) => theta);    
    -- Assign iteration as address and theta to the output of the ROM 
    
    cordic_control: process (in_clock, in_reset) is
    begin
        -- Reset State, return everything to 0.
        if (in_reset = '1') then
            state <= mode_idle; 
            x_current              <= (others => '0'); 
            y_current              <= (others => '0'); 
            z_current              <= (others => '0');
            alu_x_input            <= (others => '0');
            alu_y_input            <= (others => '0');
            alu_z_input            <= (others => '0');
            out_x_result           <= (others => '0'); 
            out_y_result           <= (others => '0'); 
            out_z_result           <= (others => '0'); 
            alu_mu                 <= '0';
            out_mu                 <= '0';
            out_iteration_complete <= '0';    
            iteration              <= (others => '0');          
            out_iteration          <= (others => '0');   
        --end if;
        
        else
            if rising_edge(in_clock) then
                case state is
                    -- mode_idle: nothing happening, waiting for start signal
                    when mode_idle =>
                        if (in_start ='1') then
                            -- set the iteration value to 0
                            iteration     <= "0000"; 
                            out_iteration <= "0000"; 
                            
                            -- load in the initial X, Y, and Z data input the ALU
                            alu_x_input <= in_x_initial; 
                            alu_y_input <= in_y_initial; 
                            alu_z_input <= in_z_initial; 
                            
                            -- feed through the initial X,Y,Z data to the output                            
                            out_x_result  <= in_x_initial; 
                            out_y_result  <= in_y_initial; 
                            out_z_result  <= in_z_initial;   
                            
                            -- Notify the output driver that the iteration 0 data (initial data) is ready for storage
                            out_iteration_complete <= '1'; 
                            
                            -- Calculate the value of MU for the next iteration
                            if(in_cordic_mode = '0') then    -- CORDIC mode is 0 - vectoring
                                -- extract the signed bit to know the direction of rotation
                                alu_mu <= in_z_initial(15); 
                                -- provide the value of mu outputed from CORDIC for debugging/testbench purposes   
                                out_mu <= in_z_initial(15);     
                            else                             -- CORDIC mode is 1 - rotation
                                -- extract the signed bit to know the direction of rotation
                                alu_mu <= not(in_y_initial(15));  
                                -- provide the value of mu outputed from CORDIC for debugging/testbench purposes
                                out_mu <= not(in_y_initial(15));  
                            end if; -- end if (in_cordic_mode = '0')
                            
                            -- set the state to calculate - perform ALU calculation
                            state <= mode_calculate;
                        else -- Zero out the registers to ensure low power usage
                            x_current              <= (others => '0'); 
                            y_current              <= (others => '0'); 
                            z_current              <= (others => '0');
                            alu_x_input            <= (others => '0');
                            alu_y_input            <= (others => '0');
                            alu_z_input            <= (others => '0');
                            out_x_result           <= (others => '0'); 
                            out_y_result           <= (others => '0'); 
                            out_z_result           <= (others => '0'); 
                            alu_mu                 <= '0';
                            out_mu                 <= '0';
                            out_iteration_complete <= '0';    
                            iteration              <= (others => '0');          
                            out_iteration          <= (others => '0');           
                        end if;
                        
                        
                    -- mode_calculate: gets the new alu values, calculate the next set of X, Y, and Z.
                    when mode_calculate =>
                        -- Disable the notification for the output driver that data is ready
                        out_iteration_complete <= '0';                                                                               
                        
                        -- Perform ALU calculations depending on value of MU. If statement is cheaper than a multiplication.
                        if(alu_mu = '0') then
                            x_current <= alu_x_input - shift_right(alu_y_input, to_integer(iteration));
                            y_current <= alu_y_input + shift_right(alu_x_input, to_integer(iteration));
                            z_current <= alu_z_input - theta;
                        else 
                            x_current <= alu_x_input + shift_right(alu_y_input, to_integer(iteration));
                            y_current <= alu_y_input - shift_right(alu_x_input, to_integer(iteration));
                            z_current <= alu_z_input + theta;
                        end if;
                        
                        -- New values are calculated, change the state
                        state <= mode_output;
                    
                    -- mode_output: calculates the next value of mu, tells the output driver to grab the calculated values
                    when mode_output =>
                        -- increment the value of the iteration for the output
                        out_iteration <= iteration + 1;          
                        
                        -- Calculate the value of MU for the next iteration
                        if(in_cordic_mode = '0') then    -- CORDIC mode is 0 - vectoring
                            -- extract the signed bit to know the direction of rotation
                            alu_mu <= z_current(15); 
                            -- provide the value of mu outputed from CORDIC for debugging/testbench purposes   
                            out_mu <= z_current(15);     
                        else                             -- CORDIC mode is 1 - rotation
                            -- extract the signed bit to know the direction of rotation
                            alu_mu <= not(y_current(15));  
                            -- provide the value of mu outputed from CORDIC for debugging/testbench purposes
                            out_mu <= not(y_current(15));  
                        end if; -- end if (in_cordic_mode = '0')
                              
                        if(iteration = "1111") then    -- work here is done, go to state completed.
                            state <= mode_completed;
                            x_current              <= (others => '0'); 
                            y_current              <= (others => '0'); 
                            z_current              <= (others => '0');
                            alu_x_input            <= (others => '0');
                            alu_y_input            <= (others => '0');
                            alu_z_input            <= (others => '0');
                            out_x_result           <= (others => '0'); 
                            out_y_result           <= (others => '0'); 
                            out_z_result           <= (others => '0'); 
                            alu_mu                 <= '0';
                            out_mu                 <= '0';
                            out_iteration_complete <= '0';    
                            iteration              <= (others => '0');          
                            out_iteration          <= (others => '0');   
                        else                           -- still got work to do, increment iteration and keep on going
                            -- increment the local variable for iteration in here as to 
                            -- not conflict with the parent if statement "if(iteration = "1111")"
                            iteration <= iteration + 1 ;
                            
                            -- Notify the output driver that the new iteration of data is ready for storage
                            out_iteration_complete <= '1'; 
                            
                            -- Load the output data and alu inputs with the new iteration data
                            out_x_result <= x_current;                                                  
                            out_y_result <= y_current;                                            
                            out_z_result <= z_current;
                            
                            alu_x_input  <= x_current;      
                            alu_y_input  <= y_current;
                            alu_z_input  <= z_current;
                            
                            -- Continue the loop by telling the ALU to calculate the next iteration
                            state <= mode_calculate;
                        end if;  
                    
                    -- mode_completed: done with CORDIC, clear everything.
                    when mode_completed =>
                        x_current              <= (others => '0'); 
                        y_current              <= (others => '0'); 
                        z_current              <= (others => '0');
                        alu_x_input            <= (others => '0');
                        alu_y_input            <= (others => '0');
                        alu_z_input            <= (others => '0');
                        out_x_result           <= (others => '0'); 
                        out_y_result           <= (others => '0'); 
                        out_z_result           <= (others => '0'); 
                        alu_mu                 <= '0';
                        out_mu                 <= '0';
                        out_iteration_complete <= '0';    
                        iteration              <= (others => '0');          
                        out_iteration          <= (others => '0');   
                        
                end case; -- end state switch statement                  
            end if; -- end rising_edge(clk)
        end if; -- end if reset else
    end process; -- end CORDIC       

end behaviour;

