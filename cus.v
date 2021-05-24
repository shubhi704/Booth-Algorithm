/////////////////////////////////////////////
///  Design: Booth Multiplier   \\\\\\\\\\\\\\
///  Designed by: Shubhi Agrawal   \\\\\\\\\
///  Date: 07-05-2021     \\\\\\\\\\\\\\\\\\\
/////////////////////////////////////////////


`define MULTIPLIER_BIT_SIZE 3

`timescale 1ns/1ns
module boothmul(
        input [`MULTIPLIER_BIT_SIZE-1:0]a,b,
        output  [(2*`MULTIPLIER_BIT_SIZE)-1:0] c
        );

	wire [(`MULTIPLIER_BIT_SIZE-1):0] Q [`MULTIPLIER_BIT_SIZE:0];
	wire [(`MULTIPLIER_BIT_SIZE-1):0]A [`MULTIPLIER_BIT_SIZE:0]  ;
	wire [`MULTIPLIER_BIT_SIZE:0] q0;
	
        genvar i;

        booth_substep step1(`MULTIPLIER_BIT_SIZE'd0,a,1'b0,b,A[1],Q[1],q0[1]);

        generate for ( i = 1; i < (`MULTIPLIER_BIT_SIZE) ; i=i+1)
            booth_substep step[i+1](A[i], Q[i], q0[i],b,A[i+1],Q[i+1],q0[i+1]);
        endgenerate
     assign c = {A[`MULTIPLIER_BIT_SIZE],Q[`MULTIPLIER_BIT_SIZE]} ;	 
endmodule

module booth_substep(
 input  [`MULTIPLIER_BIT_SIZE-1:0]A,Q,
 input  q0,
 input  [`MULTIPLIER_BIT_SIZE-1:0]M,
 output [`MULTIPLIER_BIT_SIZE-1:0]A_,Q_,
 output  Q_1 );

 wire [`MULTIPLIER_BIT_SIZE-1:0] sum,difference;
 
 assign {A_,Q_,Q_1} = ((Q[0] < q0) ? {sum[`MULTIPLIER_BIT_SIZE-1],sum,Q} : ((Q[0] > q0)  ? {difference[`MULTIPLIER_BIT_SIZE-1], difference,Q} : {A[`MULTIPLIER_BIT_SIZE-1],A,Q}) )  ; 
 
 ALU sub( A,~M,1'b1,difference);
 ALU add( A,M,1'b0,sum);
endmodule 

module ALU(b,a,cin,sum);
	input [`MULTIPLIER_BIT_SIZE-1:0] a,b;
        input  cin;
	output  [`MULTIPLIER_BIT_SIZE-1:0]sum;

   assign sum = a + b + cin;
endmodule 
   

