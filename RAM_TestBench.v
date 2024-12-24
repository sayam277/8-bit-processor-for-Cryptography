module ram_tb;

    reg [7:0] data;
    reg [7:0] addr;
    reg clk;
    reg we;
    wire [7:0] q;

    ram uut (
        .data(data),
        .addr(addr),
        .clk(clk),
        .we(we),
        .Qout(q)
    );

    initial begin
        clk = 0;
        forever #5 clk = ~clk; 
    end

    initial begin
      
        we = 1;           
        data = 8'h01;     
        addr = 8'd0;      
        
        $display("Write");
        repeat(6) begin
            #10;
            $display("Writing to Address %d: Data = %h", addr, data);
            data = data + 8'h01;  
            addr = addr + 8'd1;   
        end

        #10;
        we = 0;           
        addr = 8'd0;       
        
        $display("Read");
        repeat(6) begin
            #10;
            $display("Reading from Address %d: Data Read = %h", addr, q);
            addr = addr + 8'd1;   
        end

        #130 $finish;
    end
  
  initial begin
    // Waveform
        $dumpfile("ram_tb.vcd");
    	$dumpvars(1, ram_tb);
   end

endmodule
