`timescale 1ns / 1ps

// 32-bit instruction memory
module imem (
  input        [5:0]  a,  // pc_addr
  output logic [31:0] rd  // instr_data
);
  logic [31:0] RAM[63:0];
  initial begin
    $readmemh("seq.dat", RAM);
  end
  assign rd = RAM[a];  // word aligned
endmodule : imem
