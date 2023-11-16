`timescale 1ns/1ps

module clock_divider_tb();

    wire out_clk_div;

    reg clk = 0;
    reg reset = 0;
    reg [31:0] divisor = 32'd10;

    localparam DURATION = 10000;

    always begin
      #41.667
      clk = ~clk;
    end

    clock_divider uut (
        .clk(clk),
        .reset(reset),
        .divisor(divisor),
        .clk_div(out_clk_div)
    );

    initial begin
        $dumpfile("clock_divider_tb.vcd");
        $dumpvars(0, clock_divider_tb);
        $display("Starting simulation");
        reset = 1;
        #1
        reset = 0;
        #(DURATION);
        divisor = 32'd20;
        #(DURATION);
        $display("Ending simulation");
        $finish;
    end

endmodule