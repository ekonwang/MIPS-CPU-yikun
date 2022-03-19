`timescale 1ns/1ps

`include "common.svh"

module flopr #(
    parameter Width = 8;
)(
    input u1    clk,
    input u1    reset,
    input logic[Width-1:0]      d,
    output logic[Width-1:0]     r
);
always_ff @(posedge clk, posedge reset)
    if (reset)  q <= 0;
    else        q <= d;
end

endmodule