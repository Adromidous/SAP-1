//EIGHT BIT SAP

module SAP(input clk, 
			  input reset);

wire tb_clk_out;


reg [7:0] bus;
wire [11:0] tb_control;

wire [3:0] tb_instruction_data;
wire [3:0] tb_instruction_control;
wire [7:0] tb_address;

clock tb_clock( .halt(tb_control[11]),
					 .clk_in(clk),
					 .clk_out(tb_clk_out));
							

controller tb_controller(.instruction(tb_instruction_control),
								 .clk(clk),
								 .reset(reset),
								 .control(tb_control));
								 
					


program_counter tb_program_counter(.clk(tb_clk_out),
											  .reset(reset),
											  .enable(tb_control[9]),
											  .count(tb_control[10]),
											  .address(tb_address));
											  
											  

instruction_reg tb_instruction_reg(.load(tb_control[6]),
											  .clk(tb_clk_out),
											  .instruction(bus),
											  .reset(reset),
											  .data(tb_instruction_data),
											  .control(tb_instruction_control));
											  
											  
											  
wire [3:0] tb_IMAR_out;		
									  
IMAR tb_IMAR(.clk(tb_clk_out),
				 .load(tb_control[8]),
				 .address(bus[3:0]),
				 .reset(reset),
				 .IMAR_out(tb_IMAR_out));
				 
				 
wire [7:0] tb_RAM_out;
RAM tb_RAM(.address(tb_IMAR_out),
			  .enable(tb_control[7]),
			  .instruction(tb_RAM_out));

			  
			
wire [7:0] A_val;
wire [7:0] B_val;		

register_A tb_reg_A(.clk(tb_clk_out),
						  .reset(reset),
						  .load(tb_control[4]),
						  .enable(tb_control[3]),
						  .data(bus),
						  .regA_value(A_val));
						  

register_B tb_reg_B(.clk(tb_clk_out),
						  .reset(reset),
						  .load(tb_control[2]),
						  .data(bus),
						  .regB_value(B_val));

						  
wire [7:0] tb_ALU_out;
ALU tb_ALU(.reg_A(A_val),
			  .reg_B(B_val),
			  .op(tb_control[1]),
			  .ALU_out(tb_ALU_out));
			  

always@ (*) begin
	
	if (tb_control[9]) begin // -> PC ENABLE
		bus = tb_address;
	end
	
	else if (!tb_control[7]) begin // -> RAM ENABLE
		bus = tb_RAM_out;
	end
	
	else if (!tb_control[5]) begin // -> INTSTRUCTION REGISTER ENABLE
		bus = {tb_instruction_control, tb_instruction_data};
	end
	
	else if (tb_control[3]) begin // -> A REGISTER ENABLE
		bus = A_val;
	end
	
	else if (tb_control[0]) begin // -> ALU ENABLE
		bus = tb_ALU_out;
	end
	
	else
		bus = 8'h00;
	
end
	
			  
endmodule