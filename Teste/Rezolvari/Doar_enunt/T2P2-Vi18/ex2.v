/* Folosindu-va de modulul sum_1digit_BCD ce insumeaza doua cifre BCD x si y, construiti un sumator BCD ce insumeaza doua numere BCD cu n_digits cifre. */
module sum_1digit_BCD(input[3:0] x, y, input c_in, output reg[3:0] z, output reg c_out);

    reg[3:0] aux;
    always @(*) begin
        {c_out, aux} = x + y + c_in;
        if(aux > 9 || c_out) begin
            aux = aux + 4'd6;
            c_out = 1;
        end
        z = aux;
    end
endmodule

module sum_digits_BCD #(parameter n_digits=4)(input[n_digits*4-1:0] x, y, output[n_digits*4-1:0] z, output c_out);
    wire [3:0] aux;
	wire aux2;
	generate
		genvar j;
		for(j=0;j<n_digits;j=j+1)begin:vect
			if(j==0)
				begin
					sum_1digit_BCD d(.x(x[3:0]),.y(y[3:0]),.c_in(1'b0),.z(z[3:0]),.c_out(aux2));
				end
			else
			begin
				if(j!=n_digits-1)
				begin
					sum_1digit_BCD d(.x(x[(j*4+3):j*4]),.y(y[(j*4+3):j*4]),.c_in(aux2),.z(z[(j*4+3):j*4]),.c_out(aux2));
				end
				else
				begin
					sum_1digit_BCD d(.x(x[(j*4+3):j*4]),.y(y[(j*4+3):j*4]),.c_in(aux2),.z(z[(j*4+3):j*4]),.c_out(c_out));
				end
			end
		end
	endgenerate
endmodule

module sum_digits_BCD_tb;
    reg[7:0] x, y;
    wire[7:0] z;
    wire c_out;

    sum_digits_BCD #(.n_digits(2)) uut(.x(x), .y(y), .z(z), .c_out(c_out));

    reg[3:0] d_x, u_x;
    reg[3:0] d_y, u_y;

    initial begin
        $display("X\tY\t\tZ\tc_out");
        $monitor("%h\t%h\t\t%h\t%b", x, y, z, c_out);
        for(d_x = 0; d_x < 10; d_x = d_x + 3)
            for(u_x = 0; u_x < 10; u_x = u_x + 2)
                for(d_y = 0; d_y < 10; d_y = d_y + 1)
                    for(u_y = 0; u_y < 10; u_y = u_y + 3)
                        #10 {x, y}={d_x, u_x, d_y, u_y};
    end
endmodule