  * File Name: pwmled
  * Author: Vcatus
  * Version: V1.0
  * Date: 2019-5-7
  * Brief: 本文对项目进行详细说明
  * pwmled.v文件是pwm控制的呼吸灯
  
  ******************************************************************************************************
  * 本工程实现一个控制LED亮度的功能：
  * 具体要求：上电后，LED灯显示接近于灭，然后在10秒内，每隔2秒，亮度变化一次，逐渐变亮。
  * 在下一个10秒内，每隔2秒，亮度变化一次，逐渐变暗。
  * 就是20秒一次循环，每隔2秒变化一次，前10秒亮度增大，后10秒，亮度减小。
  * 
  ******************************************************************************************************
  * 端口定义：需要三个端口(clk, rst,led0)
  *
  ******************************************************************************************************
  * 信号分析：FPGA控制led信号，输出PWM波形，调整占空比。
  * 自行制定的占空比：第一个2s占空比95%：85% 70% 50% 20% 20% 50% 70% 85% 95% 
  * 周期是根据经验设置的10ms
  *
  * led信号变化情况为
  * 第1次持续时间2秒，每10毫秒输出一个PWM波（9.5毫秒时变低）；
  * 第2次持续时间2秒，每10毫秒输出一个PWM波（8.5毫秒时变低）；
  * 第3次持续时间2秒，每10毫秒输出一个PWM波（7.0毫秒时变低）；
  * 第4次持续时间2秒，每10毫秒输出一个PWM波（5.0毫秒时变低）；
  * 第5次持续时间2秒，每10毫秒输出一个PWM波（2.0毫秒时变低）；
  * 第6次持续时间2秒，每10毫秒输出一个PWM波（2.0毫秒时变低）； 
  * 第7次持续时间2秒，每10毫秒输出一个PWM波（5.0毫秒时变低）；
  * 第8次持续时间2秒，每10毫秒输出一个PWM波（7.0毫秒时变低）；
  * 第9次持续时间2秒，每10毫秒输出一个PWM波（8.5毫秒时变低）；
  * 第10次持续时间2秒，每10毫秒输出一个PWM波（9.5毫秒时变低）；
  *
  *
  * 有以下几个计数器：计数10毫秒时间的计数器；计数2秒时间的计数器以及计数第1~10次的计数器
  ******************************************************************************************************
  * 想法：其实就是两秒的时候进行10ms的PWM输出，一共输出十次，之后的就是循环
  * 具体解释见代码注释
  
  ******************************************************************************************************
  * 如有侵权行为请联系我：lhn0428@126.com
  *
  *
