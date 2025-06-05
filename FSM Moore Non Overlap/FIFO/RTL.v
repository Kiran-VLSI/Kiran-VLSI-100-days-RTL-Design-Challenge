`timescale 1ns / 1ps

module fifo #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 4
)(
    input clk,
    input reset,
    input wr_en,
    input rd_en,
    input [DATA_WIDTH-1:0] din,
    output reg [DATA_WIDTH-1:0] dout,
    output reg full,
    output reg empty
);
    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    reg [1:0] wr_ptr = 0;
    reg [1:0] rd_ptr = 0;
    reg [3:0] count = 0;

    always @(posedge clk or posedge reset) begin
        if (reset) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count <= 0;
            full <= 0;
            empty <= 1;
            dout <= 0;
        end else begin
            if (wr_en && !full) begin
                mem[wr_ptr] <= din;
                wr_ptr <= wr_ptr + 1;
                count <= count + 1;
            end
            if (rd_en && !empty) begin
                dout <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                count <= count - 1;
            end
            full <= (count == DEPTH);
            empty <= (count == 0);
        end
    end
endmodule

