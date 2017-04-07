unsigned char output=0x66;
void main() 
{
  PORTB=0x00;
  TRISC.RC6 = 0x00; //TX pin set as output
  TRISC.RC7 = 0xFF; //RX pin set as input
  UART1_Init(4800);               // Initialize UART module at 9600 bps
  Delay_ms(1000);                  // Wait for UART module to stabilize


  while (1) {                     // Endless loop
    int i;
    // reads text until 'OK' is found
    UART1_Write(output);             // sends back text
      Delay_ms(1000);

   // read the received data,
      // and send data via UART

   /*if(uart_rd=='a')
    {
       PORTB=0b00000001;
       delay_ms(1000);
    }
    else if(uart_rd=='b')
    {
       PORTB=0b00000010;
       delay_ms(1000);
    }
    else if(uart_rd=='c')
    {
       PORTB=0b00000011;
       delay_ms(1000);
    }
    else
    {
       PORTB=0b11111111;
       delay_ms(1000);
    }*/
  }
}