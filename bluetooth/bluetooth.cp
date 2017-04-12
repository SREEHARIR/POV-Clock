#line 1 "E:/notes/Project/S6/Mini Project/OUR/PIC program/bluetooth/bluetooth.c"
#line 17 "E:/notes/Project/S6/Mini Project/OUR/PIC program/bluetooth/bluetooth.c"
char uart_rd[100];
main(){
int i;
trisb=0;
portb=0;

UART1_Init(9600);
Delay_ms(100);
while (1) {
if (UART1_Data_Ready())
{
 for(i=0;i<100;i++)
 uart_rd[i]= UART1_Read();
 UART1_Write(uart_rd);
}
#line 82 "E:/notes/Project/S6/Mini Project/OUR/PIC program/bluetooth/bluetooth.c"
}
}
