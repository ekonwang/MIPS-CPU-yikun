`timescale 1ns/1ps

`include "common.svh"

module testbench();
    u1      clk;
    u1      reset;
    u32     writedata, dataaddr, pc;
    u1      memwrite;

    cpu top(.clk, .reset, .writedata, .dataaddr, .memwrite, .pc);

    integer cycle = 10;
    integer sim_t = cycle * 19 + cycle / 2;
    integer cnt = 0;

    // init clock signal
    initial begin
        reset <= 1;
        #1;
        reset <= 0;
    end
    // init clock signal
    // $2 = 5 (4 circles)
    // $3 = 6 (4 circles)
    // jump to 5th instr (3 circles)
    // $2 = $2 + $3 (4 circles)
    // $4 = $2 + 5 (4 circles, expected 0xa / 10, wrong if 0xf / 16)
    always begin
        clk <= 1; #(cycle/2); clk <= 0; #(cycle/2);
    end

    always begin
        #1; 
        if (dataaddr == 10) begin
            $display("Simulation succedded");
            $stop;
        end
        if (dataaddr == 16) begin
            $display("Simulation failed");
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