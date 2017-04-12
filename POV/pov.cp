#line 1 "F:/NANDU/Projects/Github/Miscellaneous Projects/POV Monu/pov.c"
#line 16 "F:/NANDU/Projects/Github/Miscellaneous Projects/POV Monu/pov.c"
unsigned char uart_rd[3];
void main(){
int i;
 trisb=0;
portb=0;
TRISC.RC6 = 0x00;
 TRISC.RC7 = 0xFF;
UART1_Init(9600);
Delay_ms(1000);

while(1)
{
#line 34 "F:/NANDU/Projects/Github/Miscellaneous Projects/POV Monu/pov.c"
if (UART1_Data_Ready())
{
 for(i=0;i<3;i++)
 {
 uart_rd[i]= UART1_Read();
 delay_ms(1000);
 }

 UART1_Write(uart_rd);
 }
 for(i=0;i<=3;i++)
 {
 switch(uart_rd[i])
 {
 case('a'):PORTB.F0=1;
 delay_ms(1000);
 break;
 case('b'):PORTB.F0=0;

 break;
 case('c'):PORTB.F0=1;

 break;
 default:break;
 }
 }
#line 63 "F:/NANDU/Projects/Github/Miscellaneous Projects/POV Monu/pov.c"
}
#line 115 "F:/NANDU/Projects/Github/Miscellaneous Projects/POV Monu/pov.c"
}
