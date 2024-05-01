`timescale 1ns / 1ps

module ripple_carry_adder_Nb #(
    parameter   ADDER_WIDTH = 16
    )
    (
    input   wire [ADDER_WIDTH-1:0]  iA, iB, 
    input   wire                    iCarry,
    output  wire [ADDER_WIDTH-1:0]  oSum, 
    output  wire                    oCarry
);

    wire [0:ADDER_WIDTH-2] c;
    
    full_adder full_adder_lead (
                    .iA(iA[0]),
                    .iB(iB[0]),
                    .iCarry(iCarry),
                    .oSum(oSum[0]),
                    .oCarry(c[0]) );
    
    genvar i;
    
    generate
        for (i=1; i<ADDER_WIDTH-1; i=i+1)
        begin
            full_adder full_adder_int(
                .iA(iA[i]),
                .iB(iB[i]),
                .iCarry(c[i-1]),
                .oSum(oSum[i]),
                .oCarry(c[i]) );
        end
    endgenerate
    
    full_adder full_adder_last (
                   .iA(iA[ADDER_WIDTH-1]),
                   .iB(iB[ADDER_WIDTH-1]),
                   .iCarry(c[ADDER_WIDTH-2]),
                   .oSum(oSum[ADDER_WIDTH-1]),
                   .oCarry(oCarry) );
                   
                     

endmodule
