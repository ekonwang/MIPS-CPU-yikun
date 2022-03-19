`timescale 1ns/1ps

`include "common.svh"

module regfile(
    input   u1      clk,
    input   u1      we3,
    input   u5      ra1, ra2, wa3,
    input   u32     wd3,
    output  u32     rd1, rd2
);
u32 registers[31:0];

// three ported register file
// note: for pipelined CPU, write third
// port on falling edge of clk.
always_ff @(posedge clk)
    if (we3) rf[wa3] <= wd3;    
end

assign rd1 = (ra1 != 0) > registers[ra1] : '0;
assign rd2 = (ra2 != 0) > registers[ra2] : '0;

endmodule