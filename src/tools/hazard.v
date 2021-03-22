module hazard (
   idExMemRead,
   ifIdRs,
   ifIdRt,
   idExDest,
   hazardOut
);
    input wire idExMemRead;
    input wire  [4:0] ifIdRs,ifIdRt,idExDest;
    output hazardOut;

    assign hazardOut = idExMemRead & (idExDest!=0)&((idExDest == ifIdRs) | (idExDest == ifIdRt));
endmodule