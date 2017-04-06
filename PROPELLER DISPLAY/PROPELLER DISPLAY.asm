
_elay_ms:

;PROPELLER DISPLAY.c,47 :: 		void elay_ms(int n)       //Delay function for variable time delay
;PROPELLER DISPLAY.c,49 :: 		while (n--)
L_elay_ms0:
	MOVF        FARG_elay_ms_n+0, 0 
	MOVWF       R0 
	MOVF        FARG_elay_ms_n+1, 0 
	MOVWF       R1 
	MOVLW       1
	SUBWF       FARG_elay_ms_n+0, 1 
	MOVLW       0
	SUBWFB      FARG_elay_ms_n+1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_elay_ms1
;PROPELLER DISPLAY.c,51 :: 		delay_ms(1);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       75
	MOVWF       R13, 0
L_elay_ms2:
	DECFSZ      R13, 1, 1
	BRA         L_elay_ms2
	DECFSZ      R12, 1, 1
	BRA         L_elay_ms2
;PROPELLER DISPLAY.c,52 :: 		}
	GOTO        L_elay_ms0
L_elay_ms1:
;PROPELLER DISPLAY.c,53 :: 		}
	RETURN      0
; end of _elay_ms

_time:

;PROPELLER DISPLAY.c,55 :: 		int time()            //Calculating time for each revolution
;PROPELLER DISPLAY.c,57 :: 		int t=0;
	CLRF        time_t_L0+0 
	CLRF        time_t_L0+1 
;PROPELLER DISPLAY.c,58 :: 		if(PORTA.F0==0x00)
	BTFSC       PORTA+0, 0 
	GOTO        L_time3
;PROPELLER DISPLAY.c,60 :: 		while(PORTA.F0==0x00);
L_time4:
	BTFSC       PORTA+0, 0 
	GOTO        L_time5
	GOTO        L_time4
L_time5:
;PROPELLER DISPLAY.c,61 :: 		while(PORTA.F0==0xff)
L_time6:
	BTFSS       PORTA+0, 0 
	GOTO        L_time7
;PROPELLER DISPLAY.c,63 :: 		t=t+1;
	INFSNZ      time_t_L0+0, 1 
	INCF        time_t_L0+1, 1 
;PROPELLER DISPLAY.c,64 :: 		delay_ms(1);
	MOVLW       2
	MOVWF       R12, 0
	MOVLW       75
	MOVWF       R13, 0
L_time8:
	DECFSZ      R13, 1, 1
	BRA         L_time8
	DECFSZ      R12, 1, 1
	BRA         L_time8
;PROPELLER DISPLAY.c,65 :: 		}
	GOTO        L_time6
L_time7:
;PROPELLER DISPLAY.c,66 :: 		return t;
	MOVF        time_t_L0+0, 0 
	MOVWF       R0 
	MOVF        time_t_L0+1, 0 
	MOVWF       R1 
	RETURN      0
;PROPELLER DISPLAY.c,67 :: 		}
L_time3:
;PROPELLER DISPLAY.c,68 :: 		}
	RETURN      0
; end of _time

_show:

;PROPELLER DISPLAY.c,70 :: 		void show(int image[],int t)      //Displaying the letter
;PROPELLER DISPLAY.c,72 :: 		int b1=0;
	CLRF        show_b1_L0+0 
	CLRF        show_b1_L0+1 
;PROPELLER DISPLAY.c,73 :: 		for(b1=0;b1<len;b1++)
	CLRF        show_b1_L0+0 
	CLRF        show_b1_L0+1 
L_show9:
	MOVLW       128
	XORWF       show_b1_L0+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _len+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__show69
	MOVF        _len+0, 0 
	SUBWF       show_b1_L0+0, 0 
L__show69:
	BTFSC       STATUS+0, 0 
	GOTO        L_show10
;PROPELLER DISPLAY.c,75 :: 		elay_ms(t);
	MOVF        FARG_show_t+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        FARG_show_t+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,76 :: 		PORTB=image[b1];
	MOVF        show_b1_L0+0, 0 
	MOVWF       R0 
	MOVF        show_b1_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_show_image+0, 0 
	MOVWF       FSR0L 
	MOVF        R1, 0 
	ADDWFC      FARG_show_image+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTB+0 
;PROPELLER DISPLAY.c,73 :: 		for(b1=0;b1<len;b1++)
	INFSNZ      show_b1_L0+0, 1 
	INCF        show_b1_L0+1, 1 
;PROPELLER DISPLAY.c,77 :: 		}
	GOTO        L_show9
L_show10:
;PROPELLER DISPLAY.c,78 :: 		PORTB=0b00000000;
	CLRF        PORTB+0 
;PROPELLER DISPLAY.c,79 :: 		}
	RETURN      0
; end of _show

_hello_world:

;PROPELLER DISPLAY.c,81 :: 		void hello_world(int t)
;PROPELLER DISPLAY.c,83 :: 		show(HH,t);
	MOVLW       _HH+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_HH+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,84 :: 		elay_ms(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,85 :: 		show(EE,t);
	MOVLW       _EE+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_EE+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,86 :: 		elay_ms(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,87 :: 		show(LL,t);
	MOVLW       _LL+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_LL+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,88 :: 		elay_ms(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,89 :: 		show(LL,t);
	MOVLW       _LL+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_LL+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,90 :: 		elay_ms(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,91 :: 		show(OO,t);
	MOVLW       _OO+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_OO+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,92 :: 		elay_ms(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,93 :: 		show(space,t);
	MOVLW       _Space+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Space+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,94 :: 		elay_ms(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,95 :: 		show(WW,t);
	MOVLW       _WW+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_WW+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,96 :: 		elay_ms(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,97 :: 		show(OO,t);
	MOVLW       _OO+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_OO+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,98 :: 		elay_ms(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,99 :: 		show(RR,t);
	MOVLW       _RR+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_RR+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,100 :: 		elay_ms(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,101 :: 		show(LL,t);
	MOVLW       _LL+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_LL+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,102 :: 		elay_ms(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,103 :: 		show(DD,t);
	MOVLW       _DD+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_DD+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,104 :: 		elay_ms(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,105 :: 		}
	RETURN      0
; end of _hello_world

_main:

;PROPELLER DISPLAY.c,107 :: 		void main()
;PROPELLER DISPLAY.c,109 :: 		TRISA=0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;PROPELLER DISPLAY.c,110 :: 		TRISB=0x00;
	CLRF        TRISB+0 
;PROPELLER DISPLAY.c,111 :: 		PORTB=0x00;
	CLRF        PORTB+0 
;PROPELLER DISPLAY.c,112 :: 		TRISC.RC6 = 0x00; //TX pin set as output
	BCF         TRISC+0, 6 
;PROPELLER DISPLAY.c,113 :: 		TRISC.RC7 = 0xFF; //RX pin set as input
	BSF         TRISC+0, 7 
;PROPELLER DISPLAY.c,114 :: 		UART1_Init(9600);
	MOVLW       25
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;PROPELLER DISPLAY.c,115 :: 		delay_ms(100);             //Dealy for UART to become stable
	MOVLW       130
	MOVWF       R12, 0
	MOVLW       221
	MOVWF       R13, 0
L_main12:
	DECFSZ      R13, 1, 1
	BRA         L_main12
	DECFSZ      R12, 1, 1
	BRA         L_main12
	NOP
	NOP
;PROPELLER DISPLAY.c,116 :: 		while(1)
L_main13:
;PROPELLER DISPLAY.c,119 :: 		ti=time();
	CALL        _time+0, 0
	MOVF        R0, 0 
	MOVWF       main_ti_L1+0 
	MOVF        R1, 0 
	MOVWF       main_ti_L1+1 
;PROPELLER DISPLAY.c,121 :: 		if (UART1_Data_Ready())    // Bluetooth data recieve
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main15
;PROPELLER DISPLAY.c,123 :: 		size1=0;
	CLRF        _size1+0 
	CLRF        _size1+1 
;PROPELLER DISPLAY.c,124 :: 		for(i=0;i<size;i++)
	CLRF        main_i_L1+0 
	CLRF        main_i_L1+1 
L_main16:
	MOVLW       128
	XORWF       main_i_L1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _size+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main70
	MOVF        _size+0, 0 
	SUBWF       main_i_L1+0, 0 
L__main70:
	BTFSC       STATUS+0, 0 
	GOTO        L_main17
;PROPELLER DISPLAY.c,126 :: 		ch[i] = UART1_Read();
	MOVLW       _ch+0
	ADDWF       main_i_L1+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_ch+0)
	ADDWFC      main_i_L1+1, 0 
	MOVWF       FLOC__main+1 
	CALL        _UART1_Read+0, 0
	MOVFF       FLOC__main+0, FSR1L
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;PROPELLER DISPLAY.c,127 :: 		UART1_Write(ch);
	MOVLW       _ch+0
	MOVWF       FARG_UART1_Write_data_+0 
	CALL        _UART1_Write+0, 0
;PROPELLER DISPLAY.c,124 :: 		for(i=0;i<size;i++)
	INFSNZ      main_i_L1+0, 1 
	INCF        main_i_L1+1, 1 
;PROPELLER DISPLAY.c,128 :: 		}
	GOTO        L_main16
L_main17:
;PROPELLER DISPLAY.c,129 :: 		}
L_main15:
;PROPELLER DISPLAY.c,131 :: 		while(ch[size1]!='\0')
L_main19:
	MOVLW       _ch+0
	ADDWF       _size1+0, 0 
	MOVWF       FSR0L 
	MOVLW       hi_addr(_ch+0)
	ADDWFC      _size1+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	XORLW       0
	BTFSC       STATUS+0, 2 
	GOTO        L_main20
;PROPELLER DISPLAY.c,133 :: 		size1++;                      //size of string
	INFSNZ      _size1+0, 1 
	INCF        _size1+1, 1 
;PROPELLER DISPLAY.c,134 :: 		}
	GOTO        L_main19
L_main20:
;PROPELLER DISPLAY.c,136 :: 		for(i=size1;i<=size;i++)           //appending space at the end
	MOVF        _size1+0, 0 
	MOVWF       main_i_L1+0 
	MOVF        _size1+1, 0 
	MOVWF       main_i_L1+1 
L_main21:
	MOVLW       128
	XORWF       _size+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       main_i_L1+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main71
	MOVF        main_i_L1+0, 0 
	SUBWF       _size+0, 0 
L__main71:
	BTFSS       STATUS+0, 0 
	GOTO        L_main22
;PROPELLER DISPLAY.c,138 :: 		ch[i]=' ';
	MOVLW       _ch+0
	ADDWF       main_i_L1+0, 0 
	MOVWF       FSR1L 
	MOVLW       hi_addr(_ch+0)
	ADDWFC      main_i_L1+1, 0 
	MOVWF       FSR1H 
	MOVLW       32
	MOVWF       POSTINC1+0 
;PROPELLER DISPLAY.c,136 :: 		for(i=size1;i<=size;i++)           //appending space at the end
	INFSNZ      main_i_L1+0, 1 
	INCF        main_i_L1+1, 1 
;PROPELLER DISPLAY.c,139 :: 		}
	GOTO        L_main21
L_main22:
;PROPELLER DISPLAY.c,141 :: 		t=ti/size;                   //calculating time delay
	MOVF        _size+0, 0 
	MOVWF       R4 
	MOVF        _size+1, 0 
	MOVWF       R5 
	MOVF        main_ti_L1+0, 0 
	MOVWF       R0 
	MOVF        main_ti_L1+1, 0 
	MOVWF       R1 
	CALL        _Div_16x16_S+0, 0
	MOVF        R0, 0 
	MOVWF       main_t_L1+0 
	MOVF        R1, 0 
	MOVWF       main_t_L1+1 
;PROPELLER DISPLAY.c,143 :: 		if(size1==0)
	MOVLW       0
	XORWF       _size1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main72
	MOVLW       0
	XORWF       _size1+0, 0 
L__main72:
	BTFSS       STATUS+0, 2 
	GOTO        L_main24
;PROPELLER DISPLAY.c,145 :: 		hello_world(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_hello_world_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_hello_world_t+1 
	CALL        _hello_world+0, 0
;PROPELLER DISPLAY.c,146 :: 		}
	GOTO        L_main25
L_main24:
;PROPELLER DISPLAY.c,150 :: 		for(i=0;i<size;i++)
	CLRF        main_i_L1+0 
	CLRF        main_i_L1+1 
L_main26:
	MOVLW       128
	XORWF       main_i_L1+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       _size+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main73
	MOVF        _size+0, 0 
	SUBWF       main_i_L1+0, 0 
L__main73:
	BTFSC       STATUS+0, 0 
	GOTO        L_main27
;PROPELLER DISPLAY.c,152 :: 		switch(ch[i])             //Identifing the letter
	MOVLW       _ch+0
	ADDWF       main_i_L1+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_ch+0)
	ADDWFC      main_i_L1+1, 0 
	MOVWF       FLOC__main+1 
	GOTO        L_main29
;PROPELLER DISPLAY.c,154 :: 		case ('a'||'A'):show(AA,t);
L_main31:
	MOVLW       _AA+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_AA+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,155 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,156 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,157 :: 		case ('b'||'B'):show(BB,t);
L_main32:
	MOVLW       _BB+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_BB+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,158 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,159 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,160 :: 		case ('c'||'C'):show(CC,t);
L_main33:
	MOVLW       _CC+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_CC+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,161 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,162 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,163 :: 		case ('d'||'D'):show(DD,t);
L_main34:
	MOVLW       _DD+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_DD+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,164 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,165 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,166 :: 		case ('e'||'E'):show(EE,t);
L_main35:
	MOVLW       _EE+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_EE+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,167 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,168 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,169 :: 		case ('f'||'F'):show(FF,t);
L_main36:
	MOVLW       _FF+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_FF+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,170 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,171 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,172 :: 		case ('g'||'G'):show(GG,t);
L_main37:
	MOVLW       _GG+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_GG+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,173 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,174 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,175 :: 		case ('h'||'H'):show(HH,t);
L_main38:
	MOVLW       _HH+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_HH+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,176 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,177 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,178 :: 		case ('i'||'I'):show(II,t);
L_main39:
	MOVLW       _II+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_II+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,179 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,180 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,181 :: 		case ('j'||'J'):show(JJ,t);
L_main40:
	MOVLW       _JJ+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_JJ+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,182 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,183 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,184 :: 		case ('k'||'K'):show(KK,t);
L_main41:
	MOVLW       _KK+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_KK+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,185 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,186 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,187 :: 		case ('l'||'L'):show(LL,t);
L_main42:
	MOVLW       _LL+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_LL+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,188 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,189 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,190 :: 		case ('m'||'M'):show(MM,t);
L_main43:
	MOVLW       _MM+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_MM+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,191 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,192 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,193 :: 		case ('n'||'N'):show(NN,t);
L_main44:
	MOVLW       _NN+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_NN+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,194 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,195 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,196 :: 		case ('o'||'O'):show(OO,t);
L_main45:
	MOVLW       _OO+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_OO+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,197 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,198 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,199 :: 		case ('p'||'P'):show(PP,t);
L_main46:
	MOVLW       _PP+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_PP+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,200 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,201 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,202 :: 		case ('q'||'Q'):show(QQ,t);
L_main47:
	MOVLW       _QQ+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_QQ+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,203 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,204 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,205 :: 		case ('r'||'R'):show(RR,t);
L_main48:
	MOVLW       _RR+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_RR+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,206 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,207 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,208 :: 		case ('s'||'S'):show(SS,t);
L_main49:
	MOVLW       _SS+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_SS+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,209 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,210 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,211 :: 		case ('t'||'T'):show(TT,t);
L_main50:
	MOVLW       _TT+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_TT+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,212 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,213 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,214 :: 		case ('u'||'U'):show(UU,t);
L_main51:
	MOVLW       _UU+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_UU+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,215 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,216 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,217 :: 		case ('v'||'V'):show(VV,t);
L_main52:
	MOVLW       _VV+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_VV+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,218 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,219 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,220 :: 		case ('w'||'W'):show(WW,t);
L_main53:
	MOVLW       _WW+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_WW+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,221 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,222 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,223 :: 		case ('x'||'X'):show(XX,t);
L_main54:
	MOVLW       _XX+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_XX+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,224 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,225 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,226 :: 		case ('y'||'Y'):show(YY,t);
L_main55:
	MOVLW       _YY+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_YY+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,227 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,228 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,229 :: 		case ('z'||'Z'):show(ZZ,t);
L_main56:
	MOVLW       _ZZ+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_ZZ+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,230 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,231 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,232 :: 		case (' '):show(Space,t);
L_main57:
	MOVLW       _Space+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Space+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,233 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,234 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,235 :: 		case ('0'):show(Zero,t);
L_main58:
	MOVLW       _Zero+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Zero+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,236 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,237 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,238 :: 		case ('1'):show(One,t);
L_main59:
	MOVLW       _One+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_One+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,239 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,240 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,241 :: 		case ('2'):show(Two,t);
L_main60:
	MOVLW       _Two+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Two+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,242 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,243 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,244 :: 		case ('3'):show(Three,t);
L_main61:
	MOVLW       _Three+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Three+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,245 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,246 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,247 :: 		case ('4'):show(Four,t);
L_main62:
	MOVLW       _Four+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Four+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,248 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,249 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,250 :: 		case ('5'):show(Five,t);
L_main63:
	MOVLW       _Five+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Five+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,251 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,252 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,253 :: 		case ('6'):show(Six,t);
L_main64:
	MOVLW       _Six+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Six+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,254 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,255 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,256 :: 		case ('7'):show(Seven,t);
L_main65:
	MOVLW       _Seven+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Seven+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,257 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,258 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,259 :: 		case ('8'):show(Eight,t);
L_main66:
	MOVLW       _Eight+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Eight+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,260 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,261 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,262 :: 		case ('9'):show(Nine,t);
L_main67:
	MOVLW       _Nine+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Nine+0)
	MOVWF       FARG_show_image+1 
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;PROPELLER DISPLAY.c,263 :: 		elay_ms(t);
	MOVF        main_t_L1+0, 0 
	MOVWF       FARG_elay_ms_n+0 
	MOVF        main_t_L1+1, 0 
	MOVWF       FARG_elay_ms_n+1 
	CALL        _elay_ms+0, 0
;PROPELLER DISPLAY.c,264 :: 		break;
	GOTO        L_main30
;PROPELLER DISPLAY.c,265 :: 		default:break;
L_main68:
	GOTO        L_main30
;PROPELLER DISPLAY.c,266 :: 		}
L_main29:
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main31
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main32
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main33
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main34
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main35
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main36
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main37
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main38
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main39
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main40
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main41
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main42
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main43
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main44
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main45
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main46
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main47
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main48
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main49
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main50
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main51
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main52
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main53
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main54
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main55
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       1
	BTFSC       STATUS+0, 2 
	GOTO        L_main56
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_main57
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_main58
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_main59
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L_main60
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L_main61
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       52
	BTFSC       STATUS+0, 2 
	GOTO        L_main62
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       53
	BTFSC       STATUS+0, 2 
	GOTO        L_main63
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       54
	BTFSC       STATUS+0, 2 
	GOTO        L_main64
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       55
	BTFSC       STATUS+0, 2 
	GOTO        L_main65
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       56
	BTFSC       STATUS+0, 2 
	GOTO        L_main66
	MOVFF       FLOC__main+0, FSR0L
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSC       STATUS+0, 2 
	GOTO        L_main67
	GOTO        L_main68
L_main30:
;PROPELLER DISPLAY.c,150 :: 		for(i=0;i<size;i++)
	INFSNZ      main_i_L1+0, 1 
	INCF        main_i_L1+1, 1 
;PROPELLER DISPLAY.c,267 :: 		}
	GOTO        L_main26
L_main27:
;PROPELLER DISPLAY.c,268 :: 		}
L_main25:
;PROPELLER DISPLAY.c,269 :: 		}
	GOTO        L_main13
;PROPELLER DISPLAY.c,270 :: 		}
	GOTO        $+0
; end of _main
