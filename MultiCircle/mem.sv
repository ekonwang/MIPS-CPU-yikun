`timescale 1ns/1ps

`include "common.svh"

module mem(
    input u1        clk,
    input u1        we,
    input u32       addr,
    input u32       writedata,

    output u32      readdata
);
u32     data[63:0];
assign  readdata = data[addr[31:2]];
always @(posedge clk) begin
    if (we) data[addr[31:2]] <= writedata;
end
endmodule