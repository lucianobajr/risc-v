module mux2 (data0,data1,select,out);
  input wire [31:0] data0, data1; 
  input wire select; 
  output reg [31:0] out;
  always @(data0, data1, select) begin
    case (select) 
      0: out <= data0;
      1: out <= data1;
    endcase
  end

endmodule