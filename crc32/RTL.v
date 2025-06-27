
module crc32(
    input wire clk,
    input wire rst,
    input wire data_valid,
    input wire [7:0] data_in,
    output reg [31:0] crc_out
);

    reg [31:0] crc_reg;
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            crc_reg <= 32'hFFFFFFFF;
        end else if (data_valid) begin
            crc_reg = crc_reg ^ {24'b0, data_in};
            for (i = 0; i < 8; i = i + 1) begin
                if (crc_reg[0])
                    crc_reg = (crc_reg >> 1) ^ 32'hEDB88320; // CRC-32 polynomial
                else
                    crc_reg = (crc_reg >> 1);
            end
        end
    end

    always @(posedge clk) begin
        crc_out <= ~crc_reg;
    end

endmodule
