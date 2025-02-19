module bist(
	input clk,
	input rst_b,
	output [3:0] sig
);

wire [4:0] q;

wire o;

lfsr5b lfsr5b_inst (.clk(clk), .rst_b(rst_b), .q(q));
check check_inst (.i(q), .o(o));
sisr4b sisr4b_inst(.clk(clk), .rst_b(rst_b), .i(o), .q(sig));

endmodule 

module bist_tb;

localparam CLK_PERIOD = 100, RST_PULSE = 25, CLK_CYCLES = 31;

reg clk, rst_b;
wire [3:0] sig;

bist bist_inst(.clk(clk), .rst_b(rst_b), .sig(sig));

// Clock generator
initial begin
    clk = 0;
    repeat (CLK_CYCLES * 2) #(CLK_PERIOD/2) clk = ~clk;
end

// Reset generator
initial begin
    rst_b = 0;
    #RST_PULSE rst_b = 1;
end

// Monitor
initial begin
    $display("Time sig[3] sig[2] sig[1] sig[0]");
    $monitor("%d %b %b %b %b", $time, sig[3], sig[2], sig[1], sig[0]);
end

endmodule
