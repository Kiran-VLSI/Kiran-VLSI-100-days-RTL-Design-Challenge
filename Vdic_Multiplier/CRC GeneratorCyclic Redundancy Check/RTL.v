`timescale 1ns / 1ps

module crc_generator(
    input clk,
    input rst,
    input data_in,         
    input data_valid,      
    output reg [7:0] crc_out
);
    reg [7:0] crc;

    always @(posedge clk or posedge rst) begin
        if (rst)
            crc <= 8'h00;
        else if (data_valid) begin
            crc[7] <= crc[6];
            crc[6] <= crc[5];
            crc[5] <= crc[4];
            crc[4] <= crc[3] ^ crc[7] ^ data_in;
            crc[3] <= crc[2];
            crc[2] <= crc[1];
            crc[1] <= crc[0];
            crc[0] <= crc[7] ^ data_in;
        end
    end

    always @(*) begin
        crc_out = crc;
    end
endmodule

