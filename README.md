### Developer Version MIPS Processor

![](https://img.shields.io/static/v1?label=&message=MIPS&color=orange&style=for-the-badge)![](https://img.shields.io/static/v1?label=&message=CPU&color=red&style=for-the-badge)![](https://img.shields.io/static/v1?label=&message=Yikun-works&color=black&style=for-the-badge)

#### A piped processor work based on [system verilog](https://en.wikipedia.org/wiki/SystemVerilog).

- [ALU design](https://github.com/ekonwang/MIPS-CPU-yikun/tree/master/ALU)
- [single circle processor](https://github.com/ekonwang/MIPS-CPU-yikun/tree/master/Single-Circle)

#### MIPS Benchmarks/ MIPS Chronology

|                    MIPS version                    |                          Processor                           | Year | Process (nm)  |            Frequency (MHz)            | Transistors (millions) | Die area (mm2) | Pin count | Power (W) |  Voltage (V)  |  D. cache (KB)  |  I. cache (KB)  | [MMU](https://en.wikipedia.org/wiki/Memory_management_unit) |        L2 cache         |   L3 cache    |                           Features                           |
| :------------------------------------------------: | :----------------------------------------------------------: | :--: | :-----------: | :-----------------------------------: | :--------------------: | :------------: | :-------: | :-------: | :-----------: | :-------------: | :-------------: | :---------------------------------------------------------: | :---------------------: | :-----------: | :----------------------------------------------------------: |
|   [MIPS I](https://en.wikipedia.org/wiki/MIPS_I)   | [R2000](https://en.wikipedia.org/wiki/R2000_(microprocessor)) | 1985 |     2000      |              8 to 16.67               |          0.11          |       80       |           |           |               |   64 external   |   64 external   |                                                             |         *none*          |    *none*     |                 5 stage pipelines, FPU: 2010                 |
|   [MIPS I](https://en.wikipedia.org/wiki/MIPS_I)   |         [R3000](https://en.wikipedia.org/wiki/R3000)         | 1988 |     1200      |              16.67 to 40              |          0.11          |       40       | 145, 172  |     4     |               | 32-256 external | 32-256 external |                                                             |     0-1 MB external     |    *none*     |                   same as R2000; FPU: 3010                   |
|  [MIPS II](https://en.wikipedia.org/wiki/MIPS_II)  |         [R6000](https://en.wikipedia.org/wiki/R6000)         | 1990 |               |               60 to 66                |                        |                |           |           |               |    external     |    external     |                                                             |         *none*          |    *none*     |      32-bit register size, 36-bit physical address, FPU      |
| [MIPS III](https://en.wikipedia.org/wiki/MIPS_III) |         [R4000](https://en.wikipedia.org/wiki/R4000)         | 1991 |      800      |                  100                  |          1.35          |      213       |    179    |    15     |       5       |        8        |        8        |                                                             | 128 KB to 4 MB external |    *none*     |                                                              |
| [MIPS III](https://en.wikipedia.org/wiki/MIPS_III) |         [R4400](https://en.wikipedia.org/wiki/R4400)         | 1992 |      600      |              100 to 250               |          2.3           |      186       |    179    |    15     |    5, 3.3     |       16        |       16        |                                                             | 128 KB to 4 MB external |    *none*     |                                                              |
| [MIPS III](https://en.wikipedia.org/wiki/MIPS_III) |         [R4200](https://en.wikipedia.org/wiki/R4200)         | 1993 |      600      |                  80                   |          1.3           |       81       |    179    |  1.8-2.0  |      3.3      |        8        |       16        |                                                             | 128 KB to 4 MB external |    *none*     | [scalar](https://en.wikipedia.org/wiki/Scalar_processor) design with a five-stage [classic RISC pipeline](https://en.wikipedia.org/wiki/Classic_RISC_pipeline) |
| [MIPS III](https://en.wikipedia.org/wiki/MIPS_III) |        [R4300i](https://en.wikipedia.org/wiki/R4300i)        | 1995 |      350      |               100 / 133               |                        |       45       |    120    |    2.2    |      3.3      |                 |                 |                                                             |                         |    *none*     |                                                              |
| [MIPS III](https://en.wikipedia.org/wiki/MIPS_III) |         [R4600](https://en.wikipedia.org/wiki/R4600)         | 1994 |      640      |               100 / 133               |          2.2           |       77       |    179    |    4.6    |       5       |       16        |       16        |                                                             |     512 KB external     |    *none*     |                                                              |
| [MIPS III](https://en.wikipedia.org/wiki/MIPS_III) |         [R4650](https://en.wikipedia.org/wiki/R4650)         | 1994 |      640      |               133 / 180               |          2.2           |       77       |    179    |    4.6    |       5       |       16        |       16        |                                                             |     512 KB external     |    *none*     |                                                              |
| [MIPS III](https://en.wikipedia.org/wiki/MIPS_III) |         [R4640](https://en.wikipedia.org/wiki/R4640)         | 1995 |      640      |                                       |                        |                |    179    |           |               |                 |                 |                                                             |                         |    *none*     |                                                              |
| [MIPS III](https://en.wikipedia.org/wiki/MIPS_III) |         [R4700](https://en.wikipedia.org/wiki/R4700)         | 1996 |      500      |              100 to 200               |          2.2           |                |    179    |           |               |       16        |       16        |                                                             |        External         |    *none*     |                                                              |
|  [MIPS IV](https://en.wikipedia.org/wiki/MIPS_IV)  |         [R5000](https://en.wikipedia.org/wiki/R5000)         | 1996 |      350      |              150 to 200               |          3.7           |       84       |    223    |    10     |      3.3      |       32        |       32        |                                                             |      1 MB external      |    *none*     |                                                              |
|  [MIPS IV](https://en.wikipedia.org/wiki/MIPS_IV)  |        [RM7000](https://en.wikipedia.org/wiki/R5000)         | 1998 | 250, 180, 130 |              250 to 600               |           18           |       91       |    304    | 10, 6, 3  | 3.3, 2.5, 1.5 |       16        |       16        |                                                             |     256 KB internal     | 1 MB external |                                                              |
|  [MIPS IV](https://en.wikipedia.org/wiki/MIPS_IV)  |         [R8000](https://en.wikipedia.org/wiki/R8000)         | 1994 |      700      |               75 to 90                |          2.6           |      299       |    591    |    30     |      3.3      |       16        |       16        |                                                             |      4 MB external      |    *none*     | [superscalar](https://en.wikipedia.org/wiki/Superscalar), up to 4 instructions per cycle |
|  [MIPS IV](https://en.wikipedia.org/wiki/MIPS_IV)  |        [R10000](https://en.wikipedia.org/wiki/R10000)        | 1996 |   350, 250    |              150 to 250               |          6.7           |      350       |    599    |    30     |      3.3      |       32        |       32        |                                                             | 512 KB – 16 MB external |    *none*     |                                                              |
|  [MIPS IV](https://en.wikipedia.org/wiki/MIPS_IV)  |        [R12000](https://en.wikipedia.org/wiki/R10000)        | 1998 |   350, 250    |              270 to 360               |          7.15          |      229       |    600    |    20     |       4       |       32        |       32        |                                                             | 512 KB – 16 MB external |    *none*     |               single-chip 4-issue superscalar                |
|  [MIPS IV](https://en.wikipedia.org/wiki/MIPS_IV)  |       [R12000A](https://en.wikipedia.org/wiki/R10000)        | 2000 |      180      |                  400                  |                        |                |           |           |               |                 |                 |                                                             |                         |    *none*     |                                                              |
|  [MIPS IV](https://en.wikipedia.org/wiki/MIPS_IV)  |        [R14000](https://en.wikipedia.org/wiki/R10000)        | 2001 |      130      |                  500                  |          7.2           |      204       |    527    |    17     |               |       32        |       32        |                                                             | 512 KB – 16 MB external |    *none*     |                                                              |
|  [MIPS IV](https://en.wikipedia.org/wiki/MIPS_IV)  |       [R14000A](https://en.wikipedia.org/wiki/R10000)        | 2002 |      130      |                  600                  |                        |                |           |    17     |               |       32        |       32        |                                                             |                         |    *none*     |                                                              |
|  [MIPS IV](https://en.wikipedia.org/wiki/MIPS_IV)  |        [R16000](https://en.wikipedia.org/wiki/R10000)        | 2003 |      110      |              700 to 1000              |                        |                |           |    20     |               |       64        |       64        |                                                             | 512 KB – 16 MB external |    *none*     |                                                              |
|  [MIPS IV](https://en.wikipedia.org/wiki/MIPS_IV)  |       [R16000A](https://en.wikipedia.org/wiki/R10000)        | 2004 |      110      |              800 to 1000              |                        |                |           |           |               |       64        |       64        |                                                             |                         |    *none*     |                                                              |
|  [MIPS IV](https://en.wikipedia.org/wiki/MIPS_IV)  |        [R18000](https://en.wikipedia.org/wiki/R10000)        | 2001 |      130      |                                       |                        |                |           |           |      1.2      |                 |                 |                                                             |          1 MB           |    *none*     |              was planned, but not manufactured               |
|   [MIPS V](https://en.wikipedia.org/wiki/MIPS_V)   |                          H1 "Beast"                          |      |               |                                       |                        |                |           |           |               |                 |                 |                                                             |                         |    *none*     |              was planned, but not manufactured               |
|   [MIPS V](https://en.wikipedia.org/wiki/MIPS_V)   |                         H2 "Captain"                         |      |               |                                       |                        |                |           |           |               |                 |                 |                                                             |                         |    *none*     |              was planned, but not manufactured               |
|   [MIPS32](https://en.wikipedia.org/wiki/MIPS32)   |                              4K                              | 1999 |      180      |                  167                  |                        |      2.5       |           |           |               |                 |                 |                                                             |                         |    *none*     |                                                              |
|   [MIPS32](https://en.wikipedia.org/wiki/MIPS32)   |                             4KE                              |      |      90       |                  420                  |                        |      1.2       |           |           |               |                 |                 |                                                             |                         |    *none*     |                                                              |
|   [MIPS32](https://en.wikipedia.org/wiki/MIPS32)   |                             24K                              | 2003 |  130, 65, 40  | 400 (130 nm) 750 (65 nm) 1468 (40 nm) |                        |      0.83      |           |           |               |     0 to 64     |     0 to 64     |                                                             |    4–16 MB external     |    *none*     |                                                              |
|   [MIPS32](https://en.wikipedia.org/wiki/MIPS32)   |                             24KE                             | 2003 |  130, 65, 40  |                                       |                        |                |           |           |               |                 |                 |                                                             |                         |    *none*     |                                                              |
|   [MIPS32](https://en.wikipedia.org/wiki/MIPS32)   |                             34K                              | 2006 |  90, 65, 40   |       500 (90 nm) 1454 (40 nm)        |                        |                |           |           |               |                 |                 |                                                             |                         |    *none*     |                                                              |
|   [MIPS32](https://en.wikipedia.org/wiki/MIPS32)   |                             74K                              | 2007 |      65       |                 1110                  |                        |      2.5       |           |           |               |     0 to 64     |     0 to 64     |                                                             |                         |    *none*     |                                                              |
|   [MIPS32](https://en.wikipedia.org/wiki/MIPS32)   |                            1004K                             | 2008 |      65       |                 1100                  |                        |      4.7       |           |           |               |     8 to 64     |     8 to 64     |                                                             |                         |    *none*     |                                                              |
|   [MIPS32](https://en.wikipedia.org/wiki/MIPS32)   |                             M14K                             | 2009 |      130      |                  200                  |                        |                |           |           |               |                 |                 |                                                             |                         |    *none*     |                          MicroMIPS                           |
|   [MIPS32](https://en.wikipedia.org/wiki/MIPS32)   |                            1074K                             | 2010 |      40       |                 1500                  |                        |                |           |           |               |                 |                 |                                                             |                         |    *none*     |                                                              |
|   [MIPS32](https://en.wikipedia.org/wiki/MIPS32)   |                            1074Kf                            | 2010 |      40       |                                       |                        |                |           |           |               |                 |                 |                                                             |                         |    *none*     |                        Floating point                        |
|   [MIPS32](https://en.wikipedia.org/wiki/MIPS32)   |                          microAptiv                          | 2012 |    90, 65     |                                       |                        |                |           |           |               |     8 to 64     |     8 to 64     |                                                             |                         |    *none*     |                                                              |
|   [MIPS32](https://en.wikipedia.org/wiki/MIPS32)   |                          interAptiv                          | 2012 |               |                                       |                        |                |           |           |               |     4 to 64     |     4 to 64     |                                                             |   up to 8 MB internal   |    *none*     |                                                              |
|   [MIPS32](https://en.wikipedia.org/wiki/MIPS32)   |                           proAptiv                           | 2012 |               |                                       |                        |                |           |           |               |    32 or 64     |    32 or 64     |                                                             |   up to 8 MB internal   |    *none*     |                                                              |
|   [MIPS64](https://en.wikipedia.org/wiki/MIPS64)   |                              5K                              | 1999 |               |                                       |                        |                |           |           |               |                 |                 |                                                             |                         |               |                                                              |
|   [MIPS64](https://en.wikipedia.org/wiki/MIPS64)   |                             20K                              | 2000 |               |                                       |                        |                |           |           |               |                 |                 |                                                             |                         |               |                                                              |
|                    MIPS version                    |                          Processor                           | Year | Process (nm)  |            Frequency (MHz)            | Transistors (millions) | Die area (mm2) | Pin count | Power (W) |  Voltage (V)  |  D. cache (KB)  |  I. cache (KB)  | [MMU](https://en.wikipedia.org/wiki/Memory_management_unit) |        L2 cache         |   L3 cache    |                           Features                           |

#### Intel Products Chronology

[click here](https://uem.edu.in/uem-jaipur-blog/timeline-and-generations-of-intel-processor/)

