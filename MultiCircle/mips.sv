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
    u1  pcen, regwrite;
    u1  alusrca, memtoreg, regdst;
    u2  alusrcb, pcsrc;         // note that `pcsrc` is 2-bit-width.
    u3  alucont;

    controller controller(
        .clk, .reset,
        .op(instr[31:26]), .funct(instr[5:0]),
        .zero,

        .pcen, .memwrite, .irwrite, .regwrite,
        .alusrca, .iord, .memtoreg, .regdst,
        .alusrcb, .pcsrc,
        .alucont
    );

    datapath datapath(
        .clk, .reset,
        .instr,
        .readdata,

        .pcen, .regwrite,
        .alusrca, .memtoreg, .regdst,
        .alusrcb, .pcsrc,
        .alucont,

        .zero,
        .pc, .aluout, .writedata
    );

    always begin 
        #7;
        $display("[controller] instr=%x pcen=%x, memwrite=%x irwrite=%x regwrite=%x", instr, pcen, memwrite, irwrite, regwrite);
        $display("             alusrca=%x iord=%x memtoreg=%x regdst=%x", alusrca, iord, memtoreg, regdst);
        $display("             alusrcb=%x pcsrc=%x alucont=%x\n", alusrcb, pcsrc, alucont);

        $display("[datapath]   readdata=%x",readdata);
        $display("             zero=%x, pc=%x, aluout=%x, writedata=%x\n", zero, pc, aluout, writedata);
        #3;
    end

endmodule