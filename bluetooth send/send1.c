char ch[]={'a'+48,'b'+48,'c'+48,'d'+48,'e'+48,'f'+48,'g'+48,'h'+48,'i'+48,'j'+48,'k'+48,'l'+48,'m'+48,'n'+48,'o'+48,'p'+48,'q'+48,'r'+48,'s'+48,'t'+48,'u'+48,'v'+48,'w'+48,'x'+48,'y'+48,'z'+48};


void main()
{
  PORTB=0x00;
  TRISC.RC6 = 0x00; //TX pin set as output
  TRISC.RC7 = 0xFF; //RX pin set as input
  UART1_Init(9600);               // Initialize UART module at 9600 bps
  Delay_ms(100);                  // Wait for UART module to stabilize

  while (1)
  {    int i;
       for(i=0;i<=26;i++)
       {
           UART1_Write(ch[i]);
           delay_ms(100);
       }
   }
}