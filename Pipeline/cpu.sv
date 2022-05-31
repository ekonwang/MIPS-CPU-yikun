`timescale 1ns / 1ps


// Top module
module cpu (
  input logic clk,
  input logic reset,
  
  output logic [31:0] writedata, dataaddr, pc,
  output logic memwrite
);
  logic [31:0]instr, read_data;
  
  mips mips (
    .clk,
    .reset,
    .instr,
    .readdata(read_data),
    .pc,
    .memwrite(memwrite),
    .aluout(dataaddr),
    .writedata(writedata)
  );

  imem imem (
    .a(pc[7:2]),
    .rd(instr)
  );

  dmem dmem (
    .clk,
    .we(memwrite),
    .a(dataaddr),
    .wd(writedata),
    .rd(read_data)
  );

endmodule : cpu
