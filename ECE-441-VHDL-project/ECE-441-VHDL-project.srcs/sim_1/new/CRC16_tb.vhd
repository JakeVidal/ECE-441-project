----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/30/2019 04:34:08 PM
-- Design Name: 
-- Module Name: CRC16_tb - 
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity CRC16_tb is
end CRC16_tb;

architecture tb of CRC16_tb is
    constant clk_period      : time := 10ns; --100MHz clock
    constant clk_half_period : time := clk_period / 2;
    constant test_data : std_logic_vector (255 downto 0) := x"0001000100020004000900110020004100800100020003ff07f60fae1dad3244";
    
    signal data_in : std_logic_vector (255 downto 0);
    signal crc_en  : std_logic;
    signal rst     : std_logic;
    signal clk     : std_logic;
    signal crc_out : std_logic_vector (15 downto 0);
begin
    UUT : entity work.CRC16 port map (
            data_in     =>      data_in,
            crc_en      =>      crc_en,
            rst         =>      rst,
            clk         =>      clk,
            crc_out     =>      crc_out
    );
    
    clk_process: process
    begin
         clk <= '0';
         wait for clk_half_period;  --for half of clock period clk stays at '0'.
         clk <= '1';
         wait for clk_half_period;  --for next half of clock period clk stays at '1'.
    end process clk_process;
    
    test_process: process
    begin
        
        rst <= '0';
        crc_en <= '0';
        data_in <= test_data;
        -- TEST STATEMENTS
        wait for clk_half_period;
        crc_en <= '1';
        wait for clk_half_period;
        crc_en <= '0';
        rst <= '0';
        wait for clk_half_period;
        rst <= '1';
        
        
        --final wait
        wait;
    end process test_process;

end tb;
