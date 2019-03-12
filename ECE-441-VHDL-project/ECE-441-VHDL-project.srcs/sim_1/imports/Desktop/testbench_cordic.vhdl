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
      signal out_iteration            : STD_LOGIC_VECTOR (  3 downto 0 ) := (others => '0');
      signal out_iteration_complete   : STD_LOGIC                        := '0';
      
      constant clk_period      : time := 10ns; --100MHz clock
      constant clk_half_period : time := clk_period / 2;

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
        in_x_initial <= x"4000";
        in_y_initial <= x"0000";
        in_z_initial <= x"2183";
        in_start <= '1', '0' after 10ns;
        
        

        wait for 2000ns;  -- indefinitely suspend process
    end process;
end testbench;



