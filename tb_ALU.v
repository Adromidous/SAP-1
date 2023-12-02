//ALU Testbench
`timescale 1ns/1ns

module tb_ALU;

	reg [7:0] tb_reg_A;
	reg [7:0] tb_reg_B;
	reg tb_op;
	wire [7:0] tb_ALU_out;
	
	ALU ALU0 (.reg_A(tb_reg_A),
				 .reg_B(tb_reg_B),
				 .op(tb_op),
				 .ALU_out(tb_ALU_out));

	initial begin
	
		tb_reg_A = 8'h00;
		tb_reg_B = 8'h00;
		tb_op = 1'b0;
		
		#10;
		
		tb_reg_A = 8'h54;
		tb_reg_B = 8'h1A;
		tb_op = 1'b0;
		
		#10;
		
		tb_reg_A = 8'hCA;
		tb_reg_B = 8'hFE;
		tb_op = 1'b0;
		
		#10;
		
		tb_reg_A = 8'h00;
		tb_reg_B = 8'h00;
		tb_op = 1'b1;
		
		#10;
		
		tb_reg_A = 8'hBA;
		tb_reg_B = 8'hBE;
		tb_op = 1'b1;
		
		#10;
		
		tb_reg_A = 8'h38;
		tb_reg_B = 8'h69;
		tb_op = 1'b1;
		
		#10;
		
		$stop;
	end 


endmodule

