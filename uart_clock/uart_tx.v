// Basic UART transmitter, 8 data bits, 1 stop bit, no parity

module UART_TX(
    input clk,
    input reset,
    input [7:0] data,
    input start,
    output reg tx
);

        reg [7:0] data_buffer;
        reg [2:0] bitcounter;
		reg [1:0] state;

        always @ (posedge clk or posedge reset) begin
            if (reset) begin
                bitcounter <= 0;
                tx <= 1;
                state <= 2'd0;
            end else begin
				case (state)
					0: begin
						if (start) begin
							state <= 1'd1;
						end
					end
					1: begin
						data_buffer <= data;
						tx <= 0; // start bit
						state <= 2'd2; 
					end
					2: begin
						tx <= data_buffer[bitcounter];
						bitcounter <= bitcounter + 1;
						if (bitcounter == 7) begin
							bitcounter <= 0;
							state <= 2'd3;
						end
					end
					3: begin
						tx <= 1; // stop bit
						if (!start) begin
							state <= 2'd0;
						end
					end
				endcase
            end
        end



endmodule