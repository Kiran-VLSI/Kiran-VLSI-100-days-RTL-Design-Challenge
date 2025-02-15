module flipflop_T (
    input t, clk, rst,
    output reg q
);
    always @(posedge clk or posedge rst) begin
        if (rst)
            q <= 0;
        else if (t)
            q <= ~q;
    end
endmodule
