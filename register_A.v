// REGISTER A

module register_A( input clk,
						 input reset,
						 input load,
						 input enable,
						 input [7:0] data,
						 output [7:0] regA_value);
						 
	reg [7:0] value_A;

	always @(posedge clk) begin
		
		if (!reset) begin // Active low reset
			value_A <= 8'h00;
		end
		
		else if (!load) begin // Active low load
			value_A <= data;
		end
		
	end
	
	assign regA_value = value_A;
						 
						 
endmodule