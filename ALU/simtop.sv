`timescale 1ns/1ps

`include "common.svh"

module simtop();
u32 A, B, result;
u3  ALUcont;
u1  zero;

ALU ALU(.A, .B, .ALUcont, .result, .zero);

initial begin
    A = '0; B = '0; ALUcont = `ALU_ADD; 
    $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);
    
    #1 A = 32'd150; B = 32'd50; ALUcont = `ALU_AND; 
    $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);

    #1 A = 32'd100; B = 32'd50; ALUcont = `ALU_SUB;
    $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);

    #1 A = 32'd1; B = 32'd2; ALUcont = `ALU_OR;
    $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);

    #1 A = 32'd10; B = 32'd5; ALUcont = `ALU_SUB;
    $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);
end
endmodule

// complete 
// random