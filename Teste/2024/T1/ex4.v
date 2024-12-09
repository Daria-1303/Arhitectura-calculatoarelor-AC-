module ex4 (
    input clk,
    input rst_b,
    input A6,
    input X3,
    input I3,
    output reg [3:0] state,
    output reg out
);
    localparam S0 = 4'b1000;
    localparam S1 = 4'b0100;
    localparam S2 = 4'b0010;
    localparam S3 = 4'b0001;

    reg [3:0] next_state;

    always @(*) begin
       
        case (state)
            S0: begin
                out  = 1;

                if ((A6 & X3 & I3) | X3)
                    next_state = S1;
                else
                    next_state = S0;
            end
            S1: begin
                out = 0;
                if ((I3 & A6) | (I3 & X3))
                    next_state = S2;
                else
                    next_state = S1;
            end
            S2: begin
                out = 0;
                if ((X3 & A6) | (A6 & I3))
                    next_state = S3;
                else
                    next_state = S2;
            end
            S3: begin
                out = 0;
                if ((X3 & A6) | (A6 & I3))
                    next_state = S0;
                else
                    next_state = S3;
            end
            default: next_state = S0;
        endcase
    end

    always @(posedge clk or negedge rst_b) begin
        if (!rst_b)
            state <= S0;
        else
            state <= next_state;
    end
endmodule


module ex4_tb;
    reg clk;
    reg rst_b;
    reg A6, X3, I3;
    wire [3:0] state;
    wire out;

    ex4 uut (
        .clk(clk),
        .rst_b(rst_b),
        .A6(A6),
        .X3(X3),
        .I3(I3),
        .state(state),
        .out(out)
    );

    localparam CLK_PERIOD = 100;
    localparam CLK_CYCLES = 11;

    initial begin
        clk = 0;

        repeat (2 * CLK_CYCLES) # (CLK_PERIOD / 2) clk = ~clk;
    end

    localparam RST_PULSE = 100;

    initial begin
        rst_b = 0;
        #RST_PULSE rst_b = 1;
    end

    // pt A6
    initial begin
        A6 = 0;
        #(CLK_PERIOD) A6 = 1;
        #(CLK_PERIOD) A6 = 0;
        #(2 * CLK_PERIOD) A6 = 1;
        #(5 * CLK_PERIOD) A6 = 0;
    end

    // pt X3
    initial begin
        X3 = 1;
        #(CLK_PERIOD) X3 = 0;
        #(CLK_PERIOD + CLK_PERIOD / 2) X3 = 1;
        #(CLK_PERIOD + CLK_PERIOD / 2) X3 = 0;
        #(CLK_PERIOD + CLK_PERIOD / 2) X3 = 1;
        #(CLK_PERIOD) X3 = 0;
        #(2 * CLK_PERIOD) X3 = 1;
        #(CLK_PERIOD / 2) X3 = 0;
        #(CLK_PERIOD / 2) X3 = 1;
    end

    // pt I3

    initial begin
        I3 = 1;
        #(CLK_PERIOD / 2) I3 = 0;
        #(CLK_PERIOD) I3 = 1;
        #(CLK_PERIOD) I3 = 0;
        #(CLK_PERIOD) I3 = 1;
        #(CLK_PERIOD) I3 = 0;
        #(CLK_PERIOD) I3 = 1;
        #(CLK_PERIOD / 2) I3 = 0;
        #(CLK_PERIOD + CLK_PERIOD / 2) I3 = 1;
        #(CLK_PERIOD + CLK_PERIOD / 2) I3 = 0;
        #(CLK_PERIOD / 2) I3 = 1;
        #(CLK_PERIOD / 2) I3 = 0;
    end

    initial begin
        $display("Time=%0d, clk=%b, rst_b=%b, A6=%b, X3=%b, I3=%b, state=%b, out = %b", $time, clk, rst_b, A6, X3, I3, state, out);
        $monitor("Time=%0d, clk=%b, rst_b=%b, A6=%b, X3=%b, I3=%b, state=%b, out = %b", $time, clk, rst_b, A6, X3, I3, state, out);
    end
endmodule