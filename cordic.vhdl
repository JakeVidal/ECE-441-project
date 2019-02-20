-- CORDIC loop controller
-- Written by Alexander Cote

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity CORDIC is
	port (
	clock                                 : in std_logic;
	reset                                 : in std_logic;
		
	x_initial, y_initial, z_initial       : in signed(15 downto 0);
	cordic_mode                           : in std_logic;
	start                                 : in std_logic;
		
	x_result, y_result, z_result          : out signed(15 downto 0)
	iteration                             : out unsigned ( 3 downto 0 ) := "0000";
	iteration_complete                    : out std_logic
	

		);
end CORDIC;
	
architecture behaviour of CORDIC is
	
	component cordic_alu is 
		Port (
			trigger							:	in	std_logic;
			x_in, y_in, z_in, theta			:	in	signed ( 15 downto 0 );
			i								:	in 	unsigned ( 3 downto 0 );
			mu								:	in	boolean;
			x_out, y_out, z_out				:	out	signed ( 15 downto 0 );
			done							:	out std_logic
		);
	end component;
	
	
	signal setup_alu                                : std_logic := "0";
	signal alu_trigger                              : std_logic := "0";
	signal alu_x_input, alu_y_input, alu_z_input    : signed(15 downto 0);
	signal alu_mu                                   : boolean := "0";
	signal alu_completed                            : std_logic := "0";
	
begin
	
	c_alu: cordic_alu port map ( alu_trigger, 
								 alu_x_input, alu_y_input, alu_z_input, 
								 iteration, 
								 alu_mu, 
								 x_result, y_result, z_result,
								 alu_completed
								 );
						
	
	cordic: process (clock, reset) is
	begin
		if rising_edge(reset) then
		iteration_complete <= 0;
		x_current <= 0;
		y_current <= 0;
		z_current <= 0;
		x_result <= 0;
		y_result <= 0;
		z_result <= 0;
		
		elsif rising_edge(clock) then
		
		determine mode
		
			if(start and iteration = 0)
				setup alu
				 -> set initial values to alu inputs
				 -> find value of mu
				 -> get value of theta
				 
				 
			
			
			

				
		
		


end behaviour;

