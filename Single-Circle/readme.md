

## 单周期 CPU 设计实验报告

*20级计算机科学与技术 王艺坤*

> 单周期 CPU[^ 2]（Single Cycle Processor）是指一条指令在一个时钟周期内完成并开始下一条指令的执行。由时钟「上升沿」和「下降沿」控制相关操作。两个相邻的「上升沿」或「下降沿」之间的时间间隔就是 CPU 的「时周期」。

#### 设计

按照 《数字设计和计算机体系结构》[^ 1]中单周期 CPU 设计，处理器应当包括一下 11 种指令：

- 5种 RTYPE 运算指令：`add, sub, and, or, slt`
- 1种 IMM 运算指令：`addi`
- 2种IO指令：`lw, sw`
- 1种跳转指令：`j`
- 1种分支指令：`beq`
- bubble：`nop`

考虑到提升处理器的拓展性，额外加入三条 IMM 运算指令与 1 种跳转指令。

新加入的指令包括 `ori`,  `andi`,  `slti`,  `bne`：

|                             ORI                              |                             ANDI                             |
| :----------------------------------------------------------: | :----------------------------------------------------------: |
| ![](https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/andi.png) | ![](https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/andi.png) |
|                           **SLTI**                           |                           **BNE**                            |
| ![](https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/slti.png) | <img src="https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/bne-mips.png" style="zoom:33%;" /> |

加入指令后，更新后的 ALU 译码器真值表：

| op                  | ALUcont                        |
| ------------------- | ------------------------------ |
| 0'b000 (ALU_AND)    | 0'b000                         |
| 0'b001 (ALU_OR)     | 0'b001                         |
| 0'b010 (ALU_ADD)    | 0'b010                         |
| 0'b011 (ALU_NO_USE) | depend on instr[5:0] (`funct`) |
| 0'b110 (ALU_SUB)    | 0'b110                         |
| 0'b111 (ALU_SLT)    | 0'b111                         |

#### 新的基准测试

《数字设计和计算机体系结构》[^ 1]中提供了基于 9 种指令的仿真测试 (benchtest)，而由于额外添加 4 条指令，需对原来测试文件作出修改，额外添加语句。

- 在原来 benchtest 的基础上，增加了对于 `andi`,  `ori` 以及 `slti` 的测试。测试保证各种指令出现的次数不少于1次，且保证指令流的强上下文依赖性。
- 同时为了保证 nop 指令的正确性，在不扰乱汇编码正常执行（即不干扰 jump 或者 branch 指令正确跳转），随机地选取了 2 处位置插入了 nop 指令 (32'b 0x00000000)。
- 除了新插入的两处 nop 指令，新的基准测试在原先基础上在结尾添加了 6 条指令，分别测试 `andi`, `slti`, `beq`, （第四条指令应当不执行），`ori`， `sw`。此外将原本第二条指令处的 `addi $3, $0, 12 `  替换成 `ori $3, $0, 12 ` ，此处的替换执行效果等价。
- 这里是 benchtest 的汇编版本，实际测试需要将每条测试指令机器码写入测试文件 `smemfile.dat`，在 vivado 仿真中需要从 .dat 文件中读出指令并执行。

```assembly
# benchtest.asm
# wangyikun19@fudan.edu.cn 22 March 2022
#
# Test the MIPS processor.
# add, sub, and, or, slt, addi, andi, ori, slti, lw, sw, beq, bne, j, nop
# If successful, cpu will store result 9 into data memory address 88.

#       Assembly		        Description             Address     Machine
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
        slti $2, $6, 0xb    # $2 = 10 < 11 = 1      54          28c20009
        bne  $2, $0, end    # should be taken       58          14400001
        ori  $6, $0, 0xff   # shouldn't happen      5c          340600ff
end:    ori  $2, $6, 0x14    # $2 = 20 | 10 = 30    60          34c20014
        sw   $2, 88($0)     # [88] = 9              64          ac020058
```

此外 benchtest 流程的基本逻辑在 `Description` 字段有所说明。

#### 设计过程

##### 1. 定义相关头文件

- 为了能够更加直观的使用宏来编写 ALU，将 ALUcont，ALU decoder，main decoder 中用到的常量定义为宏。
- 此外，为了能够更加容易地定义各类位宽的 logic 变量，我添加了 rust 风格的 typedef 。

```verilog
`ifndef _COMMON_SVH_
`define _COMMON_SVH_

`timescale 1ns/1ps

// @ALU 
`define ALU_AND     3'b000
`define ALU_OR      3'b001
`define ALU_ADD     3'b010
`define ALU_NO_USE  3'b011
`define ALU_RAND    3'b100
`define ALU_ROR     3'b101
`define ALU_SUB     3'b110
`define ALU_SLT     3'b111

// @ALUDEC
`define FUNCT_ADD   6'b100000
`define FUNCT_SUB   6'b100010
`define FUNCT_AND   6'b100100 
`define FUNCT_OR    6'b100101 
`define FUNCT_SLT   6'b101010 

// @types
typedef logic[63:0]     u64;
typedef logic[31:0]     u32;
typedef logic[15:0]     u16;
typedef logic[14:0]     u15;
typedef logic[13:0]     u14;
typedef logic[12:0]     u13;
typedef logic[11:0]     u12;
typedef logic[10:0]     u11;
typedef logic[9:0]      u10;
typedef logic[8:0]      u9;
typedef logic[7:0]      u8;
typedef logic[6:0]      u7;
typedef logic[5:0]      u6;
typedef logic[4:0]      u5;
typedef logic[3:0]      u4;
typedef logic[2:0]      u3;
typedef logic[1:0]      u2;
typedef logic           u1;

// @maindec 
// @leftvalue
`define RTYPE   6'b000000
`define LW      6'b100011
`define SW      6'b101011
`define BEQ     6'b000100
`define BNE     6'b000101
`define ADDI    6'b001000
`define ORI     6'b001101
`define ANDI    6'b001100
`define SLTI    6'b001010
`define J       6'b000010
// @rightvalue
`define IMM_CONT    8'b10100000  // for operations involving immediate values. (e.g. andi, addi, ori, slti)

`endif
```

##### 2. 源码

《数字设计和计算机体系结构》[^ 1]中同样提供了单周期的接线参考。

<figure>
  <center>
  <img src="https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/截屏2022-04-23 下午11.38.36.png" style="zoom:60%;"/>
    <figcaption>单周期 CPU 接线示意图</figcaption>
  </center>
</figure>

实际中，我将诸多部件模块化，分别实现了 datapath 与 controller 两大单周期主要模块。

其中 datapath 主要包括 ALU 模块，寄存器模块，PC 更新逻辑。而 controller 主要包含 ALU decoder （负责 ALU 译码） 以及 main decoder （负责总体译码）模块。

笔者想着重强调 datapath 部分的设计：

在 ALU 的实现中，为了保持 ALU 部件代码的可重用性与可拓展性，我做了如下设计：

- 便于 ALU 将来可以用于 64 位流水线 CPU 编写，我使用了 system verilog 提供的 parameter 机制，这样 ALU 模块就可以支持 32 位以外的其他位宽 。
- parameter 的使用类似 C++ 中 Template 机制，同时作为变量的 parameter 是全局变量，可以承担类似宏的作用。[^3]
- 在具体实现上，ALU 的核心被定义成了一个多路复用器，具体操作由 system verilog 提供的运算符支持，包括加、减、与、或以及比较运算。复用器采用了**unique case为核心的组合逻辑**，赋值采用阻塞赋值。

```verilog
module ALU #(
    parameter N = 32
) (
    input logic [N-1:0]     A,
    input logic [N-1:0]     B,
    input logic [2:0]       alucont,
    output logic [N-1:0]    result,
    output logic            zero    
);
always_comb begin
    unique case(alucont)
        `ALU_AND    : result = A & B; 
        `ALU_OR     : result = A | B; 
        `ALU_ADD    : result = A + B;

        `ALU_RAND   : result = A & ~B; 
        `ALU_ROR    : result = A | ~B; 
        `ALU_SUB    : result = A - B;
        `ALU_SLT    : result = A < B ? 1 : 0;
        default     : result = 'x;
    endcase
end
assign zero = !result;
    
endmodule
```

在 pc 更新方面，笔者使用了一个基于 parameter 机制实现的 `flopr` ，实现在时钟 clk 信号上升沿更新 PC。

代码本质是 `if-else` 式的级联，实现了在一般情况下的 PC 更新 (nextPC = PC + 4)，分支条件以及跳转情况下的更新。

```verilog
// next PC
flopr #(32) pcreg(clk, reset, pcnext, pc);
assign pcplus4      =   pc + 32'd4;
assign signimmsh    =   {signimm[29:0], 2'b00};
assign pcbranch     =   pcplus4 + signimmsh;
assign pcnextbr     =   pcsrc ? pcbranch : pcplus4;
assign pcnext       =   jump ? {pcplus4[31:28], instr[25:0], 2'b00} : pcnextbr;
```

##### 3. IO

为了更好的上板，在 IO 部分笔者尝试编写了一个小型驱动，方便之后上板适用。

代码包括一个约束文件以及两个模块 `map` （负责 dmem 的读入与总体 IO）以及 `mux7seg` （负责输出信号到 7 段数码管的映射）。

<img src="https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/截屏2022-04-24 下午12.45.27.png" style="zoom:50%;" />

最终的 module hierarchy 如下图所示：

- 其中 top 模块包含两个组件：mips (MIPS 单周期处理器) 以及 memory（指令 & 数据储存单元）
- top 模块再上层是 benchtest 模块，模拟 clk，reset 信号，实例化一个 top 模块，并且描述了测试通过与否的判断逻辑。

<figure>
  <center>
  <img src="https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/屏幕截图 2022-04-24 121837.png" style="zoom:60%;" />
    <figcaption>module hierarchy</figcaption>
  </center>
</figure>

#### 仿真结果

在 `84` dmem 位置写入 7 表示原测试通过，`88` dmem 位置写入 30 表示新 benchtest 通过。

<figure>
  <center>
  <img src="https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/屏幕截图 2022-04-24 121416.png" style="zoom:60%;" />
    <figcaption>仿真终止</figcaption>
  </center>
</figure>

<figure>
  <center>
  <img src="https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/屏幕截图 2022-04-24 121431.png" style="zoom:60%;" />
    <figcaption>TCL 终端输出</figcaption>
  </center>
</figure>

#### Reference 

[^ 1]:《数字设计和计算机体系结构》[美] 戴维·莫尼·哈里斯 著，陈俊颖 译

[^ 2]: 维基百科 wikichi.icu 单周期处理器 https://wikichi.icu/wiki/Single_cycle_processor
[^3]: PARAMETER & `define https://verificationguide.com/systemverilog/systemverilog-parameters-and-define/
