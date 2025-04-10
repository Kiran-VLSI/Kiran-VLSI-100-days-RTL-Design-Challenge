`timescale 1ns / 1ps

module fsm_moore_non_overlapp(
    input clk,
    input rst,
    input din,
    output reg dout
);

    parameter S0 = 3'b000;
    parameter S1 = 3'b001;
    parameter S2 = 3'b010;
    parameter S3 = 3'b011;
    parameter S4 = 3'b100;

    reg [2:0] state, next_state;


    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

  
    always @(*) begin
        case (state)
            S0: next_state = din ? S1 : S0;
            S1: next_state = din ? S1 : S2;
            S2: next_state = din ? S3 : S0;
            S3: next_state = din ? S4 : S2;
            S4: next_state = S0; 
            default: next_state = S0;
        endcase
    end

    always @(*) begin
        case (state)
            S4: dout = 1;
            default: dout = 0;
        endcase
    end

endmodule

   
