/////////////////////////////////////////////
///  Testbench: Booth Multiplier Test   \\\\
///  Designed by: Shubhi Agrawal   \\\\\\\\\
///  Date: 07-05-2021     \\\\\\\\\\\\\\\\\\\
/////////////////////////////////////////////

`timescale 1ns/1ns
module booth_test;

 reg [7:0]inp1,inp2;
 wire [15:0]mul_out;

 boothmul gh(inp1,inp2, mul_out);

initial
 begin
  repeat(10)
   begin
     inp1 = $random;
     inp2 = $random;
   #10;  
   end
  #5 inp1 = 0; inp2 = 8'd67;
  #5 inp2 = 0; inp1 = 8'd67;
  #5 inp1 = 8'd0; inp2 = 8'd0;
  #5 inp1 = 8'd255; inp2 = 8'd255;
  #5 inp1 = 8'd256; inp2 = 8'd255;
 end

initial
 begin
  $monitor($time," in=%d, in2=%d, out=%d",inp1,inp2,mul_out);
  $dumpfile("mul.vcd");
  $dumpvars(0,booth_test);
  #300 $stop;
 end

endmodule