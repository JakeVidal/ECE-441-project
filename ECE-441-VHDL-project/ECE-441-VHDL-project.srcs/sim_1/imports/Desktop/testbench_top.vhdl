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
      constant cordic_time     : time := 350ns; -- ammount of time cordic takes to execute.
      constant display_time    : time := 1500ns;

begin
    UUT : entity work.top port map (
       input_clk                =>    input_clk,    
       undebounced_reset        =>    undebounced_reset,
       input_button             =>    input_button,
       sw                       =>    sw,
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
        -- Rotation
--        in_reset <= '1', '0' after 5ns;
        
--        in_cordic_mode <= '0';
--        in_x_initial <= x"4000" after (0 * cordic_time);
--        in_y_initial <= x"0000" after (0 * cordic_time);                 
--        in_z_initial <= x"2183" after (0 * cordic_time);
--        in_start <= '0', '1' after (0 * cordic_time + 10ns), '0' after (0 * cordic_time + 20ns);
         
--        iteration_select <= "0000";
--        x_select <= '0', '1' after (cordic_time + 10ns), '0' after (cordic_time + display_time + 10ns);
--        y_select <= '0', '1' after (cordic_time + display_time + 10ns), '0' after (cordic_time + 2*display_time + 10ns);
--        z_select <= '0', '1' after (cordic_time + 2*display_time + 10ns), '0' after (cordic_time + 3*display_time + 10ns);
                         
        wait;  -- indefinitely suspend process
    end process;
end testbench;



