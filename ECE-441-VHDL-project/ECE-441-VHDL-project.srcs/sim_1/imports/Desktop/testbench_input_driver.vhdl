--library ieee;
--use ieee.std_logic_1164.all;
--use ieee.numeric_std.all;


--entity input_driver_tb is
--end input_driver_tb;

--architecture tb of input_driver_tb is
--    signal clk                       : STD_LOGIC := '0';
--    signal reset                     : STD_LOGIC;

--    signal x_input                   : STD_LOGIC;
--    signal y_input                   : STD_LOGIC;
--    signal z_input                   : STD_LOGIC;
--    signal cordic_mode               : STD_LOGIC;

--    signal keypad_row                : STD_LOGIC_VECTOR (3 downto 0);
--    signal keypad_col                : STD_LOGIC_VECTOR (3 downto 0);

--    signal led                       : STD_LOGIC_VECTOR (15 downto 0);
--    signal initial_x                 : STD_LOGIC_VECTOR (15 downto 0);
--    signal initial_y                 : STD_LOGIC_VECTOR (15 downto 0);
--    signal initial_z                 : STD_LOGIC_VECTOR (15 downto 0);
--    signal initial_cordic_mode       : STD_LOGIC;
--    signal start_cordic              : STD_LOGIC;
    
--    constant clk_period      : time := 10ns; --100MHz clock
--    constant clk_half_period : time := clk_period / 2;

--begin

--    UUT : entity work.input_driver port map (
--        clk                  => clk,                               
--        reset                => reset,               
--        x_input              => x_input,             
--        y_input              => y_input,            
--        z_input              => z_input,             
--        cordic_mode          => cordic_mode,         
--        keypad_row           => keypad_row,          
--        keypad_col           => keypad_col,          
--        led                  => led,                 
--        initial_x            => initial_x,           
--        initial_y            => initial_y,           
--        initial_z            => initial_z,           
--        initial_cordic_mode  => initial_cordic_mode, 
--        start_cordic         => start_cordic        
--    );

--    clk_process: process
--    begin
--         clk <= '0';
--         wait for clk_half_period;  --for half of clock period clk stays at '0'.
--         clk <= '1';
--         wait for clk_half_period;  --for next half of clock period clk stays at '1'.
--    end process;
--    --in_clock <= not in_clock after clk_half_period; -- tick the clock every 10ns (High for 5ns, Low for 5ns)

--    testbench: process
--    begin
        
--        reset <= '0';
--        cordic_mode <= '0';
--        x_input <= '0', '1' after 5ns, '0' after 450ns;
--        y_input <= '0', '1' after 500ns;
--        z_input <= '0';
        
--        keypad_row <=   "0000", "1111" after 2ns, "0111" after 40ns, "1111" after 110ns, "1101" after 150ns, "1111" after 200ns, "1011" after 220ns, "1111" after 240ns,
--                        "1110" after 270ns, "1111" after 300ns, "1101" after 580ns, "1111" after 700ns, "1110" after 740ns, "1111" after 780ns;

--        wait;
--    end process;
--end tb;

---------------- ALTERNATE TESTBENCH FOR ALTERNATE INPUT DRIVER --------------

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity input_driver_tb is
end input_driver_tb;

architecture tb of input_driver_tb is
    signal clk                       : STD_LOGIC;
    signal in_reset                  : STD_LOGIC;
    signal input_button              : STD_LOGIC;

    signal input_vector              : STD_LOGIC_VECTOR (15 downto 0);
    signal cordic_mode               : STD_LOGIC;

    signal led                       : STD_LOGIC_VECTOR (15 downto 0);
    signal initial_x                 : STD_LOGIC_VECTOR (15 downto 0);
    signal initial_y                 : STD_LOGIC_VECTOR (15 downto 0);
    signal initial_z                 : STD_LOGIC_VECTOR (15 downto 0);
    signal start_cordic              : STD_LOGIC;
    signal out_reset                 : STD_LOGIC;
    
    constant clk_period      : time := 10ns; --100MHz clock
    constant clk_half_period : time := clk_period / 2;

begin

    UUT : entity work.input_driver port map (
    --  input_driver sig    tb signals
        clk                 => clk,                               
        in_reset_button     => in_reset,
        in_input_button     => input_button,               
        in_input_value      => input_vector,         
        out_led             => led,                 
        out_x_value         => initial_x,
        out_y_value         => initial_y,
        out_z_value         => initial_z,   
        out_cordic_mode     => cordic_mode, 
        out_start_cordic    => start_cordic,
        out_reset           => out_reset      
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
       
       in_reset <= '0';
        
        -- TRANSITION FROM BEGIN TO INPUT_X
        -- at 50ns move to state state_input_x
        wait for 50ns;
        input_button <= '1';
        wait for 50ns;
        input_button <= '0';
        
        -- TRANSITION FROM INPUT_X to INPUT_Y and save X
        wait for 25ns;
        -- at 125ns, place a value on input vector
        input_vector <= x"ABCD";
        wait for 25ns;
        -- at 150ns, move save value and move to state_input_y
        input_button <= '1';
        wait for 50ns;
        input_button <= '0';
        
        -- TRANSITION FROM INPUT_Y to INPUT_Z and save Y
        wait for 25ns;
        -- at 125ns, place a value on input vector
        input_vector <= x"1234";
        wait for 25ns;
        -- at 150ns, move save value and move to state_input_y
        input_button <= '1';
        wait for 50ns;
        input_button <= '0';
        
        -- TRANSITION FROM INPUT_Z to INPUT_CORDIC_MODE and save Z
        wait for 25ns;
        -- at 125ns, place a value on input vector
        input_vector <= x"5678";
        wait for 25ns;
        -- at 150ns, move save value and move to state_input_y
        input_button <= '1';
        wait for 50ns;
        input_button <= '0';
        
        -- TRANSITION FROM INPUT_CORDIC_MODE to START_CORDIC and save CORDIC_MODE
        wait for 25ns;
        -- at 125ns, place a value on input vector
        input_vector <= x"0011"; -- check that we get the LSB and not the whole thing
        wait for 25ns;
        -- at 150ns, move save value and move to state_input_y
        input_button <= '1';
        wait for 50ns;
        input_button <= '0';
        
        -- START CORDIC and MOVE TO STATE_END
        -- EXPECT 5 clock cycles of out_start_cordic at '1' then '0' again
        wait for 50ns;
        -- at 150ns, move save value and move to state_input_y
        input_button <= '1';
        wait for 50ns;
        input_button <= '0';
        
        --wait for 100ns;
        
        -- IN STATE_END
        -- CHANGE THE INPUT BUTTON A FEW TIMES TO MAKE SURE NOTHING HAPPENS
        wait for 50ns;
        input_button <= '1';
        wait for 25ns;
        input_button <= '0';
        wait for 50ns;
        input_button <= '1';
        wait for 25ns;
        input_button <= '0';
        
        -- WAIT THEN RESET
        -- EXPECT ALL SIGNALS TO REVERT TO DEFAULT
        wait for 100ns;
        in_reset <= '1';
        wait for 100ns;
        in_reset <= '0';
        
        wait;
    end process;
end tb;

