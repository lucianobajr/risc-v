module signal_extend(
   in,
   extensor
);
    input [31:0] in;
    output[31:0] extensor;
    reg[31:0] IMM_OUT;
    wire[6:0] opcode;
    wire[2:0] funct3;

    assign extensor = IMM_OUT;
    assign opcode = in[6:0];
    assign funct3 = in[14:12];
    always @(in) 
    case(opcode)
        7'b0100011: IMM_OUT <= { {21{in[31]}}, in[30:25], in[11:8], in[7]};     // SD       -> S-Type
        7'b0000011: IMM_OUT <= { {21{in[31]}}, in[30:25], in[24:21], in[20]};   // LD       -> I-Type
        7'b1100011: IMM_OUT <= { {20{in[31]}}, in[7], in[30:25], in[11:8], {1{1'b0}}};  // BRANCH -> B-Type
        default: IMM_OUT <= 32'bx;
    endcase
endmodule


module sign_extender(
		input [2:0] unextended,
		output [7:0] extended
		);

	assign extended = { {5{unextended[2]}} , unextended};
endmodule
