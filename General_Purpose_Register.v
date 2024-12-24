// Code your design here
module registers(
    input clk,               
    input we_reg,                // Write enable
  	input [1:0] reg_select,  // Register select: 00 -> A, 01 -> B, 10 -> o/p
    input [7:0] data_in,     
    output reg [7:0] A,      
    output reg [7:0] B,      
  	output reg [7:0] out  
);

always @(posedge clk) begin
  if (we_reg) begin
        case (reg_select)
            2'b00: A <= data_in;      
            2'b01: B <= data_in;      
            2'b10: out<= data_in; 
            default: ;                // No operation
        endcase
    end
end

endmodule