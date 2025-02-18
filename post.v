module post (in1,in2,cin,opcode,out,cout);
input [47:0] in1,in2 ;
input cin,opcode ;
output reg [47:0] out ;
output reg cout ;
always @(*) begin
    if (opcode) begin
        out = in1 -(in2+cin) ;
    end
    else begin
        {cout,out} = in1 + in2 + cin ; 
    end
end
    
endmodule
