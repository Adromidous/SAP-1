//4 BIT PROGRAM COUNTER

module program_counter( input clk,
					 input reset,
					 input enable,
					 input count,
					 output [3:0] address);
	
	
	reg [3:0] counter; // 4 BIT COUNTER
					 
	
	always @ (posedge clk) begin
	
		if (!reset) begin
			counter <= 4'b0000;
		end
		
		else if (count)
			counter <= counter + 1'b1;
	end
	
	assign address = counter; //Can use assign here as PC isn't read every clock cycle

					 
					 
endmodule