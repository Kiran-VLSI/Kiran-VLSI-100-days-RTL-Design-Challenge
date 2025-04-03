module moore_fsm (
    input clk,
    input reset,
    output reg [2:0] out
);
    parameter S0 = 2'b00, 
              S1 = 2'b01, 
              S2 = 2'b10, 
              S3 = 2'b11;

    reg [1:0] current_state, next_state;

    always @(posedge clk or posedge reset) begin
        if (reset)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    always @(*) begin
        case (current_state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S0;
            default: next_state = S0;
        endcase
    end

    always @(*) begin
        case (current_state)
            S0: out = 3'b000;
            S1: out = 3'b001;
            S2: out = 3'b010;
            S3: out = 3'b011;
            default: out = 3'b000;
        endcase
    end

endmodule
