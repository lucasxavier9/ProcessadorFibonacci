module reg12b (
    input logic [11:0] d,
    input logic ld, clr, clk,
    output logic [11:0] q
);

    //inicializa o registrador em zero
    
    initial begin
        q = 12'b00000000000;
    end

    //funcionamento do registrador

    always @(negedge clk, posedge clr) begin
        if (clr == 1'b1)begin
            q = 12'b000000000000;
        end else begin
            if(ld == 1'b1) begin
                q = d;
            end
        end
    end

endmodule