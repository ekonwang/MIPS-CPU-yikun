`timescale 1ns/1ps

`include "common.svh"

module testbench();
    u1      clk;
    u1      reset;
    u32     writedata, dataaddr, pc;
    u1      memwrite;

    cpu top(.clk, .reset, .writedata, .dataaddr, .memwrite, .pc);

    integer cycle = 10;
    integer sim_t = cycle * 8 + cycle / 2;
    integer cnt = 0;

    // init clock signal
    initial begin
        reset <= 1;
        #1;
        reset <= 0;
    end
    // init clock signal
    // imm takes 
    // $2 = 12
    // [80] = $2
    always begin
        clk <= 1; #(cycle/2); clk <= 0; #(cycle/2);
    end

    always begin
        #1;
        if (memwrite) begin
            if (dataaddr == 80 & writedata == 12)
                begin
                    $display("Simulation succeeded");
                    $stop;
                end
            else 
                begin
                    $display("Simulation failed");
                    $stop;
                end
        end 
    end

    initial begin
        #(sim_t);
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