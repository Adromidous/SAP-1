//8 BIT BUS

module eight_bit_bus(input [3:0] data_in,
						   input reset,
							output reg [3:0] data_out);
								

	always@ (*) begin
	
		data_out = 8'b00;
		
		if (!reset) //ACTIVE LOW RESET
			data_out = 8'b00;
		
		else
			data_out = data_in;
	end
endmodule