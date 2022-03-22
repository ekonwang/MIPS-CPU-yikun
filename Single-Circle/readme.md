

更新后的 ALU 译码器真值表：

| op                  | ALUcont              |
| ------------------- | -------------------- |
| 0'b000 (ALU_AND)    | 0'b000               |
| 0'b001 (ALU_OR)     | 0'b001               |
| 0'b010 (ALU_ADD)    | 0'b010               |
| 0'b011 (ALU_NO_USE) | depend on instr[5:0] |
| 0'b110 (ALU_SUB)    | 0'b110               |
| 0'b111 (ALU_SLT)    | 0'b111               |



