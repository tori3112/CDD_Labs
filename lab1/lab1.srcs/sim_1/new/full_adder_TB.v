`timescale 1ns / 1ps

module full_adder_TB;

    reg r_iA, r_iB, r_iCarry;
    wire w_oSum, w_oCarry;
    
    full_adder full_adder_inst ( .iA(r_iA), .iB(r_iB), .iCarry(r_iCarry), .oSum(w_oSum), .oCarry(w_oCarry) );
    
    initial
        begin
            //
            r_iA = 0; r_iB = 0; r_iCarry = 0;
            #50;
            if (w_oSum != 0 | w_oCarry != 0)    $display("test vector 1 failed");
            else                                $display("test vector 1 passed");
            //
            r_iA = 0; r_iB = 0; r_iCarry = 1;
            #50;
            if (w_oSum != 1 | w_oCarry != 0)    $display("test vector 2 failed");
            else                                $display("test vector 2 passed");
            //
            r_iA = 0; r_iB = 1; r_iCarry = 0;
            #50;
            if (w_oSum != 1 | w_oCarry != 0)    $display("test vector 3 failed");
            else                                $display("test vector 3 passed");
            r_iA = 0; r_iB = 1; r_iCarry = 1;
            #50;
            if (w_oSum != 0 | w_oCarry != 1)    $display("test vector 4 failed");
            else                                $display("test vector 4 passed");
            r_iA = 1; r_iB = 0; r_iCarry = 0;
            #50;
            if (w_oSum != 1 | w_oCarry != 0)    $display("test vector 5 failed");
            else                                $display("test vector 5 passed");
            r_iA = 1; r_iB = 0; r_iCarry = 1;
            #50;
            if (w_oSum != 0 | w_oCarry != 1)    $display("test vector 6 failed");
            else                                $display("test vector 6 passed");
            r_iA = 1; r_iB = 1; r_iCarry = 0;
            #50;
            if (w_oSum != 0 | w_oCarry != 1)    $display("test vector 7 failed");
            else                                $display("test vector 7 passed");
            r_iA = 1; r_iB = 1; r_iCarry = 1;
            #50;
            if (w_oSum != 1 | w_oCarry != 1)    $display("test vector 8 failed");
            else                                $display("test vector 8 passed");
            
            $stop;
            
            end
            
    
endmodule
