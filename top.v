`timescale 1ns / 1ps



module top(
    input clk,
    input start,
    input [7:0] txin,
    output reg tx,
    input rx,
    output [7:0] rxout,
    output rxdone, txdone
    );
      
  parameter clk_value = 100_000;
  parameter baud = 9600;
  
  parameter wait_count = clk_value / baud;
  
  reg bitdone = 0;
  integer count = 0;
  parameter idle =0, send = 1, check = 2;
  reg [1:0] state =idle;
  
  
  
  //////////////////////////// baud rate
  
  always @(posedge clk)
  begin 
    
    if(state == idle)
      count <=0;
    else 
      begin
        if (count == wait_count)
         begin
            count <=0;
            bitdone <=1;
          end
         else 
          begin
            count <= count + 1;
            bitdone <= 0;
          end 
       end 
    end            
  
  
  
  
  //////////////////////////////////// TX 
  
  reg [9:0] txData,shiftx;
  integer bitindex;
  
  always @(posedge clk)
   begin
    case (state)
     idle:
       begin 
         tx <= 1'b1;
         txData <= 0;
         bitindex <=0;
         shiftx <= 0;
         
         if (start == 1)
          begin
            txData <= {1'b1,txin,1'b0};
            state <= send ;
          end 
         else
          state <= idle;
       end 
      
       
      send :
        begin
          tx <= txData[bitindex];
          state <= check ;
          shiftx <= {txData,shiftx[9:1]};
         end
           
      check :
         begin
            if (bitindex <= 9)
              begin
               if (bitdone == 1)
                begin
                 state <= send;
                 bitindex <= bitindex + 1;
                end 
               else
                state <= check; 
              end
            else
              state <= idle ;
          end
        
        default : state <= idle;
        
      endcase
    end                       
             
     assign txdone = (bitindex == 9 && bitdone == 1'b1)? 1'b1 : 1'b0;
          
          
          
          
 /////////////////////////////////// RX 

 integer rcount ,rindex;
 parameter ridle = 0, rwait = 1, recv =2;
 reg [1:0] rstate;
 reg [9:0] rxdata;
   
 always @(posedge clk)
 begin
   case (rstate)
    ridle :
         begin
           rindex <= 0;
           rcount <= 0;
           rxdata <= 0;
          
          if ( rx == 1'b0)
            rstate <= rwait; 
          else
            rstate <= ridle;
         end
       
    
    rwait:
     begin
       begin
      if (rcount < wait_count/2)
       begin
         rcount <= rcount +1;
         rstate <= rwait;
       end
     else 
     begin     
       rcount <= 0;
       rstate <= recv;
       rxdata <= {rx,rxdata[9:1]};
      end
      end 
     end 
      
    recv:
      begin
        if (rindex <= 9)
         begin
          if (bitdone == 1'b1)
            begin
              rindex <= rindex + 1;
              rstate <= rwait;
             end 
           end 
         else 
            rstate <= ridle;
        end    
     default : rstate <= ridle;
   endcase
  end 
  assign rxdone = (rindex == 9 && bitdone == 1'b1)? 1'b1 : 1'b0;       
  
  assign rxout = rxdata[8:1];
endmodule
