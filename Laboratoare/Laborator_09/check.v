module check(
	input [4:0] i,
	output o
);

/*
if(i % 4 == 1)
	assign o = 1;
else
	assign o = 0;

*/

assign o = (~i[1]) && i[0];

endmodule 