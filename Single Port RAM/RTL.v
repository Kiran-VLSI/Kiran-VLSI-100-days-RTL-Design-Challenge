`timescale 1ns / 1ps

module single_port_ram #(
    parameter addr_width = 6,
    parameter data_width = 8,
    parameter depth = 64
)(
    input [data_width-1:0] data,     
    input [addr_width-1:0] addr,     
    input we, clk,                    // Write Enable (WE): 1 = write, 0 = read
    output reg [data_width-1:0] q    
);

reg [data_width-1:0] ram [0:depth-1];

always @(posedge clk) begin
    if (we)
        ram[addr] <= data;    
    else
        q <= ram[addr];         
end
endmodule
