`timescale 1ns / 1ps

module ROM (
    input  [7:0] address,
    output reg [7:0] data
);

reg [7:0] rom_data [0:255];

integer i; 

initial begin
    rom_data[0]  = 8'b00000000;
    rom_data[1]  = 8'b00000001;

    for (i = 2; i < 256; i = i + 1) begin
        rom_data[i] = rom_data[i-1] + 1;
    end
end
always @(*) begin
    data = rom_data[address];
end
endmodule


