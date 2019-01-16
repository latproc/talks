# this is how we can instantiate objects for the esp32 demo

esp32 ESP32; # CPU defined in the runtime support
lolibot LOLIBOT esp32;

controller MQTTBROKER "203.33.246.58", 1883;

S_Generic ANALOGINPUTSETTINGS;

IA_IR ANALOGINPUT esp32, esp32.ADC1_CHANNEL_6, S_Generic;

XA_WheelRight MQTTSUBSCRIBER controller, "right"; # +/- 100 is forward/reverse
XA_WheelLeft MQTTSUBSCRIBER controller, "left"; # +/- 100 is forward/reverse
XA_Servo MQTTSUBSCRIBER controller, "servo"; # 
XA_IR MQTTSUBSCRIBER controller, "IRLevel"; # 

O_LEDBus OUTPUT lolibot, lolibot.NeoPixel;

C_LEDS DIGITALLEDS(/*type: LED_WS2812B_V3,*/ max_output: 32, num_pixels: 3) O_LEDBus;

OA_WheelRightFwd ANALOGOUTPUT(channel:1) lolibot, lolibot.U3_PIN6_IA;
OA_WheelRightRev ANALOGOUTPUT(channel:2) lolibot, lolibot.U3_PIN7_IB;
OA_WheelLeftFwd ANALOGOUTPUT(channel:3) lolibot, lolibot.U4_PIN6_IA;
OA_WheelLeftRev ANALOGOUTPUT(channel:4) lolibot, lolibot.U4_PIN7_IB;
#OA_Servo ANALOGOUTPUT(channel:5) lolibot, lolibot.J3_PIN3;

O_Lolin32LED OUTPUT lolibot, lolibot.StatusLED;
C_Lolin32LED ALWAYSON O_Lolin32LED;

C_WheelRight WHEELDIRECTION OA_WheelRightFwd, OA_WheelRightRev;
C_WheelLeft WHEELDIRECTION OA_WheelLeftFwd, OA_WheelLeftRev;

M_WheelRight MQTT_FOLLER XA_WheelRight, C_WheelRight;
M_WheelLeft MQTT_FOLLER XA_WheelLeft, C_WheelLeft;
#M_Servo MQTT_FOLLER XA_Servo, OA_Servo;

M_IR ANALOG2MQTT IA_IR, XA_IR;
