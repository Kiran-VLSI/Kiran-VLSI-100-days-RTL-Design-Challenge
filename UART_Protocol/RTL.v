`timescale 1ns / 1ps

module uart_tx #(
    parameter CLK_FREQ = 50000000,   
    parameter BAUD_RATE = 9600         
)(
    input wire clk,
    input wire rst,
    input wire tx_start,
    input wire [7:0] tx_data,
    output reg tx,
    output reg tx_busy
);
    localparam BAUD_TICK_COUNT = CLK_FREQ / BAUD_RATE;
    localparam IDLE  = 3'b000,
               START = 3'b001,
               DATA  = 3'b010,
               STOP  = 3'b011,
               CLEANUP = 3'b100;

    reg [2:0] state = IDLE;
    reg [15:0] clk_count = 0;
    reg [2:0] bit_index = 0;
    reg [7:0] tx_shift_reg = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= IDLE;
            tx <= 1'b1;  // Idle state for UART TX line is HIGH
            clk_count <= 0;
            bit_index <= 0;
            tx_busy <= 0;
        end else begin
            case (state)
                IDLE: begin
                    tx <= 1'b1;
                    clk_count <= 0;
                    bit_index <= 0;
                    tx_busy <= 0;
                    if (tx_start) begin
                        tx_shift_reg <= tx_data;
                        tx_busy <= 1;
                        state <= START;
                    end
                end

                START: begin
                    tx <= 1'b0;
                    if (clk_count < BAUD_TICK_COUNT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        state <= DATA;
                    end
                end

                DATA: begin
                    tx <= tx_shift_reg[bit_index];
                    if (clk_count < BAUD_TICK_COUNT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        if (bit_index < 7)
                            bit_index <= bit_index + 1;
                        else begin
                            bit_index <= 0;
                            state <= STOP;
                        end
                    end
                end

                STOP: begin
                    tx <= 1'b1; 
                    if (clk_count < BAUD_TICK_COUNT - 1)
                        clk_count <= clk_count + 1;
                    else begin
                        clk_count <= 0;
                        state <= CLEANUP;
                    end
                end
                CLEANUP: begin
                    tx_busy <= 0;
                    state <= IDLE;
                end
            endcase
        end
    end
endmodule
