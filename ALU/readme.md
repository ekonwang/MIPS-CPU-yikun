### ALU 设计报告

*20级计算机科学 王艺坤*

#### ALU 简介

ALU 是 arithmetic logic unit 的简称，是实现算术运算与位运算的组合数字电路。

与 FPU (floating logic unit) 不同，ALU 通常用于整型二进制数据的操作，前者用于浮点型数据操作。[^1] 

#### 功能设计

按照 MIPS 设计规范，ALU 应当实现以下 6 类整型操作。 

<img src="https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/ALU mips.png" style="zoom:50%;" />

除此之外按照实验还应当实现的 2 类操作包括：

- RAND : $F = A~ \&~ ~B$  `ALUcont = 0b100`
- ROR：$F~=~A~|~\tilde{B}$ `ALUcont = 0b101`

#### 实验与仿真

1. ##### 定义相关头文件

- 为了能够更加直观的使用宏来编写 ALU，将 ALUcont 定义为容易识辨功能的宏。
- 此外，为了能够更加容易地定义各类位宽的 logic 变量，我添加了 rust 风格的 typedef 。

```verilog
// common.svh

`ifndef _COMMON_SVH_
`define _COMMON_SVH_

`timescale 1ns/1ps

// ALU 
`define ALU_AND     3'b000
`define ALU_OR      3'b001
`define ALU_ADD     3'b010
`define ALU_RAND    3'b100
`define ALU_ROR     3'b101
`define ALU_SUB     3'b110
`define ALU_SLT     3'b111

// types
typedef logic[63:0]     u64;
typedef logic[31:0]     u32;
typedef logic[15:0]     u16;
typedef logic[7:0]      u8;
typedef logic[6:0]      u7;
typedef logic[5:0]      u6;
typedef logic[4:0]      u5;
typedef logic[3:0]      u4;
typedef logic[2:0]      u3;
typedef logic[1:0]      u2;
typedef logic           u1;

`endif
```

2. ##### 模块定义

- 便于 ALU 将来可以用于 64 位流水线 CPU 编写，我使用了 system verilog 提供的 parameter 机制，这样 ALU 模块就可以支持 32 位以外的其他位宽 。
- parameter 的使用类似 C++ 中 Template 机制，同时作为变量的 parameter 是全局变量，可以承担类似宏的作用。[^2]
- 在具体实现上，ALU 的核心被定义成了一个多路复用器，具体操作由 system verilog 提供的运算符支持，包括加、减、与、或以及比较运算。复用器采用了**unique case为核心的组合逻辑**，赋值采用阻塞赋值。

```verilog
module ALU #(
    N = 32
) (
    input logic [N-1:0] A,
    input logic [N-1:0] B,
    input logic [2:0]   ALUcont,
    output logic [N-1:0]  result,
    output logic        zero    
);
always_comb begin
    unique case(ALUcont)
        // 3'b000      : result = A & B;  
        // 3'b001      : result = A | B;  
        // 3'b010      : result = A + B;   
        
        // 3'b100      : result = A & ~B;  
        // 3'b101      : result = A | ~B;  
        // 3'b110      : result = A - B;   
        // 3'b111      : result = A < B ? '1 : '0;
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

3. ##### 编写仿真测试顶部模块

为了能够初步测试 ALU 正确性，仿真测试的顶层模块应当满足：

- 充分性：测试应当包含 ALU 所支持的所有运算 (`and`, `add`, `or` 等)。
- 随机性：各类的指令的执行应当没有特定的顺序，数量以及出现次序都应当随机选取。

顶部模块的伪代码大致如下：

```c
$result = 2 and 7 = 2
$result = 2 or 4 = 6
$result = 6 + 3 = 9
$result = 9 RAND 1 = 8
$result = 8 ROR 32'hfffffff8 = 15
$result = 15 - 4 = 11
$result = 11 slt 12 = 1
$result = 11 slt 11 = 0
$result = 11 + 33 = 44
$result = 44 - 22 = 22
```

- 在实际执行时，为了提高因为小概率随机事件通过测试的难度，在实际代码中，我让指令流上下文具备充分的依赖性，既大部分指令的输入与上一个指令的输出有关：
- 为了提高仿真的速度，仿真时间单位设置为 1ns, 时间精度设置为 1ps。
- 如果 ALU 行为正确，那么行为仿真结束时显示器应当输出 "simulation passed"。

以下是用 system verilog 编写的顶部模块测试：

```verilog
// # simtop.sv
// # wangyikun19@fudan.edu.cn 23 March 2022
// #
// # Test the MIPS processor ALU.
// # add, sub, and, or, slt
// # If successful, monitor output "simulation passed".
`include "common.svh"

module simtop();
u32 A, B, result;
u3  ALUcont;
u1  zero;

ALU ALU(.A, .B, .ALUcont, .result, .zero);
always begin
    #10 A = 32'd2; B = 32'd7; ALUcont = `ALU_AND; 
    #10 A = result; B = 32'd4; ALUcont = `ALU_OR;
    #10 A = result; B = 3; ALUcont = `ALU_ADD; 
    #10 A = result; B = 32'd1; ALUcont = `ALU_RAND; 
    #10 A = result; B = 32'hfffffff8; ALUcont = `ALU_ROR; 
    #10 A = result; B = 32'd4; ALUcont = `ALU_SUB;
    #10 A = result; B = 12; ALUcont = `ALU_SLT;
    #10 B = 11; ALUcont = `ALU_SLT;
    #10 B = 33; ALUcont = `ALU_ADD;
    #10 A = result; B = 22; ALUcont = `ALU_SUB;
    #10 $stop;
end
 // #10 $display("@%0t: A = %d, B = %d, ALUcont = %d, result = %d, zero = %d", $time, A, B, ALUcont, result, zero);

always begin
    #1 $display("@%0t simulation begin", $time);
    #10 if (result !== 2) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 6) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 9) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 8) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 15) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 11) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 1) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 0) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 44) begin
            $display("@%0t simulation failed", $time);
        end
    #10 if (result !== 22) begin
            $display("@%0t simulation failed", $time);
        end
    $display("@%0t simulation passed", $time);
    $stop;
end
endmodule
```

4. ##### 测试结果

将设计文件 `alu.sv`, `common.svh` 



| 宏观波形                                                     | 微观波形                                                     |
| ------------------------------------------------------------ | ------------------------------------------------------------ |
| ![](https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/alu测试波形宏观.pic.jpg) | ![](https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/alu测试波形微观.pic.jpg) |
| **变量表**                                                   | **TCL 终端输出**                                             |
| ![](https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/alu变量表.pic.jpg) | ![](https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/alu测试显示器输出.pic.jpg) |



#### 上板测试

1. ##### 编写约束文件



2. ##### 实际测试效果



#### Reference

[^1]: 维基百科：ALU https://en.wikipedia.org/wiki/Arithmetic_logic_unit
[^2]: PARAMETER & `define https://verificationguide.com/systemverilog/systemverilog-parameters-and-define/