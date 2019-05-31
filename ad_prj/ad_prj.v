module ad_prj(
           clk       ,
           rst_n     ,
           key       ,
           dac_mode ,
           dac_clka  ,
           dac_da   ,
           dac_wra  ,
           dac_sleep,
           ad_clk    ,
           ad_in       
           );
input             clk        ;
input             rst_n      ;
input [ 3-1:0]     key        ;
output            dac_mode ;
output            dac_clka  ;
output [ 8-1:0]    dac_da    ;
output            dac_wra   ;
output            dac_sleep ;
output            ad_clk    ;
input  [8-1:0]      ad_in     ;

wire    [6:0]    addr    ;
reg   [7:0]      sin_data    ;
reg   [16:0]    addr_tmp    ;
reg   [7:0]      dac_da    ;
wire             dac_sleep  ;
wire             dac_wra   ;
wire             dac_clka   ;
wire             dac_mode ;
wire             ad_clk  ;


always  @(*)begin
    case(addr)
          0: sin_data = 8'h7F;
          1: sin_data = 8'h85;
          2: sin_data = 8'h8C;
          3: sin_data = 8'h92;
          4: sin_data = 8'h98;
          5: sin_data = 8'h9E;
          6: sin_data = 8'hA4;
          7: sin_data = 8'hAA;
          8: sin_data = 8'hB0;
          9: sin_data = 8'hB6;
         10: sin_data = 8'hBC;
         11: sin_data = 8'hC1;
         12: sin_data = 8'hC6;
         13: sin_data = 8'hCB;
         14: sin_data = 8'hD0;
         15: sin_data = 8'hD5;
         16: sin_data = 8'hDA;
         17: sin_data = 8'hDE;
         18: sin_data = 8'hE2;
         19: sin_data = 8'hE6;
         20: sin_data = 8'hEA;
         21: sin_data = 8'hED;
         22: sin_data = 8'hF0;
         23: sin_data = 8'hF3;
         24: sin_data = 8'hF5;
         25: sin_data = 8'hF7;
         26: sin_data = 8'hF9;
         27: sin_data = 8'hFB;
         28: sin_data = 8'hFC;
         29: sin_data = 8'hFD;
         30: sin_data = 8'hFE;
         31: sin_data = 8'hFE;
         32: sin_data = 8'hFE;
         33: sin_data = 8'hFE;
         34: sin_data = 8'hFE;
         35: sin_data = 8'hFD;
         36: sin_data = 8'hFC;
         37: sin_data = 8'hFA;
         38: sin_data = 8'hF8;
         39: sin_data = 8'hF6;
         40: sin_data = 8'hF4;
         41: sin_data = 8'hF1;
         42: sin_data = 8'hEF;
         43: sin_data = 8'hEB;
         44: sin_data = 8'hE8;
         45: sin_data = 8'hE4;
         46: sin_data = 8'hE0;
         47: sin_data = 8'hDC;
         48: sin_data = 8'hD8;
         49: sin_data = 8'hD3;
         50: sin_data = 8'hCE;
         51: sin_data = 8'hC9;
         52: sin_data = 8'hC4;
         53: sin_data = 8'hBE;
         54: sin_data = 8'hB9;
         55: sin_data = 8'hB3;
         56: sin_data = 8'hAD;
         57: sin_data = 8'hA7;
         58: sin_data = 8'hA1;
         59: sin_data = 8'h9B;
         60: sin_data = 8'h95;
         61: sin_data = 8'h8F;
         62: sin_data = 8'h89;
         63: sin_data = 8'h82;
         64: sin_data = 8'h7D;
         65: sin_data = 8'h77;
         66: sin_data = 8'h70;
         67: sin_data = 8'h6A;
         68: sin_data = 8'h64;
         69: sin_data = 8'h5E;
         70: sin_data = 8'h58;
         71: sin_data = 8'h52;
         72: sin_data = 8'h4C;
         73: sin_data = 8'h46;
         74: sin_data = 8'h41;
         75: sin_data = 8'h3C;
         76: sin_data = 8'h36;
         77: sin_data = 8'h31;
         78: sin_data = 8'h2C;
         79: sin_data = 8'h28;
         80: sin_data = 8'h23;
         81: sin_data = 8'h1F;
         82: sin_data = 8'h1B;
         83: sin_data = 8'h17;
         84: sin_data = 8'h14;
         85: sin_data = 8'h11;
         86: sin_data = 8'hE ;
         87: sin_data = 8'hB ;
         88: sin_data = 8'h9 ;
         89: sin_data = 8'h7 ;
         90: sin_data = 8'h5 ;
         91: sin_data = 8'h3 ;
         92: sin_data = 8'h2 ;
         93: sin_data = 8'h1 ;
         94: sin_data = 8'h1 ;
         95: sin_data = 8'h1 ;
         96: sin_data = 8'h1 ;
         97: sin_data = 8'h1 ;
         98: sin_data = 8'h2 ;
         99: sin_data = 8'h3 ;
        100: sin_data = 8'h4 ;
        101: sin_data = 8'h6 ;
        102: sin_data = 8'h7 ;
        103: sin_data = 8'hA ;
        104: sin_data = 8'hC ;
        105: sin_data = 8'hF ;
        106: sin_data = 8'h12;
        107: sin_data = 8'h15;
        108: sin_data = 8'h19;
        109: sin_data = 8'h1D;
        110: sin_data = 8'h21;
        111: sin_data = 8'h25;
        112: sin_data = 8'h2A;
        113: sin_data = 8'h2E;
        114: sin_data = 8'h33;
        115: sin_data = 8'h38;
        116: sin_data = 8'h3E;
        117: sin_data = 8'h43;
        118: sin_data = 8'h49;
        119: sin_data = 8'h4E;
        120: sin_data = 8'h54;
        121: sin_data = 8'h5A;
        122: sin_data = 8'h60;
        123: sin_data = 8'h67;
        124: sin_data = 8'h6D;
        125: sin_data = 8'h73;
        126: sin_data = 8'h79;
        127: sin_data = 8'h7F;
    endcase
end

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        addr_tmp <= 0;
    end
    else if(key==0) begin
        addr_tmp <= addr_tmp + 262;
    end
    else if(key==1) begin
        addr_tmp <= addr_tmp + 524;
    end
    else if(key==2) begin
        addr_tmp <= addr_tmp + 786;
    end
    else if(key==3) begin
        addr_tmp <= addr_tmp + 1029;
    end
    else if(key==4) begin
        addr_tmp <= addr_tmp + 1311;
    end
    else if(key==5) begin
        addr_tmp <= addr_tmp + 1573;
    end
    else if(key==6) begin
        addr_tmp <= addr_tmp + 1835;
    end
    else begin
        addr_tmp <= addr_tmp + 2097;
    end
end

assign addr = addr_tmp >>10 ;

always  @(posedge clk or negedge rst_n)begin
    if(rst_n==1'b0)begin
        dac_da <= 0;
    end
    else begin
        dac_da <= 255 - sin_data;
    end
end

assign dac_sleep = 0        ;
assign dac_wra   = dac_clka ;
assign dac_clka  = ~clk      ;



my_pll u_my_pll(
    .inclk0(clk   ) ,
	.c0    (ad_clk )
);



endmodule
