`timescale 1ns / 1ps

module tb_alu_fixed_key;

    // Inputs
    reg clk;
    reg reset;
    reg en;
    reg [7:0] data_in;

    // Outputs
    wire [7:0] res_out;
    wire carry_out;
    wire zero_flag;
    wire done;

    // Instantiate the ALU module with fixed key
    alu_fixed_key uut (
        .clk(clk),
        .reset(reset),
        .en(en),
        .data_in(data_in),
        .res_out(res_out),
        .carry_out(carry_out),
        .zero_flag(zero_flag),
        .done(done)
    );

    // Clock signal generation (period = 10ns -> 100 MHz)
    always #5 clk = ~clk;  // Clock toggles every 5 ns (100 MHz frequency)

    // Define the fixed key for the ALU
    reg [7:0] fixed_key = 8'b10101010;  // Fixed XOR key

    // Test sequence
    initial begin
        // Initialize inputs
        clk = 0;
        reset = 1;
        en = 0;
        data_in = 8'b0;   // No data initially

        // Apply reset
        #10 reset = 0;

        // Test sequence begins
        #10 en = 1;  // Enable the ALU
        
        // Sequentially provide input data (plaintext) every 4 clock cycles (40 ns)
        #40 data_in = 8'b11010011;  // First plaintext input
        #40 data_in = 8'b10100101;  // Second plaintext input
        #40 data_in = 8'b01111000;  // Third plaintext input
        #40 data_in = 8'b00110011;  // Fourth plaintext input
        #40 data_in = 8'b11100011;  // Fifth plaintext input
        #40 data_in = 8'b00001111;  // Sixth plaintext input
        #40 data_in = 8'b10110101;  // Seventh plaintext input
        #40 data_in = 8'b01101100;  // Eighth plaintext input
        #40 data_in = 8'b10011010;  // Ninth plaintext input
        #40 data_in = 8'b11111111;  // Tenth plaintext input
        #40 data_in = 8'b00000000;  // Eleventh plaintext input
        #40 data_in = 8'b10000111;  // Twelfth plaintext input
        #40 data_in = 8'b01010101;  // Thirteenth plaintext input
        #40 data_in = 8'b11111000;  // Fourteenth plaintext input
        #40 data_in = 8'b00011101;  // Fifteenth plaintext input

        // Deactivate the enable signal after the test
        #40 en = 0;

        // Wait and finish simulation
        #40 $finish;
    end

    // Monitor signals for debugging, including the fixed key
    initial begin
        $monitor("At time %t, data_in = %b, key = %b, res_out = %b, carry_out = %b, zero_flag = %b, done = %b", 
                  $time, data_in, fixed_key, res_out, carry_out, zero_flag, done);
    end

endmodule