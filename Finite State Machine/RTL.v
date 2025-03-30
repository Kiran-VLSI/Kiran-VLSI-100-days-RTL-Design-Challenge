`timescale 1 ns/ 1 ps

module fsm (
    input clk,           
    input reset,         
    input in_signal,    
    output reg [1:0] state 
);

    parameter IDLE = 2'b00, 
              STATE1 = 2'b01, 
              STATE2 = 2'b10;
    
    always @(posedge clk or posedge reset) begin
        if (reset) 
            state <= IDLE;  
        else begin
            case (state)
                IDLE: 
                    if (in_signal)
                        state <= STATE1;
                    else
                        state <= IDLE;
                
                STATE1: 
                    if (!in_signal)
                        state <= STATE2;
                    else
                        state <= STATE1;

                STATE2: 
                    if (in_signal)
                        state <= IDLE;
                    else
                        state <= STATE2;
                
                default: state <= IDLE; 
            endcase
        end
    end
endmodule
