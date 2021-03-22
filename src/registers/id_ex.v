module id_ex (
    clk,
    reset,
    signExtendRegIn,
    writeRegIn,
    rs1In,
    rdIn,
    data1In,
    data2In,
    unextendedIn,
    signExtendRegOut,
    writeRegOut,
    rs1Out,
    rdOut,
    data1Out,
    data2Out,
    unextendedOut
);

    input clk,reset,signExtendRegIn,writeRegIn;
    input [2:0] rs1In,rdIn,unextendedIn;
    input [7:0]data1In,data2In;

    output reg signExtendRegOut,writeRegOut;
    output reg [2:0] rs1Out,rdOut,unextendedOut;
    output reg [7:0] data1Out,data2Out;

    always @(posedge reset) begin
        signExtendRegOut = 0;
		writeRegOut = 0;
		rs1Out = 0;
		rdOut = 0;
		data1Out = 0;
		data2Out = 0;
		unextendedOut = 0;
    end
    always @(posedge clk ) begin
        signExtendRegOut = signExtendRegIn;
		writeRegOut = writeRegIn;
		rs1Out = rs1In;
		rdOut = rdIn;
		data1Out = data1In;
		data2Out = data2In;
		unextendedOut = unextendedIn;
    end
    
endmodule