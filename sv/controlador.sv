module controlador  (
    input logic clk, rst,
    input logic acc_eq_zero,
    input logic [3:0] opcode,
    output logic pc_scr, pc_ld, pc_clr, ir_clr, ir_ld, acc_ld, acc_clr, rout_ld, rout_clr, wr_en,
    output logic [1:0] acc_scr, alu_op,
    output logic [3:0] estadoAtual
);

    //Definir os estados do Controlador:

    typedef enum {inicio, busca, decodifica, add, sub, ande, xore, lda, ldi, ine, oute, sta, jmp, jz0, jz1, halt } state;

    state pre_state, next_state;
    //Procedimento 3 - Saidas:


initial begin
    pre_state <= inicio;
        pc_scr = 0;
        pc_ld = 0;
        pc_clr = 0;
        ir_ld = 0;
        ir_clr = 0;
        acc_scr = 2'b00;
        acc_ld = 0;
        acc_clr = 0;
        rout_ld = 0;
        rout_clr = 0;
        alu_op = 2'b00;
        wr_en = 0;
        estadoAtual = 4'b0000;
end

    //Procedimento 1 - Registrador de Estado:

    always @(posedge clk, negedge rst) begin
        if(rst == 1'b0) begin
            pre_state <= inicio;
        end else begin
            pre_state <= next_state;
        end
    end

    //Procedimento 2 - Estado Proximo:

    always @ (*) begin
        case(pre_state)
            inicio: next_state = busca;
            busca: next_state = decodifica;
       decodifica: begin
           case(opcode)
               4'b0000: next_state = add;
               4'b0001: next_state = sub;
               4'b0010: next_state = ande;
               4'b0011: next_state = xore;
               4'b0111: next_state = lda;
               4'b1000: next_state = ldi;
               4'b0110: next_state = sta;
               4'b0100: next_state = jmp;
               4'b0101: next_state = jz0;
               4'b1001: next_state = ine;
               4'b1010: next_state = oute;
               4'b1011: next_state = halt;
               default: next_state = halt;
           endcase
       end
            add: next_state = busca;
            sub: next_state = busca;
            ande: next_state = busca;
            xore: next_state = busca;
            lda: next_state = busca;
            ldi: next_state = busca;
            ine: next_state = busca;
            oute: next_state = busca;
            sta: next_state = busca;
            jmp: next_state = busca;
            jz0: begin
                if(acc_eq_zero == 1'b1) next_state = jz1;
                else next_state = busca;
            end
            jz1: next_state = busca;
            halt: next_state = halt;
            default: next_state = inicio;

        endcase

    end
    
    always @(pre_state) begin
        
        case(pre_state)

        inicio : begin  
            pc_scr = 0;
            pc_ld = 0;
            pc_clr = 1;
            ir_ld = 0;
            ir_clr = 1;
            acc_scr = 2'b00;
            acc_ld = 0;
            acc_clr = 1;
            rout_ld = 0;
            rout_clr = 1;
            alu_op = 2'b00;
            wr_en = 0;
            estadoAtual = 4'b0000;
         end
        busca : begin
            pc_scr = 0;
            pc_ld = 1;
            pc_clr = 0;
            ir_ld = 1;
            ir_clr = 0;
            acc_scr = 2'b00;
            acc_ld = 0;
            acc_clr = 0;
            rout_ld = 0;
            rout_clr = 0;
            alu_op = 2'b00;
            wr_en = 0;
            estadoAtual = 4'b0001; 
        end
        decodifica : begin
            pc_scr = 0;
            pc_ld = 0;
            pc_clr = 0;
            ir_ld = 0;
            ir_clr = 0;
            acc_scr = 2'b00;
            acc_ld = 0;
            acc_clr = 0;
            rout_ld = 0;
            rout_clr = 0;
            alu_op = 2'b00;
            wr_en = 0;
            estadoAtual = 4'b0010;
        end
        add : begin
            pc_scr = 0;
            pc_ld = 0;
            pc_clr = 0;
            ir_ld = 0;
            ir_clr = 0;
            acc_scr = 2'b00;
            acc_ld = 1;
            acc_clr = 0;
            rout_ld = 0;
            rout_clr = 0;
            alu_op = 2'b00;
            wr_en = 0;
            estadoAtual = 4'b0011;
        end
        sub : begin
            pc_scr = 0;
            pc_ld = 0;
            pc_clr = 0;
            ir_ld = 0;
            ir_clr = 0;
            acc_scr = 2'b00;
            acc_ld = 1;
            acc_clr = 0;
            rout_ld = 0;
            rout_clr = 0;
            alu_op = 2'b01;
            wr_en = 0;
            estadoAtual = 4'b0100;
        end
        ande : begin
            pc_scr = 0;
            pc_ld = 0;
            pc_clr = 0;
            ir_ld = 0;
            ir_clr = 0;
            acc_scr = 2'b00;
            acc_ld = 1;
            acc_clr = 0;
            rout_ld = 0;
            rout_clr = 0;
            alu_op = 2'b10;
            wr_en = 0;
            estadoAtual = 4'b0101;
        end
        xore : begin
            pc_scr = 0;
            pc_ld = 0;
            pc_clr = 0;
            ir_ld = 0;
            ir_clr = 0;
            acc_scr = 2'b00;
            acc_ld = 1;
            acc_clr = 0;
            rout_ld = 0;
            rout_clr = 0;
            alu_op = 2'b11;
            wr_en = 0;
            estadoAtual = 4'b0110;
        end
        lda : begin
            pc_scr = 0;
            pc_ld = 0;
            pc_clr = 0;
            ir_ld = 0;
            ir_clr = 0;
            acc_scr = 2'b01;
            acc_ld = 1;
            acc_clr = 0;
            rout_ld = 0;
            rout_clr = 0;
            alu_op = 2'b00;
            wr_en = 0;
            estadoAtual = 4'b0111;
        end
        ldi : begin
            pc_scr = 0;
            pc_ld = 0;
            pc_clr = 0;
            ir_ld = 0;
            ir_clr = 0;
            acc_scr = 2'b10;
            acc_ld = 1;
            acc_clr = 0;
            rout_ld = 0;
            rout_clr = 0;
            alu_op = 2'b00;
            wr_en = 0;
            estadoAtual = 4'b1000;
        end
        ine : begin
            pc_scr = 0;
            pc_ld = 0;
            pc_clr = 0;
            ir_ld = 0;
            ir_clr = 0;
            acc_scr = 2'b11;
            acc_ld = 1;
            acc_clr = 0;
            rout_ld = 0;
            rout_clr = 0;
            alu_op = 2'b00;
            wr_en = 0;
            estadoAtual = 4'b1001;
        end
        oute : begin 
            pc_scr = 0;
            pc_ld = 0;
            pc_clr = 0;
            ir_ld = 0;
            ir_clr = 0;
            acc_scr = 2'b00;
            acc_ld = 0;
            acc_clr = 0;
            rout_ld = 1;
            rout_clr = 0;
            alu_op = 2'b00;
            wr_en = 0;
            estadoAtual = 4'b1010;
        end
        sta : begin
            pc_scr = 0;
            pc_ld = 0;
            pc_clr = 0;
            ir_ld = 0;
            ir_clr = 0;
            acc_scr = 2'b00;
            acc_ld = 0;
            acc_clr = 0;
            rout_ld = 0;
            rout_clr = 0;
            alu_op = 2'b00;
            wr_en = 1;
            estadoAtual = 4'b1011;
        end
        jmp : begin
            pc_scr = 1;
            pc_ld = 1;
            pc_clr = 0;
            ir_ld = 0;
            ir_clr = 0;
            acc_scr = 2'b00;
            acc_ld = 0;
            acc_clr = 0;
            rout_ld = 0;
            rout_clr = 0;
            alu_op = 2'b00;
            wr_en = 0;
            estadoAtual = 4'b1100;
        end
        jz0 : begin
            pc_scr = 0;
            pc_ld = 0;
            pc_clr = 0;
            ir_ld = 0;
            ir_clr = 0;
            acc_scr = 2'b00;
            acc_ld = 0;
            acc_clr = 0;
            rout_ld = 0;
            rout_clr = 0;
            alu_op = 2'b00;
            wr_en = 0;
            estadoAtual = 4'b1101;
        end
        jz1 : begin
            pc_scr = 1;
            pc_ld = 1;
            pc_clr = 0;
            ir_ld = 0;
            ir_clr = 0;
            acc_scr = 2'b00;
            acc_ld = 0;
            acc_clr = 0;
            rout_ld = 0;
            rout_clr = 0;
            alu_op = 2'b00;
            wr_en = 0;
            estadoAtual = 4'b1110;
        end
        halt : begin
            pc_scr = 0;
            pc_ld = 0;
            pc_clr = 0;
            ir_ld = 0;
            ir_clr = 0;
            acc_scr = 2'b00;
            acc_ld = 0;
            acc_clr = 0;
            rout_ld = 0;
            rout_clr = 0;
            alu_op = 2'b00;
            wr_en = 0;
            estadoAtual = 4'b1111;
        end

        endcase
    end

endmodule