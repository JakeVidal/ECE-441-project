library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity input_driver_tb is
end input_driver_tb;

architecture tb of input_driver_tb is
    signal in_reset                  : STD_LOGIC;
    signal input_button              : STD_LOGIC;

    signal input_vector              : STD_LOGIC_VECTOR (15 downto 0);
    signal cordic_mode               : STD_LOGIC;

    signal led                       : STD_LOGIC_VECTOR (15 downto 0);
    signal initial_x                 : SIGNED (15 downto 0);
    signal initial_y                 : SIGNED (15 downto 0);
    signal initial_z                 : SIGNED (15 downto 0);
    signal start_cordic              : STD_LOGIC;
    
    constant clk_period      : time := 10ns; --100MHz clock
    constant clk_half_period : time := clk_period / 2;

begin

    UUT : entity work.input_driver port map (
    --  input_driver sig    tb signals                       
        in_reset_button     => in_reset,
        in_input_button     => input_button,               
        in_input_value      => input_vector,         
        out_led             => led,                 
        out_x_value         => initial_x,
        out_y_value         => initial_y,
        out_z_value         => initial_z,   
        out_cordic_mode     => cordic_mode, 
        out_start_cordic    => start_cordic      
    );

    testbench: process
    begin
       
       in_reset <= '0';
       input_vector <= x"0000";
       input_button <= '0';
        
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
        
        -- test reset here to see how, with the reset held, further signals don't affect the state
        --in_reset <= '1';
        
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

