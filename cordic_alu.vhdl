
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

-- Describes mathematical heart of the cordic algorithm
-- mu: boolean, false -> -1, true -> 1

entity cordic_alu is 

	Port (
		clk								:	in	std_logic;
		x_in, y_in, z_in, theta, i		:	in	signed ( 15 downto 0 );
		mu								:	in	boolean;
		x_out, y_out, z_out				:	out	signed ( 15 downto 0 );
	);
end cordic_alu;


architecture behav of cordic_alu is
begin
process is
	-- not implemented yet

end

		
		
		
		