module fibonacci_counter (
    input CLK,
    input RESET,
    output reg [31:0] F
);
    reg [31:0] a, b;

    always @(posedge CLK or negedge RESET) begin
        if (!RESET) begin
            a <= 0;
            b <= 1;
            F <= 0;
        end else begin
            F <= a + b;
            a <= b;
            b <= F;
        end
    end
endmodule
