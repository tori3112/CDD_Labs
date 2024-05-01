`timescale 1ns / 1ps

module carry_select_adder_module #(
    parameter ADDER_WIDTH = 32,
    parameter BLOCK_WIDTH = 8,
    parameter BLOCK_SIZE = ADDER_WIDTH/BLOCK_WIDTH // how many carry select adder blocks we generate 
    )
    (
    input wire [ADDER_WIDTH-1:0]    iA, iB,
    input wire                      iCarry,
    output wire [ADDER_WIDTH-1:0]   oSum,
    output wire                     oCarry
    );
    
    wire [BLOCK_SIZE-1:0] wCarry;
    
    ripple_carry_adder_Nb #(.ADDER_WIDTH(BLOCK_WIDTH)) ripple_carry_adder_Nb_lead (
                                        .iA(iA[BLOCK_WIDTH-1:0]),
                                        .iB(iB[BLOCK_WIDTH-1:0]),
                                        .iCarry(iCarry),
                                        .oSum(oSum[BLOCK_WIDTH-1:0]),
                                        .oCarry(wCarry[0]));
    generate 
    genvar i;                                   
    if(BLOCK_SIZE > 1)
    begin 
        for (i=1; i<BLOCK_SIZE; i=i+1) // we generate 1 less because the last one needs to be connected 
        //to be created in a special way where it needs to be connected to the oCarry
        begin
            carry_select_adder_block #(.ADDER_BITS(BLOCK_WIDTH)) carry_select_adder_block_inst (
                                        .iA(iA[(i+1)*(BLOCK_WIDTH)-1:i*BLOCK_WIDTH]),
                                        .iB(iB[(i+1)*(BLOCK_WIDTH)-1:i*BLOCK_WIDTH]),
                                        .iCarry(wCarry[i-1]),
                                        .oSum(oSum[(i+1)*BLOCK_WIDTH-1:i*BLOCK_WIDTH]),
                                        .oCarry(wCarry[i]) );
        end
     end 
    endgenerate
    
   
    
    /*carry_select_adder_block #(.ADDER_BITS(BLOCK_WIDTH)) carry_select_adder_end (
                                        .iA(iA[ADDER_WIDTH-1:ADDER_WIDTH-BLOCK_WIDTH]),
                                        .iB(iB[ADDER_WIDTH-1:ADDER_WIDTH-BLOCK_WIDTH]),
                                        .iCarry(wCarry[BLOCK_SIZE-2]),
                                        .oSum(oSum[ADDER_WIDTH-1:ADDER_WIDTH-BLOCK_WIDTH]),
                                        .oCarry(oCarry));*/
  assign oCarry = wCarry[BLOCK_SIZE -1];
    
endmodule