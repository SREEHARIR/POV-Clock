#line 1 "M:/POV Display/OUR/PIC program/PROPELLER DISPLAY/PROPELLER DISPLAY.c"


int len=5;
int size=20;
char ch[20];
int size1=0;


int AA[] = {0b01111111, 0b10010000, 0b10010000, 0b10010000, 0b01111111};
int BB[] = {0b11111111, 0b10010001, 0b10010001, 0b10010001, 0b01101110};
int CC[] = {0b01111110, 0b10000001, 0b10000001, 0b10000001, 0b10000001};
int DD[] = {0b11111111, 0b10000001, 0b10000001, 0b10000001, 0b01111110};
int EE[] = {0b11111111, 0b10010001, 0b10010001, 0b10010001, 0b10010001};
int FF[] = {0b11111111, 0b10010000, 0b10010000, 0b10000000, 0b10000000};
int GG[] = {0b01111110, 0b10000001, 0b10010001, 0b10010001, 0b10001110};
int HH[] = {0b11111111, 0b00010000, 0b00010000, 0b00010000, 0b11111111};
int II[] = {0b10000001, 0b10000001, 0b11111111, 0b10000001, 0b10000001};
int JJ[] = {0b10000011, 0b10000001, 0b11111110, 0b10000000, 0b10000000};
int KK[] = {0b11111111, 0b00101000, 0b01000100, 0b10000010, 0b00000001};
int LL[] = {0b11111111, 0b00000001, 0b00000001, 0b00000001, 0b00000001};
int MM[] = {0b11111111, 0b01000000, 0b00100000, 0b01000000, 0b11111111};
int NN[] = {0b11111111, 0b00100000, 0b00001000, 0b00000010, 0b11111111};
int OO[] = {0b01111110, 0b10000001, 0b10000001, 0b10000001, 0b01111110};
int PP[] = {0b11111111, 0b10010000, 0b10010000, 0b10010000, 0b01100000};
int QQ[] = {0b01111100, 0b10000010, 0b10000110, 0b10000110, 0b01111111};
int RR[] = {0b11111111, 0b10011000, 0b10010100, 0b10010010, 0b01100001};
int SS[] = {0b01100001, 0b10010001, 0b10010001, 0b10010001, 0b10001110};
int TT[] = {0b10000000, 0b10000000, 0b11111111, 0b10000000, 0b10000000};
int UU[] = {0b11111110, 0b00000001, 0b00000001, 0b00000001, 0b11111110};
int VV[] = {0b10000000, 0b00010000, 0b00000010, 0b00010000, 0b10000000};
int WW[] = {0b11111111, 0b00000010, 0b00000100, 0b00000010, 0b11111111};
int XX[] = {0b10000001, 0b00100010, 0b00001000, 0b00100010, 0b10000001};
int YY[] = {0b10000000, 0b01000000, 0b00111111, 0b01000000, 0b10000000};
int ZZ[] = {0b10000001, 0b10000011, 0b10001001, 0b10100001, 0b10000001};
int Space[]={0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000};
int Zero[]= {0b11111111, 0b10000001, 0b10000001, 0b10000001, 0b11111111};
int One[] = {0b00000001, 0b01000001, 0b11111111, 0b00000001, 0b00000001};
int Two[] = {0b01000111, 0b10001001, 0b10001001, 0b10010001, 0b00100001};
int Three[]={0b10001010, 0b10010001, 0b10110001, 0b11010000, 0b10001110};
int Four[]= {0b00001000, 0b00101000, 0b11111111, 0b00001000, 0b00001000};
int Five[]= {0b11111010, 0b10010001, 0b10010001, 0b10010001, 0b10001110};
int Six[] = {0b00001110, 0b00101001, 0b10010001, 0b00010001, 0b00001110};
int Seven[]={0b10000000, 0b10000011, 0b10001100, 0b10110000, 0b11000000};
int Eight[]={0b01101110, 0b10010001, 0b10010001, 0b10010001, 0b01101110};
int Nine[]= {0b01100000, 0b10010000, 0b10010000, 0b10010000, 0b01111111};

void elay_ms(int n)
{
 while (n--)
 {
 delay_ms(1);
 }
}

int time()
{
 int t=0;
 if(PORTA.F0==0x00)
 {
 while(PORTA.F0==0x00);
 while(PORTA.F0==0xff)
 {
 t=t+1;
 delay_ms(1);
 }
 return t;
 }
}

void show(int image[],int t)
{
 int b1=0;
 for(b1=0;b1<len;b1++)
 {
 elay_ms(t);
 PORTB=image[b1];
 }
 PORTB=0b00000000;
}

void hello_world(int t)
{
 show(HH,t);
 elay_ms(t);
 show(EE,t);
 elay_ms(t);
 show(LL,t);
 elay_ms(t);
 show(LL,t);
 elay_ms(t);
 show(OO,t);
 elay_ms(t);
 show(space,t);
 elay_ms(t);
 show(WW,t);
 elay_ms(t);
 show(OO,t);
 elay_ms(t);
 show(RR,t);
 elay_ms(t);
 show(LL,t);
 elay_ms(t);
 show(DD,t);
 elay_ms(t);
}

void main()
{
 TRISA=0xFF;
 TRISB=0x00;
 PORTB=0x00;
 TRISC.RC6 = 0x00;
 TRISC.RC7 = 0xFF;
 UART1_Init(9600);
 delay_ms(100);
 while(1)
 {
 int ti,t,i,a;
 ti=time();

 if (UART1_Data_Ready())
 {
 size1=0;
 for(i=0;i<size;i++)
 {
 ch[i] = UART1_Read();
 UART1_Write(ch);
 }
 }

 while(ch[size1]!='\0')
 {
 size1++;
 }

 for(i=size1;i<=size;i++)
 {
 ch[i]=' ';
 }

 t=ti/size;

 if(size1==0)
 {
 hello_world(t);
 }

 else
 {
 for(i=0;i<size;i++)
 {
 switch(ch[i])
 {
 case ('a'||'A'):show(AA,t);
 elay_ms(t);
 break;
 case ('b'||'B'):show(BB,t);
 elay_ms(t);
 break;
 case ('c'||'C'):show(CC,t);
 elay_ms(t);
 break;
 case ('d'||'D'):show(DD,t);
 elay_ms(t);
 break;
 case ('e'||'E'):show(EE,t);
 elay_ms(t);
 break;
 case ('f'||'F'):show(FF,t);
 elay_ms(t);
 break;
 case ('g'||'G'):show(GG,t);
 elay_ms(t);
 break;
 case ('h'||'H'):show(HH,t);
 elay_ms(t);
 break;
 case ('i'||'I'):show(II,t);
 elay_ms(t);
 break;
 case ('j'||'J'):show(JJ,t);
 elay_ms(t);
 break;
 case ('k'||'K'):show(KK,t);
 elay_ms(t);
 break;
 case ('l'||'L'):show(LL,t);
 elay_ms(t);
 break;
 case ('m'||'M'):show(MM,t);
 elay_ms(t);
 break;
 case ('n'||'N'):show(NN,t);
 elay_ms(t);
 break;
 case ('o'||'O'):show(OO,t);
 elay_ms(t);
 break;
 case ('p'||'P'):show(PP,t);
 elay_ms(t);
 break;
 case ('q'||'Q'):show(QQ,t);
 elay_ms(t);
 break;
 case ('r'||'R'):show(RR,t);
 elay_ms(t);
 break;
 case ('s'||'S'):show(SS,t);
 elay_ms(t);
 break;
 case ('t'||'T'):show(TT,t);
 elay_ms(t);
 break;
 case ('u'||'U'):show(UU,t);
 elay_ms(t);
 break;
 case ('v'||'V'):show(VV,t);
 elay_ms(t);
 break;
 case ('w'||'W'):show(WW,t);
 elay_ms(t);
 break;
 case ('x'||'X'):show(XX,t);
 elay_ms(t);
 break;
 case ('y'||'Y'):show(YY,t);
 elay_ms(t);
 break;
 case ('z'||'Z'):show(ZZ,t);
 elay_ms(t);
 break;
 case (' '):show(Space,t);
 elay_ms(t);
 break;
 case ('0'):show(Zero,t);
 elay_ms(t);
 break;
 case ('1'):show(One,t);
 elay_ms(t);
 break;
 case ('2'):show(Two,t);
 elay_ms(t);
 break;
 case ('3'):show(Three,t);
 elay_ms(t);
 break;
 case ('4'):show(Four,t);
 elay_ms(t);
 break;
 case ('5'):show(Five,t);
 elay_ms(t);
 break;
 case ('6'):show(Six,t);
 elay_ms(t);
 break;
 case ('7'):show(Seven,t);
 elay_ms(t);
 break;
 case ('8'):show(Eight,t);
 elay_ms(t);
 break;
 case ('9'):show(Nine,t);
 elay_ms(t);
 break;
 default:break;
 }
 }
 }
 }
}
