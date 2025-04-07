`timescale 1ns / 1ps

module moore_seq_detct(
    input clk,
    input reset,
    input in_bit,
    output reg detected
);

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    reg [2:0] current_state, next_state;
    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end
    always @(*) begin
        case (current_state)
            S0: next_state = (in_bit) ? S1 : S0;
            S1: next_state = (in_bit) ? S1 : S2;
            S2: next_state = (in_bit) ? S3 : S0;
            S3: next_state = (in_bit) ? S4 : S2;
            S4: next_state = (in_bit) ? S1 : S2;
            default: next_state = S0;
        endcase
    end

    always @(*) begin
        if (current_state == S4)
            detected = 1;
        else
            detected = 0;
    end

endmodule


