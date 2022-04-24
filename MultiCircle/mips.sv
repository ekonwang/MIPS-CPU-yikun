`timescale 1ns/1ps

`include "common.svh"

module mips(
    input u1    clk, reset,
    input u32   instr, 
    input u32   readdata,

    output u1   iord, memwrite, irwrite, 
    output u32  pc,
    output u32  aluout, writedata
);
    u1  zero;
    u1  pcen, irwrite, regwrite;
    u1  alusrca, memtoreg, regdst;
    u2  alusrcb, pcsrc;         // note that `pcsrc` is 2-bit-width.
    u3  alucont;

    controller controller(
        .clk, .reset,
        .op(instr[31:25]), .funct(instr[5:0]),
        .zero,

        .pcen, .memwrite, .irwrite, .regwrite,
        .alusrca, .iord, .memtoreg, .regdst,
        .alusrcb, .pcsrc,
        .alucont
    );

    datapath datapath(
        
    );

endmodule