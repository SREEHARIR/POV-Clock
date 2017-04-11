char uart_rd[100];
sbit LCD_RS at RB4_bit;
sbit LCD_EN at RB5_bit;
sbit LCD_D4 at RB0_bit;
sbit LCD_D5 at RB1_bit;
sbit LCD_D6 at RB2_bit;
sbit LCD_D7 at RB3_bit;

sbit LCD_RS_Direction at TRISB4_bit;
sbit LCD_EN_Direction at TRISB5_bit;
sbit LCD_D4_Direction at TRISB0_bit;
sbit LCD_D5_Direction at TRISB1_bit;
sbit LCD_D6_Direction at TRISB2_bit;
sbit LCD_D7_Direction at TRISB3_bit;
// End LCD module connections

char text[]={"hello"};
void main()
{
int i;

    TRISB=0x00;
    PORTB=0x00;
    Lcd_Init();
    TRISC.RC6 = 0x00; //TX pin set as output
    TRISC.RC7 = 0xFF; //RX pin set as input
    UART1_Init(9600);
    delay_ms(100);             //Dealy for UART to become stable
                        // Initialize LCD

UART1_Init(9600); // Initialize UART module at 9600 bps
Delay_ms(10000); // Wait for UART module to stabilize
while (1)       // Endless loop
{
if (UART1_Data_Ready())    // If data is received,
{
 for(i=0;i<100;i++)
 {
 uart_rd[i]= UART1_Read();
 UART1_Write(uart_rd);
 delay_ms(1000);
}
for(i=0;i<100;i++)
{
  Lcd_Cmd(_LCD_CLEAR);               // Clear display
  Lcd_Out(1,0,text);
  delay_ms(10000);
}
}
}
}