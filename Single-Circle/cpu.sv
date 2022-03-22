`timescale 1ns/1ps

`include "common.svh"

module cpu(
    input u1    clk,
    input u1    reset,

    output u32  writedata, 
    output u32  dataaddr,
    output u1   memwrite,
    output u1   rclk
);
u32     pc;
u32     instr;
u32     readdata;

mips mips(.clk(clk), .reset(reset), .instr(instr), .readdata(readdata), 
            .memwrite(memwrite), .pc(pc), .aluout(dataaddr), .writedata(writedata));
imem imem(.addr(pc[7:2]), .readdata(instr));
dmem dmem(.clk(clk), .we(memwrite), .addr(dataaddr), .writedata(writedata),
            .readdata(readdata));
assign rclk = ~clk;
endmodule