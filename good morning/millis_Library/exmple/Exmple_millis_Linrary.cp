#line 1 "D:/bibliothque_publie_dans_mikroc/Biblio_millis/Bibliotheque_libstock/exmple/Exmple_millis_Linrary.c"
#line 17 "D:/bibliothque_publie_dans_mikroc/Biblio_millis/Bibliotheque_libstock/exmple/Exmple_millis_Linrary.c"
void main() {
unsigned long time_RC0,time_RC1,time_RC2;
TRISC=0;
PORTC=0;
time_RC0=millis(0);
time_RC1=millis(0);
time_RC2=millis(0);
for(;;){
 if(millis(1) -time_RC0>1000){
 PORTC.RC0=~PORTC.RC0;
 time_RC0=millis(0);
 }

 if(millis(1)-time_RC1>1500) {
 PORTC.RC1=~PORTC.RC1;
 time_RC1=millis(0);
 }

 if(millis(1)-time_RC2>2000){
 PORTC.RC2=~PORTC.RC2;
 time_RC2=millis(0);
 }
 }

}
