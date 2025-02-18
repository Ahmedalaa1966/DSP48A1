module project_tb();

  reg [17:0] A_tb, B_tb, C_tb, D_tb, BCIN_tb;
  reg [47:0] PCIN_tb;
  reg [7:0] OPMODE_tb;
  reg CARRYIN_tb;
  reg RSTA_tb, RSTB_tb, RSTC_tb, RSTCARRYIN_tb, RSTD_tb, RSTM_tb;
  reg RSTP_tb, RSTOPMODE_tb;
  reg CEA_tb, CEB_tb, CEC_tb, CED_tb, CEM_tb, CEOPMODE_tb, CEP_tb;

  wire [47:0] P_tb;
  wire [17:0] CARRYOUT_tb;

  project dut (
    .A(A_tb), .B(B_tb), .C(C_tb), .D(D_tb), .BCIN(BCIN_tb), .P(P_tb), 
    .CARRYOUT(CARRYOUT_tb), .CLK(CLK), .OPMODE(OPMODE_tb),
    .CEA(CEA_tb), .CEB(CEB_tb), .CEC(CEC_tb), .CED(CED_tb), 
    .CEM(CEM_tb), .CEOPMODE(CEOPMODE_tb), .CEP(CEP_tb),
    .RSTA(RSTA_tb), .RSTB(RSTB_tb), .RSTC(RSTC_tb), .RSTD(RSTD_tb),
    .RSTM(RSTM_tb), .RSTP(RSTP_tb), .RSTOPMODE(RSTOPMODE_tb),
    .CARRYIN(CARRYIN_tb), .RSTCARRYIN(RSTCARRYIN_tb)
  );

  reg CLK;

  initial begin
    CLK = 0;
    forever #10 CLK = ~CLK;
  end

  initial begin
    // Test Case 1
    RSTA_tb = 1; RSTB_tb = 1; RSTC_tb = 1; RSTCARRYIN_tb = 1; 
    RSTD_tb = 1; RSTM_tb = 1; RSTOPMODE_tb = 1; RSTP_tb = 1;
    CARRYIN_tb = 0;
    CEA_tb = 1; CEB_tb = 1; CEC_tb = 1; CED_tb = 1;
    CEM_tb = 1; CEOPMODE_tb = 1; CEP_tb = 1;
    A_tb = 5; B_tb = 10; C_tb = 1; D_tb = 7; 
    BCIN_tb = 0; PCIN_tb = 0; 
    OPMODE_tb = 8'b00011110;
    repeat (10) @(negedge CLK);

    // Test Case 2
    RSTA_tb = 0; RSTB_tb = 0; RSTC_tb = 0; 
    RSTD_tb = 0; RSTM_tb = 0; RSTOPMODE_tb = 0; RSTP_tb = 0;
    CARRYIN_tb = 0; 
    CEA_tb = 1; CEB_tb = 1; CEC_tb = 1; CED_tb = 1;
    CEM_tb = 1; CEOPMODE_tb = 1; CEP_tb = 1;
    A_tb = 5; B_tb = 10; C_tb = 1; D_tb = 7;
    BCIN_tb = 0; PCIN_tb = 0;
    OPMODE_tb = 8'b00011101;
    repeat (10) @(negedge CLK);

    // Test Case 3
    RSTA_tb = 0; RSTB_tb = 0; RSTC_tb = 0;
    RSTD_tb = 0; RSTM_tb = 0; RSTOPMODE_tb = 0; RSTP_tb = 0;
    CARRYIN_tb = 1;
    CEA_tb = 1; CEB_tb = 1; CEC_tb = 1; CED_tb = 1;
    CEM_tb = 1; CEOPMODE_tb = 1; CEP_tb = 1;
    A_tb = 11; B_tb = 30; C_tb = 87; D_tb = 9;
    BCIN_tb = 5; PCIN_tb = 6;
    OPMODE_tb = 8'b00011101;
    repeat (10) @(negedge CLK);

    // Final Test State
    RSTA_tb = 0; RSTB_tb = 0;
    $finish;
  end

endmodule
