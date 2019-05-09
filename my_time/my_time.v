module my_time(
     clk       ,
     rst_n     ,
     seg_sel   ,
     seg_ment    
);
input       clk       ;
input       rst_n     ;
output[5:0] seg_sel   ;
output[7:0] seg_ment  ;


reg [28:0]    cnt0     ;
wire          add_cnt0 ;
wire          end_cnt0 ;
reg [ 3:0]    cnt1     ;
wire          add_cnt1 ;
wire          end_cnt1 ;

wire [ 5:0]   seg_sel  ;
reg  [ 7:0]   seg_ment ;
reg  [28:0]   x        ;

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
assign end_cnt0 = add_cnt0 && cnt0==x-1 ;

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

assign add_cnt1 = end_cnt0;
assign end_cnt1 = add_cnt1 && cnt1==10-1 ;


assign seg_sel = 6'h3e;

always @(posedge clk or negedge rst_n)
begin
    if(rst_n==1'b0)begin
        seg_ment <= 8'hc0;
    end
    else if(cnt1==0)begin
        seg_ment <= 8'hc0 ;
    end
    else if(cnt1==1)begin
        seg_ment <= 8'hf9 ;
    end
    else if(cnt1==2)begin
        seg_ment <= 8'ha4 ;
    end
    else if(cnt1==3)begin
        seg_ment <= 8'hb0;
    end
    else if(cnt1==4)begin
        seg_ment <= 8'h99;
    end
    else if(cnt1==5)begin
        seg_ment <= 8'h92 ;
    end
    else if(cnt1==6)begin
        seg_ment <= 8'h82 ;
    end
    else if(cnt1==7)begin
        seg_ment <= 8'hf8  ;
    end
    else if(cnt1==8)begin
        seg_ment <=8'h80 ;
    end
    else if(cnt1==9)begin
        seg_ment <=8'h90 ;
    end
end

always  @(*)begin
    if(cnt1==0)
        x = 50_000_000;
    else if(cnt1==1)
        x = 100_000_000;
    else if(cnt1==2)
        x = 150_000_000;
    else if(cnt1==3)
        x = 200_000_000;
    else if(cnt1==4)
        x = 250_000_000;
    else if(cnt1==5)
        x = 300_000_000;
    else if(cnt1==6)
        x = 350_000_000;
    else if(cnt1==7)
        x = 400_000_000;
    else if(cnt1==8)
        x = 450_000_000;
    else  
        x = 500_000_000;
end


endmodule
