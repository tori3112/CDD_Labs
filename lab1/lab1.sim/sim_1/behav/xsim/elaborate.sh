#!/bin/bash -f
# ****************************************************************************
# Vivado (TM) v2020.1 (64-bit)
#
# Filename    : elaborate.sh
# Simulator   : Xilinx Vivado Simulator
# Description : Script for elaborating the compiled design
#
# Generated by Vivado on Mon Feb 26 12:04:38 CET 2024
# SW Build 2902540 on Wed May 27 19:54:35 MDT 2020
#
# Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
#
# usage: elaborate.sh
#
# ****************************************************************************
set -Eeuo pipefail
echo "xelab -wto 7fe3909c22234c20b205d34ac3b833be --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot ripple_carry_adder_Nb_TB_behav xil_defaultlib.ripple_carry_adder_Nb_TB xil_defaultlib.glbl -log elaborate.log"
xelab -wto 7fe3909c22234c20b205d34ac3b833be --incr --debug typical --relax --mt 8 -L xil_defaultlib -L unisims_ver -L unimacro_ver -L secureip --snapshot ripple_carry_adder_Nb_TB_behav xil_defaultlib.ripple_carry_adder_Nb_TB xil_defaultlib.glbl -log elaborate.log

