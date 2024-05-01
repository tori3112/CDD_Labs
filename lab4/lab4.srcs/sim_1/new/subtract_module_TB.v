`timescale 1ns / 1ps


module subtract_module_TB;
    parameter ADDER_WIDTH = 8;
    
    reg [ADDER_WIDTH-1:0]   r_iA, r_iB;
    wire [ADDER_WIDTH-1:0]  w_oSum;
    wire                    w_oCarry;
    
    subtract_module #( .ADDER_BITS(ADDER_WIDTH)) subtract_module_inst
    ( .iA(r_iA), .iB(r_iB), .oSum(w_oSum), .oCarry(w_oCarry) );
    
    integer i; //this is a variable to control the testing loop
    
    initial
        begin
            $monitor ("%d - %d = %d", r_iA, r_iB, {w_oCarry, w_oSum});
            
            for (i=0; i<5; i=i+1)
            begin
                #10
                r_iA <= $random;
                r_iB <= $random;
            end
        end
    
    
endmodule