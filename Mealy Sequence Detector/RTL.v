`timescale 1 ns / 1 ps

module mealy_seq_det(
    input clk,
    input reset,
    input din,
    output reg dout
);
    parameter S0 = 2'b00,
              S1 = 2'b01,
              S2 = 2'b10,
              S3 = 2'b11;
    reg [1:0] state;
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state <= S0;
            dout <= 0;
        end else begin
            case (state)
                S0: begin
                    state <= (din) ? S1 : S0;
                    dout <= 0;
                end
                S1: begin
                    state <= (din) ? S1 : S2;
                    dout <= 0;
                end
                S2: begin
                    state <= (din) ? S3 : S0;
                    dout <= 0;
                end
                S3: begin
                    dout <= (din) ? 1 : 0;       
                    state <= (din) ? S1 : S2;   
                end
            endcase
        end
    end
endmodule
