
_elay_us:

;good morning.c,51 :: 		void elay_us(int n)       //Delay function for variable time delay
;good morning.c,53 :: 		while (n--)
L_elay_us0:
	MOVF        FARG_elay_us_n+0, 0 
	MOVWF       R0 
	MOVF        FARG_elay_us_n+1, 0 
	MOVWF       R1 
	MOVLW       1
	SUBWF       FARG_elay_us_n+0, 1 
	MOVLW       0
	SUBWFB      FARG_elay_us_n+1, 1 
	MOVF        R0, 0 
	IORWF       R1, 0 
	BTFSC       STATUS+0, 2 
	GOTO        L_elay_us1
;good morning.c,55 :: 		delay_us(1);
	NOP
;good morning.c,56 :: 		}
	GOTO        L_elay_us0
L_elay_us1:
;good morning.c,57 :: 		}
L_end_elay_us:
	RETURN      0
; end of _elay_us

_time:

;good morning.c,59 :: 		int time()            //Calculating time for each revolution
;good morning.c,61 :: 		int t=0;
	CLRF        time_t_L0+0 
	CLRF        time_t_L0+1 
;good morning.c,62 :: 		if(PORTA.F0==0x00)
	BTFSC       PORTA+0, 0 
	GOTO        L_time2
;good morning.c,64 :: 		while(PORTA.F0==0x00);
L_time3:
	BTFSC       PORTA+0, 0 
	GOTO        L_time4
	GOTO        L_time3
L_time4:
;good morning.c,65 :: 		while(PORTA.F0==0xff)
L_time5:
	BTFSS       PORTA+0, 0 
	GOTO        L_time6
;good morning.c,67 :: 		t=t+1;
	INFSNZ      time_t_L0+0, 1 
	INCF        time_t_L0+1, 1 
;good morning.c,68 :: 		delay_us(1);
	NOP
;good morning.c,69 :: 		}
	GOTO        L_time5
L_time6:
;good morning.c,70 :: 		return t;
	MOVF        time_t_L0+0, 0 
	MOVWF       R0 
	MOVF        time_t_L0+1, 0 
	MOVWF       R1 
	GOTO        L_end_time
;good morning.c,71 :: 		}
L_time2:
;good morning.c,72 :: 		}
L_end_time:
	RETURN      0
; end of _time

_show:

;good morning.c,74 :: 		void show(int image[],int t)      //Displaying the letter
;good morning.c,76 :: 		int b1=0;
	CLRF        show_b1_L0+0 
	CLRF        show_b1_L0+1 
;good morning.c,77 :: 		for(b1=0;b1<=len;b1++)
	CLRF        show_b1_L0+0 
	CLRF        show_b1_L0+1 
L_show7:
	MOVLW       128
	XORWF       _len+1, 0 
	MOVWF       R0 
	MOVLW       128
	XORWF       show_b1_L0+1, 0 
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__show89
	MOVF        show_b1_L0+0, 0 
	SUBWF       _len+0, 0 
L__show89:
	BTFSS       STATUS+0, 0 
	GOTO        L_show8
;good morning.c,79 :: 		elay_us(t);
	MOVF        FARG_show_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_show_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,80 :: 		PORTB=image[b1];
	MOVF        show_b1_L0+0, 0 
	MOVWF       R0 
	MOVF        show_b1_L0+1, 0 
	MOVWF       R1 
	RLCF        R0, 1 
	BCF         R0, 0 
	RLCF        R1, 1 
	MOVF        R0, 0 
	ADDWF       FARG_show_image+0, 0 
	MOVWF       FSR0 
	MOVF        R1, 0 
	ADDWFC      FARG_show_image+1, 0 
	MOVWF       FSR0H 
	MOVF        POSTINC0+0, 0 
	MOVWF       PORTB+0 
;good morning.c,77 :: 		for(b1=0;b1<=len;b1++)
	INFSNZ      show_b1_L0+0, 1 
	INCF        show_b1_L0+1, 1 
;good morning.c,81 :: 		}
	GOTO        L_show7
L_show8:
;good morning.c,82 :: 		PORTB=0b00000000;
	CLRF        PORTB+0 
;good morning.c,83 :: 		}
L_end_show:
	RETURN      0
; end of _show

_hello_world:

;good morning.c,85 :: 		void hello_world(int t)
;good morning.c,87 :: 		show(HH,t);
	MOVLW       _HH+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_HH+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,88 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,89 :: 		show(EE,t);
	MOVLW       _EE+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_EE+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,90 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,91 :: 		show(LL,t);
	MOVLW       _LL+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_LL+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,92 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,93 :: 		show(LL,t);
	MOVLW       _LL+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_LL+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,94 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,95 :: 		show(OO,t);
	MOVLW       _OO+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_OO+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,96 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,97 :: 		show(space,t);
	MOVLW       _Space+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Space+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,98 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,99 :: 		show(WW,t);
	MOVLW       _WW+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_WW+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,100 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,101 :: 		show(OO,t);
	MOVLW       _OO+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_OO+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,102 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,103 :: 		show(RR,t);
	MOVLW       _RR+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_RR+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,104 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,105 :: 		show(LL,t);
	MOVLW       _LL+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_LL+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,106 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,107 :: 		show(DD,t);
	MOVLW       _DD+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_DD+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,108 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,109 :: 		show(Space,t);
	MOVLW       _Space+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Space+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,110 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,111 :: 		show(Space,t);
	MOVLW       _Space+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Space+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,112 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,113 :: 		show(Space,t);
	MOVLW       _Space+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Space+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,114 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,115 :: 		show(Space,t);
	MOVLW       _Space+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Space+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,116 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,117 :: 		show(Space,t);
	MOVLW       _Space+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Space+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,118 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,119 :: 		show(Space,t);
	MOVLW       _Space+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Space+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,120 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,121 :: 		show(Space,t);
	MOVLW       _Space+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Space+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,122 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,123 :: 		show(Space,t);
	MOVLW       _Space+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Space+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,124 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,125 :: 		show(Space,t);
	MOVLW       _Space+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Space+0)
	MOVWF       FARG_show_image+1 
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,126 :: 		elay_us(t);
	MOVF        FARG_hello_world_t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        FARG_hello_world_t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,127 :: 		}
L_end_hello_world:
	RETURN      0
; end of _hello_world

_main:

;good morning.c,129 :: 		void main()
;good morning.c,131 :: 		TRISA=0xFF;
	MOVLW       255
	MOVWF       TRISA+0 
;good morning.c,132 :: 		TRISB=0x00;
	CLRF        TRISB+0 
;good morning.c,133 :: 		PORTB=0x00;
	CLRF        PORTB+0 
;good morning.c,134 :: 		TRISC.RC6 = 0x00; //TX pin set as output
	BCF         TRISC+0, 6 
;good morning.c,135 :: 		TRISC.RC7 = 0xFF; //RX pin set as input
	BSF         TRISC+0, 7 
;good morning.c,136 :: 		UART1_Init(9600);
	BSF         BAUDCON+0, 3, 0
	CLRF        SPBRGH+0 
	MOVLW       106
	MOVWF       SPBRG+0 
	BSF         TXSTA+0, 2, 0
	CALL        _UART1_Init+0, 0
;good morning.c,137 :: 		delay_us(100);             //Delay for UART to become stable
	MOVLW       34
	MOVWF       R13, 0
L_main10:
	DECFSZ      R13, 1, 1
	BRA         L_main10
;good morning.c,138 :: 		while(1)
L_main11:
;good morning.c,141 :: 		if (UART1_Data_Ready())    // Bluetooth data recieve
	CALL        _UART1_Data_Ready+0, 0
	MOVF        R0, 1 
	BTFSC       STATUS+0, 2 
	GOTO        L_main13
;good morning.c,143 :: 		ch[size1] = UART1_Read();
	MOVLW       _ch+0
	ADDWF       _size1+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_ch+0)
	ADDWFC      _size1+1, 0 
	MOVWF       FLOC__main+1 
	CALL        _UART1_Read+0, 0
	MOVFF       FLOC__main+0, FSR1
	MOVFF       FLOC__main+1, FSR1H
	MOVF        R0, 0 
	MOVWF       POSTINC1+0 
;good morning.c,144 :: 		ch[size1+1] = '\0';
	MOVLW       1
	ADDWF       _size1+0, 0 
	MOVWF       R0 
	MOVLW       0
	ADDWFC      _size1+1, 0 
	MOVWF       R1 
	MOVLW       _ch+0
	ADDWF       R0, 0 
	MOVWF       FSR1 
	MOVLW       hi_addr(_ch+0)
	ADDWFC      R1, 0 
	MOVWF       FSR1H 
	CLRF        POSTINC1+0 
;good morning.c,145 :: 		size1++;
	INFSNZ      _size1+0, 1 
	INCF        _size1+1, 1 
;good morning.c,146 :: 		if(size1>=20)
	MOVLW       128
	XORWF       _size1+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main92
	MOVLW       20
	SUBWF       _size1+0, 0 
L__main92:
	BTFSS       STATUS+0, 0 
	GOTO        L_main14
;good morning.c,148 :: 		size1=0;
	CLRF        _size1+0 
	CLRF        _size1+1 
;good morning.c,149 :: 		}
L_main14:
;good morning.c,150 :: 		}
L_main13:
;good morning.c,162 :: 		t=30;                   //calculating time delay
	MOVLW       30
	MOVWF       _t+0 
	MOVLW       0
	MOVWF       _t+1 
;good morning.c,168 :: 		if(size1==0)
	MOVLW       0
	XORWF       _size1+1, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main93
	MOVLW       0
	XORWF       _size1+0, 0 
L__main93:
	BTFSS       STATUS+0, 2 
	GOTO        L_main15
;good morning.c,170 :: 		hello_world(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_hello_world_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_hello_world_t+1 
	CALL        _hello_world+0, 0
;good morning.c,171 :: 		}
	GOTO        L_main16
L_main15:
;good morning.c,175 :: 		for(i=0;i<20;i++)
	CLRF        _i+0 
	CLRF        _i+1 
L_main17:
	MOVLW       128
	XORWF       _i+1, 0 
	MOVWF       R0 
	MOVLW       128
	SUBWF       R0, 0 
	BTFSS       STATUS+0, 2 
	GOTO        L__main94
	MOVLW       20
	SUBWF       _i+0, 0 
L__main94:
	BTFSC       STATUS+0, 0 
	GOTO        L_main18
;good morning.c,177 :: 		switch(ch[i])             //Identifing the letter
	MOVLW       _ch+0
	ADDWF       _i+0, 0 
	MOVWF       FLOC__main+0 
	MOVLW       hi_addr(_ch+0)
	ADDWFC      _i+1, 0 
	MOVWF       FLOC__main+1 
	GOTO        L_main20
;good morning.c,179 :: 		case 'a':
L_main22:
;good morning.c,180 :: 		case 'A':
L_main23:
;good morning.c,182 :: 		show(AA,t);
	MOVLW       _AA+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_AA+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,183 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,184 :: 		break;
	GOTO        L_main21
;good morning.c,186 :: 		case 'b':
L_main24:
;good morning.c,187 :: 		case 'B':
L_main25:
;good morning.c,189 :: 		show(BB,t);
	MOVLW       _BB+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_BB+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,190 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,191 :: 		break;
	GOTO        L_main21
;good morning.c,193 :: 		case 'c':
L_main26:
;good morning.c,194 :: 		case 'C':
L_main27:
;good morning.c,196 :: 		show(CC,t);
	MOVLW       _CC+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_CC+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,197 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,198 :: 		break;
	GOTO        L_main21
;good morning.c,200 :: 		case 'd':
L_main28:
;good morning.c,201 :: 		case 'D':
L_main29:
;good morning.c,203 :: 		show(DD,t);
	MOVLW       _DD+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_DD+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,204 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,205 :: 		break;
	GOTO        L_main21
;good morning.c,207 :: 		case 'e':
L_main30:
;good morning.c,208 :: 		case 'E':
L_main31:
;good morning.c,210 :: 		show(EE,t);
	MOVLW       _EE+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_EE+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,211 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,212 :: 		break;
	GOTO        L_main21
;good morning.c,214 :: 		case 'f':
L_main32:
;good morning.c,215 :: 		case 'F':
L_main33:
;good morning.c,217 :: 		show(FF,t);
	MOVLW       _FF+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_FF+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,218 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,219 :: 		break;
	GOTO        L_main21
;good morning.c,221 :: 		case 'g':
L_main34:
;good morning.c,222 :: 		case 'G':
L_main35:
;good morning.c,224 :: 		show(GG,t);
	MOVLW       _GG+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_GG+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,225 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,226 :: 		break;
	GOTO        L_main21
;good morning.c,228 :: 		case 'h':
L_main36:
;good morning.c,229 :: 		case 'H':
L_main37:
;good morning.c,231 :: 		show(HH,t);
	MOVLW       _HH+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_HH+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,232 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,233 :: 		break;
	GOTO        L_main21
;good morning.c,235 :: 		case 'i':
L_main38:
;good morning.c,236 :: 		case 'I':
L_main39:
;good morning.c,238 :: 		show(II,t);
	MOVLW       _II+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_II+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,239 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,240 :: 		break;
	GOTO        L_main21
;good morning.c,242 :: 		case 'j':
L_main40:
;good morning.c,243 :: 		case 'J':
L_main41:
;good morning.c,245 :: 		show(JJ,t);
	MOVLW       _JJ+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_JJ+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,246 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,247 :: 		break;
	GOTO        L_main21
;good morning.c,249 :: 		case 'k':
L_main42:
;good morning.c,250 :: 		case 'K':
L_main43:
;good morning.c,252 :: 		show(KK,t);
	MOVLW       _KK+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_KK+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,253 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,254 :: 		break;
	GOTO        L_main21
;good morning.c,256 :: 		case 'l':
L_main44:
;good morning.c,257 :: 		case 'L':
L_main45:
;good morning.c,259 :: 		show(LL,t);
	MOVLW       _LL+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_LL+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,260 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,261 :: 		break;
	GOTO        L_main21
;good morning.c,263 :: 		case 'm':
L_main46:
;good morning.c,264 :: 		case 'M':
L_main47:
;good morning.c,266 :: 		show(MM,t);
	MOVLW       _MM+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_MM+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,267 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,268 :: 		break;
	GOTO        L_main21
;good morning.c,270 :: 		case 'n':
L_main48:
;good morning.c,271 :: 		case 'N':
L_main49:
;good morning.c,273 :: 		show(NN,t);
	MOVLW       _NN+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_NN+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,274 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,275 :: 		break;
	GOTO        L_main21
;good morning.c,277 :: 		case 'o':
L_main50:
;good morning.c,278 :: 		case 'O':
L_main51:
;good morning.c,280 :: 		show(OO,t);
	MOVLW       _OO+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_OO+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,281 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,282 :: 		break;
	GOTO        L_main21
;good morning.c,284 :: 		case 'p':
L_main52:
;good morning.c,285 :: 		case 'P':
L_main53:
;good morning.c,287 :: 		show(PP,t);
	MOVLW       _PP+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_PP+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,288 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,289 :: 		break;
	GOTO        L_main21
;good morning.c,291 :: 		case 'q':
L_main54:
;good morning.c,292 :: 		case 'Q':
L_main55:
;good morning.c,294 :: 		show(QQ,t);
	MOVLW       _QQ+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_QQ+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,295 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,296 :: 		break;
	GOTO        L_main21
;good morning.c,298 :: 		case 'r':
L_main56:
;good morning.c,299 :: 		case 'R':
L_main57:
;good morning.c,301 :: 		show(RR,t);
	MOVLW       _RR+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_RR+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,302 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,303 :: 		break;
	GOTO        L_main21
;good morning.c,305 :: 		case 's':
L_main58:
;good morning.c,306 :: 		case 'S':
L_main59:
;good morning.c,308 :: 		show(SS,t);
	MOVLW       _SS+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_SS+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,309 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,310 :: 		break;
	GOTO        L_main21
;good morning.c,312 :: 		case 't':
L_main60:
;good morning.c,313 :: 		case 'T':
L_main61:
;good morning.c,315 :: 		show(TT,t);
	MOVLW       _TT+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_TT+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,316 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,317 :: 		break;
	GOTO        L_main21
;good morning.c,319 :: 		case 'u':
L_main62:
;good morning.c,320 :: 		case 'U':
L_main63:
;good morning.c,322 :: 		show(UU,t);
	MOVLW       _UU+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_UU+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,323 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,324 :: 		break;
	GOTO        L_main21
;good morning.c,326 :: 		case 'v':
L_main64:
;good morning.c,327 :: 		case 'V':
L_main65:
;good morning.c,329 :: 		show(VV,t);
	MOVLW       _VV+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_VV+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,330 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,331 :: 		break;
	GOTO        L_main21
;good morning.c,333 :: 		case 'w':
L_main66:
;good morning.c,334 :: 		case 'W':
L_main67:
;good morning.c,336 :: 		show(WW,t);
	MOVLW       _WW+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_WW+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,337 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,338 :: 		break;
	GOTO        L_main21
;good morning.c,340 :: 		case 'x':
L_main68:
;good morning.c,341 :: 		case 'X':
L_main69:
;good morning.c,343 :: 		show(XX,t);
	MOVLW       _XX+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_XX+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,344 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,345 :: 		break;
	GOTO        L_main21
;good morning.c,347 :: 		case 'y':
L_main70:
;good morning.c,348 :: 		case 'Y':
L_main71:
;good morning.c,350 :: 		show(YY,t);
	MOVLW       _YY+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_YY+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,351 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,352 :: 		break;
	GOTO        L_main21
;good morning.c,354 :: 		case 'z':
L_main72:
;good morning.c,355 :: 		case 'Z':
L_main73:
;good morning.c,357 :: 		show(ZZ,t);
	MOVLW       _ZZ+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_ZZ+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,358 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,359 :: 		break;
	GOTO        L_main21
;good morning.c,361 :: 		case ' ':
L_main74:
;good morning.c,363 :: 		show(Space,t);
	MOVLW       _Space+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Space+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,364 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,365 :: 		break;
	GOTO        L_main21
;good morning.c,367 :: 		case '0':
L_main75:
;good morning.c,369 :: 		show(Zero,t);
	MOVLW       _Zero+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Zero+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,370 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,371 :: 		break;
	GOTO        L_main21
;good morning.c,373 :: 		case '1':
L_main76:
;good morning.c,375 :: 		show(One,t);
	MOVLW       _One+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_One+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,376 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,377 :: 		break;
	GOTO        L_main21
;good morning.c,379 :: 		case '2':
L_main77:
;good morning.c,381 :: 		show(Two,t);
	MOVLW       _Two+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Two+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,382 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,383 :: 		break;
	GOTO        L_main21
;good morning.c,385 :: 		case '3':
L_main78:
;good morning.c,387 :: 		show(Three,t);
	MOVLW       _Three+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Three+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,388 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,389 :: 		break;
	GOTO        L_main21
;good morning.c,391 :: 		case '4':
L_main79:
;good morning.c,393 :: 		show(Four,t);
	MOVLW       _Four+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Four+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,394 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,395 :: 		break;
	GOTO        L_main21
;good morning.c,397 :: 		case '5':
L_main80:
;good morning.c,399 :: 		show(Five,t);
	MOVLW       _Five+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Five+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,400 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,401 :: 		break;
	GOTO        L_main21
;good morning.c,403 :: 		case '6':
L_main81:
;good morning.c,405 :: 		show(Six,t);
	MOVLW       _Six+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Six+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,406 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,407 :: 		break;
	GOTO        L_main21
;good morning.c,409 :: 		case '7':
L_main82:
;good morning.c,411 :: 		show(Seven,t);
	MOVLW       _Seven+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Seven+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,412 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,413 :: 		break;
	GOTO        L_main21
;good morning.c,415 :: 		case '8':
L_main83:
;good morning.c,417 :: 		show(Eight,t);
	MOVLW       _Eight+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Eight+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,418 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,419 :: 		break;
	GOTO        L_main21
;good morning.c,421 :: 		case '9':
L_main84:
;good morning.c,423 :: 		show(Nine,t);
	MOVLW       _Nine+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Nine+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,424 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,425 :: 		break;
	GOTO        L_main21
;good morning.c,427 :: 		default:
L_main85:
;good morning.c,429 :: 		show(Space,t);
	MOVLW       _Space+0
	MOVWF       FARG_show_image+0 
	MOVLW       hi_addr(_Space+0)
	MOVWF       FARG_show_image+1 
	MOVF        _t+0, 0 
	MOVWF       FARG_show_t+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_show_t+1 
	CALL        _show+0, 0
;good morning.c,430 :: 		elay_us(t);
	MOVF        _t+0, 0 
	MOVWF       FARG_elay_us_n+0 
	MOVF        _t+1, 0 
	MOVWF       FARG_elay_us_n+1 
	CALL        _elay_us+0, 0
;good morning.c,431 :: 		break;
	GOTO        L_main21
;good morning.c,433 :: 		}
L_main20:
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       97
	BTFSC       STATUS+0, 2 
	GOTO        L_main22
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       65
	BTFSC       STATUS+0, 2 
	GOTO        L_main23
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       98
	BTFSC       STATUS+0, 2 
	GOTO        L_main24
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       66
	BTFSC       STATUS+0, 2 
	GOTO        L_main25
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       99
	BTFSC       STATUS+0, 2 
	GOTO        L_main26
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       67
	BTFSC       STATUS+0, 2 
	GOTO        L_main27
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       100
	BTFSC       STATUS+0, 2 
	GOTO        L_main28
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       68
	BTFSC       STATUS+0, 2 
	GOTO        L_main29
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       101
	BTFSC       STATUS+0, 2 
	GOTO        L_main30
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       69
	BTFSC       STATUS+0, 2 
	GOTO        L_main31
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       102
	BTFSC       STATUS+0, 2 
	GOTO        L_main32
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       70
	BTFSC       STATUS+0, 2 
	GOTO        L_main33
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       103
	BTFSC       STATUS+0, 2 
	GOTO        L_main34
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       71
	BTFSC       STATUS+0, 2 
	GOTO        L_main35
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       104
	BTFSC       STATUS+0, 2 
	GOTO        L_main36
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       72
	BTFSC       STATUS+0, 2 
	GOTO        L_main37
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       105
	BTFSC       STATUS+0, 2 
	GOTO        L_main38
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       73
	BTFSC       STATUS+0, 2 
	GOTO        L_main39
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       106
	BTFSC       STATUS+0, 2 
	GOTO        L_main40
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       74
	BTFSC       STATUS+0, 2 
	GOTO        L_main41
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       107
	BTFSC       STATUS+0, 2 
	GOTO        L_main42
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       75
	BTFSC       STATUS+0, 2 
	GOTO        L_main43
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       108
	BTFSC       STATUS+0, 2 
	GOTO        L_main44
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       76
	BTFSC       STATUS+0, 2 
	GOTO        L_main45
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       109
	BTFSC       STATUS+0, 2 
	GOTO        L_main46
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       77
	BTFSC       STATUS+0, 2 
	GOTO        L_main47
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       110
	BTFSC       STATUS+0, 2 
	GOTO        L_main48
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       78
	BTFSC       STATUS+0, 2 
	GOTO        L_main49
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       111
	BTFSC       STATUS+0, 2 
	GOTO        L_main50
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       79
	BTFSC       STATUS+0, 2 
	GOTO        L_main51
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       112
	BTFSC       STATUS+0, 2 
	GOTO        L_main52
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       80
	BTFSC       STATUS+0, 2 
	GOTO        L_main53
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       113
	BTFSC       STATUS+0, 2 
	GOTO        L_main54
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       81
	BTFSC       STATUS+0, 2 
	GOTO        L_main55
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       114
	BTFSC       STATUS+0, 2 
	GOTO        L_main56
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       82
	BTFSC       STATUS+0, 2 
	GOTO        L_main57
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       115
	BTFSC       STATUS+0, 2 
	GOTO        L_main58
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       83
	BTFSC       STATUS+0, 2 
	GOTO        L_main59
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       116
	BTFSC       STATUS+0, 2 
	GOTO        L_main60
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       84
	BTFSC       STATUS+0, 2 
	GOTO        L_main61
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       117
	BTFSC       STATUS+0, 2 
	GOTO        L_main62
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       85
	BTFSC       STATUS+0, 2 
	GOTO        L_main63
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       118
	BTFSC       STATUS+0, 2 
	GOTO        L_main64
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       86
	BTFSC       STATUS+0, 2 
	GOTO        L_main65
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       119
	BTFSC       STATUS+0, 2 
	GOTO        L_main66
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       87
	BTFSC       STATUS+0, 2 
	GOTO        L_main67
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       120
	BTFSC       STATUS+0, 2 
	GOTO        L_main68
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       88
	BTFSC       STATUS+0, 2 
	GOTO        L_main69
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       121
	BTFSC       STATUS+0, 2 
	GOTO        L_main70
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       89
	BTFSC       STATUS+0, 2 
	GOTO        L_main71
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       122
	BTFSC       STATUS+0, 2 
	GOTO        L_main72
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       90
	BTFSC       STATUS+0, 2 
	GOTO        L_main73
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       32
	BTFSC       STATUS+0, 2 
	GOTO        L_main74
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       48
	BTFSC       STATUS+0, 2 
	GOTO        L_main75
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       49
	BTFSC       STATUS+0, 2 
	GOTO        L_main76
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       50
	BTFSC       STATUS+0, 2 
	GOTO        L_main77
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       51
	BTFSC       STATUS+0, 2 
	GOTO        L_main78
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       52
	BTFSC       STATUS+0, 2 
	GOTO        L_main79
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       53
	BTFSC       STATUS+0, 2 
	GOTO        L_main80
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       54
	BTFSC       STATUS+0, 2 
	GOTO        L_main81
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       55
	BTFSC       STATUS+0, 2 
	GOTO        L_main82
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       56
	BTFSC       STATUS+0, 2 
	GOTO        L_main83
	MOVFF       FLOC__main+0, FSR0
	MOVFF       FLOC__main+1, FSR0H
	MOVF        POSTINC0+0, 0 
	XORLW       57
	BTFSC       STATUS+0, 2 
	GOTO        L_main84
	GOTO        L_main85
L_main21:
;good morning.c,175 :: 		for(i=0;i<20;i++)
	INFSNZ      _i+0, 1 
	INCF        _i+1, 1 
;good morning.c,434 :: 		}
	GOTO        L_main17
L_main18:
;good morning.c,438 :: 		}
L_main16:
;good morning.c,439 :: 		}
	GOTO        L_main11
;good morning.c,440 :: 		}
L_end_main:
	GOTO        $+0
; end of _main
