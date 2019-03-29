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
	       out_x_result                    : out SIGNED ( 15 downto 0 )    := (others => '0');
	       out_y_result                    : out SIGNED ( 15 downto 0 )    := (others => '0');
	       out_z_result                    : out SIGNED ( 15 downto 0 )    := (others => '0');
	       out_iteration                   : out UNSIGNED (  3 downto 0 )  := (others => '0');
	       out_mu                          : out STD_LOGIC                 := '0';
	       out_iteration_complete          : out STD_LOGIC                 := '0'
		);
end CORDIC;
	
architecture behaviour of CORDIC is
	
	component Theta_LUT_dist_mem_gen is
        port (
            a                              : in  STD_LOGIC_VECTOR  (  3 downto 0 );
            spo                            : out STD_LOGIC_VECTOR ( 15 downto 0 )
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
	
	----------------------------INTERNAL SIGNALS--------------------------------------
	type state_type is (mode_idle, mode_calculate, mode_output, mode_completed);
	signal state : state_type := mode_idle;
	
begin
	
	--------------------------------MEMORY PORT MAPS----------------------------------
	theta_LUT: Theta_LUT_dist_mem_gen port map (a => STD_LOGIC_VECTOR(iteration), signed(spo) => theta);         
	
	cordic_control: process (in_clock, in_reset) is
	begin
		if (in_reset = '1') then
		    state <= mode_idle; 
		    x_current     <= (others => '0'); 
            y_current     <= (others => '0'); 
            z_current     <= (others => '0'); 
            out_x_result  <= (others => '0'); 
            out_y_result  <= (others => '0'); 
            out_z_result  <= (others => '0'); 
            out_iteration_complete <= '0';    
            iteration     <= "0000";          
            out_iteration <= "0000";   
        end if;
        
	
		if rising_edge(in_clock) then
		  	case state is
		  	    -- mode_idle: nothing happening, waiting for start signal
                when mode_idle =>
                    if (in_start ='1') then
                        iteration     <= "0000"; 
                        out_iteration <= "0000"; 
                        
                        alu_x_input <= in_x_initial; 
                        alu_y_input <= in_y_initial; 
                        alu_z_input <= in_z_initial; 
                         
                        out_x_result  <= in_x_initial; 
                        out_y_result  <= in_y_initial; 
                        out_z_result  <= in_z_initial;   

                        out_iteration_complete <= '1'; 
                        
                        if(in_cordic_mode = '0') then -- CORDIC mode is 0 - vectoring
                            alu_mu <= in_z_initial(15);
                            out_mu <= in_z_initial(15);
                        else
                            alu_mu <= not(in_y_initial(15));
                            out_mu <= not(in_y_initial(15));
                        end if;
                        
                        state <= mode_calculate;
                    else
                        x_current     <= (others => '0'); 
                        y_current     <= (others => '0'); 
                        z_current     <= (others => '0'); 
                        out_x_result  <= (others => '0'); 
                        out_y_result  <= (others => '0'); 
                        out_z_result  <= (others => '0'); 
                        out_iteration_complete <= '0';    
                        iteration     <= "0000";          
                        out_iteration <= "0000";          
                    end if;
                    
                    
                -- mode_calculate: gets the new alu values
                when mode_calculate =>
                    out_iteration_complete <= '0';                                                                               
                    
                    if(alu_mu = '0') then
                        x_current <= alu_x_input - shift_right(alu_y_input, to_integer(iteration));
                        y_current <= alu_y_input + shift_right(alu_x_input, to_integer(iteration));
                        z_current <= alu_z_input - theta;
                    else 
                        x_current <= alu_x_input + shift_right(alu_y_input, to_integer(iteration));
                        y_current <= alu_y_input - shift_right(alu_x_input, to_integer(iteration));
                        z_current <= alu_z_input + theta;
                    end if;
                    state <= mode_output;
                
                when mode_output =>
                    out_iteration <= iteration + 1;    -- updates the output iteration value        
                    
                    if(in_cordic_mode = '0') then -- CORDIC mode is 0 - vectoring
                        alu_mu <= z_current(15);
                        out_mu <= z_current(15);
                    else
                        alu_mu <= not(y_current(15));
                        out_mu <= not(y_current(15));
                    end if;
                          
                    if(iteration = "1111") then    -- work here is done, scale final values
                        state <= mode_completed;
                        out_x_result  <= (others => '0');                                                  
                        out_y_result  <= (others => '0');                                            
                        out_z_result  <= (others => '0');
                        out_mu        <= '0';
                    else                           -- still got work to do, increment iteration and keep on going
                        iteration <= iteration + 1 ;
                        out_x_result  <= x_current;                                                  
                        out_y_result  <= y_current;                                            
                        out_z_result  <= z_current;
                        out_iteration_complete <= '1'; -- allows output driver to capture values 
                        alu_x_input <= x_current;      
                        alu_y_input <= y_current;
                        alu_z_input <= z_current;
                        state <= mode_calculate;
                    end if;   
                when mode_completed =>
                    x_current     <= (others => '0'); 
                    y_current     <= (others => '0'); 
                    z_current     <= (others => '0'); 
                    out_x_result  <= (others => '0'); 
                    out_y_result  <= (others => '0'); 
                    out_z_result  <= (others => '0'); 
                    out_iteration_complete <= '0';    
                    iteration     <= "0000";          
                    out_iteration <= "0000";   
		            
		    end case;	            	
		end if;
    end process;		

end behaviour;

