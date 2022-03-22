

新加入的指令包括 `ori`, `andi`, `slti`：

- ORI

<img src="https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/ori.png" style="zoom:70%;" />

- ANDI

<img src="https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/andi.png" style="zoom:70%;" />

- SLTI

<img src="https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/slti.png" style="zoom:70%;"/>

更新后的 ALU 译码器真值表：

| op                  | ALUcont              |
| ------------------- | -------------------- |
| 0'b000 (ALU_AND)    | 0'b000               |
| 0'b001 (ALU_OR)     | 0'b001               |
| 0'b010 (ALU_ADD)    | 0'b010               |
| 0'b011 (ALU_NO_USE) | depend on instr[5:0] |
| 0'b110 (ALU_SUB)    | 0'b110               |
| 0'b111 (ALU_SLT)    | 0'b111               |

#### 新的基准测试

- 在原来 benchtest 的基础上，增加了对于 `andi`, `ori` 以及 `slti` 的测试。

```assembly
# benchtest.asm
# wangyikun19@fudan.edu.cn 22 March 2022
#
# Test the MIPS processor.
# add, sub, and, or, slt, addi, andi, ori, slti, lw, sw, beq, j, nop
# xxx

#       Assembly		    Description             Address     Machine
main:   addi $2, $0, 5      # initialize $2 = 5     0           20020005
        addi $3, $0, 12     # initialize $3 = 12    4           2003000c
        addi $7, $3, -9     # initialize $7 = 3     8           2067fff7
        or   $4, $7, $2     # $4 = (3 OR 5) = 7     c           00e22025
        nop                 # no operation          10          00000000
        and  $5, $3, $4     # $5 = (12 AND 7) = 4   14          00642824
        add  $5, $5, $4     # $5 = 4 + 7 = 11       18          00a42820
        beq  $5, $7, end    # shouldn't be taken    1c          0064202a
```

