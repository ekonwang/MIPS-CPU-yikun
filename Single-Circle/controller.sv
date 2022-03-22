`timescale 1ns/1ps

`include "common.svh"

module controller(
    input u6    op, funct,
    input u1    zero,
    output u1   memtoreg,
    output u1   memwrite,
    output u1   pcsrc,
    output u1   alusrc,
    output u1   regdst,
    output u1   regwrite,
    output u1   jump,
    output u3   alucont   
);
u3  aluop;
u1  branch;

maindec maindec(.op, .memtoreg, .memwrite, .regdst, .regwrite, .jump, .aluop);
aludec  aludec(.funct, .aluop, .alucont);

assign pcsrc = branch & zero;

endmodule