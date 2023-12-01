// RING COUNTER
// USED TO GENERATE T-STATES (T1...T6)

module ring_counter( input clk,
							input reset,
							output reg [5:0] t_state);
							

	always @(negedge clk) begin // Negedge is used here to set the T state since all other modules change on the posedge of clk signal
		if (!reset) begin // Active low reset to keep all reset signals consistent
			t_state <= 6'b000001;
		end
		
		else begin
			if (t_state == 6'b100000)
				t_state <= 6'b000001;
			
			else
				t_state <= t_state << 1; //Shift t_state
		
		end
	end
							
endmodule