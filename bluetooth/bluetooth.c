/*char uart_rd;
void main() {
ANSEL  = 0;                     // Configure AN pins as digital
ANSELH = 0;
UART1_Init(9600);               // Initialize UART module at 9600 bps
Delay_ms(100);                  // Wait for UART module to stabilize
while (1) {                     // Endless loop
UART1_Write_Text(“TEST”);
char ch=USARTReadData();   // reading data
Delay_ms(2000);                  // Wait
}
}*/




char uart_rd[100];
main(){
int i;
trisb=0;
portb=0;

UART1_Init(9600); // Initialize UART module at 9600 bps
Delay_ms(100); // Wait for UART module to stabilize
while (1) { // Endless loop
if (UART1_Data_Ready())    // If data is received,
{
 for(i=0;i<100;i++)
 uart_rd[i]= UART1_Read();
 UART1_Write(uart_rd);
}
/*if (uart_rd == ‘a’){
i=21;
PWM1_Set_Duty(i);
PWM1_Start();
}
if (uart_rd == ‘b’){
i=42;
PWM1_Set_Duty(i);
PWM1_Start();
}
if (uart_rd == ‘c’){
i=63;
PWM1_Set_Duty(i);
PWM1_Start();
}
if (uart_rd == ‘d’){
portb=0b00000010;
}if (uart_rd == ‘e’){
i=165;
PWM1_Set_Duty(i);
PWM1_Start();
}
if (uart_rd == ‘f’){
i=187;
PWM1_Set_Duty(i);
PWM1_Start();
}
if (uart_rd == ‘g’){
i=207;
PWM1_Set_Duty(i);
PWM1_Start();
}
if (uart_rd == ‘h’){
portb=0b00000000;}
if (uart_rd == ‘R’){
i=255;
PWM1_Set_Duty(i);
PWM1_Start();
}
if (uart_rd == ‘L’){
i=0;
PWM1_Set_Duty(i);
PWM1_Start();
}
if (uart_rd == ‘C’){
portb=0b00000001;
delay_ms(10);
portb=0b00000000;
PWM1_Start();
} */
}
}