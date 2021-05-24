/////////////////////////////////////////////
///  Testbench: Booth Multiplier Test   \\\\
///  Designed by: Shubhi Agrawal   \\\\\\\\\
///  Date: 07-05-2021     \\\\\\\\\\\\\\\\\\\
/////////////////////////////////////////////

`define MULTIPLIER_BIT_SIZE 3

module test;

 reg [`MULTIPLIER_BIT_SIZE-1:0]inp1,inp2;
 wire [(2*`MULTIPLIER_BIT_SIZE)-1:0]mul_out;

 boothmul gh(inp1,inp2, mul_out);

initial
 begin
  repeat(20)
   begin
     inp1 = {$random};
     inp2 = {$random};
   #10;  
   end
 end

initial
 begin
  $monitor($time," in=%d, in2=%d, out=%d",inp1,inp2,mul_out);
  $dumpfile("mul.vcd");
  $dumpvars;
  #300 $finish;
 end

endmodule