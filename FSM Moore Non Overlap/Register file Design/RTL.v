`timescale 1ns / 1ps

module register_file #(
    parameter DATA_WIDTH = 32,
    parameter ADDR_WIDTH = 5,
    parameter REG_COUNT = 32
)(
    input  wire                   clk,
    input  wire                   rst,
    input  wire                   we,
    input  wire [ADDR_WIDTH-1:0] w_addr,
    input  wire [DATA_WIDTH-1:0] w_data,
    input  wire [ADDR_WIDTH-1:0] r_addr1,
    input  wire [ADDR_WIDTH-1:0] r_addr2,
    output wire [DATA_WIDTH-1:0] r_data1,
    output wire [DATA_WIDTH-1:0] r_data2
);
    reg [DATA_WIDTH-1:0] regs [0:REG_COUNT-1];

    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            for (i = 0; i < REG_COUNT; i = i + 1)
                regs[i] <= 0;
        end else if (we && w_addr != 0) begin
            regs[w_addr] <= w_data;
        end
    end

    assign r_data1 = regs[r_addr1];
    assign r_data2 = regs[r_addr2];
endmodule
