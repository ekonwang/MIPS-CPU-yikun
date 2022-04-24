`timescale 1ns/1ps

`include "common.svh"

module maindec(
    input u6    op,
    output u1   memtoreg,
    output u1   memwrite,
    output u1   beq,
    output u1   bne,
    output u1   alusrc,
    output u1   regdst,
    output u1   regwrite,
    output u1   jump,
    output u3   aluop
);
u11  controls;

assign {regwrite, regdst, alusrc, beq, bne, memwrite, 
        memtoreg, jump, aluop} = controls;
//always begin
//    # 1; 
//    $display("DEC INPUT -> @%0t op = %x", $time, op);
//    $display("DEC OUTPUT -> @%0t controls = %x", $time, controls);
//end
always_comb begin
    unique case(op)
        `RTYPE  :   controls <= {8'b11000000, `ALU_NO_USE};
        `LW     :   controls <= {8'b10100010, `ALU_ADD};
        `SW     :   controls <= {8'b00100100, `ALU_ADD}; 
        `BEQ    :   controls <= {8'b00010000, `ALU_SUB};
        `BNE    :   controls <= {8'b00001000, `ALU_SUB};
        `ADDI   :   controls <= {`IMM_CONT, `ALU_ADD};
        `ORI    :   controls <= {`IMM_CONT, `ALU_OR};
        `ANDI   :   controls <= {`IMM_CONT, `ALU_AND};
        `SLTI   :   controls <= {`IMM_CONT, `ALU_SLT};
        `J      :   controls <= {8'b00000001, `ALU_ADD};
        default :   controls <= 11'bxxxxxxxxxxx;   
    endcase
end

endmodule
