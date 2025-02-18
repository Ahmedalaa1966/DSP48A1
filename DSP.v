module project (A,B,C,BCIN,D,CARRYIN,M,P,CARRYOUT,CARRYOUTF,CLK,OPMODE,CEA,CEB,CECARRYIN,CEC,CED,CEM,CEOPMODE,CEP,RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP,BCOUT,PCIN,PCOUT);
parameter A0REG = 0 ;
parameter A1REG = 1 ;
parameter B0REG = 0 ;
parameter B1REG = 1 ;
parameter CREG=0, DREG=0, MREG=0,PREG=0, CARRYINREG=0, CARRYOUTREG=0,OPMODEREG = 0 ;
parameter CARRYINSEL = "OPMODE5";
parameter B_INPUT = "DIRECT" ;
parameter RSTTYPE = "SYNC" ;
input [17:0] A,B,D,BCIN ;
input [47:0] C,PCIN;
input [7:0] OPMODE ;
input CARRYIN,CLK,CEA,CEB,CEC,CECARRYIN,CED,CEM,CEOPMODE,CEP ;
input RSTA,RSTB,RSTC,RSTCARRYIN,RSTD,RSTM,RSTOPMODE,RSTP ;
output [35:0] M ;
output [47:0] P ;
output CARRYOUTF,CARRYOUT ;
output [17:0] BCOUT ;
output [47:0] PCOUT ;
wire [17:0] W1,W22,W3,W4,W5,W6,W10,W2;
wire [47:0] W7,CON,MMUX,W15;
reg [47:0] W11,W14 ;
wire [35:0] W8,W9;
wire[1:0] OP,OP2 ;
wire W12,W13,W16,W17 ;
assign W17 = (RSTTYPE=="SYNC") ?  1 : 0 ; //we should sent W12 to any muxreg instantiation when we need to change from sync to asuncrous but know as all are asyncrous and default us asyn so i willnot send it 
muxreg m1(D,CLK,DREG,RSTD,CED,W1) ;
muxreg m2(B,CLK,B0REG,RSTB,CEB,W22) ;
assign W2 = (B_INPUT == "DIRECT") ? W22 : (B_INPUT == "CASCADE") ? BCIN : 0 ;
ADDER A1(W1,W2,OPMODE[6],W3) ;
assign W10 = (OPMODE[4]==1) ?   W3:W2 ;
muxreg m3(W10,CLK,B1REG,RSTB,CEB,W4) ;
assign BCOUT = W4 ;
muxreg m4(A,CLK,A0REG,RSTA,CEA,W5) ;
muxreg m5(W5,CLK,A1REG,RSTA,CEA,W6) ;
muxreg #(.size(48))m6(C,CLK,CREG,RSTC,CEC,W7) ;
assign W8 = W4*W6 ;
muxreg #(.size(36))m7(W8,CLK,MREG,RSTM,CEM,W9) ;
assign M = W9 ;
assign CON = {D[11:0], A[17:0], B[17:0]};
assign MMUX = {12'b000000000000,M} ;
assign OP = OPMODE[1:0] ;
always @(*) begin
    case (OP)
       2'b00 : W11 = 0 ;
       2'b01 : W11 = MMUX ;
       2'b10 : W11 = P ;
       2'b11 : W11 = CON ; 
        
    endcase
end
assign W12 = (CARRYINSEL=="OPMODE5") ? OPMODE[5] : (CARRYINSEL=="CARRYIN") ? CARRYIN : 0 ;
muxreg #(.size(1))m8(W12,CLK,CARRYINREG,RSTCARRYIN,CECARRYIN,W13) ;
assign OP2 = OPMODE[3:2] ;
always @(*) begin
    case (OP2) 
    2'b00 : W14 = 0 ;
    2'b01 : W14 = PCIN ;
    2'b10 : W14 = P ;
    2'b11 : W14 = W7 ;
    endcase 
end
post A2(W14,W11,W13,OPMODE[7],W15,W16) ;
muxreg #(.size(48))m9(W15,CLK,PREG,RSTP,CEP,P) ;
assign PCOUT = P ;
muxreg #(.size(1))m10(W16,CLK,CARRYOUTREG,RSTCARRYIN,CECARRYIN,CARRYOUT) ;
assign CARRYOUTF = CARRYOUT ;


endmodule
