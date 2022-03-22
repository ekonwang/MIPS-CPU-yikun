`timescale 1ns/1ps

`include "common.svh"

module aludec(
    input u6    funct,
    input u3    aluop,
    output u3   alucont
);
always_comb begin
    unique case(aluop)
        `ALU_NO_USE:
            unique case(funct)  // RTYPE
                `FUNCT_ADD  :   alucont <= `ALU_ADD;
                `FUNCT_SUB  :   alucont <= `ALU_SUB;
                `FUNCT_AND  :   alucont <= `ALU_AND;
                `FUNCT_OR   :   alucont <= `ALU_OR;
                `FUNCT_SLT  :   alucont <= `ALU_SLT;
                default     :   alucont <= 3'bxxx;
            endcase
        default: 
            alucont <= aluop;
    endcase
end 
endmodule

module ALU #(
    parameter N = 32
) (
    input logic [N-1:0]     A,
    input logic [N-1:0]     B,
    input logic [2:0]       ALUcont,
    output logic [N-1:0]    result,
    output logic            zero    
);
always_comb begin
    unique case(ALUcont)
        `ALU_AND    : result = A & B; 
        `ALU_OR     : result = A | B; 
        `ALU_ADD    : result = A + B;

        `ALU_RAND   : result = A & ~B; 
        `ALU_ROR    : result = A | ~B; 
        `ALU_SUB    : result = A - B;
        `ALU_SLT    : result = A < B ? 1 : 0;
        default     : result = 'x;
    endcase
end
assign zero = !result;
    
endmodule
