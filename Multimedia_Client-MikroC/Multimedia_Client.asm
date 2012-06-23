_SecondsInterrupt:
;Multimedia_Client.c,35 :: 		void SecondsInterrupt()
SUB	SP, SP, #4
;Multimedia_Client.c,37 :: 		Ethernet_Intern_userTimerSec++ ;  // increment ethernet library counter
MOVW	R1, #lo_addr(_Ethernet_Intern_userTimerSec+0)
MOVT	R1, #hi_addr(_Ethernet_Intern_userTimerSec+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;Multimedia_Client.c,39 :: 		if (CountdownTimer > 0) CountdownTimer--;
MOVW	R0, #lo_addr(_CountdownTimer+0)
MOVT	R0, #hi_addr(_CountdownTimer+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_SecondsInterrupt0
MOVW	R1, #lo_addr(_CountdownTimer+0)
MOVT	R1, #hi_addr(_CountdownTimer+0)
LDRB	R0, [R1, #0]
SUBS	R0, R0, #1
STRB	R0, [R1, #0]
L_SecondsInterrupt0:
;Multimedia_Client.c,41 :: 		}
L_end_SecondsInterrupt:
ADD	SP, SP, #4
BX	LR
; end of _SecondsInterrupt
_SysTick_interrupt:
;Multimedia_Client.c,43 :: 		void SysTick_interrupt() iv IVT_FAULT_SYSTICK {
SUB	SP, SP, #4
;Multimedia_Client.c,44 :: 		presTmr++;
MOVW	R1, #lo_addr(_presTmr+0)
MOVT	R1, #hi_addr(_presTmr+0)
LDRB	R0, [R1, #0]
ADDS	R2, R0, #1
UXTB	R2, R2
STRB	R2, [R1, #0]
;Multimedia_Client.c,46 :: 		if (((presTmr % 3) > 0) && (halfSecondCountdownTimer > 0)) halfSecondCountdownTimer--;
MOVS	R1, #3
UDIV	R0, R2, R1
MLS	R0, R1, R0, R2
UXTB	R0, R0
CMP	R0, #0
IT	LS
BLS	L__SysTick_interrupt39
MOVW	R0, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R0, #hi_addr(_halfSecondCountdownTimer+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L__SysTick_interrupt38
L__SysTick_interrupt37:
MOVW	R1, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R1, #hi_addr(_halfSecondCountdownTimer+0)
LDRB	R0, [R1, #0]
SUBS	R0, R0, #1
STRB	R0, [R1, #0]
L__SysTick_interrupt39:
L__SysTick_interrupt38:
;Multimedia_Client.c,47 :: 		if(presTmr == 6)                   // overflows 20 times per second
MOVW	R0, #lo_addr(_presTmr+0)
MOVT	R0, #hi_addr(_presTmr+0)
LDRB	R0, [R0, #0]
CMP	R0, #6
IT	NE
BNE	L_SysTick_interrupt4
;Multimedia_Client.c,50 :: 		if (CountdownTimer > 0) CountdownTimer--;
MOVW	R0, #lo_addr(_CountdownTimer+0)
MOVT	R0, #hi_addr(_CountdownTimer+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_SysTick_interrupt5
MOVW	R1, #lo_addr(_CountdownTimer+0)
MOVT	R1, #hi_addr(_CountdownTimer+0)
LDRB	R0, [R1, #0]
SUBS	R0, R0, #1
STRB	R0, [R1, #0]
L_SysTick_interrupt5:
;Multimedia_Client.c,51 :: 		Ethernet_Intern_userTimerSec++ ;  // increment ethernet library counter
MOVW	R1, #lo_addr(_Ethernet_Intern_userTimerSec+0)
MOVT	R1, #hi_addr(_Ethernet_Intern_userTimerSec+0)
LDR	R0, [R1, #0]
ADDS	R0, R0, #1
STR	R0, [R1, #0]
;Multimedia_Client.c,52 :: 		presTmr = 0;                  // reset prescaler
MOVS	R1, #0
MOVW	R0, #lo_addr(_presTmr+0)
MOVT	R0, #hi_addr(_presTmr+0)
STRB	R1, [R0, #0]
;Multimedia_Client.c,53 :: 		}
L_SysTick_interrupt4:
;Multimedia_Client.c,54 :: 		}
L_end_SysTick_interrupt:
ADD	SP, SP, #4
BX	LR
; end of _SysTick_interrupt
_main:
;Multimedia_Client.c,56 :: 		void main() {
SUB	SP, SP, #4
;Multimedia_Client.c,57 :: 		UI_Setup();
BL	_UI_Setup+0
;Multimedia_Client.c,59 :: 		CountdownTimer = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_CountdownTimer+0)
MOVT	R0, #hi_addr(_CountdownTimer+0)
STRB	R1, [R0, #0]
;Multimedia_Client.c,60 :: 		FetchCID = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_FetchCID+0)
MOVT	R0, #hi_addr(_FetchCID+0)
STR	R1, [R0, #0]
;Multimedia_Client.c,61 :: 		GPIO_Digital_Output(&GPIO_PORTA, _GPIO_PINMASK_ALL);
MOVS	R1, #255
MOVW	R0, #lo_addr(GPIO_PORTA+0)
MOVT	R0, #hi_addr(GPIO_PORTA+0)
BL	_GPIO_Digital_Output+0
;Multimedia_Client.c,64 :: 		NVIC_ST_RELOAD = ((Get_Fosc_kHz() * 1000) / 6) - 1;
BL	_Get_Fosc_kHz+0
MOVW	R1, #1000
MULS	R1, R0, R1
MOVS	R0, #6
UDIV	R0, R1, R0
SUBS	R1, R0, #1
MOVW	R0, #lo_addr(NVIC_ST_RELOAD+0)
MOVT	R0, #hi_addr(NVIC_ST_RELOAD+0)
STR	R1, [R0, #0]
;Multimedia_Client.c,65 :: 		NVIC_ST_CTRL_CLK_SRC_bit = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(NVIC_ST_CTRL_CLK_SRC_bit+0)
MOVT	R1, #hi_addr(NVIC_ST_CTRL_CLK_SRC_bit+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #2, #1
STR	R0, [R1, #0]
;Multimedia_Client.c,66 :: 		NVIC_ST_CTRL_ENABLE_bit = 1;
MOVW	R1, #lo_addr(NVIC_ST_CTRL_ENABLE_bit+0)
MOVT	R1, #hi_addr(NVIC_ST_CTRL_ENABLE_bit+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #0, #1
STR	R0, [R1, #0]
;Multimedia_Client.c,67 :: 		NVIC_IntEnable(IVT_FAULT_SYSTICK); // enable interrupt vector
MOVW	R0, #15
BL	_NVIC_IntEnable+0
;Multimedia_Client.c,68 :: 		NVIC_ST_CTRL_INTEN_bit = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(NVIC_ST_CTRL_INTEN_bit+0)
MOVT	R1, #hi_addr(NVIC_ST_CTRL_INTEN_bit+0)
LDR	R0, [R1, #0]
BFI	R0, R2, #1, #1
STR	R0, [R1, #0]
;Multimedia_Client.c,69 :: 		NVIC_SYS_PRI3 |= 0x00FF0000;
MOVW	R0, #lo_addr(NVIC_SYS_PRI3+0)
MOVT	R0, #hi_addr(NVIC_SYS_PRI3+0)
LDR	R0, [R0, #0]
ORR	R1, R0, #16711680
MOVW	R0, #lo_addr(NVIC_SYS_PRI3+0)
MOVT	R0, #hi_addr(NVIC_SYS_PRI3+0)
STR	R1, [R0, #0]
;Multimedia_Client.c,70 :: 		EnableInterrupts();              // enable MCU core interrupts
BL	_EnableInterrupts+0
;Multimedia_Client.c,72 :: 		UART0_Init(115200);              // Initialize UART module at 56000 bps
MOV	R0, #115200
BL	_UART0_Init+0
;Multimedia_Client.c,73 :: 		Delay_ms(100);                  // Wait for UART module to stabilize
MOVW	R7, #40703
MOVT	R7, #36
NOP
NOP
L_main6:
SUBS	R7, R7, #1
BNE	L_main6
NOP
NOP
;Multimedia_Client.c,75 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Multimedia_Client.c,76 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Multimedia_Client.c,77 :: 		UART0_Write_Text("Start");
MOVW	R0, #lo_addr(?lstr1_Multimedia_Client+0)
MOVT	R0, #hi_addr(?lstr1_Multimedia_Client+0)
BL	_UART0_Write_Text+0
;Multimedia_Client.c,78 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Multimedia_Client.c,79 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Multimedia_Client.c,81 :: 		MP3_Start();
BL	_MP3_Start+0
;Multimedia_Client.c,84 :: 		GPIO_Config(&GPIO_PORTF, _GPIO_PINMASK_2 | _GPIO_PINMASK_3, _GPIO_DIR_NO_CHANGE, _GPIO_CFG_ALT_FUNCTION | _GPIO_CFG_DRIVE_8mA | _GPIO_CFG_DIGITAL_ENABLE, _GPIO_PINCODE_1);
MOVS	R0, #1
PUSH	(R0)
MOVW	R3, #1344
MOVS	R2, #15
MOVS	R1, #12
MOVW	R0, #lo_addr(GPIO_PORTF+0)
MOVT	R0, #hi_addr(GPIO_PORTF+0)
BL	_GPIO_Config+0
ADD	SP, SP, #4
;Multimedia_Client.c,85 :: 		Ethernet_Intern_Init(myMacAddr, myIpAddr, _ETHERNET_AUTO_NEGOTIATION);
MOVS	R2, #16
MOVW	R1, #lo_addr(_myIpAddr+0)
MOVT	R1, #hi_addr(_myIpAddr+0)
MOVW	R0, #lo_addr(_myMacAddr+0)
MOVT	R0, #hi_addr(_myMacAddr+0)
BL	_Ethernet_Intern_Init+0
;Multimedia_Client.c,88 :: 		Delay_ms(2000);
MOVW	R7, #27646
MOVT	R7, #732
NOP
NOP
L_main8:
SUBS	R7, R7, #1
BNE	L_main8
NOP
NOP
NOP
NOP
;Multimedia_Client.c,89 :: 		DHCP_Finished = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_DHCP_Finished+0)
MOVT	R0, #hi_addr(_DHCP_Finished+0)
STR	R1, [R0, #0]
;Multimedia_Client.c,90 :: 		while (DHCP_Finished != 0) {
L_main10:
MOVW	R1, #lo_addr(_DHCP_Finished+0)
MOVT	R1, #hi_addr(_DHCP_Finished+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main11
;Multimedia_Client.c,91 :: 		DHCP_Finished = Ethernet_Intern_initDHCP(5);
MOVS	R0, #5
BL	_Ethernet_Intern_initDHCP+0
MOVW	R1, #lo_addr(_DHCP_Finished+0)
MOVT	R1, #hi_addr(_DHCP_Finished+0)
STR	R0, [R1, #0]
;Multimedia_Client.c,92 :: 		}
IT	AL
BAL	L_main10
L_main11:
;Multimedia_Client.c,94 :: 		UART0_Write_Text("DHCP IP: ");
MOVW	R0, #lo_addr(?lstr2_Multimedia_Client+0)
MOVT	R0, #hi_addr(?lstr2_Multimedia_Client+0)
BL	_UART0_Write_Text+0
;Multimedia_Client.c,96 :: 		memcpy(ipAddr, Ethernet_Intern_getIpAddress(), 4); // fetch IP address
BL	_Ethernet_Intern_getIpAddress+0
MOVS	R2, #4
SXTH	R2, R2
MOV	R1, R0
MOVW	R0, #lo_addr(_ipAddr+0)
MOVT	R0, #hi_addr(_ipAddr+0)
BL	_memcpy+0
;Multimedia_Client.c,97 :: 		ByteToStr(ipAddr[0], stringBuffer);
MOVW	R0, #lo_addr(_ipAddr+0)
MOVT	R0, #hi_addr(_ipAddr+0)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
BL	_ByteToStr+0
;Multimedia_Client.c,98 :: 		stringBuffer[3] = '.';
MOVS	R1, #46
MOVW	R0, #lo_addr(_stringBuffer+3)
MOVT	R0, #hi_addr(_stringBuffer+3)
STRB	R1, [R0, #0]
;Multimedia_Client.c,99 :: 		ByteToStr(ipAddr[1], stringBuffer+4);
MOVW	R0, #lo_addr(_ipAddr+1)
MOVT	R0, #hi_addr(_ipAddr+1)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_stringBuffer+4)
MOVT	R1, #hi_addr(_stringBuffer+4)
BL	_ByteToStr+0
;Multimedia_Client.c,100 :: 		stringBuffer[7] = '.';
MOVS	R1, #46
MOVW	R0, #lo_addr(_stringBuffer+7)
MOVT	R0, #hi_addr(_stringBuffer+7)
STRB	R1, [R0, #0]
;Multimedia_Client.c,101 :: 		ByteToStr(ipAddr[2], stringBuffer+8);
MOVW	R0, #lo_addr(_ipAddr+2)
MOVT	R0, #hi_addr(_ipAddr+2)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_stringBuffer+8)
MOVT	R1, #hi_addr(_stringBuffer+8)
BL	_ByteToStr+0
;Multimedia_Client.c,102 :: 		stringBuffer[11] = '.';
MOVS	R1, #46
MOVW	R0, #lo_addr(_stringBuffer+11)
MOVT	R0, #hi_addr(_stringBuffer+11)
STRB	R1, [R0, #0]
;Multimedia_Client.c,103 :: 		ByteToStr(ipAddr[3], stringBuffer+12);
MOVW	R0, #lo_addr(_ipAddr+3)
MOVT	R0, #hi_addr(_ipAddr+3)
LDRB	R0, [R0, #0]
MOVW	R1, #lo_addr(_stringBuffer+12)
MOVT	R1, #hi_addr(_stringBuffer+12)
BL	_ByteToStr+0
;Multimedia_Client.c,104 :: 		stringBuffer[15] = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_stringBuffer+15)
MOVT	R0, #hi_addr(_stringBuffer+15)
STRB	R1, [R0, #0]
;Multimedia_Client.c,105 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Multimedia_Client.c,106 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Multimedia_Client.c,107 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Multimedia_Client.c,109 :: 		UI_LoadingScreen("Connecting to server");
MOVW	R0, #lo_addr(?lstr3_Multimedia_Client+0)
MOVT	R0, #hi_addr(?lstr3_Multimedia_Client+0)
BL	_UI_LoadingScreen+0
;Multimedia_Client.c,111 :: 		while (FetchCID) {
L_main12:
MOVW	R1, #lo_addr(_FetchCID+0)
MOVT	R1, #hi_addr(_FetchCID+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main13
;Multimedia_Client.c,112 :: 		Ethernet_Intern_doPacket();   // process incoming Ethernet packets
BL	_Ethernet_Intern_doPacket+0
;Multimedia_Client.c,113 :: 		if (CountdownTimer == 0)
MOVW	R0, #lo_addr(_CountdownTimer+0)
MOVT	R0, #hi_addr(_CountdownTimer+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main14
;Multimedia_Client.c,115 :: 		UDPTransmitBuffer[0] = 0xFF;
MOVS	R1, #255
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
STRB	R1, [R0, #0]
;Multimedia_Client.c,116 :: 		UDPTransmitBuffer[1] = 0x01; // Ping reply
MOVS	R1, #1
MOVW	R0, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+1)
STRB	R1, [R0, #0]
;Multimedia_Client.c,117 :: 		UDPTransmitBuffer[2] = 0; // Data length = 4
MOVS	R1, #0
MOVW	R0, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+2)
STRB	R1, [R0, #0]
;Multimedia_Client.c,118 :: 		UDPTransmitBuffer[3] = 4; // Data length = 4
MOVS	R1, #4
MOVW	R0, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+3)
STRB	R1, [R0, #0]
;Multimedia_Client.c,119 :: 		UDPTransmitBuffer[4] = UniqueDeviceID[0];
MOVW	R2, #lo_addr(_UniqueDeviceID+0)
MOVT	R2, #hi_addr(_UniqueDeviceID+0)
LDR	R0, [R2, #0]
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+4)
STRB	R1, [R0, #0]
;Multimedia_Client.c,120 :: 		UDPTransmitBuffer[5] = UniqueDeviceID[1];
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #1
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+5)
STRB	R1, [R0, #0]
;Multimedia_Client.c,121 :: 		UDPTransmitBuffer[6] = UniqueDeviceID[2];
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+6)
STRB	R1, [R0, #0]
;Multimedia_Client.c,122 :: 		UDPTransmitBuffer[7] = UniqueDeviceID[3];
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #3
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+7)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+7)
STRB	R1, [R0, #0]
;Multimedia_Client.c,123 :: 		UDPTransmitBuffer[8] = Calculate_Checksum(&UDPTransmitBuffer, 8);
MOVS	R1, #8
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R1, #lo_addr(_UDPTransmitBuffer+8)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+8)
STRB	R0, [R1, #0]
;Multimedia_Client.c,124 :: 		Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 9);
MOVS	R1, #9
MOVW	R0, #lo_addr(_serverIpAddr+0)
MOVT	R0, #hi_addr(_serverIpAddr+0)
PUSH	(R1)
MOVW	R3, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+0)
MOVW	R2, _serverPort
MOVW	R1, _localClientPort
BL	_Ethernet_Intern_sendUDP+0
ADD	SP, SP, #4
;Multimedia_Client.c,125 :: 		CountdownTimer = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_CountdownTimer+0)
MOVT	R0, #hi_addr(_CountdownTimer+0)
STRB	R1, [R0, #0]
;Multimedia_Client.c,126 :: 		}
L_main14:
;Multimedia_Client.c,127 :: 		}
IT	AL
BAL	L_main12
L_main13:
;Multimedia_Client.c,129 :: 		UI_LoadingScreen("Getting files list");
MOVW	R0, #lo_addr(?lstr4_Multimedia_Client+0)
MOVT	R0, #hi_addr(?lstr4_Multimedia_Client+0)
BL	_UI_LoadingScreen+0
;Multimedia_Client.c,130 :: 		Delay_ms(1000);
MOVW	R7, #13823
MOVT	R7, #366
NOP
NOP
L_main15:
SUBS	R7, R7, #1
BNE	L_main15
NOP
NOP
;Multimedia_Client.c,131 :: 		UI_ShowMainScreen();
BL	_UI_ShowMainScreen+0
;Multimedia_Client.c,133 :: 		RequestRootFolder();
BL	_RequestRootFolder+0
;Multimedia_Client.c,134 :: 		CountdownTimer = 15;
MOVS	R1, #15
MOVW	R0, #lo_addr(_CountdownTimer+0)
MOVT	R0, #hi_addr(_CountdownTimer+0)
STRB	R1, [R0, #0]
;Multimedia_Client.c,135 :: 		while ((FolderFileRequestIDCount < FoldersFilesToReceive) || (FoldersFilesToReceive == 0)) {
L_main17:
MOVW	R0, #lo_addr(_FoldersFilesToReceive+0)
MOVT	R0, #hi_addr(_FoldersFilesToReceive+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_FolderFileRequestIDCount+0)
MOVT	R0, #hi_addr(_FolderFileRequestIDCount+0)
LDRB	R0, [R0, #0]
CMP	R0, R1
IT	CC
BCC	L__main42
MOVW	R0, #lo_addr(_FoldersFilesToReceive+0)
MOVT	R0, #hi_addr(_FoldersFilesToReceive+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__main41
IT	AL
BAL	L_main18
L__main42:
L__main41:
;Multimedia_Client.c,136 :: 		Ethernet_Intern_doPacket();   // process incoming Ethernet packets
BL	_Ethernet_Intern_doPacket+0
;Multimedia_Client.c,137 :: 		if (CountdownTimer == 0)  {
MOVW	R0, #lo_addr(_CountdownTimer+0)
MOVT	R0, #hi_addr(_CountdownTimer+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_main21
;Multimedia_Client.c,138 :: 		RequestRootFolder();
BL	_RequestRootFolder+0
;Multimedia_Client.c,139 :: 		CountdownTimer = 15;
MOVS	R1, #15
MOVW	R0, #lo_addr(_CountdownTimer+0)
MOVT	R0, #hi_addr(_CountdownTimer+0)
STRB	R1, [R0, #0]
;Multimedia_Client.c,140 :: 		}
L_main21:
;Multimedia_Client.c,141 :: 		KeepAlive_Handler(); // Make sure downloading and other things is kept alive and not stopped/paused not on purpose
BL	_KeepAlive_Handler+0
;Multimedia_Client.c,142 :: 		delay_ms(10);
MOVW	R7, #43391
MOVT	R7, #3
NOP
NOP
L_main22:
SUBS	R7, R7, #1
BNE	L_main22
NOP
NOP
;Multimedia_Client.c,143 :: 		}
IT	AL
BAL	L_main17
L_main18:
;Multimedia_Client.c,144 :: 		while (CurrentState != IDLE);
L_main24:
MOVW	R0, #lo_addr(_CurrentState+0)
MOVT	R0, #hi_addr(_CurrentState+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L_main25
IT	AL
BAL	L_main24
L_main25:
;Multimedia_Client.c,146 :: 		DownloadMode = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_DownloadMode+0)
MOVT	R0, #hi_addr(_DownloadMode+0)
STR	R1, [R0, #0]
;Multimedia_Client.c,148 :: 		while(1)
L_main26:
;Multimedia_Client.c,150 :: 		if(Ethernet_Intern_doDHCPLeaseTime())
BL	_Ethernet_Intern_doDHCPLeaseTime+0
CMP	R0, #0
IT	EQ
BEQ	L_main28
;Multimedia_Client.c,151 :: 		Ethernet_Intern_renewDHCP(5); // it's time to renew the IP address lease, with 5 secs for a reply
MOVS	R0, #5
BL	_Ethernet_Intern_renewDHCP+0
L_main28:
;Multimedia_Client.c,152 :: 		Ethernet_Intern_doPacket();   // process incoming Ethernet packets
BL	_Ethernet_Intern_doPacket+0
;Multimedia_Client.c,154 :: 		UI_Handler();
BL	_UI_Handler+0
;Multimedia_Client.c,155 :: 		KeepAlive_Handler(); // Make sure downloading and other things is kept alive and not stopped/paused not on purpose
BL	_KeepAlive_Handler+0
;Multimedia_Client.c,158 :: 		if (UART0_Data_Ready())
BL	_UART0_Data_Ready+0
CMP	R0, #0
IT	EQ
BEQ	L_main29
;Multimedia_Client.c,160 :: 		serialReceive = UART0_Read();
BL	_UART0_Read+0
MOVW	R1, #lo_addr(_serialReceive+0)
MOVT	R1, #hi_addr(_serialReceive+0)
STRB	R0, [R1, #0]
;Multimedia_Client.c,162 :: 		switch (serialReceive) {
IT	AL
BAL	L_main30
;Multimedia_Client.c,163 :: 		case 'c':
L_main32:
;Multimedia_Client.c,164 :: 		UART0_Write_Text("Check communication");
MOVW	R0, #lo_addr(?lstr5_Multimedia_Client+0)
MOVT	R0, #hi_addr(?lstr5_Multimedia_Client+0)
BL	_UART0_Write_Text+0
;Multimedia_Client.c,165 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Multimedia_Client.c,166 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Multimedia_Client.c,167 :: 		UDPTransmitBuffer[0] = 0xFF; // Empty CID (Request for new CID)
MOVS	R1, #255
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
STRB	R1, [R0, #0]
;Multimedia_Client.c,168 :: 		UDPTransmitBuffer[1] = 0x01; // Check communication (request CID) command
MOVS	R1, #1
MOVW	R0, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+1)
STRB	R1, [R0, #0]
;Multimedia_Client.c,169 :: 		UDPTransmitBuffer[2] = 4; // Data length
MOVS	R1, #4
MOVW	R0, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+2)
STRB	R1, [R0, #0]
;Multimedia_Client.c,170 :: 		UDPTransmitBuffer[3] = UniqueDeviceID[0];
MOVW	R2, #lo_addr(_UniqueDeviceID+0)
MOVT	R2, #hi_addr(_UniqueDeviceID+0)
LDR	R0, [R2, #0]
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+3)
STRB	R1, [R0, #0]
;Multimedia_Client.c,171 :: 		UDPTransmitBuffer[4] = UniqueDeviceID[1];
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #1
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+4)
STRB	R1, [R0, #0]
;Multimedia_Client.c,172 :: 		UDPTransmitBuffer[5] = UniqueDeviceID[2];
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+5)
STRB	R1, [R0, #0]
;Multimedia_Client.c,173 :: 		UDPTransmitBuffer[6] = UniqueDeviceID[3];
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #3
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+6)
STRB	R1, [R0, #0]
;Multimedia_Client.c,174 :: 		UDPTransmitBuffer[7] = Calculate_Checksum(UDPTransmitBuffer, 7);
MOVS	R1, #7
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R1, #lo_addr(_UDPTransmitBuffer+7)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+7)
STRB	R0, [R1, #0]
;Multimedia_Client.c,175 :: 		Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 8);
MOVS	R1, #8
MOVW	R0, #lo_addr(_serverIpAddr+0)
MOVT	R0, #hi_addr(_serverIpAddr+0)
PUSH	(R1)
MOVW	R3, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+0)
MOVW	R2, _serverPort
MOVW	R1, _localClientPort
BL	_Ethernet_Intern_sendUDP+0
ADD	SP, SP, #4
;Multimedia_Client.c,176 :: 		break;
IT	AL
BAL	L_main31
;Multimedia_Client.c,177 :: 		case 'l':
L_main33:
;Multimedia_Client.c,178 :: 		UART0_Write_Text("Request folders");
MOVW	R0, #lo_addr(?lstr6_Multimedia_Client+0)
MOVT	R0, #hi_addr(?lstr6_Multimedia_Client+0)
BL	_UART0_Write_Text+0
;Multimedia_Client.c,179 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Multimedia_Client.c,180 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Multimedia_Client.c,181 :: 		RequestRootFolder();
BL	_RequestRootFolder+0
;Multimedia_Client.c,182 :: 		break;
IT	AL
BAL	L_main31
;Multimedia_Client.c,183 :: 		case 'f':
L_main34:
;Multimedia_Client.c,184 :: 		UART0_Write_Text("Request file #1");
MOVW	R0, #lo_addr(?lstr7_Multimedia_Client+0)
MOVT	R0, #hi_addr(?lstr7_Multimedia_Client+0)
BL	_UART0_Write_Text+0
;Multimedia_Client.c,185 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Multimedia_Client.c,186 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Multimedia_Client.c,187 :: 		PlayAudio(1);
MOVS	R0, #1
BL	_PlayAudio+0
;Multimedia_Client.c,188 :: 		break;
IT	AL
BAL	L_main31
;Multimedia_Client.c,189 :: 		case 's':
L_main35:
;Multimedia_Client.c,190 :: 		UART0_Write_Text("Stopping...");
MOVW	R0, #lo_addr(?lstr8_Multimedia_Client+0)
MOVT	R0, #hi_addr(?lstr8_Multimedia_Client+0)
BL	_UART0_Write_Text+0
;Multimedia_Client.c,191 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Multimedia_Client.c,192 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Multimedia_Client.c,193 :: 		CurrentState = IDLE;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CurrentState+0)
MOVT	R0, #hi_addr(_CurrentState+0)
STRB	R1, [R0, #0]
;Multimedia_Client.c,194 :: 		break;
IT	AL
BAL	L_main31
;Multimedia_Client.c,195 :: 		case 'r':
L_main36:
;Multimedia_Client.c,196 :: 		UART0_Write_Text("Re-leasing Client ID");
MOVW	R0, #lo_addr(?lstr9_Multimedia_Client+0)
MOVT	R0, #hi_addr(?lstr9_Multimedia_Client+0)
BL	_UART0_Write_Text+0
;Multimedia_Client.c,197 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Multimedia_Client.c,198 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Multimedia_Client.c,199 :: 		ReLeaseCID();
BL	_ReLeaseCID+0
;Multimedia_Client.c,200 :: 		break;
IT	AL
BAL	L_main31
;Multimedia_Client.c,201 :: 		}
L_main30:
MOVW	R0, #lo_addr(_serialReceive+0)
MOVT	R0, #hi_addr(_serialReceive+0)
LDRB	R0, [R0, #0]
CMP	R0, #99
IT	EQ
BEQ	L_main32
MOVW	R0, #lo_addr(_serialReceive+0)
MOVT	R0, #hi_addr(_serialReceive+0)
LDRB	R0, [R0, #0]
CMP	R0, #108
IT	EQ
BEQ	L_main33
MOVW	R0, #lo_addr(_serialReceive+0)
MOVT	R0, #hi_addr(_serialReceive+0)
LDRB	R0, [R0, #0]
CMP	R0, #102
IT	EQ
BEQ	L_main34
MOVW	R0, #lo_addr(_serialReceive+0)
MOVT	R0, #hi_addr(_serialReceive+0)
LDRB	R0, [R0, #0]
CMP	R0, #115
IT	EQ
BEQ	L_main35
MOVW	R0, #lo_addr(_serialReceive+0)
MOVT	R0, #hi_addr(_serialReceive+0)
LDRB	R0, [R0, #0]
CMP	R0, #114
IT	EQ
BEQ	L_main36
L_main31:
;Multimedia_Client.c,203 :: 		}
L_main29:
;Multimedia_Client.c,205 :: 		}
IT	AL
BAL	L_main26
;Multimedia_Client.c,206 :: 		}
L_end_main:
L__main_end_loop:
B	L__main_end_loop
; end of _main
_ReLeaseCID:
;Multimedia_Client.c,247 :: 		void ReLeaseCID()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Multimedia_Client.c,249 :: 		UDPTransmitBuffer[0] = 0xFF;
MOVS	R1, #255
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
STRB	R1, [R0, #0]
;Multimedia_Client.c,250 :: 		UDPTransmitBuffer[1] = 0x01; // Ping reply
MOVS	R1, #1
MOVW	R0, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+1)
STRB	R1, [R0, #0]
;Multimedia_Client.c,251 :: 		UDPTransmitBuffer[2] = 0; // Data length = 4
MOVS	R1, #0
MOVW	R0, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+2)
STRB	R1, [R0, #0]
;Multimedia_Client.c,252 :: 		UDPTransmitBuffer[3] = 4; // Data length = 4
MOVS	R1, #4
MOVW	R0, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+3)
STRB	R1, [R0, #0]
;Multimedia_Client.c,253 :: 		UDPTransmitBuffer[4] = UniqueDeviceID[0];
MOVW	R2, #lo_addr(_UniqueDeviceID+0)
MOVT	R2, #hi_addr(_UniqueDeviceID+0)
LDR	R0, [R2, #0]
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+4)
STRB	R1, [R0, #0]
;Multimedia_Client.c,254 :: 		UDPTransmitBuffer[5] = UniqueDeviceID[1];
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #1
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+5)
STRB	R1, [R0, #0]
;Multimedia_Client.c,255 :: 		UDPTransmitBuffer[6] = UniqueDeviceID[2];
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #2
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+6)
STRB	R1, [R0, #0]
;Multimedia_Client.c,256 :: 		UDPTransmitBuffer[7] = UniqueDeviceID[3];
MOV	R0, R2
LDR	R0, [R0, #0]
ADDS	R0, R0, #3
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+7)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+7)
STRB	R1, [R0, #0]
;Multimedia_Client.c,257 :: 		UDPTransmitBuffer[8] = Calculate_Checksum(&UDPTransmitBuffer, 8);
MOVS	R1, #8
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R1, #lo_addr(_UDPTransmitBuffer+8)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+8)
STRB	R0, [R1, #0]
;Multimedia_Client.c,258 :: 		Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 9);
MOVS	R1, #9
MOVW	R0, #lo_addr(_serverIpAddr+0)
MOVT	R0, #hi_addr(_serverIpAddr+0)
PUSH	(R1)
MOVW	R3, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+0)
MOVW	R2, _serverPort
MOVW	R1, _localClientPort
BL	_Ethernet_Intern_sendUDP+0
ADD	SP, SP, #4
;Multimedia_Client.c,259 :: 		CountdownTimer = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_CountdownTimer+0)
MOVT	R0, #hi_addr(_CountdownTimer+0)
STRB	R1, [R0, #0]
;Multimedia_Client.c,260 :: 		FetchCID = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_FetchCID+0)
MOVT	R0, #hi_addr(_FetchCID+0)
STR	R1, [R0, #0]
;Multimedia_Client.c,261 :: 		}
L_end_ReLeaseCID:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _ReLeaseCID
