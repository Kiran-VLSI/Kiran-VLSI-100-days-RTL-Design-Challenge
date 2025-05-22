`timescale 1ns / 1ps

module mod_n_counter #(parameter N = 10, WIDTH = 4)(
input clk,
input rst,
output reg [WIDTH-1:0] count
    );
    always@(posedge clk or posedge rst)begin
    if(rst)
    count <= 0;
    else if (count == N-1)
    count <= N-1;
    else
    count <= count+1;
    end
endmodule
