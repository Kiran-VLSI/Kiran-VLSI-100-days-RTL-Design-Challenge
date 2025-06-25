`timescale 1ns / 1ps

module apb_timer(
    input wire        PCLK,
    input wire        PRESETn,
    input wire        PSEL,
    input wire        PENABLE,
    input wire        PWRITE,
    input wire [7:0]  PADDR,
    input wire [7:0]  PWDATA,
    output reg [7:0]  PRDATA,
    output reg        PREADY
);
reg [7:0] load_reg;
reg [7:0] counter;
reg       start;
reg       done_flag;
always @(posedge PCLK or negedge PRESETn) begin
    if (!PRESETn) begin
        load_reg <= 8'd0;
        start    <= 1'b0;
        counter  <= 8'd0;
        done_flag <= 1'b0;
        PREADY   <= 1'b0;
    end else begin
        PREADY <= 1'b0;
        if (PSEL && PENABLE) begin
            PREADY <= 1'b1;
            if (PWRITE) begin
                case (PADDR)
                    8'h00: load_reg <= PWDATA; 
                    8'h04: begin
                        start <= PWDATA[0];
                        if (PWDATA[0]) begin
                            counter <= load_reg;
                            done_flag <= 1'b0;
                        end
                    end
                endcase
            end else begin
                case (PADDR)
                    8'h08: PRDATA <= {7'b0, done_flag}; 
                    8'h0C: PRDATA <= counter;           
                    default: PRDATA <= 8'h00;
                endcase
            end
        end
    end
end
always @(posedge PCLK or negedge PRESETn) begin
    if (!PRESETn) begin
        counter <= 8'd0;
        done_flag <= 1'b0;
    end else if (start && counter > 0) begin
        counter <= counter - 1;
        if (counter == 1) begin
            done_flag <= 1'b1;
            start <= 0;
        end
    end
end
endmodule

