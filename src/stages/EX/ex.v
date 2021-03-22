`include "./util/imm_gen.v"
`include "./tools/forward.v"


module ex ( signaltoReg_in, writeReg_in, id_ex_rs1, id_ex_rd, ex_wb_rd, data1, data2, forward_data, unextended, signaltoReg_out, writeReg_out, rd_out, sum, extensor);
    input signaltoReg_in, writeReg_in;
    input [2:0] id_ex_rd, id_ex_rs1, ex_wb_rd, unextended;
    input [7:0] data1, data2, forward_data;
    
    output signaltoReg_out, writeReg_out;
    output [2:0] rd_out;
    output [7:0] sum, extensor;

    // Fios para o mux 2 por 1 #1
    wire mux2to1_1;
    wire [7:0] mux2to1_d0_1;
    wire [7:0] mux2to1_d1_1;
    wire [7:0] mux2to1_out_1;

    // Fios para o mux 2 por 1 #2
    wire mux2to1_2;
    wire [7:0] mux2to1_d0_2;
    wire [7:0] mux2to1_d1_2;
    wire [7:0] mux2to1_out_2;

    wire [7:0] add_operador1;
    wire [7:0] add_operador2;
    wire [7:0] adder_sum;

    wire [2:0] sign_unextend;
    wire [7:0] sign_extend;

    wire [2:0] forward_id_ex_rs1;
    wire [2:0] forward_id_ex_rd;
    wire [2:0] forward_ex_wb_rd;
    wire forwardA;
    wire forwardB;

    wire [4:0] aluControl;

    // Ligando fios a algumas entradas
    assign forward_id_ex_rs1 = id_ex_rs1;
    assign forward_id_ex_rd = id_ex_rd;
    assign forward_ex_wb_rd = ex_wb_rd;
    assign mux2to1_d0_1 = data1;
    assign mux2to1_d1_1 = forward_data;
    assign mux2to1_d0_2 = data2;
    assign mux2to1_d1_2 = forward_data;
    assign sign_unextend = unextended; 

    // Ligando fios a algumas saidas
    assign signaltoReg_out = signaltoReg_in;
    assign writeReg_out = writeReg_in;
    assign rd_out = id_ex_rd;
    assign sum = adder_sum;
    assign extensor = sign_extend;

    assign mux2to1_1 = forwardA;
    assign mux2to1_2 = forwardB;

    assign add_operador1 = mux2to1_out_1;
    assign add_operador2 = mux2to1_out_2;

    mux2 Mux2to1_1(.data0(mux2to1_d0_1), .data1(mux2to1_d1_1), .select(mux2to1_1), .out(mux2to1_out_1));

    mux2 Mux2to1_2(.data0(mux2to1_d0_2), .data1(mux2to1_d1_2), .select(mux2to1_2), .out(mux2to1_out_2));

    adder ADDER(.operand1(add_operador1), .operand2(add_operador2), .sum(adder_sum));

    sign_extender Extend(.unextended(sign_unextend), .extended(sign_extend));

    forward ForwardUnit(.idExRs1(forward_id_ex_rs1), .idExRd(forward_id_ex_rd), .exWbRd(forward_ex_wb_rd), .forwardA(forwardA), .forwardB(forwardB));
endmodule