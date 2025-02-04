module clock1Hz (
    input logic clk,  
    input logic rst,     
    output logic clk_out 
);


    parameter DIVISOR = 900000;  

    logic [25:0] counter;  

    always_ff @(posedge clk or negedge rst) begin
        if (rst == 1'b0) begin
            counter <= 0;
            clk_out <= 0;
        end else if (counter == (DIVISOR - 1)) begin
            counter <= 0;
            clk_out <= ~clk_out;  
        end else begin
            counter <= counter + 1;
        end
    end

endmodule
