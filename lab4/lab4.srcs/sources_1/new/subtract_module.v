`timescale 1ns / 1ps

module subtract_module#(
    parameter ADDER_BITS = 8 // variable M from the slides
    )
    (
    input wire [ADDER_BITS-1:0]  iA, iB,
    output wire [ADDER_BITS-1:0] oSum,
    output wire                  oCarry
    );
    
    // iA-iB
    
    wire [ADDER_BITS-1:0] w_iB_inv;
    
    assign w_iB_inv = ~iB+1;
    
    carry_select_adder_block #(.ADDER_WIDTH(ADDER_BITS)) carry_select_adder_block_inst(
                                                .iA(iA),
                                                .iB(w_iB_inv),
                                                .iCarry(0),
                                                .oSum(oSum),
                                                .oCarry(oCarry) );
                                                
    
    
endmodule
