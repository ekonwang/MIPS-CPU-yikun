`timescale 1ns/1ps

`include "common.svh"

module testbench();
    u1      clk;
    u1      reset;
    u32     writedata, dataaddr, pc;
    u1      memwrite;

    cpu top(.clk, .reset, .writedata, .dataaddr, .memwrite, .pc);

    integer cycle = 10;
    integer sim_t = cycle * 2 + cycle / 2;
    integer cnt = 0;

    // init clock signal
    initial begin
        reset <= 1;
        #1;
        reset <= 0;
    end

    always begin
        clk <= 1; #(cycle/2); clk <= 0; #(cycle/2);
    end

    // bubble
    // bubble <- here stop
    // bubble
    always begin
        #sim_t; 
        if (pc != PC_start + 4*(sim_t/cycle/2)) begin
            $display("Simulation failed");
            $stop;
        end else begin
            $display("Simulation succedded");
            $stop;
        end
    end

    always begin 
        $display("epoch %d", )
        #9;
        $display("\n\n");
        #(cycle-9);
        cnt = cnt + cycle;
    end

endmodule