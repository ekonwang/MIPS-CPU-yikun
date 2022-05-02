`timescale 1ns/1ps

`include "common.svh"

module cpu(
    input u1    clk,
    input u1    reset,

    output u32  writedata, 
    output u32  dataaddr,
    output u32  pc,
    output u1   memwrite
);
    u32     instr, readdata;
    u1      iord, memwrite, irwrite;
    u32     wirtedata;

    mips mips(.clk, .reset, .instr, .readdata, 
                .iord, .memwrite, .irwrite, 
                .pc, 
                .aluout(dataaddr), .writedata);

    mem mem(.clk, .memwrite, .writedata, .pc, .dataaddr, .iord, .irwrite,
                .instr, .readdata);

    always begin 
        #8;
        $display("[mem]     memwrite=%x writedata=%x pc=%x dataaddr=%x iord=%x irwrite=%x", memwrite, writedata, pc, dataaddr, iord, irwrite);
        $display("          instr=%x readdata=%x\n", instr, readdata);
        #2;
    end

endmodule