-- CORDIC loop controller
-- Written by Alexander Cote

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity CORDIC is
	port (
	        in_clock                : in STD_LOGIC;
	        in_reset                : in STD_LOGIC;
	        in_x_initial            : in STD_LOGIC_VECTOR ( 15 downto 0 );
	        in_y_initial            : in STD_LOGIC_VECTOR ( 15 downto 0 );
	        in_z_initial            : in STD_LOGIC_VECTOR ( 15 downto 0 );
	        in_cordic_mode          : in STD_LOGIC;
	        in_start                : in STD_LOGIC;
	        
	        out_x_result             : out STD_LOGIC_VECTOR ( 15 downto 0 );
	        out_y_result             : out STD_LOGIC_VECTOR ( 15 downto 0 );
	        out_z_result             : out STD_LOGIC_VECTOR ( 15 downto 0 );
	        out_iteration            : out STD_LOGIC_VECTOR (  3 downto 0 );
	        out_iteration_complete   : out STD_LOGIC
		);
end CORDIC;
	
architecture behaviour of CORDIC is
	
	component cordic_alu is 
		Port (
            trigger				: in STD_LOGIC;
            x_in	  	        : in STD_LOGIC_VECTOR ( 15 downto 0 );
            y_in			    : in STD_LOGIC_VECTOR ( 15 downto 0 );
            z_in		        : in STD_LOGIC_VECTOR ( 15 downto 0 );
            theta		     	: in STD_LOGIC_VECTOR ( 15 downto 0 );			
            i					: in STD_LOGIC_VECTOR (  3 downto 0 );
            mu					: in STD_LOGIC;
            x_out				: out STD_LOGIC_VECTOR ( 15 downto 0 );
            y_out				: out STD_LOGIC_VECTOR ( 15 downto 0 );
            z_out				: out STD_LOGIC_VECTOR ( 15 downto 0 );
            done				: out STD_LOGIC
		);
	end component;
	
	
	signal iteration       : STD_LOGIC_VECTOR (  3 downto 0 );
    signal x_current       : STD_LOGIC_VECTOR ( 15 downto 0 );
    signal y_current       : STD_LOGIC_VECTOR ( 15 downto 0 );
    signal z_current       : STD_LOGIC_VECTOR ( 15 downto 0 );
	
	signal setup_alu       : STD_LOGIC;
	signal alu_trigger     : STD_LOGIC;
	signal alu_x_input     : STD_LOGIC_VECTOR ( 15 downto 0 );
	signal alu_y_input     : STD_LOGIC_VECTOR ( 15 downto 0 );
	signal alu_z_input     : STD_LOGIC_VECTOR ( 15 downto 0 );
	signal theta           : STD_LOGIC_VECTOR ( 15 downto 0 );
	signal alu_mu          : STD_LOGIC;
	signal alu_completed   : STD_LOGIC;
	
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
	    x_out	    => out_x_result,
	    y_out	    => out_y_result,
	    z_out	    => out_z_result,
	    done	    => alu_completed
		);
						
	
	cordic: process (in_clock, in_reset) is
	begin
		if rising_edge(in_reset) then
            out_iteration_complete <= '0';
            x_current          <= (others => '0');
            y_current          <= (others => '0');
            z_current          <= (others => '0');
            out_x_result       <= (others => '0');
            out_y_result       <= (others => '0');
            out_z_result       <= (others => '0');
		
		elsif rising_edge(in_clock) then
		
		--determine mode
		
			if(in_start = '1' and iteration = "0000") then
			    out_iteration_complete <= '0';
				--setup alu
				--> set initial values to alu inputs
				--> find value of mu
				--> get value of theta
				
			end if; -- end (start and iteration = 0)
				 
			
		end if; -- end rising edge of clock or reset
			

				
		
		


end behaviour;

