`timescale 1ns/1ps

module uart_tx_tb();

    reg start = 0;

    wire tx;

    wire [3:0] state;

    reg clk = 0;
    reg reset = 0;
    reg [7:0] data = 8'd65;

    localparam DURATION = 1000;

    always begin
      #41.667
      clk = ~clk;
    end

    UART_TX uut (
        .clk(clk),
        .reset(reset),
        .data(data),
        .start(start),
        .tx(tx),
        .state(state)
    );

    initial begin
        $dumpfile("uart_tx_tb.vcd");
        $dumpvars(0, uart_tx_tb);
        $display("Starting simulation");
        reset = 1;
        #1
        reset = 0;
        #100
        data = 8'h0F;
        start = 1;
        #1
        start = 0;
        #(DURATION);
        data = 8'd66;
        start = 1;
        #1
        start = 0;
        #(DURATION);
        $display("Ending simulation");
        $finish;
    end

endmodule

