
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Describes mathematical heart of the cordic algorithm
-- mu: boolean, false -> -1, true -> 1

entity cordic_alu is 

	Port (
		trigger							:	in	std_logic;
		x_in, y_in, z_in, theta			:	in	signed ( 15 downto 0 );
		i								:	in 	unsigned ( 3 downto 0 );
		mu								:	in	boolean;
		x_out, y_out, z_out				:	out	signed ( 15 downto 0 );
		done							:	out std_logic
	);
end cordic_alu;


architecture behav of cordic_alu is
	signal 
begin

x_calc: process ( trigger ) is
	-- not implemented yet
end process;

y_calc: process ( trigger ) is

end process;

z_calc: process ( trigger ) is

end process;

end

		
		
		
		