`timescale 1ns/1ps

`include "common.svh"

module datapath(
    input u1    clk,
    input u1    reset,
    input u1    memtoreg,
    input u1    pcsrc,
    input u1    alusrc,
    input u1    regdst,
    input u1    regwrite,
    input u1    jump,
    input u3    alucont,
    input u32   instr,
    input u32   readdata,

    output u1   zero,
    output u32  pc,
    output u32  aluout,
    output u32  writedata
);
u5  writereg;
u32 pcnext, pcnextbr, pcplus4, pcbranch;
u32 signimm, signimmsh;
u32 srca, srab;
u32 result;

// next PC
flopr #(32) pcreg(clk, reset, pcnext, pc);
assign pcplus4      =   pc + 32'd4;
assign signimmsh    =   {signimm[29:0], 2'b00};
assign pcbranch     =   pcplus4 + signimmsh;
assign pcnextbr     =   pcsrc ? pcbranch : pcplus4;
assign pcnext       =   jump ? {pcplus4[31:28], instr[25:0], 2'b00} : pcnextbr;

// register file logic
regfile regfile(.clk, .we3(regwrite), .ra1(instr[25:21]), .ra2(instr[20:16]), .wa3(writereg),
                .wd3(result), .rd1(srca), .rd2(writedata)); 
assign writereg     =   regdst ? instr[15:11] : instr[20:16];
assign result       =   memtoreg ? readdata : aluout; 
assign signimm      =   {{16{instr[15]}}, instr[15:0]};

// ALU
assign srcb         =   alusrc ? signimm : writedata;
ALU     alu(.A(srca), .B(srcb), .alucont, .result, .zero);

endmodule