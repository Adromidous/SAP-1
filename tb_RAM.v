// RAM TESTBENCH
`timescale 1ns/1ns

module tb_RAM;

	reg [3:0] tb_address;
	wire [7:0] tb_operation;

	RAM RAM0( .address(tb_address),
				 .operation(tb_operation));
			 
	initial begin
	
		tb_address = 4'b0000;
		
		#10;
		
		tb_address = 4'b0001;
		
		#10;
		
		tb_address = 4'b0010;
		
		#10;
		
		tb_address = 4'b1111;
		
		#10;
		
		$stop;
	end
endmodule