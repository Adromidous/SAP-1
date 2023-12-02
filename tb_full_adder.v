`timescale 1ns/1ns

module tb_full_adder;

reg tb_a, tb_b, tb_cin;
wire tb_sum, tb_cout;

full_adder full_adder0( .a(tb_a),
								.b(tb_b),
								.cin(tb_cin),
								.cout(tb_cout),
								.sum(tb_sum));
								
								
	initial begin
		tb_a = 1'b0;
		tb_b = 1'b0;
		tb_cin = 1'b0;
		
		#10;
		
		tb_a = 1'b1;
		tb_b = 1'b0;
		tb_cin = 1'b0;
		
		#10;
		
		tb_a = 1'b0;
		tb_b = 1'b1;
		tb_cin = 1'b0;
		
		#10;
		
		tb_a = 1'b1;
		tb_b = 1'b1;
		tb_cin = 1'b0;
		
		#10;
		
		tb_a = 1'b0;
		tb_b = 1'b0;
		tb_cin = 1'b1;
		
		#10;
		
		tb_a = 1'b1;
		tb_b = 1'b0;
		tb_cin = 1'b1;
		
		#10;
		
		tb_a = 1'b0;
		tb_b = 1'b1;
		tb_cin = 1'b1;
		
		#10;
		
		tb_a = 1'b1;
		tb_b = 1'b1;
		tb_cin = 1'b1;
		
		#10;
		
		$stop;
	end
	
endmodule