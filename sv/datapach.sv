module datapach (
    input logic clk,
    input logic pc_ld, pc_clr, pc_scr, ir_clr, ir_ld,
    input logic acc_ld, acc_clr, rout_ld, rout_clr,
    input logic [1:0] alu_op, acc_scr,
    input logic wr_en,
    input logic [7:0] data_in,
    output logic [7:0] data_out, soma_out,
    output logic [3:0] opcode,
    output logic acc_eq_zero_signal
);

    // Sinais internos
    logic [7:0] pc_out, addr_out, data_mem_out, acc_out, alu_out, ir_down, mux4_out, mux2_out ;
    logic [11:0] ir_out, memROM_out;

    assign ir_down = ir_out[7:0];
    assign opcode = ir_out [11:8];
  
    // Program Counter (PC)
    reg8b PC_reg (
        .d(mux2_out),
        .ld(pc_ld),
        .clr(pc_clr),
        .clk(clk),
        .q(pc_out)
    );

    // Memória de Instruções
    memROM inst_memory (
        .addr(pc_out),
        .data(memROM_out)
    );

    //Registrador IR
    reg12b reg12b_inst(
        .d(memROM_out),
        .clk(clk),
        .ld(ir_ld),
        .clr(ir_clr),
        .q(ir_out)
    );

    // Registrador do ACC
    reg8b ACC_reg (
        .d(mux4_out),
        .ld(acc_ld),
        .clr(acc_clr),
        .clk(clk),
        .q(acc_out)
    );

    //Registrador ROUT

    reg8b rOUT_inst(
        .d(acc_out),
        .ld(rout_ld),
        .clr(rout_clr),
        .clk(clk),
        .q(data_out)
    );

    // Unidade Lógica e Aritmética ALU
    alu ALU_inst (
        .a(acc_out),
        .b(data_mem_out),
        .sel(alu_op),
        .x(alu_out)
    );

    // Memória de Dados (RAM)
    memRAM data_memory (
        .clk(clk),
        .wr_en(wr_en),
        .addr(ir_down),
        .datain(acc_out), 
        .dataout(data_mem_out)
    );

    // Comparador de Zero para ACC
    eqzero acc_zero_cmp (
        .a(acc_out),
        .acc_eq_zero(acc_eq_zero_signal)
    );

    //somador
    adder adder_inst(
        .a(8'd1),
        .b(pc_out),
        .s(soma_out)
    );

    // Multiplexador para selecionar dados de saída
    mux2x1 mux_inst (
        .a(soma_out),
        .b(ir_down),
        .sel(pc_scr),
        .x(mux2_out)
    );

        // Multiplexador para selecionar dados de saída
    mux4x1 mux4_inst (
        .a(alu_out),
        .b(data_mem_out),
        .c(ir_down),
        .d(data_in),
        .sel(acc_scr),
        .x(mux4_out)
    );

endmodule
