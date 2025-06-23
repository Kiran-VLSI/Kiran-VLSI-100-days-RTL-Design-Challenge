`timescale 1ns / 1ps

module spi_master (
    input  wire       clk,
    input  wire       rst,
    input  wire       en,
    output reg        cs,
    output reg        sck,
    input  wire [7:0] ext_command_in,
    input  wire [23:0] ext_address_in,
    input  wire [31:0] ext_data_in,
    output reg        mosi,
    input  wire       miso,
    output reg [31:0] ext_data_out
);
    reg [7:0]  bit_cnt;
    reg [63:0] tx_shift;
    reg [31:0] rx_shift;
    reg [1:0]  state;
    localparam IDLE = 2'd0,
               TRANSFER = 2'd1,
               DONE = 2'd2;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            cs    <= 1'b1;
            sck   <= 1'b0;
            mosi  <= 1'b0;
            ext_data_out <= 32'd0;
            bit_cnt <= 8'd0;
        end else begin
            case (state)
                IDLE: begin
                    cs <= 1'b1;
                    sck <= 1'b0;
                    if (en) begin
                        tx_shift <= {ext_command_in, ext_address_in, ext_data_in};
                        bit_cnt <= 8'd63;
                        cs <= 1'b0;
                        state <= TRANSFER;
                    end
                end
                TRANSFER: begin
                    sck <= ~sck;
                    if (sck == 0) begin
                        mosi <= tx_shift[63];
                        tx_shift <= {tx_shift[62:0], 1'b0};
                    end else begin
                        rx_shift <= {rx_shift[30:0], miso};
                        if (bit_cnt == 0) begin
                            state <= DONE;
                        end else begin
                            bit_cnt <= bit_cnt - 1;
                        end
                    end
                end
                DONE: begin
                    cs <= 1'b1;
                    ext_data_out <= rx_shift;
                    state <= IDLE;
                end
            endcase
        end
    end

endmodule


