`timescale 1ns/1ps

`include "common.svh"

module maindec(
    input u6    op,
    output u1   memtoreg,
    output u1   memwrite,
    output u1   regdst,
    output u1   regwrite,
    output u1   jump,
    output u2   aluop
);
u9  controls;

assign {regwrite, regdst, alusrc, branch, memwrite, 
        memtoreg, jump, aluop} = controls;

always_comb
    unique case(op)
        `RTYPE  :   controls <= 9'b110000010;
        `LW     :   controls <= 9'b101001000;
        `SW     :   controls <= 9'b001010000; 
        `BEQ    :   controls <= 9'b000100001;
        `ADDI   :   controls <= 9'b101000000;
        `J      :   controls <= 9'b000000100;
        default :   controls <= 9'bxxxxxxxxx;   
    endcase
end

endmodule
