// File: processor_tb.v
`timescale 1ns / 1ps

module ControlUnit_tb;

    // Testbench signals
    reg rst;
    reg clk;
    reg [7:0] c_data_in;
    reg [7:0] c_addr_in;
    reg manual_we;
    reg [7:0] alu_res_in;

    wire [7:0] c_data_out;
    wire [7:0] c_addr_out;
    wire c_we;
//    wire ld_A;
//    wire ld_B;
//    wire ld_C;
    wire [7:0] c_out_A;
    wire [7:0] c_out_B;
    wire [7:0] c_out_C;
    //wire alu_en;

    // Instantiate the ControlUnit module
    ControlUnit uut (
        .rst(rst),
        .clk(clk),
        .c_data_in(c_data_in),
        .c_addr_in(c_addr_in),
        .manual_we(manual_we),
        .alu_res_in(alu_res_in),
        .c_data_out(c_data_out),
        .c_addr_out(c_addr_out),
        .c_we(c_we),
//        .ld_A(ld_A),
//        .ld_B(ld_B),
//        .ld_C(ld_C),
        .c_out_A(c_out_A),
        .c_out_B(c_out_B),
        .c_out_C(c_out_C)
        //.alu_en(alu_en)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns clock period
    end

    // Test sequence
    initial begin
        // Initialize signals
//        rst = 1;
//        manual_we = 0;
//        c_data_in = 8'd0;
//        c_addr_in = 8'd0;
//        alu_res_in = 8'd0;

        // Reset the system
         rst = 0;

        // Step 1: Load instructions and data into memory using manual_we
        manual_we = 1;

        // Load instruction: Feed immediate data into memory (opcode: 00010000)
//        c_addr_in = 8'd0; c_data_in = 8'b00010000; #10;
//        c_addr_in = 8'd1; c_data_in = 8'd10;      #10; // Address to store
//        c_addr_in = 8'd2; c_data_in = 8'd99;      #10; // Data to store

        // Load instruction: Load immediate value into Reg A (opcode: 00100000)
        c_addr_in = 8'd0; c_data_in = 8'b00100000; #10;
        c_addr_in = 8'd1; c_data_in = 8'h1f;       #10; // Immediate value
        
        // Load instruction: Load immediate value into Reg A (opcode: 00100000)
        c_addr_in = 8'd2; c_data_in = 8'b00110000; #10;
        c_addr_in = 8'd3; c_data_in = 8'h34;       #10; // Immediate value

        // Load instruction: ALU Encryption (opcode: 01100000)
        c_addr_in = 8'd4; c_data_in = 8'b01100000; #10;

        // Turn off manual write enable
        manual_we = 0;

        // Step 2: Reset the system to start instruction execution
        rst = 1; #10; rst = 0;

        // Step 3: Observe execution
        #300 $stop; // Observe the execution for 100ns
    end
endmodule