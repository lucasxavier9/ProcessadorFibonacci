module moduloprincipal1 (
    input logic clk,
    input logic rst,
    input logic [7:0] data_in,
    output logic [7:0] data_out,
    output logic [3:0] estadoAtual,
    output logic [3:0] opcode_out,
    output logic [6:0] displayA_dezenas, displayA_unidades, displayA_centenas,
    output logic clk_1Hz
);

    // Sinais de controle entre controlador e datapath
    logic pc_ld, pc_clr, pc_scr, ir_clr, ir_ld, ir_out, ir_down, acc_ld, acc_clr, rout_ld, rout_clr, wr_en, acc_eq_zero_signal;
    logic [3:0] opcode, centenaA, dezenaA, unidadeA; 
    logic [1:0] acc_scr, alu_op;

    assign opcode_out = opcode;

    clock1Hz u1 (
        .clk(clk),        // Ligando o clk de entrada do sistema
        .rst(rst),        // Ligando o reset
        .clk_out(clk_1Hz) // Ligando o clk_out à saída de clock de 1Hz
    );

    // Instancia o Controlador
    controlador ctrl_inst (
        .clk(clk_1Hz),
        .rst(rst),
        .acc_eq_zero(acc_eq_zero_signal),
        .opcode(opcode),
        .pc_scr(pc_scr),
        .pc_ld(pc_ld),
        .pc_clr(pc_clr),
        .ir_ld(ir_ld),
        .ir_clr(ir_clr),
        .acc_ld(acc_ld),
        .acc_clr(acc_clr),
        .rout_ld(rout_ld),
        .rout_clr(rout_clr),
        .wr_en(wr_en),
        .acc_scr(acc_scr),
        .alu_op(alu_op),
        .estadoAtual(estadoAtual)
    );

    // Instancia o Datapath
    datapach dp_inst (
        .clk(clk_1Hz),
        .pc_ld(pc_ld),
        .pc_clr(pc_clr),
        .pc_scr(pc_scr),
        .ir_ld(ir_ld),
        .ir_clr(ir_clr),
        .acc_ld(acc_ld),
        .acc_clr(acc_clr),
        .acc_scr(acc_scr),
        .rout_ld(rout_ld),
        .rout_clr(rout_clr),
        .alu_op(alu_op),
        .wr_en(wr_en),
        .data_in(data_in),
        .data_out(data_out),
        .soma_out(soma_out),
        .acc_eq_zero_signal(acc_eq_zero_signal),
        .opcode(opcode) 
    );

        //DISPLAY DE 7SEG:
    bin2BCD converterA (
        .bin(data_out),
        .dez(dezenaA),
        .und(unidadeA),
        .cen(centenaA)
    );

    // Conversão de BCD para display de sete segmentos
    always_comb begin
        displayA_dezenas = converte(dezenaA);
        displayA_unidades = converte(unidadeA);
        displayA_centenas = converte(centenaA);
    end

    // Função para conversão de números para display de sete segmentos
    function logic [6:0] converte(input logic [3:0] num);
        case (num)
            4'b0000: converte = 7'b1000000;
            4'b0001: converte = 7'b1111001;
            4'b0010: converte = 7'b0100100;
            4'b0011: converte = 7'b0110000;
            4'b0100: converte = 7'b0011001;
            4'b0101: converte = 7'b0010010;
            4'b0110: converte = 7'b0000010;
            4'b0111: converte = 7'b1111000;
            4'b1000: converte = 7'b0000000;
            4'b1001: converte = 7'b0010000;
            default: converte = 7'b1111111; // Display apagado para valores inválidos
        endcase
    endfunction

endmodule