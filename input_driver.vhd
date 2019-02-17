library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity input_driver is 
    Port (
            clk             : in STD_LOGIC;
            x_input         : in STD_LOGIC;
            y_input         : in STD_LOGIC;
            z_input         : in STD_LOGIC;
            cordic_mode     : in STD_LOGIC;


    );
end input_driver;