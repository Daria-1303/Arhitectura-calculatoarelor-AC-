module ex4(
    input clk,
    input bit,      // semnal pentru citirea unui bit
    input flush,    // semnal pentru golire, activa pe 1 -> vom citi alt nr byte, desi cel anterior isi pastreaza valoarea
    output reg [7 : 0] byte
);

reg [7 : 0] buffer; // buffer pentru citirea unui byte
reg [2 : 0] cnt;    // contor pentru citirea unui byte -> cand ajunge la 8, am citit un byte

always @(posedge clk) begin
    if(flush) begin
        buffer <= 8'b0; // daca flush este activ, golim buffer-ul
        cnt <= 3'b0;    // resetam contorul
    end
    else begin
        buffer <= {buffer[6 :0], bit};  // shiftam buffer-ul la stanga si adaugam bit-ul citit
        cnt <= cnt + 1;                 // incrementam contorul

        if(cnt == 3'b111) begin
            byte <= buffer; // daca am citit un byte, il scriem in byte
            cnt <= 3'b0;    // resetam contorul
        end
    end
end
 
endmodule


module ex4_tb;

reg clk;
reg flush;
reg bit;
wire [7:0] byte;

// Instanțierea modulului ex4
ex4 uut (
    .clk(clk),
    .flush(flush),
    .bit(bit),
    .byte(byte)
);

// Generarea semnalului de ceas
localparam CLK_PERIOD = 10;
localparam CLK_CYCLES = 30;
initial begin
    clk = 0;
    repeat (2 * CLK_CYCLES) # (CLK_PERIOD / 2) clk = ~clk;
end

initial begin
    bit = 0;
    #(CLK_PERIOD) bit = 1;
    #(2 * CLK_PERIOD) bit = 0;
    #(CLK_PERIOD) bit = 1;
    #(CLK_PERIOD) bit = 0;
    #(CLK_PERIOD) bit = 1;
    #(CLK_PERIOD) bit = 0;
    #(CLK_PERIOD) bit = 1;
    #(CLK_PERIOD) bit = 0;  
    #(CLK_PERIOD) bit = 1;
    #(2 * CLK_PERIOD) bit = 0;
    #(CLK_PERIOD) bit = 1;
    #(CLK_PERIOD) bit = 0;
    #(CLK_PERIOD) bit = 1;
    #(CLK_PERIOD) bit = 0;
    #(CLK_PERIOD) bit = 1;
    #(2 * CLK_PERIOD) bit = 0;
    #(CLK_PERIOD) bit = 1;
    #(2 * CLK_PERIOD) bit = 0;
    #(CLK_PERIOD) bit = 1;
    #(CLK_PERIOD) bit = 0;
    #(2 * CLK_PERIOD) bit = 1;
    #(2 * CLK_PERIOD) bit = 0;
    #(2 * CLK_PERIOD) bit = 1;
end

initial begin
    flush = 0;
    #(13 * CLK_PERIOD) flush = 1;
    #(8 * CLK_PERIOD) flush = 0;
end

initial begin
    $display("Time       |   flush      | bit_in      | byte");
    $display("------------------------------------------------");
    $monitor("%d          |   %b          | %b          | %b", $time, flush, bit, byte);
end



endmodule
