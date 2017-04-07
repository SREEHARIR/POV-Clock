#line 1 "E:/notes/Project/S6/Mini Project/OUR/PIC program/bluetoothtest/test.c"
unsigned char output=0x66;
void main()
{
 PORTB=0x00;
 TRISC.RC6 = 0x00;
 TRISC.RC7 = 0xFF;
 UART1_Init(4800);
 Delay_ms(1000);


 while (1) {
 int i;

 UART1_Write(output);
 Delay_ms(1000);
#line 40 "E:/notes/Project/S6/Mini Project/OUR/PIC program/bluetoothtest/test.c"
 }
}
