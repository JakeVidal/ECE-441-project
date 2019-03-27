-- Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
-- --------------------------------------------------------------------------------
-- Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
-- Date        : Wed Mar 27 16:02:49 2019
-- Host        : noah-yoga running 64-bit major release  (build 9200)
-- Command     : write_vhdl -force -mode synth_stub
--               D:/CourseProjects/ECE441/ECE-441-project/ECE-441-VHDL-project/ECE-441-VHDL-project.srcs/sources_1/ip/Theta_LUT_dist_mem_gen/Theta_LUT_dist_mem_gen_stub.vhdl
-- Design      : Theta_LUT_dist_mem_gen
-- Purpose     : Stub declaration of top-level module interface
-- Device      : xc7a35tcpg236-1
-- --------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Theta_LUT_dist_mem_gen is
  Port ( 
    a : in STD_LOGIC_VECTOR ( 3 downto 0 );
    spo : out STD_LOGIC_VECTOR ( 15 downto 0 )
  );

end Theta_LUT_dist_mem_gen;

architecture stub of Theta_LUT_dist_mem_gen is
attribute syn_black_box : boolean;
attribute black_box_pad_pin : string;
attribute syn_black_box of stub : architecture is true;
attribute black_box_pad_pin of stub : architecture is "a[3:0],spo[15:0]";
attribute x_core_info : string;
attribute x_core_info of stub : architecture is "dist_mem_gen_v8_0_12,Vivado 2017.4";
begin
end;
