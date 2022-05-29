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
parameter BNE       =       6'b000101;
parameter ORI       =       6'b001101;
parameter ANDI      =       6'b001100;
parameter SLTI      =       6'b001010;

// FSM defines
parameter FETCH     =       5'b00000;
parameter DECODE    =       5'b00001;
parameter MEMADR    =       5'b00010;
parameter MEMRD     =       5'b00011; 
parameter MEMWB     =       5'b00100; 
parameter MEMWR     =       5'b00101; 
parameter RTYPEEX   =       5'b00110; 
parameter RTYPEWB   =       5'b00111; 
parameter BEQEX     =       5'b01000; 
parameter ADDIEX    =       5'b01001; 
parameter ADDIWB    =       5'b01010; 
parameter JEX       =       5'b01011; 
parameter BNEEX     =       5'b01100;
parameter ORIEX     =       5'b01101;
parameter ORIWB     =       5'b01110;
parameter ANDIEX    =       5'b01111;
parameter ANDIWB    =       5'b10000; 
parameter SLTIEX    =       5'b10001; 
parameter SLTIWB    =       5'b10010;

// FSM control code
parameter FETCH_C       =      14'h1404; 
parameter DECODE_C      =      14'h000c;    
parameter MEMADR_C      =      14'h0108;  
parameter MEMRD_C       =      14'h0040;   
parameter MEMWB_C       =      14'h0220; 
parameter MEMWR_C       =      14'h0840;   
parameter RTYPEEX_C     =      14'h0100;  
parameter RTYPEWB_C     =      14'h0210; 
parameter BEQEX_C       =      14'h0181; 
parameter BNEEX_C       =      14'h2101;
parameter ADDIEX_C      =      14'h0108; 
parameter ADDIWB_C      =      14'h0200; 
parameter JEX_C         =      14'h1002;      

`endif