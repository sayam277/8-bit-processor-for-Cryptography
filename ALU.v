module alu_fixed_key (
    input clk,
    input reset,
    input en,
    //input reg[7:0] key,
    input [7:0] data_in,        // Input data (plaintext)
    output reg [7:0] res_out,   // Output data (ciphertext)
    output reg carry_out,
    output reg zero_flag,
    output reg done
);

    reg [7:0] key = 8'b10101010;  // Fixed XOR key

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            // Reset all outputs
            res_out <= 8'b0;
            carry_out <= 0;
            zero_flag <= 0;
            done <= 0;
        end else if (en) begin
            // Perform XOR operation (encryption)
            res_out <= data_in ^ key;
            
            // Set carry_out to 0 because XOR doesn't generate a carry
            carry_out <= 0;
            
            // Check if result is zero
            zero_flag <= (res_out == 8'b0) ? 1'b1 : 1'b0;
            
            // Set done flag to 1 to indicate operation completion
            done <= 1'b1;
        end else begin
            done <= 1'b0;
        end
    end

endmodule