`ifndef _COMMON_SVH_
`define _COMMON_SVH_

`timescale 1ns/1ps

// @PC_start
parameter PC_start      =       32'h100;

// @ALU 
parameter ALU_AND       =       3'b000;
parameter ALU_OR        =       3'b001;
parameter ALU_ADD       =       3'b010;
parameter ALU_NO_USE    =       3'b011;
parameter ALU_RAND      =       3'b100;
parameter ALU_ROR       =       3'b101;
parameter ALU_SUB       =       3'b110;
parameter ALU_SLT       =       3'b111;

// ALUDEC
parameter FUNCT_ADD     =       6'b100000;
parameter FUNCT_SUB     =       6'b100010;
parameter FUNCT_AND     =       6'b100100;
parameter FUNCT_OR      =       6'b100101; 
parameter FUNCT_SLT     =       6'b101010; 


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


// DECODER 
// leftvalue
parameter RTYPE     =       6'b000000;
parameter LW        =       6'b100011;
parameter SW        =       6'b101011;
parameter BEQ       =       6'b000100;
parameter ADDI      =       6'b001000;
parameter J         =       6'b000010;
parameter BUBBLE    =       6'b000000;
// parameter BNE       =       6'b000101
// parameter ORI       =       6'b001101
// parameter ANDI      =       6'b001100
// parameter SLTI      =       6'b001010

// FSM defines
parameter FETCH     =       4'b0000;
parameter DECODE    =       4'b0001;
parameter MEMADR    =       4'b0010;
parameter MEMRD     =       4'b0011; 
parameter MEMWB     =       4'b0100; 
parameter MEMWR     =       4'b0101; 
parameter RTYPEEX   =       4'b0110; 
parameter RTYPEWB   =       4'b0111; 
parameter BEQEX     =       4'b1000; 
parameter ADDIEX    =       4'b1001; 
parameter ADDIWB    =       4'b1010; 
parameter JEX       =       4'b1011; 

// FSM control code
parameter FETCH_C       =       15'h5010;
parameter DECODE_C      =       15'h0030; 
parameter MEMADR_C      =       15'h0420;
parameter MEMRD_C       =       15'h0100; 
parameter MEMWB_C       =       15'h0880;
parameter MEMWR_C       =       15'h2100; 
parameter RTYPEEX_C     =       15'h0402; 
parameter RTYPEWB_C     =       15'h0840; 
parameter BEQEX_C       =       15'h0605; 
parameter ADDIEX_C      =       15'h0420; 
parameter ADDIWB_C      =       15'h0800; 
parameter JEX_C         =       15'h4008;      

`endif