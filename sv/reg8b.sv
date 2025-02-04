module reg8b (
    input logic [7:0] d,
    input logic ld, clr, clk,
    output logic [7:0] q
);

    //inicializa o registrador em zero
    
    initial begin
        q = 8'b00000000;
    end

    //funcionamento do registrador

    always @(negedge clk, posedge clr) begin
        if (clr == 1'b1) begin
            q = 8'b00000000;
        end else begin
            if(ld == 1'b1) begin
                q = d;
            end
        end
    end

endmodule