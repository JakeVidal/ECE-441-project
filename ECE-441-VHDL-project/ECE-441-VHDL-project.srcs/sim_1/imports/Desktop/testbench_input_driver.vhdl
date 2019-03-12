library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity input_driver_tb is
end input_driver_tb;

architecture tb of input_driver_tb is
    signal clk                       : STD_LOGIC := 0;
    signal reset                     : STD_LOGIC;

    signal x_input                   : STD_LOGIC;
    signal y_input                   : STD_LOGIC;
    signal z_input                   : STD_LOGIC;
    signal cordic_mode               : STD_LOGIC;

    signal keypad_row                : STD_LOGIC_VECTOR (3 downto 0);
    signal keypad_col                : STD_LOGIC_VECTOR (3 downto 0);

    signal led                       : STD_LOGIC_VECTOR (15 downto 0);
    signal 
    signal initial_x                 : STD_LOGIC_VECTOR (15 downto 0);
    signal initial_y                 : STD_LOGIC_VECTOR (15 downto 0);
    signal initial_z                 : STD_LOGIC_VECTOR (15 downto 0);
    signal initial_cordic_mode       : STD_LOGIC;
    signal start_cordic              : STD_LOGIC

begin

    UUT : entity work.input_driver port map (
        clk                  => clk,                               
        reset                => reset,               
        x_input              => x_input,             
        y_input              => y_input,            
        z_input              => z_input,             
        cordic_mode          => cordic_mode,         
        keypad_row           => keypad_row,          
        keypad_col           => keypad_col,          
        led                  => led,                 
        initial_x            => initial_x,           
        initial_y            => initial_y,           
        initial_z            => initial_z,           
        initial_cordic_mode  => initial_cordic_mode, 
        start_cordic         => start_cordic        
    );

    testbench: process
    begin

        clk <= not clk after 2ns;

        x_input <= '0', '1' after 1ns, '0' after 2ns, '1' after 3ns, '0' after 4ns, '1' after 5ns, '0' after 6ns;

        keypad_row <= "1111", "1110" after 10ns, "1111" after 11ns, "1110" after 12ns, "1111" after 13ns, "1110" after 14ns;

        wait;
    end process;
end tb;