`timescale 1ns/1ps

`include "common.svh"

module ALU #(
    N = 32
) (
    input logic [N-1:0] A,
    input logic [N-1:0] B,
    input logic [2:0]   ALUcont,
    output logic [N-1:0]  result,
    output logic        zero    
);
always_comb begin
    unique case(ALUcont)
        `ALU_ADD    : result = A + B;
        `ALU_AND    : result = A & B; 
        `ALU_OR     : result = A | B; 
        `ALU_RAND   : result = A & ~B; 
        `ALU_ROR    : result = A | ~B; 
        `ALU_SLT    : result = A < B ? '1 : '0;
        `ALU_SUB    : result = A - B;
        default     : result = '0;
    endcase
end
assign zero = !result;
    
endmodule
