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
u1  beq, exec_beq;
u1  bne, exec_bne;
//always begin
//    # 1; 
//    $display("CONT INPUT -> @%0t op = %x, funct = %x", $time, op, funct);
//end
maindec maindec(.op, .memtoreg, .memwrite, .beq, .bne, .alusrc, .regdst, .regwrite, .jump, .aluop);
aludec  aludec(.funct, .aluop, .alucont);

assign exec_beq = beq & zero;
assign exec_bne = bne & !zero;
assign pcsrc = exec_beq | exec_bne;

endmodule