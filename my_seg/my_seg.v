

module my_seg(

    clk        ,
    rst_n      ,
    seg_sel    ,
    seg_ment    

);

input       clk      ;
input       rst_n    ;
output      seg_sel  ;
output      seg_ment ;

reg [5:0]  seg_sel   ;
reg [7:0]  seg_ment  ;

wire [3:0]     data     ;
reg [25:0]     cnt0  ;
wire           add_cnt0 ;
wire           end_cnt0 ;

reg [2:0]      cnt1  ;
wire           add_cnt1 ;
wire           end_cnt1 ;




//1s计数器
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt0 <= 0;
    end
    else if(add_cnt0)begin
        if(end_cnt0)
            cnt0 <= 0;
        else
            cnt0 <= cnt0 + 1;
    end
end

assign add_cnt0 = 1;       
assign end_cnt0 = add_cnt0 && cnt0 == 50_000_000-1 ; 


//数6次的
always @(posedge clk or negedge rst_n)begin
    if(!rst_n)begin
        cnt1 <= 0;
    end
    else if(add_cnt1)begin
        if(end_cnt1)
            cnt1 <= 0;
        else
            cnt1 <= cnt1 + 1;
    end
end

assign add_cnt1 = end_cnt0 ;       
assign end_cnt1 = add_cnt1 && cnt1== 6-1 ;   

//数码管显示电路

always @(posedge clk or negedge rst_n)
begin
    if(rst_n ==1'b0) begin 
        seg_sel <= 8'hfe  ;
    end
    else if(cnt1==0)  begin 
         seg_sel <= 8'hfe ;
     end
     else if(cnt1==1)begin
         seg_sel <= 8'hfd ;
     end
     else if(cnt1==2)begin
         seg_sel <= 8'hfb ;
     end
     else if(cnt1==3)begin
         seg_sel <=8'hf7  ;
     end
     else if(cnt1==4)begin
         seg_sel <=8'hef  ;
     end
     else if(cnt1==5)begin
         seg_sel <=8'hdf  ;
     end
 end

 //优化代码
 /*
 always@(posedge clk or negedge rst_n)
 begin
     if(rst_n==1'b0)begin
         seg_sel <= 8'hfe ;
     end
     else begin
         seg_sel <= ~(8'b1<<cnt1);
     end
 end
 */



//数码管译码模块

always @(posedge clk or negedge rst_n)
begin
    if(rst_n==1'b0)begin
        seg_ment <= 8'hc0;
    end
    else if(data==0)begin
        seg_ment <= 8'hc0 ;
    end
    else if(data==1)begin
        seg_ment <= 8'hf9 ;
    end
    else if(data==2)begin
        seg_ment <= 8'ha4 ;
    end
    else if(data==3)begin
        seg_ment <= 8'hb0;
    end
    else if(data==4)begin
        seg_ment <= 8'h99;
    end
    else if(data==5)begin
        seg_ment <= 8'h92 ;
    end
    else if(data==6)begin
        seg_ment <= 8'h82 ;
    end
    else if(data==7)begin
        seg_ment <= 8'hf8  ;
    end
    else if(data==8)begin
        seg_ment <=8'h80 ;
    end
    else if(data==9)begin
        seg_ment <=8'h90 ;
    end
end

assign data = cnt1 ;

endmodule 













































