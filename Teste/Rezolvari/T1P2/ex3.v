module ex3 #(
    parameter w = 8
)(
    input clk,
    input rst_b,    // activ la 0
    input sh,   // activa la 1, pentru shiftare la dreapta
    input ld,   // activa la 1, pentru incarcare
    // prioritar rst_b > sh > ld
    input [w - 1 : 0] data_in, // datele de incarcat
    output reg [w - 1 : 0] data_out,
    output reg [w - 1 : 0] b_out
);

always @(posedge clk, negedge rst_b)
    if(!rst_b) begin
        data_out <= 0;
        b_out <= 1'bz;
    end
    else begin
        if(sh) begin 
            b_out <= data_out[0];
            data_out <= {1'b0, data_out[w - 1 : 1]};
        end
        else if(ld) begin
            data_out <= data_in;
            b_out <= 1'bz;
        end
    end
endmodule

module ex3_tb;

reg clk;
reg rst_b;
reg sh;
reg ld;
// reg sh_type;
reg [7:0] data_in;
wire [7:0] data_out;
wire [7 : 0]b_out;

ex3 #(
    .w(8)        // Număr de biți
) uut (
    .clk(clk),
    .rst_b(rst_b),
    .sh(sh),
    .ld(ld),
    //    .sh_type(sh_type),
    .data_in(data_in),
    .data_out(data_out),
    .b_out(b_out)
);

// Generare semnal de ceas
always #5 clk = ~clk;

initial begin
    clk = 0; rst_b = 0; sh = 0; ld = 0; data_in = 8'b0;

    $display("Time | rst_b | ld | sh | data_in | data_out | b_out");
    $monitor("%4t |   %b   | %b  | %b  |  %b   |   %b    |   %b", 
             $time, rst_b, ld, sh, data_in, data_out, b_out);

    // Test 1: Reset
    #10 rst_b = 1; // Scoatem resetul
    #10 rst_b = 0; // Aplicăm resetul
    #10 rst_b = 1; // Scoatem resetul din nou

    // Test 2: Încărcare sincronă
    #10 ld = 1; data_in = 8'b10101010;
    #10 ld = 0;

    // Test 3: Shiftare logică la dreapta
    #10 sh = 1;
    #10 sh = 0;

    // Test 4: Shiftare aritmetică la dreapta
    #10 sh = 1;
    #10 sh = 0;

    // Test 5: Comportament normal fără schimbări
    #10;

    $stop;
end

endmodule
