module sha2indpath(
  input clk,rst_b,clr,st_pkt,pad_pkt,zero_pkt,mgln_pkt,
  input [63:0] pkt,
  output [2:0] idx,
  output [511:0] blk
);
  wire [63:0] mlen, mout;
  pktmux inst1(.pkt(pkt),.pad_pkt(pad_pkt),.zero_pkt(zero_pkt),
      .mgln_pkt(mgln_pkt),.msg_len(mlen),.o(mout));
  regfl inst2(.clk(clk),.rst_b(rst_b),.we(st_pkt),.d(mout),
      .s(idx),.q(blk));
  cntr #(.w(3)) inst3(.clk(clk),.rst_b(rst_b),.clr(clr),.c_up(st_pkt),.q(idx));
  rgst #(.w(64)) inst4(.clk(clk),.rst_b(rst_b),.clr(clr),.q(mlen),
      .ld(st_pkt&(~(pad_pkt|zero_pkt|mgln_pkt))),
      .d(mlen+64));
endmodule

module sha2indpath_tb;
  reg clk,rst_b,clr,st_pkt,pad_pkt,zero_pkt,mgln_pkt;
  reg [63:0] pkt;
  wire [2:0] idx;
  wire [511:0] blk;
  
  sha2indpath inst1(.clk(clk),.rst_b(rst_b),.clr(clr),.st_pkt(st_pkt),
      .pad_pkt(pad_pkt),.zero_pkt(zero_pkt),.mgln_pkt(mgln_pkt),
      .pkt(pkt),.idx(idx),.blk(blk));
endmodule