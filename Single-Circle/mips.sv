`timescale 1ns/1ps

`include "common.svh"

module mips(
    input u1    clk, 
    input u1    reset,
    input u32   instr, 
    input u32   readdata,

    output u1   memwrite,
    output u32  pc,
    output u32  aluout, 
    output u32  writedata
);

u1  memtoreg;
u1  alusrc;
u1  regdst;
u1  regwrite;
u1  jump;
u1  pcsrc;
u1  zero;

u3  alucont;

 always begin
     # 2; 
     $display("MIPS INPUT        -> @%0t clk = %x, reset = %x, instr = %x, readdata = %x", $time, clk, reset, instr, readdata);
     $display("CONTROLLER OUTPUT -> @%0t memtoreg = %x, memwrite = %x, pcsrc = %x, alusrc = %x, regdst = %x, regwrite = %x, jump = %x, alucont = %x", 
             $time, memtoreg, memwrite, pcsrc, alusrc, regdst, regwrite, jump, alucont);
     $display("DATAPATH OUTPUT   -> @%0t aluout = %x, pc = %x, zero = %x, writedata = %x", $time, aluout, pc, zero, writedata);
 end

controller controller(
    .op(instr[31:26]),
    .funct(instr[5:0]),
    .zero,

    .memtoreg,
    .memwrite,
    .pcsrc,
    .alusrc,
    .regdst,
    .regwrite,
    .jump,
    .alucont
);

datapath datapath(
    .clk,
    .reset,
    .memtoreg,
    .pcsrc,
    .alusrc,
    .regdst,
    .regwrite,
    .jump,
    .alucont,
    .instr,
    .readdata,

    .zero,
    .pc,
    .aluout,
    .writedata
);

endmodule