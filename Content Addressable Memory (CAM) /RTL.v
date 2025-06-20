`timescale 1ns / 1ps

module cam #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 8
)(
    input wire clk,
    input wire rst,
    input wire [DATA_WIDTH-1:0] search_key,
    output reg match,
    output reg [$clog2(DEPTH)-1:0] match_index
);

    reg [DATA_WIDTH-1:0] memory [0:DEPTH-1];
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            match <= 0;
            match_index <= 0;
            for (i = 0; i < DEPTH; i = i + 1)
                memory[i] <= i; 
        end else begin
            match <= 0;
            for (i = 0; i < DEPTH; i = i + 1) begin
                if (memory[i] == search_key) begin
                    match <= 1;
                    match_index <= i;
                end
            end
        end
    end
endmodule

