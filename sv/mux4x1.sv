module mux4x1 (
    input logic [7:0] a, b, c, d,
    input logic [1:0] sel,
    output logic [7:0] x
);

    always_comb begin
        case(sel)
            2'b00: x = a;
            2'b01: x = b;
            2'b10: x = c;
            2'b11: x = d;
        endcase        
    end

endmodule