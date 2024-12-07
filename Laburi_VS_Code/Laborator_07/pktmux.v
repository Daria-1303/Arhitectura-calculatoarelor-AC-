module pktmux #(
    parameter w=64
)(
    input wire [w - 1: 0] pkt, //pachet
    input wire [w - 1: 0] msg_len, //lungimea mesajului pe w biti
    input wire pad_pkt, //activa daca pachetul curent este de tip extensie
    input wire zero_pkt, //activa daca pachetul curent este de tip zero
    input wire mgln_pkt, //activa daca pachetul curent are lungimea mesajului
    output reg [w - 1: 0] o //iesirea multiplexorului
);


endmodule