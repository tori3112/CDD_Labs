`timescale 1ns / 1ps

module top_module_mpadder_sub_TB;

// Define signals for module under test
  reg  rClk = 0;
  reg  rRst = 0;
  wire wTx;
  
  
  // for the echo test
  reg rRx = 0;
  
  // We downscale the values in the simulation
  // this will give CLKS_PER_BIT = 100 / 10 = 10
  localparam CLK_FREQ_inst  = 100;
  localparam BAUD_RATE_inst = 10;
  localparam OPERAND_WIDTH_inst = 16;
  localparam ADDER_WIDTH_inst = 8;
  
  // Instantiate DUT  
  uart_top 
  #(  .CLK_FREQ(CLK_FREQ_inst), .BAUD_RATE(BAUD_RATE_inst), .OPERAND_WIDTH(OPERAND_WIDTH_inst), .ADDER_WIDTH(ADDER_WIDTH_inst) )
  uart_top_inst
  ( .iClk(rClk), .iRst(rRst), .iRx(rRx), .oTx(wTx) );
  
  // Define clock signal
  localparam CLOCK_PERIOD = 0.1;
  
  always
    #(0.01/2) rClk <= !rClk;
 
  // Input stimulus
  initial
    begin
      rRx = 1;
      rRst = 1;
      #(5*CLOCK_PERIOD);
      rRst = 0;
      #(5*CLOCK_PERIOD);
      
      
      //THIS IS A
      //BYTE 1
      
       rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0; //START BIT
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      
       rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0; //START BIT
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      
      
      
      
      
      //THIS IS B
      //BYTE 1
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0; //START BIT
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0; //START BIT
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      
      
      
      //THIS is the operation
      //BYTE 1
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0; //START BIT
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
     
            
      // Let it run for a while
      #(15*CLOCK_PERIOD);
            
      $stop;
           
    end


endmodule
