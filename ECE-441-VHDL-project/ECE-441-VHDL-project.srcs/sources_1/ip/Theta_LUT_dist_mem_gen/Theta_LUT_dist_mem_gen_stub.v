// Copyright 1986-2017 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2017.4 (win64) Build 2086221 Fri Dec 15 20:55:39 MST 2017
// Date        : Sun Mar 10 16:01:36 2019
// Host        : DESKTOP-I2HU3TI running 64-bit major release  (build 9200)
// Command     : write_verilog -force -mode synth_stub
//               e:/VLSI_Projects/ECE-441-project/ECE-441-VHDL-project/ECE-441-VHDL-project.srcs/sources_1/ip/Theta_LUT_dist_mem_gen/Theta_LUT_dist_mem_gen_stub.v
// Design      : Theta_LUT_dist_mem_gen
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7a35tcpg236-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* x_core_info = "dist_mem_gen_v8_0_12,Vivado 2017.4" *)
module Theta_LUT_dist_mem_gen(a, spo)
/* synthesis syn_black_box black_box_pad_pin="a[3:0],spo[15:0]" */;
  input [3:0]a;
  output [15:0]spo;
endmodule