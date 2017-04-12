
_main:

;bluetooth.c,18 :: 		main(){
;bluetooth.c,20 :: 		trisb=0;
	CLRF        TRISB+0 
;bluetooth.c,21 :: 		portb=0;
	CLRF        PORTB+0 
;bluetooth.c,23 :: 		UART1_Init(9600); // Initialize UART module at 9600 bps
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;bluetooth.c,24 :: 		Delay_ms(100); // Wait for UART module to stabilize
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
;bluetooth.c,25 :: 		while (1) { // Endless loop
L_main1:
;bluetooth.c,26 :: 		if (UART1_Data_Ready())    // If data is received,
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main3
;bluetooth.c,28 :: 		for(i=0;i<100;i++)
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main4:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main7
	MOVLW       100
	SUBWF       main_i_L0+0, 0 
L__main7:
	BTFSC       STATUS+0, 0 
	GOTO        L_main5
;bluetooth.c,29 :: 		uart_rd[i]= UART1_Read();
	MOVLW       _uart_rd+0
	ADDWF       main_i_L0+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_uart_rd+0)
	ADDWFC      main_i_L0+1, 0 
	MOVWF       FLOC__main+1 
	CALL        _UART1_Read+0, 0
	MOVFF       FLOC__main+0, FSR1L
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;bluetooth.c,28 :: 		for(i=0;i<100;i++)
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;bluetooth.c,29 :: 		uart_rd[i]= UART1_Read();
	GOTO        L_main4
L_main5:
;bluetooth.c,30 :: 		UART1_Write(uart_rd);
	MOVLW       _uart_rd+0
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;bluetooth.c,31 :: 		}
L_main3:
;bluetooth.c,82 :: 		}
	GOTO        L_main1
;bluetooth.c,83 :: 		}
	GOTO        $+0
; end of _main
