//16x8 RAM

module RAM ( input [3:0] address,
				 input enable,
				 output reg [7:0] instruction);
	
	reg [7:0] memory [0:15]; // 8 bit wide vector array with depth of 16
	
	
	initial begin
		instruction = 8'h00;
		$readmemb("D:/Quartus/SAP_EIGHT_BIT/array.txt", memory); // Preload memory with array.txt file
	end
	
	always @(!enable)	begin //Active low chip enable
		instruction <= memory[address];
	end	
				 
				 
endmodule