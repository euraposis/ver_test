module uart_clock(
  input reset,
  input clk,
  output tx
);

    wire div_clock;
    wire uart_t_clock;

    reg [7:0] data;


    UART_TX uart (
        .clk(uart_t_clock),
        .reset(reset),
        .data(data),
        .start(div_clock),
        .tx(tx)
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
        .clk_div(uart_t_clock)
    );
	

    always @ (posedge div_clock or posedge reset) begin
		if (reset) begin
			data <= 0;
		end else begin
			data <= data + 1;
		end
    end
endmodule