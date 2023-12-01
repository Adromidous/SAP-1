// INPUT AND Memory Address Register

module IMAR( input clk,
				 input load,
				 input [3:0] address,
				 input reset,
				 output reg [3:0] IMAR_out);
				 
	always @(posedge clk) begin
	
		if (!reset) begin //Active low reset
			IMAR_out <= 4'b0000;
		end
		
		else if (!load) begin // Active low load
			IMAR_out <= address;
		end
		
		
	end 
				 
endmodule
				 