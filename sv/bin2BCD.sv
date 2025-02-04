module bin2BCD(
    input logic [7:0] bin,
    output logic [3:0] cen,
    output logic [3:0] dez,
    output logic [3:0] und
    );

	integer i;
	
	always_comb begin
		cen = 4'b0000;
		dez = 4'b0000;
		und = 4'b0000;
		
		for (i=7; i>=0; i=i-1) begin
			if (cen >= 4'd5) cen = cen + 4'd3;
			if (dez >= 4'd5) dez = dez + 4'd3;
			if (und >= 4'd5) und = und + 4'd3;
			
			cen = cen << 1;
			cen[0] = dez[3];
			
			dez = dez << 1;
			dez[0] = und[3];
			
			und = und << 1;
			und[0] = bin[i];
		end
	end

endmodule
