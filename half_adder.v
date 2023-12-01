// HALF ADDER -> 1 BIT

module half_adder (
	input a, b,
	output sum, carry
);

assign sum = a ^ b;
assign carry = a & b;

endmodule
