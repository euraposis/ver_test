module uart_clock(
  input reset,
  input clk,
  output tx
);

    wire div_clock;
    wire uart_clock;

    reg [7:0] data = 8'd00;

    wire [2:0] state;

    reg start = 1'd0;

    UART_TX uart (
        .clk(uart_clock),
        .reset(reset),
        .data(data),
        .start(div_clock),
        .tx(tx),
        .state(state)
    );

    clock_divider divider (
        .clk(clk),
        .reset(reset),
        .divisor(32'd20000),
        .clk_div(div_clock)
    );

    clock_divider uart_divider (
        .clk(clk),
        .reset(reset),
        .divisor(32'd625),
        .clk_div(uart_clock)
    );

    always @ (posedge div_clock) begin
        data <= data + 1;
        start <= 1;
    end

    always @ (negedge div_clock) begin
        start <= 0;
    end
endmodule