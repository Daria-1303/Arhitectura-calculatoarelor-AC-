module ex2(
    input [3 : 0] nr1, // 4 bit input
    input [3 : 0] nr2, // 4 bit input 
    output [3:0] cifra_zecilor,
    output [3:0] cifra_unitatilor
);

assign cifra_zecilor =  (nr1 + nr2) / 10;
assign cifra_unitatilor = (nr1 + nr2) % 10;

endmodule

