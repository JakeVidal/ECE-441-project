-- CORDIC output controller
-- Written by Jake Vidal

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity output_driver is 
    Port (
            clk                       : in STD_LOGIC;
            reset                     : in STD_LOGIC;

            x_input                   : in STD_LOGIC_VECTOR (15 downto 0);
            y_input                   : in STD_LOGIC_VECTOR (15 downto 0);
            z_input                   : in STD_LOGIC_VECTOR (15 downto 0);
            iteration                 : in STD_LOGIC_VECTOR (3 downto 0);
            data_ready                : in STD_LOGIC;

            anode                     : out STD_LOGIC_VECTOR ( 3 downto 0 );
            segment                   : out STD_LOGIC_VECTOR ( 6 downto 0 )
    );
end output_driver;