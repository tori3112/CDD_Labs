// Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
// --------------------------------------------------------------------------------
// Tool Version: Vivado v.2020.1 (lin64) Build 2902540 Wed May 27 19:54:35 MDT 2020
// Date        : Fri Mar 22 20:31:17 2024
// Host        : tardis running 64-bit Ubuntu 22.04.4 LTS
// Command     : write_verilog -force -mode synth_stub
//               /home/wiktoria/Documents/labs/cdd/project_1/project_1.srcs/sources_1/bd/design_1/ip/design_1_Debounce_Switch_0_0/design_1_Debounce_Switch_0_0_stub.v
// Design      : design_1_Debounce_Switch_0_0
// Purpose     : Stub declaration of top-level module interface
// Device      : xc7z020clg400-1
// --------------------------------------------------------------------------------

// This empty module with port declaration file causes synthesis tools to infer a black box for IP.
// The synthesis directives are for Synopsys Synplify support to prevent IO buffer insertion.
// Please paste the declaration into a Verilog source file or add the file as an additional source.
(* X_CORE_INFO = "Debounce_Switch,Vivado 2020.1" *)
module design_1_Debounce_Switch_0_0(i_Clk, i_Switch, o_Switch)
/* synthesis syn_black_box black_box_pad_pin="i_Clk,i_Switch,o_Switch" */;
  input i_Clk;
  input i_Switch;
  output o_Switch;
endmodule
