// CLOCK MODULE FOR ENTIRE SAP COMPUTER

module clock(	input halt,
					input clk_in,
					output reg clk_out);
					
	always @(*) begin
	
		if (halt)
			clk_out = 1'b0;
		
		else
			clk_out = clk_in;
	end
	

endmodule
					