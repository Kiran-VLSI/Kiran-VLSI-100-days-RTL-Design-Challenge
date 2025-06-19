`timescale 1ns / 1ps

module stack_over_under_detection #(
    parameter DATA_WIDTH = 8,
    parameter DEPTH = 16,
    parameter PTR_WIDTH = $clog2(DEPTH)
)(
    input  wire clk,
    input  wire rst,
    input  wire push,
    input  wire pop,
    input  wire [DATA_WIDTH-1:0] data_in,
    output reg  [DATA_WIDTH-1:0] data_out,
    output reg  overflow,
    output reg  underflow
);

    reg [DATA_WIDTH-1:0] stack_mem [0:DEPTH-1];
    reg [PTR_WIDTH:0] sp;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sp        <= 0;
            overflow  <= 0;
            underflow <= 0;
            data_out  <= 0;
        end else begin
            overflow  <= 0;
            underflow <= 0;

            case ({push, pop})
                2'b10: begin
                    if (sp < DEPTH) begin
                        stack_mem[sp] <= data_in;
                        sp <= sp + 1;
                    end else begin
                        overflow <= 1;
                    end
                end
                2'b01: begin 
                    if (sp > 0) begin
                        sp <= sp - 1;
                        data_out <= stack_mem[sp - 1];
                    end else begin
                        underflow <= 1;
                    end
                end
                default: ;
            endcase
        end
    end

endmodule

