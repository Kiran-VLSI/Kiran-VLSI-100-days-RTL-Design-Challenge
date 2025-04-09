module mealy_seq_overlap (
    input clk,
    input rst,
    input din,
    output reg dout
);

    parameter S0 = 2'b00;
    parameter S1 = 2'b01;
    parameter S2 = 2'b10;
    parameter S3 = 2'b11;

    reg [1:0] state, next_state;

    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= S0;
        else
            state <= next_state;
    end

    always @(*) begin
        dout = 0; 
        case (state)
            S0: begin
                if (din)
                    next_state = S1;
                else
                    next_state = S0;
            end

            S1: begin
                if (din)
                    next_state = S1;
                else
                    next_state = S2;
            end

            S2: begin
                if (din)
                    next_state = S3;
                else
                    next_state = S0;
            end

            S3: begin
                if (din) begin
                    dout = 1;         
                    next_state = S1; 
                end else
                    next_state = S2;
            end

            default: next_state = S0;
        endcase
    end

endmodule
