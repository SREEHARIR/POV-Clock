
_main:

;rec.c,18 :: 		void main()
;rec.c,21 :: 		TRISA=0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;rec.c,22 :: 		TRISB=0x00;
	CLRF        TRISB+0 
;rec.c,23 :: 		PORTB=0x00;
	CLRF        PORTB+0 
;rec.c,24 :: 		Lcd_Init();
	CALL        _Lcd_Init+0, 0
;rec.c,25 :: 		TRISC.RC6 = 0x00; //TX pin set as output
	BCF         TRISC+0, 6 
;rec.c,26 :: 		TRISC.RC7 = 0xFF; //RX pin set as input
	BSF         TRISC+0, 7 
;rec.c,27 :: 		UART1_Init(9600);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;rec.c,28 :: 		delay_ms(100);             //Dealy for UART to become stable
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
;rec.c,31 :: 		UART1_Init(9600); // Initialize UART module at 9600 bps
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;rec.c,32 :: 		Delay_ms(10000); // Wait for UART module to stabilize
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_main1:
	DECFSZ      R13, 1, 1
	BRA         L_main1
	DECFSZ      R12, 1, 1
	BRA         L_main1
	DECFSZ      R11, 1, 1
	BRA         L_main1
	NOP
	NOP
;rec.c,33 :: 		while (1)       // Endless loop
L_main2:
;rec.c,35 :: 		if (UART1_Data_Ready())    // If data is received,
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main4
;rec.c,37 :: 		for(i=0;i<100;i++)
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main5:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main13
	MOVLW       100
	SUBWF       main_i_L0+0, 0 
L__main13:
	BTFSC       STATUS+0, 0 
	GOTO        L_main6
;rec.c,39 :: 		uart_rd[i]= UART1_Read();
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
;rec.c,40 :: 		UART1_Write(uart_rd);
	MOVLW       _uart_rd+0
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;rec.c,41 :: 		delay_ms(1000);
	MOVLW       6
	MOVWF       R11, 0
	MOVLW       19
	MOVWF       R12, 0
	MOVLW       173
	MOVWF       R13, 0
L_main8:
	DECFSZ      R13, 1, 1
	BRA         L_main8
	DECFSZ      R12, 1, 1
	BRA         L_main8
	DECFSZ      R11, 1, 1
	BRA         L_main8
	NOP
	NOP
;rec.c,37 :: 		for(i=0;i<100;i++)
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;rec.c,42 :: 		}
	GOTO        L_main5
L_main6:
;rec.c,43 :: 		for(i=0;i<100;i++)
	CLRF        main_i_L0+0 
	CLRF        main_i_L0+1 
L_main9:
	MOVLW       128
	XORWF       main_i_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main14
	MOVLW       100
	SUBWF       main_i_L0+0, 0 
L__main14:
	BTFSC       STATUS+0, 0 
	GOTO        L_main10
;rec.c,45 :: 		Lcd_Cmd(_LCD_CLEAR);               // Clear display
	MOVLW       1
	MOVWF       FARG_Lcd_Cmd_out_char+0 
	CALL        _Lcd_Cmd+0, 0
;rec.c,46 :: 		Lcd_Out(1,0,text);
	MOVLW       1
	MOVWF       FARG_Lcd_Out_row+0 
	CLRF        FARG_Lcd_Out_column+0 
	MOVLW       _text+0
	MOVWF       FARG_Lcd_Out_text+0 
	MOVLW       hi_addr(_text+0)
	MOVWF       FARG_Lcd_Out_text+1 
	CALL        _Lcd_Out+0, 0
;rec.c,47 :: 		delay_ms(10000);
	MOVLW       51
	MOVWF       R11, 0
	MOVLW       187
	MOVWF       R12, 0
	MOVLW       223
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	DECFSZ      R11, 1, 1
	BRA         L_main12
	NOP
	NOP
;rec.c,43 :: 		for(i=0;i<100;i++)
	INFSNZ      main_i_L0+0, 1 
	INCF        main_i_L0+1, 1 
;rec.c,48 :: 		}
	GOTO        L_main9
L_main10:
;rec.c,49 :: 		}
L_main4:
;rec.c,50 :: 		}
	GOTO        L_main2
;rec.c,51 :: 		}
	GOTO        $+0
; end of _main
