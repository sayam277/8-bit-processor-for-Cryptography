// Code your testbench here
module tb_registers;

reg clk;
reg we_reg;
reg [1:0] reg_select;
reg [7:0] data_in;
wire [7:0] A;
wire [7:0] B;
wire [7:0] out;

registers uut (
    .clk(clk),
    .we_reg(we_reg),
    .reg_select(reg_select),
    .data_in(data_in),
    .A(A),
    .B(B),
    .out(out)
);

// Clock generation
initial begin
    clk = 0;
    forever #5 clk = ~clk;  
end

// Test procedure
initial begin
    we_reg = 0;
    reg_select = 2'b00;
    data_in = 8'b00000000;
    
    #10;
    
    // Test 1: Register A
    we_reg = 1;
    reg_select = 2'b00;    
    data_in = 8'b10101010; 
    #10;                   

    // Test 2: Register B
    reg_select = 2'b01;    
    data_in = 8'b11001100; 
    #10;                   

    // Test 3: Register out
    reg_select = 2'b10;    
    data_in = 8'b11110000; 
    #10;                     

    $finish;
end

  
initial begin
    // Waveform
        $dumpfile("tb_registers.vcd");
    	$dumpvars(1, tb_registers);
   end

endmodule
