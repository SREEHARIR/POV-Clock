
_main:

;test.c,2 :: 		void main()
;test.c,4 :: 		PORTB=0x00;
	CLRF        PORTB+0 
;test.c,5 :: 		TRISC.RC6 = 0x00; //TX pin set as output
	BCF         TRISC+0, 6 
;test.c,6 :: 		TRISC.RC7 = 0xFF; //RX pin set as input
	BSF         TRISC+0, 7 
;test.c,7 :: 		UART1_Init(4800);               // Initialize UART module at 9600 bps
	MOVLW       51
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;test.c,8 :: 		Delay_ms(1000);                  // Wait for UART module to stabilize
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main0:
	DECFSZ      R13, 1, 1
	BRA         L_main0
	DECFSZ      R12, 1, 1
	BRA         L_main0
	DECFSZ      R11, 1, 1
	BRA         L_main0
	NOP
	NOP
;test.c,11 :: 		while (1) {                     // Endless loop
L_main1:
;test.c,14 :: 		UART1_Write(output);             // sends back text
	MOVF        _output+0, 0 
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;test.c,15 :: 		Delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main3:
	DECFSZ      R13, 1, 1
	BRA         L_main3
	DECFSZ      R12, 1, 1
	BRA         L_main3
	DECFSZ      R11, 1, 1
	BRA         L_main3
	NOP
	NOP
;test.c,40 :: 		}
	GOTO        L_main1
;test.c,41 :: 		}
	GOTO        $+0
; end of _main
