module clock_divider(
    input clk,
    input reset,
    input [31:0] divisor,
    output reg clk_div
);
    
        reg [32:0] counter;
        
        always @ (posedge clk or posedge reset) begin
            if (reset) begin
                counter <= 0;
                clk_div <= 0;
            end else begin
                counter <= counter + 32'b01;
                if (counter == (divisor - 1)) begin
                    counter <= 0;
                    clk_div <= ~clk_div;
                end
            end
        end

endmodule