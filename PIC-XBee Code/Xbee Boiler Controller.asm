
_main:

;Xbee Boiler Controller.c,5 :: 		void main() {
;Xbee Boiler Controller.c,8 :: 		CMCON = 7;       // Disable Comparators
	MOVLW      7
	MOVWF      CMCON+0
;Xbee Boiler Controller.c,9 :: 		TRISA = 0;
	CLRF       TRISA+0
;Xbee Boiler Controller.c,11 :: 		PORTA = 0;
	CLRF       PORTA+0
;Xbee Boiler Controller.c,13 :: 		hwStatus = 0;
	CLRF       _hwStatus+0
	CLRF       _hwStatus+1
;Xbee Boiler Controller.c,14 :: 		chStatus = 0;
	CLRF       _chStatus+0
	CLRF       _chStatus+1
;Xbee Boiler Controller.c,15 :: 		Delay_ms(5000);                 // Wait for XBee to stabalize
	MOVLW      26
	MOVWF      R11+0
	MOVLW      94
	MOVWF      R12+0
	MOVLW      110
	MOVWF      R13+0
L_main0:
	DECFSZ     R13+0, 1
	GOTO       L_main0
	DECFSZ     R12+0, 1
	GOTO       L_main0
	DECFSZ     R11+0, 1
	GOTO       L_main0
	NOP
;Xbee Boiler Controller.c,16 :: 		UART1_Init(9600);               // Initialize UART module at 9600 bps
	MOVLW      25
	MOVWF      SPBRG+0
	BSF        TXSTA+0, 2
	CALL       _UART1_Init+0
;Xbee Boiler Controller.c,17 :: 		Delay_ms(500);                  // Wait for UART module to stabilize
	MOVLW      3
	MOVWF      R11+0
	MOVLW      138
	MOVWF      R12+0
	MOVLW      85
	MOVWF      R13+0
L_main1:
	DECFSZ     R13+0, 1
	GOTO       L_main1
	DECFSZ     R12+0, 1
	GOTO       L_main1
	DECFSZ     R11+0, 1
	GOTO       L_main1
	NOP
	NOP
;Xbee Boiler Controller.c,19 :: 		UART1_Write_Text(" Xbee Connection Successful! ");   // Character Message to be Sent
	MOVLW      ?lstr1_Xbee_32Boiler_32Controller+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Xbee Boiler Controller.c,20 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,21 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,24 :: 		while (1) {                     // Endless loop
L_main2:
;Xbee Boiler Controller.c,25 :: 		if (UART1_Data_Ready() == 1) {
	CALL       _UART1_Data_Ready+0
	MOVF       R0+0, 0
	XORLW      1
	BTFSS      STATUS+0, 2
	GOTO       L_main4
;Xbee Boiler Controller.c,26 :: 		i = UART1_Read();                  // read the received data
	CALL       _UART1_Read+0
	MOVF       R0+0, 0
	MOVWF      _i+0
;Xbee Boiler Controller.c,29 :: 		if (i == 'h'){  // Set hot water on
	MOVF       R0+0, 0
	XORLW      104
	BTFSS      STATUS+0, 2
	GOTO       L_main5
;Xbee Boiler Controller.c,30 :: 		PORTA.B1 = 1;
	BSF        PORTA+0, 1
;Xbee Boiler Controller.c,31 :: 		UART1_Write_Text("1");   // Character Message to be Sent
	MOVLW      ?lstr2_Xbee_32Boiler_32Controller+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Xbee Boiler Controller.c,32 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,33 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,34 :: 		hwStatus = 1;
	MOVLW      1
	MOVWF      _hwStatus+0
	MOVLW      0
	MOVWF      _hwStatus+1
;Xbee Boiler Controller.c,35 :: 		}
L_main5:
;Xbee Boiler Controller.c,36 :: 		if (i == 'i'){ // Set hot water off
	MOVF       _i+0, 0
	XORLW      105
	BTFSS      STATUS+0, 2
	GOTO       L_main6
;Xbee Boiler Controller.c,37 :: 		PORTA.B1 = 0;
	BCF        PORTA+0, 1
;Xbee Boiler Controller.c,38 :: 		UART1_Write_Text("0");   // Character Message to be Sent
	MOVLW      ?lstr3_Xbee_32Boiler_32Controller+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Xbee Boiler Controller.c,39 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,40 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,41 :: 		hwStatus = 0;
	CLRF       _hwStatus+0
	CLRF       _hwStatus+1
;Xbee Boiler Controller.c,42 :: 		}
L_main6:
;Xbee Boiler Controller.c,43 :: 		if (i == 'j'){ // Check hot water status
	MOVF       _i+0, 0
	XORLW      106
	BTFSS      STATUS+0, 2
	GOTO       L_main7
;Xbee Boiler Controller.c,44 :: 		if (hwStatus == 1){
	MOVLW      0
	XORWF      _hwStatus+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main16
	MOVLW      1
	XORWF      _hwStatus+0, 0
L__main16:
	BTFSS      STATUS+0, 2
	GOTO       L_main8
;Xbee Boiler Controller.c,45 :: 		UART1_Write_Text("1");   // Character Message to be Sent
	MOVLW      ?lstr4_Xbee_32Boiler_32Controller+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Xbee Boiler Controller.c,46 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,47 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,48 :: 		}
	GOTO       L_main9
L_main8:
;Xbee Boiler Controller.c,50 :: 		UART1_Write_Text("0");   // Character Message to be Sent
	MOVLW      ?lstr5_Xbee_32Boiler_32Controller+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Xbee Boiler Controller.c,51 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,52 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,53 :: 		}
L_main9:
;Xbee Boiler Controller.c,54 :: 		}
L_main7:
;Xbee Boiler Controller.c,57 :: 		if (i == 'c'){    // set Central Heating on
	MOVF       _i+0, 0
	XORLW      99
	BTFSS      STATUS+0, 2
	GOTO       L_main10
;Xbee Boiler Controller.c,58 :: 		PORTA.B7 = 1;
	BSF        PORTA+0, 7
;Xbee Boiler Controller.c,59 :: 		UART1_Write_Text("1");   // Character Message to be Sent
	MOVLW      ?lstr6_Xbee_32Boiler_32Controller+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Xbee Boiler Controller.c,60 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,61 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,62 :: 		chStatus = 1;
	MOVLW      1
	MOVWF      _chStatus+0
	MOVLW      0
	MOVWF      _chStatus+1
;Xbee Boiler Controller.c,63 :: 		}
L_main10:
;Xbee Boiler Controller.c,64 :: 		if (i == 'd'){   // set Central Heating off
	MOVF       _i+0, 0
	XORLW      100
	BTFSS      STATUS+0, 2
	GOTO       L_main11
;Xbee Boiler Controller.c,65 :: 		PORTA.B7 = 0;
	BCF        PORTA+0, 7
;Xbee Boiler Controller.c,66 :: 		UART1_Write_Text("0");   // Character Message to be Sent
	MOVLW      ?lstr7_Xbee_32Boiler_32Controller+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Xbee Boiler Controller.c,67 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,68 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,69 :: 		chStatus = 0;
	CLRF       _chStatus+0
	CLRF       _chStatus+1
;Xbee Boiler Controller.c,70 :: 		}
L_main11:
;Xbee Boiler Controller.c,71 :: 		if (i == 'e'){  // check Central Heating status
	MOVF       _i+0, 0
	XORLW      101
	BTFSS      STATUS+0, 2
	GOTO       L_main12
;Xbee Boiler Controller.c,72 :: 		if (chStatus == 1){
	MOVLW      0
	XORWF      _chStatus+1, 0
	BTFSS      STATUS+0, 2
	GOTO       L__main17
	MOVLW      1
	XORWF      _chStatus+0, 0
L__main17:
	BTFSS      STATUS+0, 2
	GOTO       L_main13
;Xbee Boiler Controller.c,73 :: 		UART1_Write_Text("1");   // Character Message to be Sent
	MOVLW      ?lstr8_Xbee_32Boiler_32Controller+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Xbee Boiler Controller.c,74 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,75 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,76 :: 		}
	GOTO       L_main14
L_main13:
;Xbee Boiler Controller.c,78 :: 		UART1_Write_Text("0");   // Character Message to be Sent
	MOVLW      ?lstr9_Xbee_32Boiler_32Controller+0
	MOVWF      FARG_UART1_Write_Text_uart_text+0
	CALL       _UART1_Write_Text+0
;Xbee Boiler Controller.c,79 :: 		UART1_Write(10);
	MOVLW      10
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,80 :: 		UART1_Write(13);
	MOVLW      13
	MOVWF      FARG_UART1_Write_data_+0
	CALL       _UART1_Write+0
;Xbee Boiler Controller.c,81 :: 		}
L_main14:
;Xbee Boiler Controller.c,82 :: 		}
L_main12:
;Xbee Boiler Controller.c,84 :: 		}
L_main4:
;Xbee Boiler Controller.c,85 :: 		}
	GOTO       L_main2
;Xbee Boiler Controller.c,87 :: 		}
L_end_main:
	GOTO       $+0
; end of _main
