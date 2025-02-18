module muxreg (in,clk,select,reset,clk_en,q);
    parameter size = 18 ;
    parameter RSTYPE = 1 ;
    input select,reset,clk_en ;
    input clk ;
    input [size-1:0] in ;
    output  [size-1:0] q ;
    reg [size-1:0] wire1 ;
   generate
  if(RSTYPE)begin
  
    always @(posedge clk) begin
       if (reset)
          wire1=0 ;
       
        else
         if(clk_en)
            wire1 = in ; 
        
    end
    assign q = (select==1) ? wire1: in ;
   end
   else begin
      always @(posedge clk or posedge reset) begin
       if (reset)
          wire1=0 ;
       
        else
         if(clk_en)
            wire1 = in ; 
        
    end
    assign q = (select==1) ? wire1: in ;
   end
  endgenerate
  


















    
endmodule
