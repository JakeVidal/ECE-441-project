-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Fri Mar 15 17:56:45 2019
-- Host        : DESKTOP-I2HU3TI running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               e:/VLSI_Projects/ECE-441-project/ECE-441-VHDL-project/ECE-441-VHDL-project.srcs/sources_1/ip/ResultStorage_dist_mem_gen_0/ResultStorage_dist_mem_gen_0_stub.vhdl
-- Design      : ResultStorage_dist_mem_gen_0
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity ResultStorage_dist_mem_gen_0 is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 5 downto 0 );
    d : in STD_LOGIC_VECTOR ( 15 downto 0 );
    clk : in STD_LOGIC;
    we : in STD_LOGIC;
    spo : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );

end ResultStorage_dist_mem_gen_0;

architecture stub of ResultStorage_dist_mem_gen_0 is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[5:0],d[15:0],clk,we,spo[15:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_12,Vivado 2017.4";
begin
end;
