# benchtest.asm
# wangyikun19@fudan.edu.cn 22 March 2022
#
# Test the MIPS processor.
# add, sub, and, or, slt, addi, lw, sw, beq, j, nop
# If successful, cpu will store result 9 into data memory address 88.

#       Assembly            Description             Address     Machine
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
        j    store          # should be taken       44          08000011
        addi $2, $0, 1      # shouldn't happen      48          20020001
store:  sw   $2, 84($0)     # write mem[84] = 7     4c          ac020054
