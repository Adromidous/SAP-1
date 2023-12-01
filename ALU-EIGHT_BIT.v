// 8 BIT ALU -> ADD/SUB INSTRUCTIONS

module ALU ( input [7:0] reg_A,
				 input [7:0] reg_B,
				 input op, // If OP=0 -> ADD, OP=1 -> SUB
				 output [7:0] ALU_out 

);
	reg [7:0] ALU_reg;

	always@ (*) begin
	
		if (!op) begin
			ALU_reg = reg_A + reg_B;
		end
		
		else if (op) begin
			ALU_reg = reg_A - reg_B;
		end
		
	end
	
	assign ALU_out = ALU_reg;

endmodule