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
	        --in_test_iteration       : in STD_LOGIC_VECTOR (  3 downto 0 );
	        in_cordic_mode          : in STD_LOGIC;
	        in_start                : in STD_LOGIC;
	        
	        out_x_result             : out SIGNED ( 15 downto 0 );
	        out_y_result             : out SIGNED ( 15 downto 0 );
	        out_z_result             : out SIGNED ( 15 downto 0 );
	        --out_test_theta           : out STD_LOGIC_VECTOR ( 15 downto 0 );
	        out_iteration            : out STD_LOGIC_VECTOR (  3 downto 0 );
	        out_iteration_complete   : out STD_LOGIC
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
            z_out				: out SIGNED ( 15 downto 0 );
            done				: out STD_LOGIC
		);
	end component;
	
	component Theta_LUT_dist_mem_gen is
      port (
          a   : in STD_LOGIC_VECTOR  (  3 downto 0 );
          spo : out STD_LOGIC_VECTOR ( 15 downto 0 )
      );
    end component;
	
	-- iteration and current values
	signal iteration       : STD_LOGIC_VECTOR (  3 downto 0 );
    signal x_current       : SIGNED ( 15 downto 0 );
    signal y_current       : SIGNED ( 15 downto 0 );
    signal z_current       : SIGNED ( 15 downto 0 );
    
    -- data storage (LUTS)
    type matrix is array (15 downto 0) of STD_LOGIC_VECTOR (15 downto 0);
    -- signal theta_LUT : matrix := (others => (others => '0'));
    -- https://www.ics.uci.edu/~jmoorkan/vhdlref/arrays.html
    -- signal theta_LUT : matrix := ( x"3244", x"1dac", x"faf" , x"7f7" , 
    --                               x"3ff" , x"200" , x"100" , x"80"  ,
    --                               x"40"  , x"21"  , x"11"  , x"9"   ,
    --                               x"4"   , x"2"   , x"1"   , x"1"   );

	-- ALU interface
	signal setup_alu       : STD_LOGIC;
	signal alu_trigger     : STD_LOGIC;
	signal alu_x_input     : SIGNED ( 15 downto 0 );
	signal alu_y_input     : SIGNED ( 15 downto 0 );
	signal alu_z_input     : SIGNED ( 15 downto 0 );
	signal theta           : UNSIGNED ( 15 downto 0 );
	signal alu_mu          : STD_LOGIC;
	signal alu_completed   : STD_LOGIC;
	
	-- State machine
	type state_type is (mode_idle, mode_zero, mode_calculate, mode_launchALU, mode_waitALU, mode_scale);
	signal state : state_type := mode_idle;
	
begin
	
	c_alu: cordic_alu port map ( 
	    trigger     => alu_trigger ,
	    x_in	    => alu_x_input ,
	    y_in	    => alu_y_input ,
	    z_in	    => alu_z_input ,
	    theta	    => theta       ,
	    i		 	=> iteration   ,
	    mu		    => alu_mu      ,
	    -- reset       => in_reset    ,
	    x_out	    => x_current,
	    y_out	    => y_current,
	    z_out	    => z_current,
	    done	    => alu_completed
		);
	
	theta_LUT: Theta_LUT_dist_mem_gen port map (
	    a               =>   iteration,
        unsigned(spo)   =>   theta
	    ); 					
	

	
	cordic_control: process (in_clock, in_reset, state) is
	begin
		if rising_edge(in_reset) then
		    state <= mode_idle;
		    
            out_iteration_complete <= '0';
            x_current          <= (others => '0');
            y_current          <= (others => '0');
            z_current          <= (others => '0');
            out_x_result       <= (others => '0');
            out_y_result       <= (others => '0');
            out_z_result       <= (others => '0');
		
		elsif rising_edge(in_clock) then
		  	case state is
		  	    -- mode_idle: nothing happening, waiting for start signal
                when mode_idle =>
                    if rising_edge(in_start) then
                        state <= mode_zero;
                    end if;
                    
                -- mode_zero: start state, initializes variables
                when mode_zero =>
                    out_iteration_complete <= '0';
                    iteration   <= "0000";  
                    alu_x_input <= in_x_initial; 
                    alu_y_input <= in_y_initial; 
                    alu_z_input <= in_z_initial; 
                    x_current <= in_x_initial;
                    y_current <= in_y_initial;
                    z_current <= in_z_initial;
                    state <= mode_calculate;
                    
                -- mode_calculate: calculates the mu value    
                when mode_calculate =>
                    out_iteration_complete <= '0';
                    if(in_cordic_mode = '0') then -- CORDIC mode is 0 - vectoring
                        alu_mu <= y_current(15);
                    else 
                        alu_mu <= z_current(15);
                    end if;
                    state <= mode_launchALU;
                    
                -- mode_launchALU: triggers the ALU    
                when mode_launchALU =>
                    alu_trigger <= '1';
                    state <= mode_waitALU;
                    
                -- mode_waitALU: waits for the ALU to finish, then starts next iteration
                when mode_waitALU =>
		            alu_trigger <= '0';
		            if( rising_edge(alu_completed)) then
		                out_iteration <= iteration;    -- updates the output iteration value
		                out_x_result  <= x_current;
                        out_y_result  <= y_current;
                        out_z_result  <= z_current;
		                if(iteration = "1111") then    -- work here is done, scale final values
		                    state <= mode_scale;
		                else                           -- still got work to do, increment iteration and keep on going
		                	out_iteration_complete <= '1'; -- allows output driver to capture values
		                    iteration <= std_logic_vector( unsigned(iteration) + 1 );
		                    state <= mode_calculate;
		                end if;
		            end if;	
		            
		        -- scales final value
		        when mode_scale =>
		          --out_x_result <= 0.607252935103 * x_current;
		          --out_y_result <= 0.607252935103 * y_current;
		          out_iteration_complete <= '1'; -- allows output driver to capture values
		          state <= mode_idle;
		    end case;	            	
		end if;
    end process;		


end behaviour;

