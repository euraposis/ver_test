// Basic UART transmitter, 8 data bits, 1 stop bit, no parity

module UART_TX(
    input clk,
    input reset,
    input [7:0] data,
    input start,
    output reg tx,
    output reg [3:0] state
);

        reg [7:0] data_buffer;
        reg [3:0] bitcounter;

        always @ (posedge start) begin
            if (state == 0) begin
                state <= 1;
            end 
        end

        always @ (posedge clk or posedge reset) begin
            if (reset) begin
                bitcounter <= 0;
                tx <= 1;
                state <= 0;
            end else begin
                case (state)
                    1: begin
                        data_buffer <= data;
                        tx <= 0; // start bit
                        state <= 2; 
                    end
                    2: begin
                        tx <= data_buffer[bitcounter];
                        bitcounter <= bitcounter + 1;
                        if (bitcounter == 7) begin
                            bitcounter <= 0;
                            state <= 3;
                        end
                    end
                    3: begin
                        tx <= 1; // stop bit
                        state <= 0;
                    end
                endcase
            end
        end



endmodule