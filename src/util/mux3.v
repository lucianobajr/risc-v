module mux3 (
    data0,data1,data2,select,out
);
    input wire [31:0] data0, data1,data2; 
    input wire select; 
    output reg [31:0] out;
    always @(data0, data1, data2,select) begin
        case (select) 
            0: out <= data0;
            1: out <= data1;
            2: out <= data2;
        endcase
    end
endmodule