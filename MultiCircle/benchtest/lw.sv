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
    // imm takes 
    // $3 = 12
    // $2 = 1
    // [80] = 1
    // $4 = [80]
    // $4 = $4 + $2 = 2
    always begin
        clk <= 1; #(cycle/2); clk <= 0; #(cycle/2);
    end

    always begin
        #sim_t; 
        if (memwrite != 0) begin
            $display("Simulation failed");
            $stop;
        end else if (writedata != 1) begin
            $display("Simulation failed");
            $stop;
        end else if (dataaddr != 2) begin
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