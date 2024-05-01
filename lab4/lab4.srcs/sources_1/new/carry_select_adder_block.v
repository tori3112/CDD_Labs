`timescale 1ns / 1ps

module carry_select_adder_block #(
    parameter ADDER_BITS = 8 // variable M from the slides
    )
    (
    input wire [ADDER_BITS-1:0]  iA, iB,
    input wire                   iCarry,
    output wire [ADDER_BITS-1:0] oSum,
    output wire                  oCarry
    );
        
    wire [7:0] woSum_C0;
    wire [7:0] woSum_C1;
    wire woCarry0,woCarry1;
    
    ripple_carry_adder_Nb #(.ADDER_WIDTH(ADDER_BITS)) ripple_carry_adder_carry0
    (.iA(iA),.iB(iB),.iCarry(0),.oSum(woSum_C0),.oCarry(woCarry0));
    
    ripple_carry_adder_Nb #(.ADDER_WIDTH(ADDER_BITS)) ripple_carry_adder_carry1
    (.iA(iA),.iB(iB),.iCarry(1),.oSum(woSum_C1),.oCarry(woCarry1));
    
    
    assign oSum = (iCarry == 1)? woSum_C1 : woSum_C0;
    assign oCarry = (iCarry == 1)? woCarry1 : woCarry0;
    
    
endmodule