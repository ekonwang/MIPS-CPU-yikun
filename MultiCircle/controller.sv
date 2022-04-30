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
    u1  pcwrite, branch, pcen;
    u2  aluop;

    pcen = (branch & zero) | pcwrite;

    aludec aludec(
        .funct,
        .aluop,

        .alucont
    );

    maindec maindec(
        .clk, .reset,
        .op,

        .pcwrite, .memwrite, .irwrite, .regwrite,
        .alusrca, .branch, .iord, .memtoreg, .regdst,
        .alusrcb, .pcsrc, .aluop
    );
endmodule


module aludec(
    input u6    funct,
    input u2    aluop,
    
    output u3   alucont
);
    always_comb begin
        unique case(aluop)
            2'b00:  alucont <= ALU_ADD;
            2'b01:  alucont <= ALU_SUB;
            2'b10: 
                unique case(funct) // RTYPE
                    FUNCT_ADD:  alucont <= ALU_ADD;
                    FUNCT_AND:  alucont <= ALU_AND;
                    FUNCT_OR:   alucont <= ALU_OR;
                    FUNCT_SLT:  alucont <= ALU_SLT;
                    FUNCT_SUB:  alucont <= ALU_SUB;
                endcase
            default: alucont <= 'x;
        endcase
    end 
endmodule


module maindec(
    input u1    clk, reset,
    input u6    op,
    
    output u1   pcwrite, memwrite, irwrite, regwrite,
    output u1   alusrca, branch, iord, memtoreg, regdst,
    output u2   alusrcb, pcsrc, aluop
);

    u4  state, nextstate;
    u15 controls;

    assign {pcwrite, memwrite, irwrite, regwrite,
            alusrca, branch, iord, memtoreg, regdst,
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
                    RTYPE:      nextstate = RTYPEEX;
                    BEQ:        nextstate = BEQEX;
                    ADDI:       nextstate = ADDIEX;
                    J:          nextstate = JEX;
                    BUBBLE:     nextstate = FETCH;
                    default:    nextstate = 4'bx;
            endcase
            MEMADR: case(op)
                    LW:         nextstate = MEMRD;
                    SW:         nextstate = MEMWR;
                    default:    nextstate = 4'bx;
            endcase
            MEMRD:      nextstate = MEMWB;
            MEMWB:      nextstate = FETCH;
            MEMWR:      nextstate = FETCH;
            RTYPEEX:    nextstate = RTYPEWB;
            RTYPEWB:    nextstate = FETCH;
            BEQEX:      nextstate = FETCH;
            ADDIEX:     nextstate = ADDIWB;
            ADDIWB:     nextstate = FETCH;
            JEX:        nextstate = FETCH;
            default:    nextstate = 4'bx;
        endcase
    end

    always_comb begin
        unique case(state)
            FETCH:      controls = FETCH_C;
            DECODE:     controls = DECODE_C;
            MEMADR:     controls = MEMADR_C;
            MEMRD:      controls = MEMRD_C;
            MEMWB:      controls = MEMWB_C;
            MEMWR:      controls = MEMWR_C;
            RTYPEEX:    controls = RTYPEEX_C;
            RTYPEWB:    controls = RTYPEWB_C;
            BEQEX:      controls = BEQEX_C;
            ADDIEX:     controls = ADDIEX_C;
            ADDIWB:     controls = ADDIWB_C;
            JEX:        controls = JEX_C;
            default:    controls = 15'hxxxx;
        endcase
    end

    always begin 
        #6;
        $display("[maindec]    state=%x nextstate=%x\n", state, nextstate);
        #4;
    end

endmodule