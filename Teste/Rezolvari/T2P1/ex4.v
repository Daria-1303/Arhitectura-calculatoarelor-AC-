module rca_4bit(
    input [3 : 0] nr1,
    input [3 : 0] nr2,
    input carry_in,
    output [3 : 0] suma,
    output carry_out
);
wire [2 : 0] carry;

assign {carry[0], suma[0]} = nr1[0] + nr2[0] + carry_in;
assign {carry[1], suma[1]} = nr1[1] + nr2[1] + carry[0];
assign {carry[2], suma[2]} = nr1[2] + nr2[2] + carry[1];
assign {carry_out, suma[3]} = nr1[3] + nr2[3] + carry[2];

endmodule

module ex4(
    input [3 : 0] X,
    input [3 : 0] Y,
    output [7 : 0] P
);



endmodule