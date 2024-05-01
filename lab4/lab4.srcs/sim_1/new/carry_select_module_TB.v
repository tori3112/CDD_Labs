`timescale 1ns / 1ps

module carry_select_module_TB;

    parameter ADDER_WIDTH = 32;
    parameter BLOCK_WIDTH = 8;
    parameter BLOCK_SIZE = ADDER_WIDTH/BLOCK_WIDTH;
    
    reg [ADDER_WIDTH-1:0]   r_iA, r_iB;
    reg                     r_iCarry;
    wire [ADDER_WIDTH-1:0]  w_oSum;
    wire                    w_oCarry;
    
    carry_select_adder_module #(.ADDER_WIDTH(ADDER_WIDTH), .BLOCK_WIDTH(BLOCK_WIDTH), .BLOCK_SIZE(BLOCK_SIZE) )
     carry_select_adder_inst
    ( .iA(r_iA), .iB(r_iB), .iCarry(r_iCarry), .oSum(w_oSum), .oCarry(w_oCarry) );
    
    integer i; //this is a variable to control the testing loop
    
    initial
        begin
            $monitor ("%d+%d +%d = %d", r_iA, r_iB, r_iCarry, {w_oCarry, w_oSum});
            
            for (i=0; i<5; i=i+1)
            begin
                #10
                r_iA <= $random;
                r_iB <= $random;
                r_iCarry <= $random;
            end
        end
    
endmodule
