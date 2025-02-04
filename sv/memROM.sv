module memROM (
    input logic [7:0] addr,
    output logic [11:0] data
);
    
    always @* begin
        case(addr)
        8'h00 : data = 12'h800;
        8'h01 : data = 12'h600;
        8'h02 : data = 12'h801;
        8'h03 : data = 12'h601;
        8'h04 : data = 12'h700;
        8'h05 : data = 12'h001;
        8'h06 : data = 12'h602;
        8'h07 : data = 12'h701;
        8'h08 : data = 12'h600;
        8'h09 : data = 12'h702;
        8'h0A : data = 12'h601;
        8'h0B : data = 12'hA00;
        8'h0C : data = 12'h404; 
        default : data = 12'h000;
        endcase        
    end

endmodule