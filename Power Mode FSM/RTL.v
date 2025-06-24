`timescale 1ns / 1ps

module power_fsm(
    input wire clk,
    input wire rst,
    input wire activity_detected,   
    input wire sleep_req,           
    output reg [1:0] power_mode    
);

localparam ACTIVE = 2'b00;
localparam IDLE   = 2'b01;
localparam SLEEP  = 2'b10;

reg [1:0] current_state, next_state;

always @(posedge clk or posedge rst) begin
    if (rst)
        current_state <= ACTIVE;
    else
        current_state <= next_state;
end

always @(*) begin
    case (current_state)
        ACTIVE: begin
            if (!activity_detected)
                next_state = IDLE;
            else
                next_state = ACTIVE;
        end
        IDLE: begin
            if (sleep_req)
                next_state = SLEEP;
            else if (activity_detected)
                next_state = ACTIVE;
            else
                next_state = IDLE;
        end
        SLEEP: begin
            if (activity_detected)
                next_state = ACTIVE;
            else
                next_state = SLEEP;
        end
        default: next_state = ACTIVE;
    endcase
end

always @(posedge clk or posedge rst) begin
    if (rst)
        power_mode <= ACTIVE;
    else
        power_mode <= current_state;
end
endmodule

