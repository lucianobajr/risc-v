module forward (
   idExRs1,
   idExRd,
   exWbRd,
   forwardA,
   forwardB
);
    input wire [2:0] idExRs1,idExRd,exWbRd;
    output forwardA,forwardB;

    assign forwardA = (idExRs1 == exWbRd) ? 1'b1 : 1'b0;
    assign forwardB = (idExRd == exWbRd) ? 1'b1 : 1'b0;
endmodule