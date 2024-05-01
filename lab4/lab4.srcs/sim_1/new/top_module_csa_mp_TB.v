`timescale 1ns / 1ps

module top_module_csa_mp_TB();

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
  localparam OPERAND_WIDTH_inst = 128;
  localparam ADDER_WIDTH_inst = 32;
  localparam NBYTES_inst = 4;
  
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
 
  // Input stimulus
  initial
    begin
      rRx = 1;
      rRst = 1;
      #(5*CLOCK_PERIOD);
      rRst = 0;
      #(5*CLOCK_PERIOD);
      // NO A
      for (i=0; i<16; i=i+1)
      begin
        rRx=1; //START BIT
        #(CLOCK_PERIOD);
        rRx=1;
        #(CLOCK_PERIOD);
        rRx=1;
        #(CLOCK_PERIOD);
        rRx=0;
        #(CLOCK_PERIOD);
        rRx=1;
        #(CLOCK_PERIOD);
        rRx=0;
        #(CLOCK_PERIOD);
        rRx=1;
        #(CLOCK_PERIOD);
        rRx=1;
        #(CLOCK_PERIOD);
        rRx=0;
        #(CLOCK_PERIOD);
        rRx=0;
      end
      //NO B
      for (i=0; i<16; i=i+1)
      begin
        rRx=1; //START BIT
        #(CLOCK_PERIOD);
        rRx=0;
        #(CLOCK_PERIOD);
        rRx=1;
        #(CLOCK_PERIOD);
        rRx=1;
        #(CLOCK_PERIOD);
        rRx=1;
        #(CLOCK_PERIOD);
        rRx=1;
        #(CLOCK_PERIOD);
        rRx=0;
        #(CLOCK_PERIOD);
        rRx=0;
        #(CLOCK_PERIOD);
        rRx=0;
        #(CLOCK_PERIOD);
        rRx=0;
      end
      
      
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
      #(50*CLOCK_PERIOD);
            
      $stop;
           
    end


endmodule