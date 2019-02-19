-- CORDIC loop controller
-- Written by Alexander Cote

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity CORDIC is
	port (
	clock                                 : in STD_LOGIC;
	reset                                 : in STD_LOGIC;
		
	x_initial, y_initial, z_initial       : in signed(15 downto 0);
	cordic_mode                           : in STD_LOGIC;
	start                                 : in STD_LOGIC;
		
	x_result, y_result, z_result          : out signed(15 downto 0)

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
	
	type x_results is array (15 downto 0) of signed(15 down to 0);
	type y_results is array (15 downto 0) of signed(15 down to 0);
	type z_results is array (15 downto 0) of signed(15 down to 0);
	signal iteration          : signed( 3 downto 0);
	signal iteration_complete : std_logic
	
begin
	
	
		
	
	cordic: process (clock, reset) is
	begin
		if rising_edge(reset) is
		iteration_complete <= 0;
		x_current <= 0;
		y_current <= 0;
		z_current <= 0;
		x_result <= 0;
		y_result <= 0;
		z_result <= 0;
		
		elsif rising_edge(clock) and done


end behaviour;

