# SAP-1
SAP-1 Computer Architecture

SAP stands for Simple As Possible and it's a great architecture to learn about the main components of any computer architecture and how the logic blocks interact with each other. There are 3 different version of SAP where each one builds off the last and adds more features.

Credits are given to Albert Paul Malvino and Jerald A. Brown for introducing this architecture in their book _Digital Computer Electronics_ and Ben Eater for implementing his own version of the SAP Computer using IC's and breadboards.

The SAP-1 Architecture introduces 4 instructions which include:  
  **1. LDA -> 0001** - Loads Register A with 8 bits of data.  
  **2. ADD -> 0010** - Add contents of Register A and Register B and store in Register A.  
  **3. SUB -> 0011** - Subtract contents of Register B from Register A and store in Register A.  
  **4. HLT -> 0000** - Halt the clock.  

The logic blocks that I developed in this Verilog implementation of the SAP-1 include:

  **1. PROGRAM COUNTER** - The program counter stores the memory address of the current instruction to be executed which is used by the IMAR and RAM to fetch the instruction or data itself. The program counter is 4 bits which means that 16 instructions can be fetched in total. 
  
  **2. IMAR (Input and Memory Address Register)** - The IMAR is used to store the address of the instruction which is to be executed. This address is sent off to RAM where the 8 bit instruction is fetched and placed onto the bus. 
  
  **3. RAM** - The RAM receives a 4 bit address from the IMAR and uses it to output an 8 bit instruction onto the bus. This means the dimensions of the RAM should be atleast 16x8. The **array.txt** file was used to program the RAM with all the instructions and data.  
  
  **4. INSTRUCTION REGISTER** - Once the instruction register receives the 8 bit instruction from the RAM, it divides the instruction into two portions; The 4 MSB are the OPCODE instructions and the 4 LSB are the addresses of the 8 bit OPERAND. For example, the instruction 00011010 has an OPCODE of **0001** and OPERAND of **1010** which means to load the A Register with the data at address 1010 in the RAM.  
  
  **5. CONTROLLER** - The controller controls which logic blocks should be enabled to output data onto the bus or read data from the bus. This is to make sure the timing of the logic blocks are correct and that no logic block reads or outputs data onto the bus when it's not supposed to. Inside the controller exists a ring counter composed of 6 bits. Using **One Hot Encoding**, each of these bits is used to represent one of the 6 states. The first three states are used to fetch the instruction for the instruction register while the final three stages are used to execute the instruction itself.  
  
  **6. A/B Registers** - Although both are general purpose registers, the A Register is used to store values from the ALU unit or load values itself using the LDA instruction while the B register is a register used to hold an 8 bit OPERAND.  

  **7. ALU** - The Arithmetic Logic Unit is a combinational circuit which is used to ADD and SUBTRACT two 8 bit numbers using the ADD and SUB instructions.  

  Below I've included some screenshots of how the timings of each instruction looks like. The first screenshot displays an LDA and ADD instruction while the second screenshot displays a LDA, SUB and HLT instruction.  
  
  ![SAP-1-LDA-ADD](https://github.com/Adromidous/SAP-1/assets/110305385/a6720be5-3009-4312-b2e6-996f5f3ece5e)
   -> By the 6th clock cycle, notice how the A register has the value 10101010 loaded into it. As mentioned above, there are 6 states that the ring counter encodes which is why after 6 clock cycles, the LDA instruction is executed.  
   -> By the 12th clock cycle, the ALU adds 10101010 with 01010101 to get a value of 11111111. This is outputted onto the bus and by the 13th clock cycle, this value is loaded into the A register.

   
  ![SAP-1-LDA-SUB](https://github.com/Adromidous/SAP-1/assets/110305385/f40113b6-d12c-41eb-8a3f-9948e5b7280c)  
  -> By the 6th clock cycle, the A register is loaded with value 10101010.    
  -> By the 12th clock cycle, the B register is also loaded with 10101010. Since the ALU is a combinational circuit, it outputs the result of 00000000 on the bus at the same clock cycle.  
  -> By the 13th clock cycle, the value of 00000000 is stored into register A.  
  -> After this, notice how the tb_clock_out signal is halted at a value of 0. This is because the HALT instruction was executed. 
