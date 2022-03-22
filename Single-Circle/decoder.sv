`timescale 1ns/1ps

`include "common.svh"

module maindec(
    input u6    op,
    output u1   memtoreg,
    output u1   memwrite,
    output u1   branch,
    output u1   alusrc,
    output u1   regdst,
    output u1   regwrite,
    output u1   jump,
    output u3   aluop
);
u10  controls;

assign {regwrite, regdst, alusrc, branch, memwrite, 
        memtoreg, jump, aluop} = controls;
//always begin
//    # 1; 
//    $display("DEC INPUT -> @%0t op = %x", $time, op);
//    $display("DEC OUTPUT -> @%0t controls = %x", $time, controls);
//end
always_comb begin
    unique case(op)
<<<<<<< HEAD
        `RTYPE  :   controls <= 9'b110000010;
        `LW     :   controls <= 9'b101001000;
        `SW     :   controls <= 9'b001010000; 
        `BEQ    :   controls <= 9'b000100000;
        `ADDI   :   controls <= 9'b101000000;
        `J      :   controls <= 9'b000000100;
=======
        `RTYPE  :   controls <= {6'b1100000, `ALU_NO_USE};
        `LW     :   controls <= {6'b1010010, `ALU_ADD};
        `SW     :   controls <= {6'b0010100, `ALU_ADD}; 
        `BEQ    :   controls <= {6'b0001000, `ALU_ADD};
        `ADDI   :   controls <= {6'b1010000, `ALU_ADD};
        `J      :   controls <= {6'b0000001, `ALU_ADD};
>>>>>>> 57beae46c4741aa759e613a552f5c1964c4431d0
        default :   controls <= 9'bxxxxxxxxx;   
    endcase
end

endmodule
