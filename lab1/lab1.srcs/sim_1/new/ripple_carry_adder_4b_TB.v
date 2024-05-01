`timescale 1ns / 1ps

module ripple_carry_adder_4b_TB;

    reg [3:0] r_iA, r_iB;
    reg       r_iCarry;
    wire [3:0] w_oSum;
    wire       w_oCarry;
    
    ripple_carry_adder_4b ripple_carry_adder_4b_inst ( .iA(r_iA), .iB(r_iB), .iCarry(r_iCarry), .oSum(w_oSum), .oCarry(w_oCarry) );
    
    integer i;

initial
    begin

    $monitor ("(%d + %d + %d) = %d", r_iA, r_iB, r_iCarry, {w_oCarry, w_oSum});  

    // Use a for loop to apply random values to the input  
    for (i = 0; i < 5; i = i+1) 
    begin  
        #10 
        r_iA <= $random;  
        r_iB <= $random;  
        r_iCarry <= $random;  
    end  
end


endmodule
