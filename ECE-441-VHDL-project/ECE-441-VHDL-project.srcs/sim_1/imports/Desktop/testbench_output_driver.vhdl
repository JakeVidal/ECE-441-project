library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;


entity output_driver_tb is
end output_driver_tb;

architecture tb of output_driver_tb is
    signal clk                       : STD_LOGIC;
    signal reset                     : STD_LOGIC;

    signal x_result                  : STD_LOGIC_VECTOR (15 downto 0);
    signal y_result                  : STD_LOGIC_VECTOR (15 downto 0);
    signal z_result                  : STD_LOGIC_VECTOR (15 downto 0);
    signal iteration                 : STD_LOGIC_VECTOR (3 downto 0);
    signal data_ready                : STD_LOGIC;

    signal x_select                  : STD_LOGIC;
    signal y_select                  : STD_LOGIC;
    signal z_select                  : STD_LOGIC;
    signal iteration_select          : STD_LOGIC_VECTOR (3 downto 0);

    signal anode                     : STD_LOGIC_VECTOR (3 downto 0);
    signal segment                   : STD_LOGIC_VECTOR (6 downto 0)

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

    testbench: process
    begin

        wait;
    end process;
end tb;