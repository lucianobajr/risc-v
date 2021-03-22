module bottom_mux (a,b,sel,out);
	input wire [4:0] a,b;
	input wire sel;
    output wire	[4:0] out;

    assign	out = sel ? a : b;
endmodule