library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cordic_tb is
end cordic_tb;

architecture testbench of cordic_tb is
	  signal in_clock                : STD_LOGIC;
      signal in_reset                : STD_LOGIC;
      signal in_x_initial            : signed ( 15 downto 0 );
      signal in_y_initial            : signed ( 15 downto 0 );
      signal in_z_initial            : signed ( 15 downto 0 );
      signal in_test_iteration       : STD_LOGIC_VECTOR (  3 downto 0 );
      signal in_cordic_mode          : STD_LOGIC;
      signal in_start                : STD_LOGIC;
     
      signal out_x_result             : signed ( 15 downto 0 );
      signal out_y_result             : signed ( 15 downto 0 );
      signal out_z_result             : signed ( 15 downto 0 );
      signal out_test_theta           : STD_LOGIC_VECTOR ( 15 downto 0 );
      signal out_iteration            : STD_LOGIC_VECTOR (  3 downto 0 );
      signal out_iteration_complete   : STD_LOGIC;

begin
    UUT : entity work.CORDIC port map (
       in_clock                  =>    in_clock              ,    
       in_reset                  =>    in_reset              ,
       in_x_initial              =>    in_x_initial          ,
       in_y_initial              =>    in_y_initial          ,
       in_z_initial              =>    in_z_initial          ,
       in_test_iteration         =>    in_test_iteration     ,
       in_cordic_mode            =>    in_cordic_mode        ,
       in_start                  =>    in_start              ,
                                                             
       out_x_result              =>    out_x_result          ,
       out_y_result              =>    out_y_result          ,
       out_z_result              =>    out_z_result          ,
       out_test_theta            =>    out_test_theta        ,
       out_iteration             =>    out_iteration         ,
       out_iteration_complete    =>    out_iteration_complete 
    );
    testbench: process
    begin
        in_test_iteration <= "0000", "0001" after 10ns, "0010" after 20ns, "0011" after 30ns;
        
        
        
        wait;
    end process;
end testbench;



