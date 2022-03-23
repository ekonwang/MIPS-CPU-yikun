`timescale 1ns/1ps

`include "common.svh"

module simtop();
u32 A, B, result;
u3  ALUcont;
u1  zero;

ALU ALU(.A, .B, .ALUcont, .result, .zero);

//$result = 2 and 7 = 2
//$result = 2 or 4 = 6
//$result = 6 + 3 = 9
//$result = 9 RAND 1 = 8
//$result = 8 ROR 32'hfffffff8 = 15
//$result = 15 - 4 = 11
//$result = 11 slt 12 = 1
//$result = 11 slt 11 = 0
//$result = 11 + 33 = 44
//$result = 44 - 22 = 22
 
always begin
    #10 A = 32'd2; B = 32'd7; ALUcont = `ALU_AND; 
    #10 A = result; B = 32'd4; ALUcont = `ALU_OR;
    #10 A = result; B = 3; ALUcont = `ALU_ADD; 
    #10 A = result; B = 32'd1; ALUcont = `ALU_RAND; 
    #10 A = result; B = 32'hfffffff8; ALUcont = `ALU_ROR; 
    #10 A = result; B = 32'd4; ALUcont = `ALU_SUB;
    #10 A = result; B = 12; ALUcont = `ALU_SLT;
    #10 B = 11; ALUcont = `ALU_SLT;
    #10 B = 33; ALUcont = `ALU_ADD;
    #10 A = result; B = 22; ALUcont = `ALU_SUB;
    #10 $stop;
end
 // #10 $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);

always begin
    #1 $display("@%0t simulation begin", $time);
    #10 if (result !== 2) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 6) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 9) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 8) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 15) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 11) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 1) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 0) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 44) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 22) begin
            $display("@%0t simulation failed", $time);
        end
    $display("@%0t simulation passed", $time);
    $stop;
end

endmodule

// complete 
// random