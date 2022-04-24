// new version.
`timescale 1ns / 1ps

module IO (
    input logic clk,
    input logic reset,
    input logic pread,
    input logic pwrite,
    input logic [1:0] addr,
    input logic [11:0] pwritedata,
    output logic [31:0] preaddata,

    input logic buttonl,
    input logic buttonr,
    input logic [15:0] switch,
    output logic [11:0] led
);
    logic [1:0] status;
    logic [15:0] switch1;
    logic [11:0] led1;

    always_ff @( posedge clk ) begin
        if (reset) begin
            status <= 2'b00;
            led1 <= 12'h00;
            switch1 <= 16'h00;
        end else begin
            if (buttonr) begin
                status[1] <= 1;
                switch1 <= switch;
            end
            if (buttonl) begin
                status[0] <= 1;
                led <= led1;
            end

            if (pwrite & (addr == 2'b01)) begin
                led1 <= pwritedata;
                status[0] <= 0;
            end
        end
    end

    always_comb begin
        if (pread) begin
            case (addr)
                2'b11: preaddata = {24'b0, switch1[15:8]};
                2'b10: preaddata = {24'b0, switch1[7:0]};
                2'b00: preaddata = {24'b0, 6'b0, status};
                default: preaddata = 32'b0;
            endcase
        end
        else
            preaddata = 32'b0;
    end
endmodule