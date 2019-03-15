-- CORDIC loop controller
-- Written by Alexander Cote

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CORDIC is
	port (
	        in_clock                : in STD_LOGIC;
	        in_reset                : in STD_LOGIC;
	        in_x_initial            : in SIGNED ( 15 downto 0 );
	        in_y_initial            : in SIGNED ( 15 downto 0 );
	        in_z_initial            : in SIGNED ( 15 downto 0 );
	        in_cordic_mode          : in STD_LOGIC;
	        in_start                : in STD_LOGIC;
	        
	        out_x_result             : out SIGNED ( 15 downto 0 )             := (others => '0');
	        out_y_result             : out SIGNED ( 15 downto 0 )             := (others => '0');
	        out_z_result             : out SIGNED ( 15 downto 0 )             := (others => '0');
	        out_iteration            : out UNSIGNED (  3 downto 0 )           := (others => '0');
	        out_iteration_complete   : out STD_LOGIC                          := '0'
		);
end CORDIC;
	
architecture behaviour of CORDIC is
	
	component cordic_alu is 
		port (
            trigger				: in STD_LOGIC;
            x_in	  	        : in SIGNED ( 15 downto 0 );
            y_in			    : in SIGNED ( 15 downto 0 );
            z_in		        : in SIGNED ( 15 downto 0 );
            theta		     	: in SIGNED ( 15 downto 0 );			
            i					: in STD_LOGIC_VECTOR (  3 downto 0 );
            mu					: in STD_LOGIC;
            x_out				: out SIGNED ( 15 downto 0 );
            y_out				: out SIGNED ( 15 downto 0 );
            z_out				: out SIGNED ( 15 downto 0 )
		);
	end component;
	
	component Theta_LUT_dist_mem_gen is
      port (
          a   : in STD_LOGIC_VECTOR  (  3 downto 0 );
          spo : out STD_LOGIC_VECTOR ( 15 downto 0 )
      );
    end component;
	
	-- iteration and current values
	signal iteration       : UNSIGNED (  3 downto 0 ) := (others => '0');
    signal x_current       : SIGNED ( 15 downto 0 )           := (others => '0');
    signal y_current       : SIGNED ( 15 downto 0 )           := (others => '0');
    signal z_current       : SIGNED ( 15 downto 0 )           := (others => '0');
    
    -- data storage (LUTS)
    type matrix is array (15 downto 0) of STD_LOGIC_VECTOR (15 downto 0);
    -- signal theta_LUT : matrix := (others => (others => '0'));
    -- https://www.ics.uci.edu/~jmoorkan/vhdlref/arrays.html
    -- signal theta_LUT : matrix := ( x"3244", x"1dac", x"faf" , x"7f7" , 
    --                               x"3ff" , x"200" , x"100" , x"80"  ,
    --                               x"40"  , x"21"  , x"11"  , x"9"   ,
    --                               x"4"   , x"2"   , x"1"   , x"1"   );

	-- ALU interface
	signal alu_trigger     : STD_LOGIC              := '0';
	signal alu_x_input     : SIGNED ( 15 downto 0 ) := (others => '0');
	signal alu_y_input     : SIGNED ( 15 downto 0 ) := (others => '0');
	signal alu_z_input     : SIGNED ( 15 downto 0 ) := (others => '0');
	signal theta           : SIGNED ( 15 downto 0 ) := (others => '0');
	signal alu_mu          : STD_LOGIC              := '0';
	
	
	-- State machine
	type state_type is (mode_idle, mode_zero, mode_calculate, mode_readALU, mode_release);
	signal state : state_type := mode_idle;
	
begin
	
	theta_LUT: Theta_LUT_dist_mem_gen port map (
        a               =>   STD_LOGIC_VECTOR(iteration),
        signed(spo)     =>   theta
        );         
	
	--c_alu: cordic_alu port map ( 
	--    trigger     => alu_trigger ,
	--    x_in	    => alu_x_input ,
	--    y_in	    => alu_y_input ,
	--    z_in	    => alu_z_input ,
	--    theta	    => theta       ,
	--    i		 	=> iteration   ,
	--    mu		    => alu_mu      ,
	--    -- reset       => in_reset    ,
	--    x_out	    => x_current,
	--    y_out	    => y_current,
	--    z_out	    => z_current
	--	);
	

	cordic_control: process (in_clock, in_reset) is
	begin
		if (in_reset = '1') then
		    state <= mode_idle;   
		
		elsif rising_edge(in_clock) then
		  	case state is
		  	    -- mode_idle: nothing happening, waiting for start signal
                when mode_idle =>
                    if (in_start = '1') then
                        state <= mode_zero;
                        out_iteration <= "0000"; 
                        iteration     <= "0000";  
                        out_x_result  <= in_x_initial; 
                        out_y_result  <= in_y_initial; 
                        out_z_result  <= in_z_initial;   
                        alu_x_input <= in_x_initial; 
                        alu_y_input <= in_y_initial; 
                        alu_z_input <= in_z_initial; 
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
                    
                -- mode_zero: start state, output
                when mode_zero =>
                    out_iteration_complete <= '1'; 
                    iteration <= iteration + 1 ;
                    state <= mode_calculate;
                    
                -- mode_calculate: calculates the mu value, and trigger 
                when mode_calculate =>
                    out_iteration_complete <= '0';
                    if(in_cordic_mode = '1') then -- CORDIC mode is 0 - vectoring
                        --alu_mu <= y_current(15);
                         x_current <= alu_x_input - shift_right(alu_y_input, to_integer(iteration));
                         y_current <= alu_y_input + shift_right(alu_x_input, to_integer(iteration));
                         z_current <= alu_z_input - theta;
                    else 
                        --alu_mu <= z_current(15);
                        x_current <= alu_x_input + shift_right(alu_y_input, to_integer(iteration));
                        y_current <= alu_y_input - shift_right(alu_x_input, to_integer(iteration));
                        z_current <= alu_z_input + theta;
                    end if;
                    state <= mode_readALU;
                         
		        when mode_readALU =>
		           out_iteration <= iteration;    -- updates the output iteration value         
                   out_x_result  <= x_current;                                                  
                   out_y_result  <= y_current;                                            
                   out_z_result  <= z_current;   
                   state <= mode_release;
                
                when mode_release =>
                    out_iteration_complete <= '1'; -- allows output driver to capture values       
                    if(iteration = "1111") then    -- work here is done, scale final values
                        state <= mode_idle;
                    else                           -- still got work to do, increment iteration and keep on going
                        iteration <= iteration + 1 ;
                        alu_x_input <= x_current;      
                        alu_y_input <= y_current;
                        alu_z_input <= z_current;
                        state <= mode_calculate;
                    end if;                                  
		            
		            
		    end case;	            	
		end if;
    end process;		


end behaviour;

