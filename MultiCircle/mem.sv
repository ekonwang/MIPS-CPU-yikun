`timescale 1ns/1ps

`include "common.svh"

module mem(
    input u1        clk,
    input u1        we,
    input u32       writedata,
    input u32       pc,
    input u32       dataaddr,
    input u1        iord, irwrite,

    output u32      instr,
    output u32      readdata
);
    u32     data[127:0]; // 512 KB total storage
    u32     read_data, read_instr, read, addr;

    assign read = data[addr[31:2]];  // addr must be 4-byte aligned
    always @(posedge clk) begin
        if (we) data[addr[31:2]] <= writedata;
    end

    always_comb begin
        if (iord) read_data = read;
        else read_instr = read;
    end

    always_comb begin
        if (iord) addr = dataaddr;
        else addr = pc;
    end

    always @(posedge clk) begin 
        if (irwrite) instr = read_instr;
        readdata = read_data;
    end

    initial begin
    $readmemh("ext-seq.dat", data, PC_start/4);
    end

endmodule