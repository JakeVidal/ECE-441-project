library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity output_driver_tb is
end output_driver_tb;

architecture tb of output_driver_tb is
    signal clk                       : STD_LOGIC;
    signal reset                     : STD_LOGIC;

    signal x_result                  : SIGNED (15 downto 0);
    signal y_result                  : SIGNED (15 downto 0);
    signal z_result                  : SIGNED (15 downto 0);
    signal iteration                 : UNSIGNED (3 downto 0);
    signal data_ready                : STD_LOGIC;

    signal x_select                  : STD_LOGIC;
    signal y_select                  : STD_LOGIC;
    signal z_select                  : STD_LOGIC;
    signal iteration_select          : STD_LOGIC_VECTOR (3 downto 0);

    signal anode                     : STD_LOGIC_VECTOR (3 downto 0);
    signal segment                   : STD_LOGIC_VECTOR (6 downto 0);
    
    constant clk_period      : time := 4ns; --100MHz clock
    constant clk_half_period : time := clk_period / 2;
    
begin

    UUT : entity work.output_driver port map (
        clk               => clk,
        reset             => reset,
        x_result          => x_result,
        y_result          => y_result,
        z_result          => z_result,
        iteration         => iteration,
        data_ready        => data_ready,
        x_select          => x_select,
        y_select          => y_select,
        z_select          => z_select,
        iteration_select  => iteration_select,
        anode             => anode,
        segment           => segment         
    );
    
    clk_process :process
    begin
         clk <= '0';
         wait for clk_half_period;  --for half of clock period clk stays at '0'.
         clk <= '1';
         wait for clk_half_period;  --for next half of clock period clk stays at '1'.
    end process;
    --in_clock <= not in_clock after clk_half_period; -- tick the clock every 10ns (High for 5ns, Low for 5ns)
    
    testbench: process
    begin
        
        -- note that this timing relies on a hex driver altered to have a much faster refresh rate
        reset <= '0';
        
        x_result <= x"ABAB";
        y_result <= x"CDCD";
        z_result <= x"EFEF";
        iteration <= "1110", "1111" after 20ns;
        
        data_ready <= '0', '1' after 10ns, '0' after 20ns;
        iteration_select <= "1110";
        x_select <= '0', '1' after 30ns, '0' after 510ns;
        y_select <= '0', '1' after 510ns, '0' after 1022ns;
        z_select <= '0', '1' after 1022ns, '0' after 1534ns;

        wait;
    end process;
end tb;