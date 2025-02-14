module D_flipflop (
  input clk,
  input rst,
  input d,
  output reg Q
);
  always @(posedge clk or posedge rst) begin
    if (rst)
      Q <= 0;
    else
      Q <= d;
  end
endmodule
