`timescale 1ns/1ps

`include "common.svh"

module testbench();
    u1      clk;
    u1      reset;
    u32     writedata, dataaddr, pc;
    u1      memwrite;

    cpu top(.clk, .reset, .writedata, .dataaddr, .memwrite, .pc);

    integer cycle = 10;
    integer sim_t = cycle * 22 + cycle / 2;
    integer cnt = 0;

    // init clock signal
    initial begin
        reset <= 1;
        #1;
        reset <= 0;
    end
    // init clock signal
    // imm takes 
    // $3 = 12 (4)
    // $2 = 1 (4)
    // [80] = 1 (4)
    // $4 = [80] (5)
    // $4 = $4 + $2 = 2 (4)
    always begin
        clk <= 1; #(cycle/2); clk <= 0; #(cycle/2);
    end

    always begin
        #1; 
        if (memwrite & dataaddr == 80 & writedata == 1) 
        begin
            $display("Milestone hit");
        end

        if (dataaddr == 2) 
        begin 
            $display("Simulation succeeded");
            $stop;
        end
    end

    initial begin 
        #(sim_t);
        $display("Simulation time limit exceeded");
        $stop;
    end

    always begin 
        $display("epoch %d", cnt/cycle);
        #9;
        $display("\n\n");
        #(cycle-9);
        cnt = cnt + cycle;
    end

endmodule