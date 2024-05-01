`timescale 1ns / 1ps

module top_module_sub_TB;

// Define signals for module under test
  reg  rClk = 0;
  reg  rRst = 0;
  wire wTx;
  
  
  // for the echo test
  reg rRx = 0;
  reg rSub = 0;
    
  // We downscale the values in the simulation
  // this will give CLKS_PER_BIT = 100 / 10 = 10
  localparam CLK_FREQ_inst  = 100;
  localparam BAUD_RATE_inst = 10;
  localparam OPERAND_WIDTH_inst = 64;
  localparam ADDER_WIDTH_inst = 32;
  localparam NBYTES_inst = 4;
  
  reg [OPERAND_WIDTH_inst-1:0] rA, rB;
  
  // Instantiate DUT  
  uart_top 
  #(  .CLK_FREQ(CLK_FREQ_inst), .BAUD_RATE(BAUD_RATE_inst), .OPERAND_WIDTH(OPERAND_WIDTH_inst), .ADDER_WIDTH(ADDER_WIDTH_inst) )
  uart_top_inst
  ( .iClk(rClk), .iRst(rRst), .iRx(rRx), .oTx(wTx) );
  
  // Define clock signal
  localparam CLOCK_PERIOD = 0.1;
  
  integer i;
  
  always
    #(0.01/2) rClk <= !rClk;
    
    
  initial
  begin
      rRx = 1;
      rRst = 1;
      rA = 0;
      rB = 0;
      rSub = 0;
      #(5*CLOCK_PERIOD);
      rRst = 0;
      #(5*CLOCK_PERIOD);
      
      rA = 64'hb0bdb93141c72263;
      rB = 64'ha05fb82784652939;
      
      #(5*CLOCK_PERIOD);
      
      rRx=1; //START BIT
      #(CLOCK_PERIOD);
      for (i=0; i<OPERAND_WIDTH_inst; i=i+1)
      begin
        rRx = rA[i];
        #CLOCK_PERIOD;
      end
      #CLOCK_PERIOD;
      rRx=0;
      #CLOCK_PERIOD;
      rRx=1; //START BIT
      #(CLOCK_PERIOD);
      for (i=0; i<OPERAND_WIDTH_inst; i=i+1)
      begin
        rRx = rB[i];
        #CLOCK_PERIOD;
      end
      #(CLOCK_PERIOD);
      rRx=0;
      
      
      #(10*CLOCK_PERIOD);
      
      $stop;
      
      
  end

endmodule
