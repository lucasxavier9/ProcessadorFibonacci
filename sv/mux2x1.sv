module mux2x1 (
    input logic [7:0] a, b,
    input logic sel,
    output logic [7:0] x
);
    assign x = ( sel == 1'b0) ? a : b ;
    
endmodule