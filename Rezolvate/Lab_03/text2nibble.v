module text2nibble (
  input [7:0] i,
  output reg [3:0] o
);
  always @(*)
    if ((i >= 8'h30) && (i <= 8'h 39))
      o = i - 8'h30; /*se vor pastra ultimii, cei mai putin 
                       semnificativi 4 biti*/
    else
      o = 4'd15;
endmodule

module text2nibble_tb;
  reg [7:0] i;
  wire [3:0] o;

  text2nibble text2nibble_i (.i(i), .o(o));

  integer k;
  initial begin
    $display("Time\ti\ti_chr\to");
    $monitor("%0t\t%b\t%c\t%b(%d)", $time, i, i, o, o);
    i = 0;
    for (k = 1; k < 256; k = k + 1)
      #10 i = k;
  end
endmodule