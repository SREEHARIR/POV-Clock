 //============================================================================
// Library: millis.
// Author : Arezki YOUYOU
// Date:21/07/2014
// Microcontrollers : PIC18F
/*********************millis*******************************/
//The millis Library calculate a time between tow instance in ms. It can be used like delay function,
//without blocking the CPU like the Delay_ms function.

//==============Importante========================//
//millis Library calculate a time between two instance in ms

//============================================================================
// Contact me:
// e-mail: arezkiyouyou@gmail.com
//============================================================================
void main() {
unsigned long time_RC0,time_RC1,time_RC2;
TRISC=0;
PORTC=0;
time_RC0=millis(0); // save_time
time_RC1=millis(0); // save_time
time_RC2=millis(0); // save_time
for(;;){
   if(millis(1)/*read_time*/-time_RC0>1000){   // blink LED on RC0 evry 1000 ms
       PORTC.RC0=~PORTC.RC0;
        time_RC0=millis(0);  // save_time
                             }
                             
   if(millis(1)-time_RC1>1500) {    // blink LED on RC1 evry 1500 ms
       PORTC.RC1=~PORTC.RC1;
        time_RC1=millis(0);  // save_time
                             }
                             
   if(millis(1)-time_RC2>2000){  // blink LED on RC2 evry 2000 ms
       PORTC.RC2=~PORTC.RC2;
        time_RC2=millis(0);  // save_time
                             }
       }

}