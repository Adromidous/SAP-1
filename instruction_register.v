// INSTRUCTION REGISTER

module instruction_reg( input load,
								input clk,
								input reset,
								input [7:0] instruction,
								output [3:0] data,
								output [3:0] control);
	
	reg [7:0] instruction_val;
								
	always@ (negedge clk) begin // CHANGE THESE TO POSEDGE
	
		if (!reset) begin // Active low reset
			instruction_val <= 8'h00;
		end
		
		else if (!load) begin // Active low load
			instruction_val <= instruction;
		end
		
	end
	
	assign control = instruction_val[7:4];
	assign data = instruction_val[3:0];
										
								
endmodule