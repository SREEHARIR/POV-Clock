
_main:

;pov.c,17 :: 		void main(){
;pov.c,19 :: 		trisb=0;
	CLRF        TRISB+0 
;pov.c,20 :: 		portb=0;
	CLRF        PORTB+0 
;pov.c,21 :: 		TRISC.RC6 = 0x00; //TX pin set as output
	BCF         TRISC+0, 6 
;pov.c,22 :: 		TRISC.RC7 = 0xFF; //RX pin set as input
	BSF         TRISC+0, 7 
;pov.c,23 :: 		UART1_Init(9600); // Initialize UART module at 9600 bps
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       133
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;pov.c,24 :: 		Delay_ms(1000); // Wait for UART module to stabilize
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       140
	MOVWF       R12, 0
	MOVLW       9
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
;pov.c,26 :: 		while(1)
L_main1:
;pov.c,34 :: 		if (UART1_Data_Ready())    // If data is received,
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;pov.c,36 :: 		for(i=0;i<3;i++)
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main4:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main19
	MOVLW       3
	SUBWF       main_i_L0+0, 0 
L__main19:
	BTFSC       STATUS+0, 0 
	GOTO        L_main5
;pov.c,38 :: 		uart_rd[i]= UART1_Read();
	MOVLW       _uart_rd+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_uart_rd+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FLOC__main+1 
	CALL        _UART1_Read+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;pov.c,39 :: 		delay_ms(1000);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       140
	MOVWF       R12, 0
	MOVLW       9
	MOVWF       R13, 0
L_main7:
	DECFSZ      R13, 1, 1
	BRA         L_main7
	DECFSZ      R12, 1, 1
	BRA         L_main7
	DECFSZ      R11, 1, 1
	BRA         L_main7
	NOP
	NOP
;pov.c,36 :: 		for(i=0;i<3;i++)
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;pov.c,40 :: 		}
	GOTO        L_main4
L_main5:
;pov.c,42 :: 		UART1_Write(uart_rd);
	MOVLW       _uart_rd+0
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;pov.c,43 :: 		}
L_main3:
;pov.c,44 :: 		for(i=0;i<=3;i++)
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main8:
	MOVLW       128
	MOVWF       R0 
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main20
	MOVF        main_i_L0+0, 0 
	SUBLW       3
L__main20:
	BTFSS       STATUS+0, 0 
	GOTO        L_main9
;pov.c,46 :: 		switch(uart_rd[i])
	MOVLW       _uart_rd+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       R1 
	MOVLW       hi_addr(_uart_rd+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       R2 
	GOTO        L_main11
;pov.c,48 :: 		case('a'):PORTB.F0=1;
L_main13:
	BSF         PORTB+0, 0 
;pov.c,49 :: 		delay_ms(1000);
	MOVLW       7
	MOVWF       R11, 0
	MOVLW       140
	MOVWF       R12, 0
	MOVLW       9
	MOVWF       R13, 0
L_main14:
	DECFSZ      R13, 1, 1
	BRA         L_main14
	DECFSZ      R12, 1, 1
	BRA         L_main14
	DECFSZ      R11, 1, 1
	BRA         L_main14
	NOP
	NOP
;pov.c,50 :: 		break;
	GOTO        L_main12
;pov.c,51 :: 		case('b'):PORTB.F0=0;
L_main15:
	BCF         PORTB+0, 0 
;pov.c,53 :: 		break;
	GOTO        L_main12
;pov.c,54 :: 		case('c'):PORTB.F0=1;
L_main16:
	BSF         PORTB+0, 0 
;pov.c,56 :: 		break;
	GOTO        L_main12
;pov.c,57 :: 		default:break;
L_main17:
	GOTO        L_main12
;pov.c,58 :: 		}
L_main11:
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       97
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       98
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
	MOVFF       R1, FSR0
	MOVFF       R2, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       99
	BTFSC       STATUS+0, 2 
	GOTO        L_main16
	GOTO        L_main17
L_main12:
;pov.c,44 :: 		for(i=0;i<=3;i++)
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;pov.c,59 :: 		}
	GOTO        L_main8
L_main9:
;pov.c,63 :: 		}
	GOTO        L_main1
;pov.c,115 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
