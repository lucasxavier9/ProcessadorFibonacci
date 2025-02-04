module eqzero (
    input logic [7:0] a,
    output logic acc_eq_zero
);
    assign acc_eq_zero = ~(a[7] | a[6] | a[5] | a[4] | a[3] | a[2] | a[1] | a[0]);
    
endmodule