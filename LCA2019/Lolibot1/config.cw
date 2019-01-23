# this is how we can instantiate objects for the esp32 demo

esp32 ESP32; # CPU defined in the runtime support
lolibot LOLIBOT esp32;

controller MQTTBROKER "192.168.2.10", 1883;

WS2812B_V3 LEDCONFIGURATION (bytesPerPixel:3, T0H:350, T1H:700, T0L:800, T1L:600, TRS:50000);

XA_WheelRight MQTTSUBSCRIBER controller, "slider_y"; # +/- 100 is forward/reverse
XA_WheelLeft MQTTSUBSCRIBER controller, "slider_x"; # +/- 100 is forward/reverse
XA_Servo MQTTSUBSCRIBER controller, "servo"; # 

XA_Led0Red MQTTSUBSCRIBER controller, "light_0_r";
XA_Led0Green MQTTSUBSCRIBER controller, "light_0_g";
XA_Led0Blue MQTTSUBSCRIBER controller, "light_0_b";

XA_Led1Red MQTTSUBSCRIBER controller, "light_1_r";
XA_Led1Green MQTTSUBSCRIBER controller, "light_1_g";
XA_Led1Blue MQTTSUBSCRIBER controller, "light_1_b";

XA_Led2Red MQTTSUBSCRIBER controller, "light_2_r";
XA_Led2Green MQTTSUBSCRIBER controller, "light_2_g";
XA_Led2Blue MQTTSUBSCRIBER controller, "light_2_b";

O_LEDPin OUTPUT lolibot, lolibot.NeoPixel;
O_Lolin32LED OUTPUT lolibot, lolibot.StatusLED;

OA_WheelRightFwd ANALOGOUTPUT(channel:1) lolibot, lolibot.U3_PIN6_IA;
OA_WheelRightRev ANALOGOUTPUT(channel:2) lolibot, lolibot.U3_PIN7_IB;
OA_WheelLeftFwd ANALOGOUTPUT(channel:3) lolibot, lolibot.U4_PIN6_IA;
OA_WheelLeftRev ANALOGOUTPUT(channel:4) lolibot, lolibot.U4_PIN7_IB;
#OA_Servo ANALOGOUTPUT(channel:5) lolibot, lolibot.J3_PIN3;

C_Lolin32LED ALWAYSON O_Lolin32LED;

#C_LedBus LEDSTRIP(channel:1, pin: 2, max_output: 32, num_pixels: 3) O_LEDPin, WS2812B_V3;
C_LedBus LEDSTRIP (max_output: 32, num_pixels: 3) O_LEDPin, WS2812B_V3;
C_Pixel0 DIGITALLED C_LedBus, 0;
C_Pixel1 DIGITALLED C_LedBus, 1;
C_Pixel2 DIGITALLED C_LedBus, 2;

C_WheelRight WHEELDIRECTION OA_WheelRightFwd, OA_WheelRightRev;
C_WheelLeft WHEELDIRECTION OA_WheelLeftFwd, OA_WheelLeftRev;

M_Pixel0 MQTT_AIN_LINK XA_Led0Green, XA_Led0Red, XA_Led0Blue, C_Pixel0;
M_Pixel1 MQTT_AIN_LINK XA_Led1Green, XA_Led1Red, XA_Led1Blue, C_Pixel1;
M_Pixel2 MQTT_AIN_LINK XA_Led2Green, XA_Led2Red, XA_Led2Blue, C_Pixel2;

M_WheelRight MQTT_FOLLOWER XA_WheelRight, C_WheelRight;
M_WheelLeft MQTT_FOLLOWER XA_WheelLeft, C_WheelLeft;
#M_Servo MQTT_FOLLOWER XA_Servo, OA_Servo;
