

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

- 在原来 benchtest 的基础上，增加了对于 `andi`,  `ori` 以及 `slti` 的测试。测试保证各种指令出现的次数不少于1次，且保证指令流的强上下文依赖性。
- 同时为了保证 nop 指令的正确性，在不扰乱汇编码正常执行（即不干扰 jump 或者 branch 指令正确跳转），随机地选取了 2 处位置插入了 nop 指令 (32'b 0x00000000)。
- 除了新插入的两处 nop 指令，新的基准测试在原先基础上在结尾添加了 6 条指令，分别测试 `andi`, `slti`, `beq`, （第四条指令应当不执行），`ori`， `sw`。此外将原本第二条指令处的 `addi $3, $0, 12 `  替换成 `ori $3, $0, 12 ` ，此处的替换执行效果等价。

```assembly
# benchtest.asm
# wangyikun19@fudan.edu.cn 22 March 2022
#
# Test the MIPS processor.
# add, sub, and, or, slt, addi, andi, ori, slti, lw, sw, beq, j, nop
# If successful, cpu will store result 9 into data memory address 88.

#       Assembly		    		Description             Address     Machine
main:   addi $2, $0, 5      # initialize $2 = 5     0           20020005
        ori  $3, $0, 12     # initialize $3 = 12    4           3403000c
        addi $7, $3, -9     # initialize $7 = 3     8           2067fff7
        or   $4, $7, $2     # $4 = (3 OR 5) = 7     c           00e22025
        nop                 # no operation          10          00000000
        and  $5, $3, $4     # $5 = (12 AND 7) = 4   14          00642824
        add  $5, $5, $4     # $5 = 4 + 7 = 11       18          00a42820
        beq  $5, $7, end    # shouldn't be taken    1c          10a7000a
        slt  $4, $3, $4     # $4 = 12 < 7 = 0       20          0064202a
        beq  $4, $0, around # should be taken       24          10800001
        addi $5, $0, 0      # shouldn't happen      28          00e2202a
around: slt  $4, $7, $2     # $4 = 3 < 5 = 1        2c          00e2202a
        add  $7, $4, $5     # $7 = 1 + 11 = 12      30          00853820
        sub  $7, $7, $2     # $7 = 12 - 5 = 7       34          00e23822
        sw   $7, 68($3)     # [80] = 7              38          ac670044
        lw   $2, 80($0)     # $2 = [80] = 7         3c          8c020050
        nop                 # no operation          40          00000000
        j    store          # should be taken       44          08000013
        addi $2, $0, 1      # shouldn't happen      48          20020001
store:  sw   $2, 84($0)     # write mem[84] = 7     4c          ac020054
        andi $6, $5, 0xe    # $6 = 11 & 14 = 10     50          30a6000e          
        slti $2, $6, 9      # $2 = 10 < 9 = 0       54          28c20009
        beq  $2, $0, end    # should be taken       58          10400001
        ori  $6, $0, 0xff   # shouldn't happen      5c          340600ff
end:    ori  $2, $6, 0x14    # $2 = 20 | 10 = 30    60          34c20014
        sw   $2, 88($0)     # [88] = 9              64          ac020058
```

