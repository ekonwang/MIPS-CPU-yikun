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
    output u2   aluop
);
u9  controls;

assign {regwrite, regdst, alusrc, branch, memwrite, 
        memtoreg, jump, aluop} = controls;
//always begin
//    # 1; 
//    $display("DEC INPUT -> @%0t op = %x", $time, op);
//    $display("DEC OUTPUT -> @%0t controls = %x", $time, controls);
//end
always_comb begin
    unique case(op)
        `RTYPE  :   controls <= 9'b110000010;
        `LW     :   controls <= 9'b101001000;
        `SW     :   controls <= 9'b001010000; 
        `BEQ    :   controls <= 9'b000100000;
        `ADDI   :   controls <= 9'b101000000;
        `J      :   controls <= 9'b000000100;
        default :   controls <= 9'bxxxxxxxxx;   
    endcase
end

endmodule
