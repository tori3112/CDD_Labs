`timescale 1ns / 1ps

module uart_top #(
    parameter   OPERAND_WIDTH = 512,
    parameter   ADDER_WIDTH   = 32,
    parameter   NBYTES        = OPERAND_WIDTH / 8,
    // values for the UART (in case we want to change them)
    parameter   CLK_FREQ      = 125_000_000,
    parameter   BAUD_RATE     = 115_200
  )  
  (
    input   wire   iClk, iRst,
    input   wire   iRx,
    output  wire   oTx
  );
  
  // Buffer to exchange data between Pynq-Z2 and laptop
  //reg [NBYTES*8-1:0] rBuffer; //[95:0] 
  
  reg [NBYTES*8-1:0] rA,rB;
  reg [7:0]          rOperation;
  
  
  // State definition  
  localparam s_IDLE         = 3'b000; //0
  localparam s_WAIT_RX_A    = 3'b001; //1
  localparam s_WAIT_RX_B    = 3'b010; //2
  localparam s_WAIT_OP      = 3'b011; //3
  localparam s_MP_ADDER     = 3'b100; //4
  localparam s_TX           = 3'b101; //5
  localparam s_WAIT_TX      = 3'b110; //6
  localparam s_DONE         = 3'b111; //7
   
  // Declare all variables needed for the finite state machine 
  // -> the FSM state
  reg [2:0]   rFSM;  
  
  // Connection to UART TX (inputs = registers, outputs = wires)
  reg         rTxStart;
  reg [7:0]   rTxByte;  //Z
  
  wire        wTxBusy;
  wire        wTxDone;
  
  wire [7:0]  wRxByte; //Z
  wire        wRxDone;
  
  reg       riStart;
  
  wire[NBYTES*8:0] wRes;
  wire wDone;
  reg[(NBYTES+1)*8-1:0] rRes;
  
  
  uart_rx #(    .CLK_FREQ(CLK_FREQ), .BAUD_RATE(BAUD_RATE) )
  UART_RX_INST
    (.iClk(iClk),
     .iRst(iRst),
     .iRxSerial(iRx),
     .oRxByte(wRxByte), //output is a wire
     .oRxDone(wRxDone)
    );
      
      
  mp_adder #(.OPERAND_WIDTH(OPERAND_WIDTH),.ADDER_WIDTH(ADDER_WIDTH))
  MP_ADDER_INST
  (.iClk(iClk),
  .iRst(iRst),
  .iStart(riStart),
  .iOpA(rA),
  .iOpB(rB),
  .oRes(wRes),
  .oDone(wDone));
  
  uart_tx #(  .CLK_FREQ(CLK_FREQ), .BAUD_RATE(BAUD_RATE) )
  UART_TX_INST
    (.iClk(iClk),
     .iRst(iRst),
     .iTxStart(rTxStart),
     .iTxByte(rTxByte),  //input is a register
     .oTxSerial(oTx),
     .oTxBusy(wTxBusy),
     .oTxDone(wTxDone)
     );
     
 
  
            
  reg [$clog2(NBYTES):0] rCnt;
  
  always @(posedge iClk)
  begin
  
  // reset all registers upon reset
  if (iRst == 1 ) 
    begin
      rFSM <= s_IDLE;
      rTxStart <= 0;
      rCnt <= 0;
      rTxByte <= 0;
      rA <= 0;
      rB <= 0;
      riStart <= 0;
      rOperation <= 0;
    end 
  else 
    begin
      case (rFSM)
        s_IDLE :
          begin
             rFSM <= s_WAIT_RX_A;
             rA <= 0;
             rB <= 0;
             rRes <= 0;
             rOperation <= 0;
             rCnt <=0;
          end
          
        s_WAIT_RX_A :
          begin
          if (rCnt < NBYTES)
              begin
              rFSM <= s_WAIT_RX_A;
              if (wRxDone)
                  begin
                  rA <= { rA[(NBYTES)*8-9 : 0], wRxByte  };
                  rCnt <= rCnt+1;
                  end
              end
          else 
             begin
                rCnt <= 0;
                rFSM <= s_WAIT_RX_B; 
             end                     
          end
             
             
         s_WAIT_RX_B :
          begin
          if (rCnt < NBYTES)
              begin
              rFSM <= s_WAIT_RX_B;
              if (wRxDone)
                  begin
                  rB <= { rB[(NBYTES)*8-9 : 0], wRxByte  };
                  rCnt <= rCnt+1;
                  end
              end
          else 
             begin
                rCnt <= 0;
                riStart = 1;
                rFSM <= s_WAIT_OP; 
             end   
          end
          
       s_WAIT_OP:
        begin
            if (rCnt < 1)
            begin
                rFSM <= s_WAIT_OP;
                if (wRxDone)
                begin
                    rOperation <= {wRxByte};
                    rCnt <= rCnt+1;
                end
            end
            else
            begin
                if (rOperation == 8'b0000001)
                begin
                    rB <= ~rB +1;
                end
                rCnt <= 0;
                riStart <= 1;
                rFSM <= s_MP_ADDER;
            end
        end   
          
       s_MP_ADDER:
       begin
        riStart = 0;
        if(wDone)
        begin
        rRes <= {7'b0000000, wRes};
        rFSM <= s_TX;
        end
        else 
        begin
        rRes <= rRes;
        rFSM <= s_MP_ADDER;
        end
       end   
                  
        s_TX :
          begin
            if ( rCnt < NBYTES+1  && (wTxBusy == 0) ) 
              begin
                rFSM <= s_WAIT_TX;
                rTxStart <= 1; 
                rTxByte <= rRes[(NBYTES+1)*8-1:(NBYTES+1)*8-8];    // we send the uppermost byte
                rRes <= {rRes[(NBYTES+1)*8-9:0] , 8'b00000000};    // we shift from right to left
                rCnt <= rCnt + 1;
              end 
            else 
              begin
                rFSM <= s_DONE;
                rTxStart <= 0;
                rTxByte <= 0;
                rCnt <= 0;
                rRes <= rRes;
              end
            end 
            
            s_WAIT_TX :
              begin
                if (wTxDone)
                begin
                  rFSM <= s_TX;
                  rTxStart <= rTxStart;
                end 
                else
                begin
                  rFSM <= s_WAIT_TX;
                  rTxStart <= 0;
                end
              end 
              
            s_DONE :
              begin
                rFSM <= s_IDLE;
              end
              

            default :
              rFSM <= s_IDLE;
             
          endcase
      end
    end       
        
endmodule