module sumator #(
	parameter w=64
)(
	input [w-1:0] i,
	output [w-1:0] o
);
	assign o = i + 64;
endmodule
