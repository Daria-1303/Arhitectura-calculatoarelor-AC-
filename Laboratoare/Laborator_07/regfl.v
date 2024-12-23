module regfl(
	input clk,
	input rst_b,
	input we,
	input [2:0] s,
	input [63:0] d,
	output [511:0] q
);

wire [7:0] o;
wire [63:0] data [7:0]; // 8 linii de semnal, fiecare avand latime de 64 de biti -> stocheaza iesirile celor 8 registre individuale

//instanta decodificator

dec #(
	.w(3)
) dec0 (
	.s(s),
	.e(we),
	.o(o)
);

//generarea celor 8 registre
generate
	genvar i;

	for (i = 0; i < 8; i = i + 1) begin: re
g_inst
		rgst #(.w(64)) reg_inst(
			.clk(clk),
			.clr(1'b0),
			.rst_b(rst_b),//reset asincron
			.ld(o[3'd7 - i]), //linia de selectie din decodor (7 - i)
			.d(d),
			.q(data[i])
		);
	end

endgenerate

assign q = {data[7], data[6], data[5], data[4], data[3], data[2], data[1], data[0]};

endmodule

module regfl_tb;

// Variables
reg clk, rst_b, write_enable;
reg [2:0] index;
reg [63:0] data_in;
wire [511:0] blk_out;

// regfl instance
regfl regfl_tb(
    .clk(clk),
    .rst_b(rst_b),
    .we(write_enable),
    .s(index),
    .d(data_in),
    .q(blk_out)
);

// Testbench parameters
localparam CLK_PERIOD = 100;
localparam RST_PULSE = 25;
localparam RUNNING_CYCLES = 13;

// Clock generation block
initial begin
    clk = 0;
    repeat (RUNNING_CYCLES) #(CLK_PERIOD/2) clk = ~clk;
end

// Reset generation block
initial begin
    rst_b = 0;
    #RST_PULSE rst_b = 1;
end

// Random number generation block
initial begin
    repeat (RUNNING_CYCLES) begin
        index = $urandom;
        data_in[63:32] = $urandom;
        data_in[31:0] = $urandom;
        #CLK_PERIOD;
    end
end

// Testbench block
initial begin
    $display("wr_en | index | data | blk");
    $monitor(" %b  |  %x  | %x  |  %x ", write_enable, index, data_in, blk_out);

    write_enable = 1;

    #(CLK_PERIOD * 6) write_enable = 0;
    #CLK_PERIOD write_enable = 1;

    #1

    $finish;

end

endmodule

