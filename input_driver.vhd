library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity input_driver is 
    Port (
            clk             : in STD_LOGIC;
            x_input         : in STD_LOGIC;
            y_input         : in STD_LOGIC;
            z_input         : in STD_LOGIC;
            cordic_mode     : in STD_LOGIC;
            initial_x       : out STD_LOGIC_VECTOR (15 downto 0);
            initial_y       : out STD_LOGIC_VECTOR (15 downto 0);
            initial_z       : out STD_LOGIC_VECTOR (15 downto 0);
    );
end input_driver;

architecture behavioural of input_driver is
type   state_type is (input, input_x, input_y, input_z, output);  
signal state : state_type := input;  
begin

process (state)
begin
end process;

end behavioural;