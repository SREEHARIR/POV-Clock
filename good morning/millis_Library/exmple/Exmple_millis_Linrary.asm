
_main:

;Exmple_millis_Linrary.c,17 :: 		void main() {
;Exmple_millis_Linrary.c,19 :: 		TRISC=0;
	CLRF        TRISC+0 
;Exmple_millis_Linrary.c,20 :: 		PORTC=0;
	CLRF        PORTC+0 
;Exmple_millis_Linrary.c,21 :: 		time_RC0=millis(0); // save_time
	CLRF        FARG_millis_action+0 
	CALL        _millis+0, 0
	MOVF        R0, 0 
	MOVWF       main_time_RC0_L0+0 
	MOVF        R1, 0 
	MOVWF       main_time_RC0_L0+1 
	MOVLW       0
	MOVWF       main_time_RC0_L0+2 
	MOVWF       main_time_RC0_L0+3 
;Exmple_millis_Linrary.c,22 :: 		time_RC1=millis(0); // save_time
	CLRF        FARG_millis_action+0 
	CALL        _millis+0, 0
	MOVF        R0, 0 
	MOVWF       main_time_RC1_L0+0 
	MOVF        R1, 0 
	MOVWF       main_time_RC1_L0+1 
	MOVLW       0
	MOVWF       main_time_RC1_L0+2 
	MOVWF       main_time_RC1_L0+3 
;Exmple_millis_Linrary.c,23 :: 		time_RC2=millis(0); // save_time
	CLRF        FARG_millis_action+0 
	CALL        _millis+0, 0
	MOVF        R0, 0 
	MOVWF       main_time_RC2_L0+0 
	MOVF        R1, 0 
	MOVWF       main_time_RC2_L0+1 
	MOVLW       0
	MOVWF       main_time_RC2_L0+2 
	MOVWF       main_time_RC2_L0+3 
;Exmple_millis_Linrary.c,24 :: 		for(;;){
L_main0:
;Exmple_millis_Linrary.c,25 :: 		if(millis(1)/*read_time*/-time_RC0>1000){   // blink LED on RC0 evry 1000 ms
	MOVLW       1
	MOVWF       FARG_millis_action+0 
	CALL        _millis+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVWF       R5 
	MOVF        main_time_RC0_L0+0, 0 
	SUBWF       R2, 1 
	MOVF        main_time_RC0_L0+1, 0 
	SUBWFB      R3, 1 
	MOVF        main_time_RC0_L0+2, 0 
	SUBWFB      R4, 1 
	MOVF        main_time_RC0_L0+3, 0 
	SUBWFB      R5, 1 
	MOVF        R5, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main6
	MOVF        R4, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main6
	MOVF        R3, 0 
	SUBLW       3
	BTFSS       STATUS+0, 2 
	GOTO        L__main6
	MOVF        R2, 0 
	SUBLW       232
L__main6:
	BTFSC       STATUS+0, 0 
	GOTO        L_main3
;Exmple_millis_Linrary.c,26 :: 		PORTC.RC0=~PORTC.RC0;
	BTG         PORTC+0, 0 
;Exmple_millis_Linrary.c,27 :: 		time_RC0=millis(0);  // save_time
	CLRF        FARG_millis_action+0 
	CALL        _millis+0, 0
	MOVF        R0, 0 
	MOVWF       main_time_RC0_L0+0 
	MOVF        R1, 0 
	MOVWF       main_time_RC0_L0+1 
	MOVLW       0
	MOVWF       main_time_RC0_L0+2 
	MOVWF       main_time_RC0_L0+3 
;Exmple_millis_Linrary.c,28 :: 		}
L_main3:
;Exmple_millis_Linrary.c,30 :: 		if(millis(1)-time_RC1>1500) {    // blink LED on RC1 evry 1500 ms
	MOVLW       1
	MOVWF       FARG_millis_action+0 
	CALL        _millis+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVWF       R5 
	MOVF        main_time_RC1_L0+0, 0 
	SUBWF       R2, 1 
	MOVF        main_time_RC1_L0+1, 0 
	SUBWFB      R3, 1 
	MOVF        main_time_RC1_L0+2, 0 
	SUBWFB      R4, 1 
	MOVF        main_time_RC1_L0+3, 0 
	SUBWFB      R5, 1 
	MOVF        R5, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main7
	MOVF        R4, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main7
	MOVF        R3, 0 
	SUBLW       5
	BTFSS       STATUS+0, 2 
	GOTO        L__main7
	MOVF        R2, 0 
	SUBLW       220
L__main7:
	BTFSC       STATUS+0, 0 
	GOTO        L_main4
;Exmple_millis_Linrary.c,31 :: 		PORTC.RC1=~PORTC.RC1;
	BTG         PORTC+0, 1 
;Exmple_millis_Linrary.c,32 :: 		time_RC1=millis(0);  // save_time
	CLRF        FARG_millis_action+0 
	CALL        _millis+0, 0
	MOVF        R0, 0 
	MOVWF       main_time_RC1_L0+0 
	MOVF        R1, 0 
	MOVWF       main_time_RC1_L0+1 
	MOVLW       0
	MOVWF       main_time_RC1_L0+2 
	MOVWF       main_time_RC1_L0+3 
;Exmple_millis_Linrary.c,33 :: 		}
L_main4:
;Exmple_millis_Linrary.c,35 :: 		if(millis(1)-time_RC2>2000){  // blink LED on RC2 evry 2000 ms
	MOVLW       1
	MOVWF       FARG_millis_action+0 
	CALL        _millis+0, 0
	MOVF        R0, 0 
	MOVWF       R2 
	MOVF        R1, 0 
	MOVWF       R3 
	MOVLW       0
	MOVWF       R4 
	MOVWF       R5 
	MOVF        main_time_RC2_L0+0, 0 
	SUBWF       R2, 1 
	MOVF        main_time_RC2_L0+1, 0 
	SUBWFB      R3, 1 
	MOVF        main_time_RC2_L0+2, 0 
	SUBWFB      R4, 1 
	MOVF        main_time_RC2_L0+3, 0 
	SUBWFB      R5, 1 
	MOVF        R5, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main8
	MOVF        R4, 0 
	SUBLW       0
	BTFSS       STATUS+0, 2 
	GOTO        L__main8
	MOVF        R3, 0 
	SUBLW       7
	BTFSS       STATUS+0, 2 
	GOTO        L__main8
	MOVF        R2, 0 
	SUBLW       208
L__main8:
	BTFSC       STATUS+0, 0 
	GOTO        L_main5
;Exmple_millis_Linrary.c,36 :: 		PORTC.RC2=~PORTC.RC2;
	BTG         PORTC+0, 2 
;Exmple_millis_Linrary.c,37 :: 		time_RC2=millis(0);  // save_time
	CLRF        FARG_millis_action+0 
	CALL        _millis+0, 0
	MOVF        R0, 0 
	MOVWF       main_time_RC2_L0+0 
	MOVF        R1, 0 
	MOVWF       main_time_RC2_L0+1 
	MOVLW       0
	MOVWF       main_time_RC2_L0+2 
	MOVWF       main_time_RC2_L0+3 
;Exmple_millis_Linrary.c,38 :: 		}
L_main5:
;Exmple_millis_Linrary.c,39 :: 		}
	GOTO        L_main0
;Exmple_millis_Linrary.c,41 :: 		}
	GOTO        $+0
; end of _main
