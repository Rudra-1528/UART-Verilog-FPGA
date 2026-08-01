`timescale 1ns / 1ps



module tb();
reg clk,start;
reg [7:0] txin;
wire [7:0] rxout;
wire txdone , rxdone;

wire txrx;

top dut(clk,start,txin,txrx,txrx,rxout,rxdone,txdone);

initial
 begin
  clk = 0;
  start =0;
  #50;
 end 
always #5 clk = ~clk ;

integer i=0;

initial 
 begin
  start = 1;
  for ( i=0; i<10; i=i+1)
  begin 
    txin = $urandom_range(10, 200);
    @(posedge rxdone);
    @(posedge txdone);
  end
 $stop;   
  end

endmodule
