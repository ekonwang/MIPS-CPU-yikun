`timescale 1ns/1ps

`include "common.svh"

module flopr #(
    parameter Width = 8
)(
    input u1    clk,
    input u1    reset,
    input logic[Width-1:0]      d,
    output logic[Width-1:0]     r
);
always @(posedge clk, posedge reset) begin
    if (reset)  r <= 0;
    else        r <= d;
end

endmodule