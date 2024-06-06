`timescale 1ns / 1ps

module main_memory#(
// Parameters
parameter AWIDTH        = 9,    //Address Bus width
parameter DWIDTH        = 8        //Data Bus Width
)(
input clk,
input reset_n,
input rd_mem,
input wr_mem,
inout [DWIDTH-1:0] data,
input [AWIDTH-1:0]  addr_mem,
output  ready_mem
    );
   reg [DWIDTH-1:0] ram_block [0:511];
   reg [DWIDTH-1:0] data_out;
  // Memory initialization
initial
begin
    $readmemb("/home/cse/Thales/test_code/memory.txt",ram_block );
end
   always @(negedge clk) begin

   if (!reset_n)
   data_out<='b0;

   if (wr_mem)
   ram_block[addr_mem] <= data;

   if (rd_mem ) begin
   data_out <= ram_block[addr_mem];
   end
   end
   assign data= rd_mem ? data_out : 'bz;
   assign ready_mem= (wr_mem | rd_mem ) ? 1'b0:1'b1; 
endmodule
