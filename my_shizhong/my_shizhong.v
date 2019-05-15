module my_shizhong(
		
		clk      ,
		rst_n 	 ,
		seg_sel  ,
		seg_ment 
);

input 			clk      ;
input 			rst_n    ;

output 	[5:0]		seg_sel  ;
output   [7:0]    seg_ment ;
reg      [5:0]    seg_sel  ;
reg      [7:0]    seg_ment ;

reg [16:0]    cnt0 ;
wire         add_cnt0 ;
wire 			 end_cnt0 ;

reg  [2:0]   cnt1 ;
wire         add_cnt1 ;
wire 			 end_cnt1 ;



reg [3:0]    sel_data ;

reg [24:0]    cnt2 ;
wire        add_cnt2 ;
wire 			end_cnt2 ;

reg [3:0]    m_g ;
wire 			add_m_g ;
wire 			end_m_g  ;

reg [2:0]     m_s ;
wire 			add_m_s ;
wire        end_m_s ;

reg [3:0]     f_g ;
wire 			add_f_g ;
wire 			end_f_g ;

reg [2:0]     f_s ;
wire 			add_f_s ;
wire 			end_f_s  ;

reg [3:0]     s_g ;
wire 			add_s_g ;
wire 			end_s_g ;
  
reg [1:0]      s_s ;
wire 			add_s_s ;
wire 			end_s_s ;

reg [3:0]     x ;

//因为是片选端为了让时间同时显示出来
//经过2ms的计数器 进行轮训，给人的感觉是六个数码管都在亮


always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		 cnt0  <= 0 ;		
	end
	else if (add_cnt0) begin
	     if(end_cnt0)
		  cnt0 <= 0 ;
    else  cnt0 <= cnt0 + 1 ;
    end
end

assign  add_cnt0 = 1 ;
assign  edd_cnt0 = add_cnt0 &&  cnt0 ==100_000 - 1  ;

//片选端，有六个
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		 cnt1  <= 0 ;		
	end
	else if (add_cnt1) begin
	     if(end_cnt1) 
		  cnt1 <= 0 ;
    else  cnt1 <= cnt1 + 1 ;
    end
end

assign  add_cnt1 = edd_cnt0;
assign  edd_cnt1 = add_cnt1 &&  cnt1 == 6- 1  ;



//片选端选择
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		seg_sel <= 6'h3e;
	end
	else begin
		seg_sel <= ~(6'b1 << cnt1) ;
	end
end


//数码管显示电路
always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		seg_ment <= 8'hc0 ;
	end
	else begin 
	    case(sel_data)
		0  : seg_ment <= 8'hc0 ;
		1  : seg_ment <= 8'hf9 ;
		2  : seg_ment <= 8'ha4 ;
		3  : seg_ment <= 8'hb0 ;
		4  : seg_ment <= 8'h99 ;
		5  : seg_ment <= 8'h92 ;
		6  : seg_ment <= 8'h82 ;
		7  : seg_ment <= 8'hf8 ;
		8  : seg_ment <= 8'h80 ;
   default : seg_ment <= 8'h90 ;
		endcase
	end
end

//数码选择数据电路，当片选端选到谁时，进行数据选择进行显示
always @(*) begin
	if (cnt1==0) 
	    sel_data <= m_g ;
   else if (cnt1==1)
		sel_data <= m_s ;
   else if (cnt1==2)
   		sel_data <=f_g ;
   else if (cnt1 ==3)
   		sel_data <= f_s ;
   else if (cnt1 ==4)
   		sel_data <= s_g ;
   else 
   		sel_data <= s_s ;
end


//秒针各位上的数据

always @(posedge clk or negedge rst_n) begin
	if (!rst_n) begin
		cnt2 <= 0 ;
	end
	else if (add_cnt2) begin
        if(end_cnt2)
		  cnt2 <= 0 ;
	else 
		  cnt2 <= cnt2 + 1 ;
    end
end

assign   add_cnt2 = 1 ;
assign   end_cnt2 =add_cnt2 && cnt2 == 25_000_000 - 1 ;


//秒的个位
always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		m_g<= 0 ;
	end
	else if (add_m_g) begin
        if(end_m_g)
		  m_g <= 0 ;
	else 
		  m_g <= m_g + 1 ;
    end
end

assign   add_m_g =end_cnt2;
assign   end_m_g =add_m_g && m_g == 10 - 1 ;  

//秒的十位
always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		m_s<= 0 ;
	end
	else if (add_m_s) begin
        if(end_m_s)
		  m_s <= 0 ;
	else 
		  m_s <= m_s + 1 ;
    end
end

assign   add_m_s =end_m_g;
assign   end_m_s =add_m_s && m_s == 6 - 1 ;  


//分的个位
always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		f_g<= 0 ;
	end
	else if (add_f_g) begin
        if(end_f_g)
		  f_g <= 0 ;
	else 
		  f_g <= f_g + 1 ;
    end
end

assign   add_f_g =end_m_s;
assign   end_f_g =add_f_g && m_s == 10 - 1 ;  

//分的十位
always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		f_s<= 0 ;
	end
	else if (add_f_s) begin
        if(end_f_s)
		  f_s <= 0 ;
	else 
		  f_s <= f_s + 1 ;
    end
end

assign   add_f_s =end_f_g;
assign   end_f_s =add_f_s && f_s == 6 - 1 ;  

//时的个位是一个不确定的数字，当十位位2是则为0-4 ，当为其他时为0-9

always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		s_g<= 0 ;
	end
	else if (add_s_g) begin
        if(end_s_g)
		  s_g <= 0 ;
	else 
		  s_g <= s_g + 1 ;
    end
end

assign   add_s_g =end_f_s;
assign   end_s_g =add_s_g && s_g == x - 1 ;  


//时的十位
always @(posedge clk or negedge rst_n) begin
	if (rst_n==1'b0) begin
		s_s<= 0 ;
	end
	else if (add_s_s) begin
        if(end_s_s)
		  s_s <= 0 ;
	else 
		  s_s <= s_s + 1 ;
    end
end

assign   add_s_s =end_s_g;
assign   end_s_s =add_s_s && s_s == 3 - 1 ;  

always@(*)begin
   if (s_s == 2)
      x = 4 ;
   else 
      x = 10 ;
end 






endmodule  












