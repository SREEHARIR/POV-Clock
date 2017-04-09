
_main:

;send1.c,4 :: 		void main()
;send1.c,6 :: 		PORTB=0x00;
	CLRF        PORTB+0 
;send1.c,7 :: 		TRISC.RC6 = 0x00; //TX pin set as output
	BCF         TRISC+0, 6 
;send1.c,8 :: 		TRISC.RC7 = 0xFF; //RX pin set as input
	BSF         TRISC+0, 7 
;send1.c,9 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;send1.c,10 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	NOP
	NOP
;send1.c,12 :: 		while (1)
L_main1:
;send1.c,14 :: 		for(i=0;i<=26;i++)
	CLRF        main_i_L1+0 
	CLRF        main_i_L1+1 
L_main3:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_i_L1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main7
	MOVF        main_i_L1+0, 0 
	SUBLW       26
L__main7:
	BTFSS       STATUS+0, 0 
	GOTO        L_main4
;send1.c,16 :: 		UART1_Write(ch[i]);
	MOVLW       _ch+0
	ADDWF       main_i_L1+0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_ch+0)
	ADDWFC      main_i_L1+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;send1.c,17 :: 		delay_ms(100);
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main6:
	DECFSZ      R13, 1, 1
	BRA         L_main6
	DECFSZ      R12, 1, 1
	BRA         L_main6
	NOP
	NOP
;send1.c,14 :: 		for(i=0;i<=26;i++)
	INFSNZ      main_i_L1+0, 1 
	INCF        main_i_L1+1, 1 
;send1.c,18 :: 		}
	GOTO        L_main3
L_main4:
;send1.c,19 :: 		}
	GOTO        L_main1
;send1.c,20 :: 		}
	GOTO        $+0
; end of _main
