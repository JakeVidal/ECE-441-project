library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity top_tb is
end top_tb;

architecture testbench of top_tb is
	  signal input_clk                   : STD_LOGIC                        := '0';
      signal undebounced_reset           : STD_LOGIC                        := '0';
      signal input_button                : STD_LOGIC                        := '0';
      signal sw                          : STD_LOGIC_VECTOR ( 15 downto 0 ) := (others => '0');
      
      signal led                         : STD_LOGIC_VECTOR ( 15 downto 0 ) := (others => '0');
      signal anode                       : STD_LOGIC_VECTOR (3 downto 0)    := "0000";
      signal segment                     : STD_LOGIC_VECTOR (6 downto 0)    := "0000000";

      constant clk_period      : time := 10ns; --100MHz clock
      constant clk_half_period : time := clk_period / 2;
      constant start_time      : time := 600ns;
      constant cordic_time     : time := 350ns; -- ammount of time cordic takes to execute.
      constant display_time    : time := 1000ns;

begin
    UUT : entity work.top port map (
       input_clk                =>    input_clk,    
       undebounced_reset_button =>    undebounced_reset,
       undebounced_input_button =>    input_button,
       undebounced_switches     =>    sw,
       led                      =>    led,
       anode                    =>    anode,
       segment                  =>    segment 
          
    );
    
    clk_process :process
    begin
         input_clk <= '0';
         wait for clk_half_period;  --for half of clock period clk stays at '0'.
         input_clk <= '1';
         wait for clk_half_period;  --for next half of clock period clk stays at '1'.
    end process;
    --in_clock <= not in_clock after clk_half_period; -- tick the clock every 10ns (High for 5ns, Low for 5ns)
    
    testbench: process
    begin
    
        undebounced_reset <= '0';
        sw <= x"0000";
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
        sw <= x"4000";
        wait for 25ns;
        -- at 150ns, move save value and move to state_input_y
        input_button <= '1';
        wait for 50ns;
        input_button <= '0';
        
        -- TRANSITION FROM INPUT_Y to INPUT_Z and save Y
        wait for 25ns;
        -- at 125ns, place a value on input vector
        sw <= x"0000";
        wait for 25ns;
        -- at 150ns, move save value and move to state_input_y
        input_button <= '1';
        wait for 50ns;
        input_button <= '0';
        
        -- TRANSITION FROM INPUT_Z to INPUT_CORDIC_MODE and save Z
        wait for 25ns;
        -- at 125ns, place a value on input vector
        sw <= x"2183";
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
        sw <= x"0011"; -- check that we get the LSB and not the whole thing
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
        
        sw(15 downto 12) <= "0000" after (display_time), "0010" after (4*display_time), "0100" after (7*display_time); -- iteration select
        sw(9)  <= '1' after (display_time), '0' after (2*display_time), '1' after (4*display_time), '0' after (5*display_time), '1' after (7*display_time), '0' after (8*display_time); -- X, Y, Z select
        sw(10) <= '0' after (display_time), '1' after (2*display_time), '0' after (3*display_time), '1' after (5*display_time), '0' after (6*display_time), '1' after (8*display_time), '0' after (9*display_time);
        sw(11) <= '0' after (display_time), '1' after (3*display_time), '0' after (4*display_time), '1' after (6*display_time), '0' after (7*display_time), '1' after (9*display_time), '0' after (10*display_time);

        wait;  -- indefinitely suspend process
    end process;
end testbench;



