// CONTROL SEQUENCER

module controller( input [3:0] instruction,
						 input clk,
						 input reset,
						 output[11:0] control);
		
		reg [11:0] ctrl_reg; //USED TO MODIFY THE SIGNALS SO THAT IT CAN BE OUTPUTTED IN THE END
		
		
		//12 BIT CONTROL SIGNAL FOR ALL MODULES IN SAP-1
		
		localparam HALT_BIT     = 11; // ACTIVE HIGH SIGNAL
		localparam PC_COUNT_BIT = 10; // ACTIVE HIGH SIGNAL
		localparam PC_EN_BIT    =  9; // ACTIVE HIGH SIGNAL
		localparam MEM_LOAD_BIT =  8; // ACTIVE LOW SIGNAL
		localparam MEM_EN_BIT   =  7; // ACTIVE LOW SIGNAL
		localparam IR_LOAD_BIT  =  6; // ACTIVE LOW SIGNAL
		localparam IR_EN_BIT    =  5; // ACTIVE LOW SIGNAL
		localparam A_LOAD_BIT   =  4; // ACTIVE LOW SIGNAL
		localparam A_EN_BIT     =  3; // ACTIVE HIGH SIGNAL
		localparam B_LOAD_BIT   =  2; // ACTIVE LOW SIGNAL
		localparam ALU_OP_BIT   =  1; // 0 -> ADD, 1 -> SUB
		localparam ALU_EN_BIT   =  0; // ACTIVE HIGH SIGNAL
		
		
		//OPCODES
		
		reg [5:0] ring_counter;
		
		localparam HLT = 4'b0000;
		localparam LDA = 4'b0001;
		localparam ADD = 4'b0010;
		localparam SUB = 4'b0011;
		
		always@ (negedge clk or negedge reset) begin
			
			if (!reset) begin
				ring_counter <= 6'b000001;
			end
			
			else begin
				if (ring_counter == 6'b100000) begin
					ring_counter <= 6'b000001;
				end
				
				else begin
					ring_counter <= ring_counter << 1;
				end
			end
			
		end
		
		
		
		// 6 CYCLES, FIRST 3 ARE FETCH CYCLES, LAST 3 ARE EXECUTION CYCLES
		
		always@ (posedge clk) begin
		
			ctrl_reg <= 12'b000111110100; //DEFAULT 12 BIT CONTROL SIGNAL WHEN EVERYTHING IS RESET
			
			case (ring_counter)
			
				6'b000001: begin //T1 STATE - 12'b001011110100
					ctrl_reg[PC_EN_BIT] <= 1; // ENABLE PROGRAM COUNTER TO OUTPUT ADDRESS ONTO BUS
					ctrl_reg[MEM_LOAD_BIT] <= 0; // LOAD IMAR TO STORE ADDRESS
					
				end
				
				6'b000010: begin //T2 STATE - 12'b010111110100
					ctrl_reg[PC_COUNT_BIT] <= 1; // INCREMENT COUNTER
				end
			
				6'b000100: begin //T3 STATE - 12'b000100110100;
					ctrl_reg[MEM_EN_BIT] <= 0; // ENABLE RAM TO FETCH DATA AT ADDRESS GIVEN BY IMAR AND OUTPUT ONTO BUS
					ctrl_reg[IR_LOAD_BIT] <= 0; // LOAD INSTRUCTION REGISTER WITH DATA ON BUS
					
				end
				
				6'b001000: begin //T4 STATE
					
					case (instruction)
						HLT: begin
							ctrl_reg[HALT_BIT] <= 1; // HALT THE PROGRAM
						end
						
						LDA: begin //12'b000011010100
							ctrl_reg[IR_EN_BIT] <= 0; // ALLOW INSTRUCTION REGISTER TO OUTPUT OPCODE AND OPERAND ONTO BUS
							ctrl_reg[MEM_LOAD_BIT] <= 0; // LOAD DATA FROM MEMORY SO OPERAND CAN BE FETCHED
						end
						
						ADD: begin
							ctrl_reg[IR_EN_BIT] <= 0; // ALLOW INSTRUCTION REGISTER TO OUTPUT OPCODE AND OPERAND ONTO BUS
							ctrl_reg[MEM_LOAD_BIT] <= 0; // LOAD DATA FROM MEMORY SO OPERAND CAN BE FETCHED
						end
						
						SUB: begin
							ctrl_reg[IR_EN_BIT] <= 0; // ALLOW INSTRUCTION REGISTER TO OUTPUT OPCODE AND OPERAND ONTO BUS
							ctrl_reg[MEM_LOAD_BIT] <= 0; // LOAD DATA FROM MEMORY SO OPERAND CAN BE FETCHED
						end
					endcase
				end
			
				6'b010000: begin //T5 STATE
					
					case (instruction)
						HLT: begin
							ctrl_reg[HALT_BIT] <= 1;
						end
						
						LDA: begin
							ctrl_reg[MEM_EN_BIT] <= 0; // OPERAND IS OUTPUTTED ONTO BUS AND STORED INTO REGISTER A
							ctrl_reg[A_LOAD_BIT] <= 0; // LOAD A WITH CONTENTS ON BUS
						end
						
						ADD: begin
							ctrl_reg[MEM_EN_BIT] <= 0; // OPERAND IS OUTPUTTED ONTO BUS AND STORED INTO REGISTER B
							ctrl_reg[B_LOAD_BIT] <= 0; // LOAD B WITH CONTENTS ON BUS
						end
						
						SUB: begin
							ctrl_reg[MEM_EN_BIT] <= 0; // OPERAND IS OUTPUTTED ONTO BUS AND STORED INTO REGISTER B
							ctrl_reg[B_LOAD_BIT] <= 0; // LOAD A WITH CONTENTS ON BUS
						end
					endcase
				end
				
				6'b100000: begin //T6 STATE
				
					case(instruction)
						
						ADD: begin //12'b000111100101
							ctrl_reg[ALU_EN_BIT] <= 1; // ENABLE ALU TO OUTPUT DATA ONTO BUS -> DEFAULTS TO ADD INSTRUCTION
							ctrl_reg[A_LOAD_BIT] <= 0; // LOAD A REGISTER
						end
						
						SUB: begin
							ctrl_reg[ALU_OP_BIT] <= 1; // SUB INSTRUCTION
							ctrl_reg[ALU_EN_BIT] <= 1; // ENABLE ALU
							ctrl_reg[A_LOAD_BIT] <= 0; // LOAD A REGISTER
						end
					endcase
				end
		
		   endcase
			
		end
	
	assign control = ctrl_reg;
						 
						 
						 
endmodule