`ifndef _COMMON_SVH_
`define _COMMON_SVH_

`timescale 1ns/1ps

// ALU 
`ALU_AND  =   3`b000
`ALU_OR   =   3`b001
`ALU_ADD  =   3`b010
`ALU_RAND =   3`b100
`ALU_ROR  =   3`b101
`ALU_SUB  =   3`b110
`ALU_SLT  =   3`b111

// types
typedef logic[63:0]     u64;
typedef logic[31:0]     u32;
typedef logic[15:0]     u16;
typedef logic[7:0]      u8;
typedef logic[6:0]      u7;
typedef logic[5:0]      u6;
typedef logic[4:0]      u5;
typedef logic[3:0]      u4;
typedef logic[2:0]      u3;
typedef logic[1:0]      u2;
typedef logic           u1;

`endif