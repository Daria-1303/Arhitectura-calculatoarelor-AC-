module mux #(
	parameter width = 32
)(
	input [width - 1 : 0] i1, i0,
	input s,
	output [width - 1 : 0] o 
);

assign o = (s) ? i1 : i0;

endmodule
