`timescale 1ns/1ps

`include "common.svh"

module cpu(
    input u1    clk,
    input u1    reset,

    output u32  writedata, 
    output u32  dataaddr,
    output u1   memwrite
);
u32     pc;
u32     instr;
u32     readdata;

mips mips(.clk, .reset, .instr, .readdata, 
            .memwrite, .pc, .aluout(dataaddr), .writedata);
imem imem(.addr(pc[7:2]), .instr);
dmem dmem(.clk, .we(memwrite), .addr(dataaddr), .writedata(writedata),
            .readdata(readdata));
endmodule