`timescale 1ns / 1ps

module uart_top_TB ();
 
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
  
  // Instantiate DUT  
  uart_top 
  #(  .CLK_FREQ(CLK_FREQ_inst), .BAUD_RATE(BAUD_RATE_inst) )
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
      
      //BYTE 1
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
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      //BYTE 2
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
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      
      //BYTE 3
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
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      
      //BYTE 4
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
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      
      //BYTE 5
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
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      
      //BYTE 6
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
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      //BYTE 7
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
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      //BYTE 8
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
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      
      //BYTE 9
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
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      //BYTE 10
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
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      
      //BYTE 11
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
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      //BYTE 12
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
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1;
      #(CLOCK_PERIOD);
      rRx = 0;
      #(CLOCK_PERIOD);
      rRx = 1; //END BIT
      
      
      
      
            
      // Let it run for a while
      #(105*CLOCK_PERIOD);
            
      $stop;
           
    end
   
endmodule