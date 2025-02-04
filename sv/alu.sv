module alu (
    input logic [7:0] a, b,
    input logic [1:0] sel,
    output logic [7:0] x
);
    always_comb begin
        case(sel)
            2'b00: x = a + b;
            2'b01: x = a - b;
            2'b10: x = a & b;
            2'b11: x = a ^ b;
        endcase

    end

endmodule