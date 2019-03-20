library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity input_driver_tb is
end input_driver_tb;

architecture tb of input_driver_tb is
    signal clk                       : STD_LOGIC := '0';
    signal reset                     : STD_LOGIC;

    signal x_input                   : STD_LOGIC;
    signal y_input                   : STD_LOGIC;
    signal z_input                   : STD_LOGIC;
    signal cordic_mode               : STD_LOGIC;

    signal keypad_row                : STD_LOGIC_VECTOR (3 downto 0);
    signal keypad_col                : STD_LOGIC_VECTOR (3 downto 0);

    signal led                       : STD_LOGIC_VECTOR (15 downto 0);
    signal initial_x                 : STD_LOGIC_VECTOR (15 downto 0);
    signal initial_y                 : STD_LOGIC_VECTOR (15 downto 0);
    signal initial_z                 : STD_LOGIC_VECTOR (15 downto 0);
    signal initial_cordic_mode       : STD_LOGIC;
    signal start_cordic              : STD_LOGIC;
    
    constant clk_period      : time := 10ns; --100MHz clock
    constant clk_half_period : time := clk_period / 2;

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

    clk_process: process
    begin
         clk <= '0';
         wait for clk_half_period;  --for half of clock period clk stays at '0'.
         clk <= '1';
         wait for clk_half_period;  --for next half of clock period clk stays at '1'.
    end process;
    --in_clock <= not in_clock after clk_half_period; -- tick the clock every 10ns (High for 5ns, Low for 5ns)

    testbench: process
    begin
        
        reset <= '0';
        cordic_mode <= '0';
        x_input <= '0', '1' after 5ns, '0' after 450ns;
        y_input <= '0', '1' after 500ns;
        z_input <= '0';
        
        keypad_row <=   "0000", "1111" after 2ns, "0111" after 40ns, "1111" after 110ns, "1101" after 150ns, "1111" after 200ns, "1011" after 220ns, "1111" after 240ns,
                        "1110" after 270ns, "1111" after 300ns, "1101" after 580ns, "1111" after 700ns, "1110" after 740ns, "1111" after 780ns;

        wait;
    end process;
end tb;