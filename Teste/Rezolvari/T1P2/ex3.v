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
