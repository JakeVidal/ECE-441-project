-- CORDIC loop controller
-- Written by Alexander Cote

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.numeric_std.ALL;

entity CORDIC is
	port (
		clock           : in STD_LOGIC;
		x_input         : in signed(15 downto 0);
        y_input         : in signed(15 downto 0);
        z_input         : in signed(15 downto 0);
        cordic_mode     : in STD_LOGIC;
		reset           : in STD_LOGIC;
        x_output        : out signed(15 downto 0);
        y_output        : out signed(15 downto 0);
        z_output        : out signed(15 downto 0)
		);