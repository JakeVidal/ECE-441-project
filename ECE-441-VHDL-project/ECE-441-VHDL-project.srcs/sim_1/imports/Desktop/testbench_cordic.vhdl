library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cordic_tb is
end cordic_tb;

architecture testbench of cordic_tb is
	  signal in_clock                 : STD_LOGIC                        := '0';
      signal in_reset                 : STD_LOGIC                        := '0';
      signal in_x_initial             : SIGNED ( 15 downto 0 )           := (others => '0');
      signal in_y_initial             : SIGNED ( 15 downto 0 )           := (others => '0');
      signal in_z_initial             : SIGNED ( 15 downto 0 )           := (others => '0');
      signal in_cordic_mode           : STD_LOGIC                        := '0';
      signal in_start                 : STD_LOGIC                        := '0';
     
      signal out_x_result             : SIGNED ( 15 downto 0 )           := (others => '0');
      signal out_y_result             : SIGNED ( 15 downto 0 )           := (others => '0');
      signal out_z_result             : SIGNED ( 15 downto 0 )           := (others => '0');
      signal out_iteration            : UNSIGNED (  3 downto 0 )         := (others => '0');
      signal out_mu                   : STD_LOGIC                        := '0';
      signal out_iteration_complete   : STD_LOGIC                        := '0';
      
      constant clk_period      : time := 10ns; --100MHz clock
      constant clk_half_period : time := clk_period / 2;
      constant cordic_time     : time := 350ns; -- ammount of time cordic takes to execute.

begin
    UUT : entity work.CORDIC port map (
       in_clock                  =>    in_clock              ,    
       in_reset                  =>    in_reset              ,
       in_x_initial              =>    in_x_initial          ,
       in_y_initial              =>    in_y_initial          ,
       in_z_initial              =>    in_z_initial          ,
       in_cordic_mode            =>    in_cordic_mode        ,
       in_start                  =>    in_start              ,
                                                             
       out_x_result              =>    out_x_result          ,
       out_y_result              =>    out_y_result          ,
       out_z_result              =>    out_z_result          ,
       out_iteration             =>    out_iteration         ,
       out_mu                    =>    out_mu                ,
       out_iteration_complete    =>    out_iteration_complete 
    );
    
    clk_process :process
    begin
         in_clock <= '0';
         wait for clk_half_period;  --for half of clock period clk stays at '0'.
         in_clock <= '1';
         wait for clk_half_period;  --for next half of clock period clk stays at '1'.
    end process;
    --in_clock <= not in_clock after clk_half_period; -- tick the clock every 10ns (High for 5ns, Low for 5ns)
    
    testbench: process
    begin
        -- Rotation
    
        in_cordic_mode <= '0', '1' after (4 * cordic_time);
        
        in_x_initial <= x"4000" after (0 * cordic_time),
                        x"376D" after (1 * cordic_time),
                        x"2000" after (2 * cordic_time),
                        x"2000" after (2 * cordic_time),
                        
                        x"0000" after (5 * cordic_time),
                        x"2000" after (6 * cordic_time),
                        x"2000" after (7 * cordic_time),
                        x"376D" after (8 * cordic_time);
                        
        
        in_y_initial <= x"0000" after (0 * cordic_time),
                        x"2000" after (1 * cordic_time),
                        x"376D" after (2 * cordic_time),
                        x"376D" after (3 * cordic_time),
                        
                        x"4000" after (5 * cordic_time),
                        x"6EDA" after (6 * cordic_time),
                        x"2000" after (7 * cordic_time),
                        x"2000" after (7 * cordic_time);
                        
        in_z_initial <= x"2183" after (0 * cordic_time),                                                   
                        x"10C1" after (1 * cordic_time),
                        x"10C1" after (2 * cordic_time), -- x"4305"
                        x"2183" after (3 * cordic_time),
                        
                        x"0000" after (5 * cordic_time),
                        x"0000" after (6 * cordic_time),
                        x"0000" after (7 * cordic_time),
                        x"0000" after (8 * cordic_time);
        
        
        in_start <= '0', '1' after (0 * cordic_time + 10ns), '0' after (0 * cordic_time + 20ns),
                         '1' after (1 * cordic_time + 10ns), '0' after (1 * cordic_time + 20ns),
                         '1' after (2 * cordic_time + 10ns), '0' after (2 * cordic_time + 20ns),
                         '1' after (3 * cordic_time + 10ns), '0' after (3 * cordic_time + 20ns),
                         '1' after (5 * cordic_time + 10ns), '0' after (5 * cordic_time + 20ns),
                         '1' after (6 * cordic_time + 10ns), '0' after (6 * cordic_time + 20ns),
                         '1' after (7 * cordic_time + 10ns), '0' after (7 * cordic_time + 20ns),
                         '1' after (8 * cordic_time + 10ns), '0' after (8 * cordic_time + 20ns);
                         
                         
        
        wait;  -- indefinitely suspend process
    end process;
end testbench;



