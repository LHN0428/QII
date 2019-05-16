module color_execl(

   input  clk ,
   input  rst_n ,
	output lcd_hs ,
	output lcd_ys ,
	output[15:0] lcd_rgb

);


wire  clk_0;


//PLL模块例化

vga_pll		module_1(
     .inclk0 (clk ),
     .c0(clk_0) 

	);

//驱动化模块

color  module6(
	
		.rst(rst_n) ,
		.clk(clk_0) ,
		.hys(lcd_hs) ,
		.vys(lcd_ys) ,
		.lcd_rgb(lcd_rgb)
);



endmodule 






