`timescale 1ns/1ps

`include "common.svh"

module maindec(
    input u6    op,
    output u1   memtoreg,
    output u1   memwrite,
    output u1   regdst,
    output u1   regwrite,
    output u1   jump,
    output u3   aluop
);
u10  controls;

assign {regwrite, regdst, alusrc, branch, memwrite, 
        memtoreg, jump, aluop} = controls;

always_comb begin
    unique case(op)
        `RTYPE  :   controls <= {6'b1100000, `ALU_NO_USE};
        `LW     :   controls <= {6'b1010010, `ALU_ADD};
        `SW     :   controls <= {6'b0010100, `ALU_ADD}; 
        `BEQ    :   controls <= {6'b0001000, `ALU_ADD};
        `ADDI   :   controls <= {6'b1010000, `ALU_ADD};
        `J      :   controls <= {6'b0000001, `ALU_ADD};
        default :   controls <= 9'bxxxxxxxxx;   
    endcase
end

endmodule
