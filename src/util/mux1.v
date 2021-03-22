module mux1 (data0,data1,select,out);
  input wire [4:0] data0, data1;
  input wire select; 
  output reg out;
  always @(data0, data1, select) begin
    case (select) 
      0: out <= data0;
      1: out <= data1;
    endcase
  end
endmodule

module AND (A, B, Exit);
  input wire A, B;
  output reg Exit;
  always @ (*) begin
    Exit <= A & B;
  end
endmodule