module spmu #(
    parameter DEPTH = 16,
    parameter PTR_WIDTH = $clog2(DEPTH)
)(
    input  wire clk,
    input  wire rst,
    input  wire push,
    input  wire pop,
    output reg  [PTR_WIDTH-1:0] sp,
    output wire full,
    output wire empty
);
    reg [PTR_WIDTH:0] count;

    assign full  = (count == DEPTH);
    assign empty = (count == 0);

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            sp    <= 0;
            count <= 0;
        end else begin
            case ({push, pop})
                2'b10: if (!full) begin
                    sp    <= sp + 1;
                    count <= count + 1;
                end
                2'b01: if (!empty) begin
                    sp    <= sp - 1;
                    count <= count - 1;
                end
                default: ;
            endcase
        end
    end
endmodule
