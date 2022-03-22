`timescale 1ns/1ps

module testbench();
u1      clk;
u1      reset;

u32     writedata, dataaddr;
u1      memwrite;

cpu top (.clk, .reset, .writedata, .dataaddr, .memwrite);

initial begin
    reset <= 1; #2; reset <= 0;
end

//always begin
//    #25; $stop;
//end

always begin
    clk <= 1; #5; clk <= 0; #5;
end

always @(negedge clk) begin
    if (memwrite) begin 
        if (dataaddr === 84 & writedata === 7) begin 
            $display("Simulation succedded");
            $stop;
        end else if (dataaddr !== 80) begin 
            $display("Simulation failed");
            $stop;
        end
    end
end

endmodule