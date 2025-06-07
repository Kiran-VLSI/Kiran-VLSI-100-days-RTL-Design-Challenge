`timescale 1ns / 1ps

module traffic_light(
    input clk,
    input rst,
    output reg [2:0] ns_light,  
    output reg [2:0] ew_light   
);
    reg [1:0] state;
    parameter NS_GREEN  = 2'b00,
              NS_YELLOW = 2'b01,
              EW_GREEN  = 2'b10,
              EW_YELLOW = 2'b11;
    reg [3:0] timer;
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            state <= NS_GREEN;
            timer <= 0;
        end else begin
            if (timer == 9) begin
                timer <= 0;
                state <= state + 1;
            end else begin
                timer <= timer + 1;
            end
        end
    end

    always @(*) begin
        case (state)
            NS_GREEN: begin
                ns_light = 3'b001;  
                ew_light = 3'b100;  
            end
            NS_YELLOW: begin
                ns_light = 3'b010;  
                ew_light = 3'b100;  
            end
            EW_GREEN: begin
                ns_light = 3'b100;  
                ew_light = 3'b001;  
            end
            EW_YELLOW: begin
                ns_light = 3'b100;  
                ew_light = 3'b010;  
            end
            default: begin
                ns_light = 3'b100;
                ew_light = 3'b100;
            end
        endcase
    end

endmodule
