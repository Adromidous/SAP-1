// EIGHT BIT SAP CPU TESTBENCH
`timescale 1ns/1ns

module tb_SAP;

	// PROGRAM STARTS HERE //

	reg tb_clk, tb_reset;

	SAP SAP0 (.clk(tb_clk),
				 .reset(tb_reset));
			

	initial begin
		tb_reset <= 0;
		#5 tb_reset <= 1;
		#5 tb_reset <= 0;
		#5 tb_reset <= 1;
	end
	
	initial begin
		tb_clk <= 0;
		forever begin
			#10 tb_clk <= ~tb_clk;
		end
	end

endmodule


											  