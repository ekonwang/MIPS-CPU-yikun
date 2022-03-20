`timescale 1ns/1ps

`include "common.svh"

module simtop();
u32 A, B, result;
u3  ALUcont;
u1  zero;

ALU ALU(.A, .B, .ALUcont, .result, .zero);

initial begin
    
    #10 A = 32'd150; B = 32'd50; ALUcont = `ALU_AND; 
    #10 $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);

    #10 A = 32'd1; B = 32'd2; ALUcont = `ALU_OR;
    #10 $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);

    #10 A = 32'd10000; B = 32'd32; ALUcont = `ALU_ADD; 
    #10 $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);

    #10 A = 32'd1; B = 32'd0; ALUcont = `ALU_RAND; 
    #10 $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);

    #10 A = 32'd1; B = 32'd0; ALUcont = `ALU_ROR; 
    #10 $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);

    #10 A = 32'd100; B = 32'd50; ALUcont = `ALU_SUB;
    #10 $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);

    #10 A = 32'd10; B = 32'd5; ALUcont = `ALU_SLT;
    #10 $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);

    #10 A = 32'd10; B = 32'd11; ALUcont = `ALU_SLT;
    #10 $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);
end
endmodule

// complete 
// random