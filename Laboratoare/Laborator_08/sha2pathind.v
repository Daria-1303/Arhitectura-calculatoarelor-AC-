module sha2indpath #(
	parameter reg_w=64,
	parameter reg_cnt=8,
	parameter dec_w=3
)(
	input clk,
	input rst_b,
	input [reg_w-1:0] pkt,	
	input st_pkt,
	input clr,
	input pad_pkt,
	input zero_pkt,
	input mgln_pkt,
	output [dec_w-1:0] idx,
	output [reg_cnt*reg_w-1:0] blk
);
