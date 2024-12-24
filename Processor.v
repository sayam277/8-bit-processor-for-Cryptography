// File: Processor_Top
module ControlUnit (
    // Input Pins
    input wire rst,                    // Reset signal
    input wire clk,                    // Clock signal
    input wire [7:0] c_data_in,        // External data input
    input wire [7:0] c_addr_in,        // External address input
    input wire manual_we,              // Manual write enable
    input wire [7:0] alu_res_in,       // ALU result input
    input wire [7:0]mem_data_in,
    // Output Pins
    output reg [7:0] c_data_out,       // Data to memory
    output reg [7:0] c_addr_out,       // Address to memory
    output reg c_we,                   // Write enable to memory
//    output reg ld_A,                   // Load enable for register A
//    output reg ld_B,                   // Load enable for register B
//    output reg ld_C,                   // Load enable for register C
    output reg [7:0] c_out_A,          // Data output to register A
    output reg [7:0] c_out_B,          // Data output to register B
    output reg [7:0] c_out_C          // Data output to register C
//    output reg alu_en                  // ALU encryption/decryption mode
);
 
    
    // Internal Registers
    reg [7:0] instruction_reg;         // Current instruction register

    reg [7:0] PC;         // Program counter

    reg [2:0] counter;
    reg start;
    reg [7:0] temp1;
    reg [7:0] temp2;
    

//    // Memory Instantiation
    Memory memory_unit (
        .data_in(c_data_out),          // Connect c_data_out to memory's data_in
        .data_out(mem_data_in),        // Connect memory's data_out to mem_data_in
        .address(c_addr_out),          // Connect c_addr_out to memory's address
        .we(c_we),                     // Connect c_we to memory's write enable
        .clk(clk)                      // Connect clock to memory's clock
    );
    
    
    always@(*) begin
        if(manual_we) begin
            c_data_out = c_data_in;
            c_addr_out = c_addr_in;
            c_we = 1;
        end
    end
    
    
  

    // Opcodes
    
    localparam OPCODE_LD_IMM_A     = 8'b00100000;
    localparam OPCODE_LD_IMM_B     = 8'b00110000;
    localparam OPCODE_ALU_ENCRYPT  = 8'b01100000;
    localparam OPCODE_ALU_DECRYPT  = 8'b01110000;
    

    // Control Logic
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            // Reset all outputs and internal registers
            PC = 8'd0;
            instruction_reg = 8'd0;
//            operand_reg = 8'd0;
            c_data_out = 8'd0;
            c_addr_out = 8'd0;
            c_we = 1'b0;
            //ld_A = 1'b0;
            //ld_B = 1'b0;
            //ld_C = 1'b0;
            c_out_A = 8'd0;
            c_out_B = 8'd0;
            c_out_C = 8'd0;
            //alu_en = 1'b0;
            start = 0;
            counter = 0;
            
        end else begin
            if(~start) begin
                if(counter == 0) begin
                     c_addr_out = PC;
                     c_we = 0;
                     counter = counter + 1;
                end else if(counter == 1) begin
                    counter = counter + 1;
                end else if(counter == 2) begin
                    instruction_reg = mem_data_in;
                    PC = PC + 1;
                    counter = 0;
                    start = 1;
                end
            end else begin 
                case(instruction_reg)
//                    OPCODE_FEED_IMM_MEM: begin
//                            if(counter == 0) counter = counter + 1;
//                            if(counter == 1) begin
//                                c_addr_out = PC;
//                                c_we = 0;
//                                counter = counter + 1;
//                            end else if(counter == 2) begin
//                                temp1 = mem_data_in;
//                                PC = PC + 1;
//                                counter = counter + 1;
//                                c_addr_out = PC;                                
//                            end else if(counter == 3) begin
//                                temp2 = mem_data_in;
//                                PC = PC + 1;
//                                counter = counter + 1;
//                                c_addr_out = temp1;
//                                c_data_out = temp2;
//                                c_we = 1;
//                            end else if(counter == 4)
//                                counter = counter + 1;
//                            else if(counter == 5) begin
//                                 c_addr_out = PC;
//                                 c_we = 0;
//                                 counter = counter + 1;
//                            end else if(counter == 6) 
//                                counter = counter + 1;
//                            else if(counter == 7) begin
//                                instruction_reg = mem_data_in;
//                                PC = PC + 1;
//                                counter = 0;
//                            end 
                                
//                         end
                 OPCODE_LD_IMM_A: begin
                            if(counter == 0) begin
                                c_addr_out = PC;
                                counter = counter + 1;
                                c_we = 0;                           
                            end else if(counter == 1) begin                              
                                counter = counter + 1;
                            end else if(counter == 2) begin
                            temp1 = mem_data_in;
                                PC = PC + 1;
                                //ld_A = 1;
                                c_out_A = temp1;
                                counter = counter + 1;
                            end else if(counter == 3)              
                                  counter = counter + 1;                                    
                            else if(counter == 4) begin
                                 //ld_A = 0;
                                 c_addr_out = PC;
                                 c_we = 0;
                                 counter = counter + 1;
                            end else if(counter == 5) 
                                counter = counter + 1;
                                else if(counter == 6)begin
                                instruction_reg = mem_data_in;
                                PC = PC + 1;
                                counter = 0;
                            end 
                 end
                 
                OPCODE_LD_IMM_B: begin
                            if(counter == 0) begin
                                c_addr_out = PC;
                                counter = counter + 1;
                                c_we = 0;                           
                            end else if(counter == 1) begin                              
                                counter = counter + 1;
                            end else if(counter == 2) begin
                            temp1 = mem_data_in;
                                PC = PC + 1;
                                //ld_B = 1;
                                c_out_B = temp1;
                                counter = counter + 1;
                            end else if(counter == 3)              
                                  counter = counter + 1;                                    
                            else if(counter == 4) begin
                                 //ld_B = 0;
                                 c_addr_out = PC;
                                 c_we = 0;
                                 counter = counter + 1;
                            end else if(counter == 5) 
                                counter = counter + 1;
                                else if(counter == 6)begin
                                instruction_reg = mem_data_in;
                                PC = PC + 1;
                                counter = 0;
                            end 
                 end 
                   
                 OPCODE_ALU_ENCRYPT : begin
                            if(counter == 0)begin
                            c_out_C = ((c_out_A*2) + 5)^c_out_B;
                            //alu_en = 1;
                            //ld_C = 1;
                            //PC = PC + 1;
                            counter = counter + 1;                            
                    end else if(counter == 1)              
                                  counter = counter + 1;                                    
                            else if(counter == 2) begin
                                 c_addr_out = PC;
                                 c_we = 0; 
                                 //ld_C = 0;                                
                                 counter = counter + 1;
                            end else if(counter == 3) begin 
                            instruction_reg = mem_data_in; 
                            PC = PC + 1;                          
                            counter = 0;
                    end                 
                 end 
                 
                 OPCODE_ALU_DECRYPT : begin
                            if(counter == 0)begin
                            c_out_C = ((c_out_A^c_out_B)-5)/2;
                            //alu_en = 0;
                            //ld_C = 1;
                            //PC = PC + 1;
                            counter = counter + 1;                            
                    end else if(counter == 1)              
                                  counter = counter + 1;                                    
                            else if(counter == 2) begin
                                 c_addr_out = PC;
                                 c_we = 0;
                                 //ld_C = 0;
                                 counter = counter + 1;
                            end else if(counter == 3) begin 
                            instruction_reg = mem_data_in;
                            PC = PC + 1;
                            counter = 0;
                    end                 
                 end         
                
                endcase
            end
        end
   end
endmodule