`timescale 1ns / 1ps
module mux7seg (
    input logic clk,
    input logic reset,
    input logic [15:0] switch,
    input logic [11:0] led,
    output logic [7:0] an,
    output logic [6:0] a2g
);
    logic [2:0] cnt;
    logic [19:0] cntl = 20'h00000;
    assign cnt = cntl[19:17];
    
    always@(posedge clk) begin
        if(reset)
            cntl <= 32'h00000000;
        cntl <= cntl + 1;
    end
    
    always_comb begin
        case (cnt)
            3'b000: an = 8'b11111110;
            3'b001: an = 8'b11111101;
            3'b010: an = 8'b11111011;
            3'b011: an = 8'b11110111;
            3'b100: an = 8'b11101111;
            3'b101: an = 8'b11011111;
            3'b110: an = 8'b10111111;
            3'b111: an = 8'b01111111;
            default: an = 8'b11111111;
        endcase
    end
    
    logic [3:0] dgt;
    always_comb begin
        case (cnt)
            3'b000: dgt = led[3:0];
            3'b001: dgt = led[7:4];
            3'b010: dgt = led[11:8];
            3'b011: dgt = 4'b0000;
            3'b100: dgt = switch[3:0];
            3'b101: dgt = switch[7:4];
            3'b110: dgt = switch[11:8];
            3'b111: dgt = switch[15:12];
            default: dgt = 4'b1111;
        endcase
    end
    
    always_comb begin
        case (dgt)
            4'b0000: a2g = 7'b1000000;
            4'b0001: a2g = 7'b1111001;
            4'b0010: a2g = 7'b0100100;
            4'b0011: a2g = 7'b0110000;
            4'b0100: a2g = 7'b0011001;
            4'b0101: a2g = 7'b0010010;
            4'b0110: a2g = 7'b0000010;
            4'b0111: a2g = 7'b1111000;
            4'b1000: a2g = 7'b0000000;
            4'b1001: a2g = 7'b0010000;
            4'b1010: a2g = 7'b0001000;
            4'b1011: a2g = 7'b0000011;
            4'b1100: a2g = 7'b1000110;
            4'b1101: a2g = 7'b0100001;
            4'b1110: a2g = 7'b0000110;
            4'b1111: a2g = 7'b0001110;
            default: a2g = 7'b0001001;
        endcase
    end
endmodule