`timescale 1ns/100ps

module tb_half_adder;

	reg tb_a;
	reg tb_b;
	
	wire tb_sum;
	wire tb_carry;
	
	half_adder half_adder0 (	.a(tb_a),
										.b(tb_b),
										.sum(tb_sum),
										.carry(tb_carry));
	
	initial begin
		tb_a = 1'b0;
		tb_b = 1'b0;
		
		#10; // Delay of 10ns
		
		tb_a = 1'b0;
		tb_b = 1'b1;
		
		#10; // Delay of 10ns
		
		tb_a = 1'b1;
		tb_b = 1'b0;
		
		#10; // Delay of 10ns
		
		tb_a = 1'b1;
		tb_b = 1'b1;
		
		#10; // Delay of 10ns
		$stop;
	end

endmodule