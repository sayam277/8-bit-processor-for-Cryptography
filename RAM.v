// Code your design here
module ram( 
	input [7:0]data, 
    input [7:0]addr, 
	input clk, 
	input we, 
    output reg [7:0]Qout 
    );
  
reg[7:0]ram[255:0]; //8*256 bit ram
reg[7:0]addr_reg;
    
always @(posedge clk)
    begin 
    if(we)
      ram[addr] <= data; //Write
    else
    addr_reg <= addr;  //Read
end
  
assign  Qout = ram[addr_reg];
    
endmodule