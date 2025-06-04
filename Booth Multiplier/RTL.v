`timescale 1ns / 1ps

module booth_multiplier(
    input clk,
    input rst,
    input start,
    input signed [3:0] multiplicand,
    input signed [3:0] multiplier,
    output reg signed [7:0] product,
    output reg done
);
    reg signed [7:0] A, S, P;
    reg [2:0] count;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            A <= 0;
            S <= 0;
            P <= 0;
            product <= 0;
            count <= 0;
            done <= 0;
        end else if (start) begin
            A <= {multiplicand, 4'b0000};
            S <= {-multiplicand, 4'b0000};
            P <= {4'b0000, multiplier, 1'b0};
            count <= 4;
            done <= 0;
        end else if (count > 0) begin
            case (P[1:0])
                2'b01: P <= P + A;
                2'b10: P <= P + S;
            endcase
            P <= {P[7], P[7:1]}; 
            count <= count - 1;
            if (count == 1) begin
                product <= P[7:0];
                done <= 1;
            end
        end
    end
endmodule
