`timescale 1ns/1ps

module uart_clock_tb();

    reg clk = 1'b0;
    reg reset = 1'b0;
    reg start = 1'b0;
    reg [7:0] data = 8'd0;
    wire tx;

    uart_clock uut (
        .reset(reset),
        .clk(clk),
        .tx(tx)
    );

    initial begin
        $dumpfile("uart_clock_tb.vcd");
        $dumpvars(0, uart_clock_tb);
        clk = 1'b0;
        reset = 1'b1;
        #10 reset = 1'b0;
        #100000000
        $finish;
    end

    always begin
      #41.667
      clk = ~clk;
    end

endmodule