`timescale 1ns/1ps

`include "common.svh"

module datapath(
    input u1    clk, reset,
    input u32   instr,
    input u32   readdata,

    input u1   pcen, regwrite,
    input u1   alusrca, memtoreg, regdst,
    input u2   alusrcb, pcsrc,
    input u3   alucont,

    output u1   zero,
    output u32  pc, aluout, writedata
);
    u5  writereg;
    u32 pcnext;
    u32 writeregdata, rd1, rd2, readreg1, readreg2;
    u32 signimm, signimmsh;
    u32 srca, srcb;
    u32 aluresult;

    always begin 
        #4;
        $display("[pc]       pcsrc=%x   aluout=%x   aluresult=%x   signimmsh=%x    pcnext=%x    pc=%x    signimmsh=%x\n", pcsrc, aluout, aluresult, signimmsh, pcnext, pc, signimmsh);

        $display("[regfile]  regwrite=%x   ra1=%x   ra2=%x   wa3=%x", regwrite, instr[25:21], instr[20:16], writereg);
        $display("           wd3=%x   rd1=%x   rd2=%x    writeregdata=%x\n", writeregdata, rd1, rd2, writeregdata);

        $display("[alu]      srca=%x   srcb=%x   aluresult=%x    alusrcb=%x", srca, srcb, aluresult, alusrcb);
        $display("           alucont=%x   aluout=%x\n", alucont, aluout);
        #6;
    end

    // next pc
    always_ff @(posedge clk or posedge reset) begin
        if (reset)  pc <= PC_start;
        else if(pcen)   pc <= pcnext; 
    end
    // next pc logic
    always_comb begin
        unique case(pcsrc)
            2'b00:  pcnext = aluresult;
            2'b01:  pcnext = aluout;
            2'b10:  pcnext = {pc[31:28], signimmsh[27:0]};
            default: 
                pcnext = 'x;
        endcase
    end


    // register file logic
    regfile regfile(.clk, .we3(regwrite), 
                    .ra1(instr[25:21]), .ra2(instr[20:16]), .wa3(writereg), 
                    .wd3(writeregdata), 
                    .rd1, .rd2); 
    assign writereg     =   regdst ? instr[15:11] : instr[20:16];
    assign writeregdata =   memtoreg ? readdata : aluout; 
    assign writedata    =   readreg2;
    always_ff @(posedge clk) begin
        readreg1 <= rd1;
        readreg2 <= rd2;
    end


    // ALU
    assign signimm      =   {{16{instr[15]}}, instr[15:0]};
    assign signimmsh    =   {signimm[29:0], 2'b00};
    assign srca         =   alusrca ? readreg1 : pc;
    always_comb begin
        case(alusrcb)
            2'b00:  srcb    =   readreg2;
            2'b01:  srcb    =   32'd4;
            2'b10:  srcb    =   signimm;
            2'b11:  srcb    =   signimmsh;
        endcase
    end
    always_ff @(posedge clk) begin
        aluout <= aluresult;
    end
    ALU     alu(.A(srca), .B(srcb), .alucont, .result(aluresult), .zero);

endmodule