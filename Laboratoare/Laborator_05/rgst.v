module rgst #(
	parameter width = 8
)(
	input clk, rst_b, ld, clr, 
	input [width - 1 : 0] d, 
	output reg [width - 1 : 0] q
);

always @ (posedge clk, negedge rst_b)
        if (!rst_b)                 
		q <= 0;
        else if (clr)               
		q <= 0;
        else if (ld)                
		q <= d;
endmodule