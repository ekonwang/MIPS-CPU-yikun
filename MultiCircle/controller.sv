`timescale 1ns/1ps

`include "common.svh"

module controller(
    input u1    clk, reset,
    input u6    op, funct,
    input u1    zero,

    output u1   pcen, memwrite, irwrite, regwrite,
    output u1   alusrca, iord, memtoreg, regdst,
    output u2   alusrcb, pcsrc,
    output u3   alucont
);
    u1  pcwrite, bne, beq;
    u3  aluop;

    assign pcen = (beq & zero) | (bne & !zero) | pcwrite;

    aludec aludec(
        .funct,
        .aluop,

        .alucont
    );

    maindec maindec(
        .clk, .reset,
        .op, .funct,

        .bne,
        .pcwrite, .memwrite, .irwrite, .regwrite,
        .alusrca, .beq, .iord, .memtoreg, .regdst,
        .alusrcb, .pcsrc, .aluop
    );
endmodule


module aludec(
    input u6    funct,
    input u3    aluop,
    
    output u3   alucont
);
    always_comb begin
        unique case(aluop)
            ALU_NO_USE:
                unique case(funct)  // RTYPE
                    FUNCT_ADD  :   alucont <= ALU_ADD;
                    FUNCT_SUB  :   alucont <= ALU_SUB;
                    FUNCT_AND  :   alucont <= ALU_AND;
                    FUNCT_OR   :   alucont <= ALU_OR;
                    FUNCT_SLT  :   alucont <= ALU_SLT;
                    default    :   alucont <= 3'bxxx;
                endcase
            default:
                alucont <= aluop;
        endcase
    end 
endmodule


module maindec(
    input u1    clk, reset,
    input u6    op, funct,
    
    output u1   bne,
    output u1   pcwrite, memwrite, irwrite, regwrite,
    output u1   alusrca, beq, iord, memtoreg, regdst,
    output u2   alusrcb, pcsrc, 
    output u3   aluop
);

    u5  state, nextstate;
    u17 controls;

    assign {bne, pcwrite, 
            memwrite, irwrite, regwrite,
            alusrca, beq, iord, memtoreg, regdst,
            alusrcb, pcsrc, aluop} = controls;
    
    always_ff @(posedge clk or posedge reset) begin 
        if (reset)  state <= FETCH;
        else        state <= nextstate;
    end

    always_comb begin
        unique case(state)
            FETCH:      nextstate = DECODE;
            DECODE: case(op)
                    LW:         nextstate = MEMADR;
                    SW:         nextstate = MEMADR;
                    // branch.
                    BEQ:        nextstate = BEQEX;
                    BNE:        nextstate = BNEEX;
                    // imm.
                    ADDI:       nextstate = ADDIEX;
                    ANDI:       nextstate = ANDIEX;
                    ORI:        nextstate = ORIEX;
                    SLTI:       nextstate = SLTIEX;  
                    // jump.                  
                    J:          nextstate = JEX;
                    RTYPE: case(funct)
                        BUBBLE:     nextstate = FETCH;
                        default:    nextstate = RTYPEEX;
                    endcase
                    default:    nextstate = 5'bx;
            endcase
            MEMADR: case(op)
                    LW:         nextstate = MEMRD;
                    SW:         nextstate = MEMWR;
                    default:    nextstate = 5'bx;
            endcase
            MEMRD:      nextstate = MEMWB;
            MEMWB:      nextstate = FETCH;
            MEMWR:      nextstate = FETCH;
            RTYPEEX:    nextstate = RTYPEWB;
            RTYPEWB:    nextstate = FETCH;
            // branch.
            BEQEX:      nextstate = FETCH;
            BNEEX:      nextstate = FETCH;
            // imm.
            ADDIEX:     nextstate = ADDIWB;
            ANDIEX:     nextstate = ANDIWB;
            ORIEX:      nextstate = ORIWB;
            SLTIEX:     nextstate = SLTIWB;
            ADDIWB:     nextstate = FETCH;
            ANDIWB:     nextstate = FETCH;
            ORIWB:      nextstate = FETCH;
            SLTIWB:     nextstate = FETCH;
            // jump.
            JEX:        nextstate = FETCH;
            default:    nextstate = 5'bx;
        endcase
    end

    always_comb begin
        unique case(state)
            FETCH:      controls = {FETCH_C,    ALU_ADD};
            DECODE:     controls = {DECODE_C,   ALU_ADD};
            MEMADR:     controls = {MEMADR_C,   ALU_ADD};
            MEMRD:      controls = {MEMRD_C,    ALU_ADD};
            MEMWB:      controls = {MEMWB_C,    ALU_ADD};
            MEMWR:      controls = {MEMWR_C,    ALU_ADD};
            RTYPEEX:    controls = {RTYPEEX_C,  ALU_NO_USE};
            RTYPEWB:    controls = {RTYPEWB_C,  ALU_ADD};
            // branch instructions.
            BEQEX:      controls = {BEQEX_C,    ALU_SUB};
            BNEEX:      controls = {BNEEX_C,    ALU_SUB};

            // imm instructions.
            ADDIEX:     controls = {ADDIEX_C,   ALU_ADD};
            ADDIWB:     controls = {ADDIWB_C,   ALU_ADD};
            ANDIEX:     controls = {ADDIEX_C,   ALU_AND};
            ANDIWB:     controls = {ADDIWB_C,   ALU_ADD};
            ORIEX:      controls = {ADDIEX_C,   ALU_OR};
            ORIWB:      controls = {ADDIWB_C,   ALU_ADD};
            SLTIEX:     controls = {ADDIEX_C,   ALU_SLT};
            SLTIWB:     controls = {ADDIWB_C,   ALU_ADD};

            JEX:        controls = {JEX_C,      ALU_ADD};
            default:    controls = 16'hxxxx;
        endcase
    end

    always begin 
        #6;
        $display("[maindec]    state=%x   nextstate=%x    op=%x   funct=%x\n", state, nextstate, op, funct);
        #4;
    end

endmodule