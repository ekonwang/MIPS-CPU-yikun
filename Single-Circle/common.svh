`ifndef _COMMON_SVH_
`define _COMMON_SVH_

`timescale 1ns/1ps

// ALU 
`define ALU_AND     3'b000
`define ALU_OR      3'b001
`define ALU_ADD     3'b010
`define ALU_NO_USE  3'b011
`define ALU_RAND    3'b100
`define ALU_ROR     3'b101
`define ALU_SUB     3'b110
`define ALU_SLT     3'b111

// ALUDEC
`define FUNCT_ADD   6'b101000
`define FUNCT_SUB   6'b100010
`define FUNCT_AND   6'b100100 
`define FUNCT_OR    6'b100101 
`define FUNCT_SLT   6'b101010 

// types
typedef logic[63:0]     u64;
typedef logic[31:0]     u32;
typedef logic[15:0]     u16;
typedef logic[14:0]     u15;
typedef logic[13:0]     u14;
typedef logic[12:0]     u13;
typedef logic[11:0]     u12;
typedef logic[10:0]     u11;
typedef logic[9:0]      u10;
typedef logic[8:0]      u9;
typedef logic[7:0]      u8;
typedef logic[6:0]      u7;
typedef logic[5:0]      u6;
typedef logic[4:0]      u5;
typedef logic[3:0]      u4;
typedef logic[2:0]      u3;
typedef logic[1:0]      u2;
typedef logic           u1;

// controller
`define RTYPE   6'b000000
`define LW      6'b100011
`define SW      6'b000100
`define BEQ     6'b000100
`define ADDI    6'b000100
`define J       6'b000010


`endif