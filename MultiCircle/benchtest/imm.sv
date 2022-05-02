`timescale 1ns/1ps

`include "common.svh"

module testbench();
    u1      clk;
    u1      reset;
    u32     writedata, dataaddr, pc;
    u1      memwrite;

    cpu top(.clk, .reset, .writedata, .dataaddr, .memwrite, .pc);

    integer cycle = 10;
    integer sim_t = cycle * (4 + 2 + 1) + cycle / 2;
    integer cnt = 0;

    // init clock signal
    // imm takes 
    initial begin
        reset <= 1;
        #1;
        reset <= 0;
    end

    always begin
        clk <= 1; #(cycle/2); clk <= 0; #(cycle/2);
    end

    // $2 = 1 + $0
    always begin
        #(1);
        if (dataaddr == 1) 
            begin
                $display("milestone hit, simulation succeeded");
                $stop;
            end
    end 

    initial begin
        #(sim_t);
    end


    always begin 
        $display("epoch %d", cnt/cycle);
        #9;
        $display("\n\n");
        #(cycle-9);
        cnt = cnt + cycle;
    end

endmodule