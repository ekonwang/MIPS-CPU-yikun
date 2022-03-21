### ALU 设计报告

*20级计算机科学 王艺坤*

#### ALU 简介

ALU 是 arithmetic logic unit 的简称，是实现算术运算与位运算的组合数字电路。

与 FPU (floating logic unit) 不同，ALU 通常用于整型二进制数据的操作，前者用于浮点型数据操作。[^1] 

#### 功能设计

按照 MIPS 设计规范，ALU 应当实现以下 6 类整型操作。 

![](https://cdn.jsdelivr.net/gh/ekonwang/images@master/img/ALU mips.png)

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



4. ##### 测试结果

#### Reference

[^1]: 维基百科：ALU https://en.wikipedia.org/wiki/Arithmetic_logic_unit
[^2]: PARAMETER & `define https://verificationguide.com/systemverilog/systemverilog-parameters-and-define/