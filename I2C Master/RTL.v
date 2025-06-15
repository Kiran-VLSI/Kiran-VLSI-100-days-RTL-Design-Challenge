`timescale 1ns / 1ps

module i2c_master(
    input wire clk,
    input wire rst,
    input wire start,
    input wire [6:0] addr,     
    input wire [7:0] data,    
    output reg scl,
    inout wire sda,
    output reg done
);
    reg [3:0] state;
    reg [3:0] bit_cnt;
    reg sda_out;
    reg sda_dir;

    assign sda = sda_dir ? sda_out : 1'bz;

    localparam IDLE=0, START=1, ADDR=2, ACK1=3, DATA=4, ACK2=5, STOP=6, DONE=7;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            scl <= 1;
            sda_dir <= 1;
            sda_out <= 1;
            done <= 0;
            bit_cnt <= 0;
        end else begin
            case (state)
                IDLE: begin
                    scl <= 1;
                    sda_out <= 1;
                    done <= 0;
                    if (start)
                        state <= START;
                end
                START: begin
                    sda_out <= 0;
                    scl <= 1;
                    state <= ADDR;
                    bit_cnt <= 7;
                end
                ADDR: begin
                    scl <= 0;
                    sda_out <= addr[bit_cnt];
                    scl <= 1;
                    if (bit_cnt == 0)
                        state <= ACK1;
                    else
                        bit_cnt <= bit_cnt - 1;
                end
                ACK1: begin
                    scl <= 0;
                    sda_dir <= 0; // release SDA
                    scl <= 1;     // receive ACK
                    state <= DATA;
                    sda_dir <= 1;
                    bit_cnt <= 7;
                end
                DATA: begin
                    scl <= 0;
                    sda_out <= data[bit_cnt];
                    scl <= 1;
                    if (bit_cnt == 0)
                        state <= ACK2;
                    else
                        bit_cnt <= bit_cnt - 1;
                end
                ACK2: begin
                    scl <= 0;
                    sda_dir <= 0;
                    scl <= 1;
                    state <= STOP;
                end
                STOP: begin
                    scl <= 1;
                    sda_dir <= 1;
                    sda_out <= 0;
                    #1;
                    sda_out <= 1;
                    state <= DONE;
                end
                DONE: begin
                    done <= 1;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
