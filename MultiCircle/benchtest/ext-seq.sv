`timescale 1ns/1ps

`include "common.svh"

module testbench();
    u1      clk;
    u1      reset;
    u32     writedata, dataaddr, pc;
    u1      memwrite;

    cpu top(.clk, .reset, .writedata, .dataaddr, .memwrite, .pc);

    integer cycle = 10;
    integer sim_t = cycle * 130 + cycle / 2;
    integer cnt = 0;

    // init clock signal
    initial begin
        reset <= 1;
        #1;
        reset <= 0;
    end
    
    // look into seq.asm for more information
    always begin
        clk <= 1; #(cycle/2); clk <= 0; #(cycle/2);
    end

    always begin
        #1;
        if (memwrite & (dataaddr != 84 & dataaddr != 80 & dataaddr != 88)) begin
            $display("Simulation failed");
            $stop;
        end else if (memwrite & dataaddr == 80) begin
            if (writedata == 7) begin
                $display("Milestone hit");
            end else begin
                $display("Simulation failed");
                $stop;
            end
        end else if (memwrite & dataaddr == 84) begin
            if (writedata == 7) begin
                $display("Milestone hit");
            end else begin
                $display("Simulation failed");
                $stop; 
            end
        end else if (memwrite & dataaddr == 88) begin 
            if (writedata == 30) begin
                $display("Succeeded");
                $stop;
            end else begin
                $display("Simulation failed");
                $stop; 
            end
        end
    end

    always begin 
        $display("epoch %d", cnt/cycle);
        #9;
        $display("\n\n");
        #(cycle-9);
        cnt = cnt + cycle;
    end

endmodule