// REGISTER B

module register_B ( input clk,
						  input reset,
						  input load,
						  input [7:0] data,
						  output [7:0] regB_value);
						  
		reg [7:0] reg_B_data;
		
		always @(posedge clk) begin

			if (!reset) begin // Active low reset
				reg_B_data <= 8'h00;
			end
			
			else if (!load) begin // Active low load
				reg_B_data <= data;
			end
		
		end
		
		assign regB_value = reg_B_data; //We want to drive the signal on the same clock cycle, not wait another cycle.
						  
endmodule