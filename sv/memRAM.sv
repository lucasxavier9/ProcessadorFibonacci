module memRAM (
    input logic clk, wr_en,
    input logic [7:0] addr,
    input logic [7:0] datain,
    output logic [7:0] dataout
);

    //Criando um ararnjo para implementar a memória

    logic [7:0] memoria [255:0];

    initial begin
        memoria = '{default:'0};
    end

    //Operação de Escrita
    always @(negedge clk) begin
        if(wr_en) memoria[addr] <= datain;
    end

    //Operação de Leitura

    assign dataout = memoria[addr];

endmodule