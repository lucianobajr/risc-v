
module wb (
    signExtendReg,
    writeRegIn,
    rdIn,
    sum,
    extended,
    writeRegOut,
    rdOut,
    result
);

    input wire signExtendReg,writeRegIn;
    input wire [2:0] rdIn;
    input wire [7:0] sum,extended;
    output writeRegOut;
    output [2:0] rdOut;
    output [7:0] result; 

    wire muxSelect;
	wire [7:0] muxData0;
	wire [7:0] muxData1;
	wire [7:0] muxOut;

	assign muxSelect = signExtendReg;	
	assign muxData0 = sum;
	assign muxData1 = extended;
	
	assign writeRegOut = writeRegIn;
	assign rdOut = rdIn;
	assign result = muxOut;
	
    mux2 m2(.data0(muxData0),.data1(muxData1),.select(muxSelect),.out(muxOut));
endmodule