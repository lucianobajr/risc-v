module program_counter(clock, reset, data_in, data_out);
    input clock;
    input reset;
    input [31:0] data_in;
    output reg [31:0] data_out;

    always @ (posedge clock) begin
        if (reset) begin
          data_out <= 32'd0;
        end
            
        else begin
          data_out <= data_in; 
        end
    end
endmodule

module pcplus4 (pcIn, pcOut,clock,reset);
  input clock;
  input reset;
  input wire [31:0] pcIn;
  output reg [31:0] pcOut;
  always @ (*) begin
    if(reset) begin
     pcOut <= 0;
    end
    else begin
      pcOut <= pcIn + 32'd4;
    end
  end
endmodule

module result_pc (A, B, Sum, ANDBranch, clock);
  input wire [31:0] A, B;
  input wire ANDBranch, clock;
  output reg [31:0] Sum;
  always @ (posedge clock) begin
    if(ANDBranch) begin
      Sum <= A + B;
    end
    else if(~ANDBranch) begin
      Sum <= A;
    end
  end
endmodule

module adder(
	input [7:0] operand1,
	input [7:0] operand2,
	output [7:0] sum
	);

	assign sum = operand1 + operand2;
endmodule

 module adder32(
    input [31:0] operand1,
    input [31:0] operand2,
    output [31:0] sum
	);

	assign sum = operand1 + operand2;
endmodule