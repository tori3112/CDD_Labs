`timescale 1ns / 1ps

module ripple_carry_adder_4b (
    input   wire [3:0]  iA, iB, 
    input   wire        iCarry,
    output  wire [3:0]  oSum, 
    output  wire        oCarry
);

    wire [0:2] c;

    full_adder full_adder_inst1 ( .iA(iA[0]), .iB(iB[0]), .iCarry(iCarry), .oSum(oSum[0]), .oCarry(c[0]) );
    full_adder full_adder_inst2 ( .iA(iA[1]), .iB(iB[1]), .iCarry(c[0]), .oSum(oSum[1]), .oCarry(c[1]) );
    full_adder full_adder_inst3 ( .iA(iA[2]), .iB(iB[2]), .iCarry(c[1]), .oSum(oSum[2]), .oCarry(c[2]) );
    full_adder full_adder_inst4 ( .iA(iA[3]), .iB(iB[3]), .iCarry(c[2]), .oSum(oSum[3]), .oCarry(oCarry) );


endmodule
