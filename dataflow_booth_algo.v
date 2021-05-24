/////////////////////////////////////////////
///  Design: Booth Multiplier   \\\\\\\\\\\\\\
///  Designed by: Shubhi Agrawal   \\\\\\\\\
///  Date: 07-05-2021     \\\\\\\\\\\\\\\\\\\
/////////////////////////////////////////////




`timescale 1ns/1ns
module boothmul(
        input [7:0]a,b,
        output [15:0] c
        );

	wire  [7:0]Q0,Q1,Q2,Q3,Q4,Q5,Q6,Q7;
	wire  [7:0] A1,A0,A3,A2;
	wire  [7:0] A4,A5,A6,A7;
	wire [7:0] q0;
	wire qout;
	
	booth_substep step1(8'b00000000,a,1'b0,b,A1,Q1,q0[1]);
	booth_substep step2(A1,Q1,q0[1],b,A2,Q2,q0[2]);
	booth_substep step3(A2,Q2,q0[2],b,A3,Q3,q0[3]);
	booth_substep step4(A3,Q3,q0[3],b,A4,Q4,q0[4]);
	booth_substep step5(A4,Q4,q0[4],b,A5,Q5,q0[5]);
	booth_substep step6(A5,Q5,q0[5],b,A6,Q6,q0[6]);
	booth_substep step7(A6,Q6,q0[6],b,A7,Q7,q0[7]);
	booth_substep step8(A7,Q7,q0[7],b,c[15:8],c[7:0],qout);	 
endmodule

module booth_substep(
 input [7:0]A,Q,
 input  q0,
 input [7:0]M,
 output  [7:0]A_,Q_,
 output  Q_1 );

 wire [7:0] sum,difference;
 
 assign {A_,Q_,Q_1} = ((Q[0] < q0) ? {sum[7],sum,Q} : ((Q[0] > q0)  ? {difference[7], difference,Q} : {A[7],A,Q}) )  ; 
 
 ALU sub( A,~M,1'b1,difference);
 ALU add( A,M,1'b0,sum);
endmodule 

module ALU(b,a,cin,sum);
	input [7:0] a,b;
        input  cin;
	output  [7:0]sum;

   assign sum = a + b + cin;
endmodule 
   

