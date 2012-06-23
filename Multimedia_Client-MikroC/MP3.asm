_MP3_Init:
;MP3.c,23 :: 		void MP3_Init(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MP3.c,25 :: 		XDCS = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(XDCS+0)
MOVT	R0, #hi_addr(XDCS+0)
STR	R1, [R0, #0]
;MP3.c,26 :: 		MP3_CS = 1;
MOVW	R0, #lo_addr(MP3_CS+0)
MOVT	R0, #hi_addr(MP3_CS+0)
STR	R1, [R0, #0]
;MP3.c,29 :: 		MP3_RST = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(MP3_RST+0)
MOVT	R0, #hi_addr(MP3_RST+0)
STR	R1, [R0, #0]
;MP3.c,30 :: 		Delay_ms(10);
MOVW	R7, #43391
MOVT	R7, #3
NOP
NOP
L_MP3_Init0:
SUBS	R7, R7, #1
BNE	L_MP3_Init0
NOP
NOP
;MP3.c,31 :: 		MP3_RST = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(MP3_RST+0)
MOVT	R0, #hi_addr(MP3_RST+0)
STR	R1, [R0, #0]
;MP3.c,33 :: 		while (DREQ == 0);
L_MP3_Init2:
MOVW	R1, #lo_addr(DREQ+0)
MOVT	R1, #hi_addr(DREQ+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_MP3_Init3
IT	AL
BAL	L_MP3_Init2
L_MP3_Init3:
;MP3.c,35 :: 		MP3_SCI_Write(SCI_MODE_ADDR, 0x0800);
MOVW	R1, #2048
MOVS	R0, _SCI_MODE_ADDR
BL	_MP3_SCI_Write+0
;MP3.c,36 :: 		MP3_SCI_Write(SCI_BASS_ADDR, 0x7A00);
MOVW	R1, #31232
MOVS	R0, _SCI_BASS_ADDR
BL	_MP3_SCI_Write+0
;MP3.c,38 :: 		MP3_SCI_Write(SCI_CLOCKF_ADDR, 0x2000);   // default 12 288 000 Hz
MOVW	R1, #8192
MOVS	R0, _SCI_CLOCKF_ADDR
BL	_MP3_SCI_Write+0
;MP3.c,41 :: 		volume_left  = 0; //0x3F;
MOVS	R1, #0
MOVW	R0, #lo_addr(_volume_left+0)
MOVT	R0, #hi_addr(_volume_left+0)
STRB	R1, [R0, #0]
;MP3.c,42 :: 		volume_right = 0; //0x3F;
MOVS	R1, #0
MOVW	R0, #lo_addr(_volume_right+0)
MOVT	R0, #hi_addr(_volume_right+0)
STRB	R1, [R0, #0]
;MP3.c,43 :: 		MP3_Set_Volume(volume_left, volume_right);
MOVS	R1, #0
MOVS	R0, #0
BL	_MP3_Set_Volume+0
;MP3.c,44 :: 		}
L_end_MP3_Init:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MP3_Init
_MP3_Reset:
;MP3.c,46 :: 		void MP3_Reset(void)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;MP3.c,48 :: 		MP3_RST           = 1;               // Set MP3_RST pin
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(MP3_RST+0)
MOVT	R0, #hi_addr(MP3_RST+0)
STR	R0, [SP, #4]
STR	R1, [R0, #0]
;MP3.c,52 :: 		&_GPIO_MODULE_SPI0_A245);
MOVW	R3, #lo_addr(__GPIO_MODULE_SPI0_A245+0)
MOVT	R3, #hi_addr(__GPIO_MODULE_SPI0_A245+0)
;MP3.c,51 :: 		_SPI_8_BIT | _SPI_CLK_IDLE_HIGH | _SPI_SECOND_CLK_EDGE_TRANSITION,
MOVS	R2, #199
;MP3.c,50 :: 		_SPI_MASTER,
MOVW	R1, #0
;MP3.c,49 :: 		SPI0_Init_Advanced(400000,
MOVW	R0, #6784
MOVT	R0, #6
;MP3.c,52 :: 		&_GPIO_MODULE_SPI0_A245);
BL	_SPI0_Init_Advanced+0
;MP3.c,54 :: 		XDCS = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(XDCS+0)
MOVT	R0, #hi_addr(XDCS+0)
STR	R1, [R0, #0]
;MP3.c,55 :: 		MP3_CS = 1;
MOVW	R0, #lo_addr(MP3_CS+0)
MOVT	R0, #hi_addr(MP3_CS+0)
STR	R1, [R0, #0]
;MP3.c,58 :: 		MP3_RST = 0;
MOVS	R1, #0
SXTB	R1, R1
LDR	R0, [SP, #4]
STR	R1, [R0, #0]
;MP3.c,59 :: 		Delay_ms(10);
MOVW	R7, #43391
MOVT	R7, #3
NOP
NOP
L_MP3_Reset4:
SUBS	R7, R7, #1
BNE	L_MP3_Reset4
NOP
NOP
;MP3.c,60 :: 		MP3_RST = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(MP3_RST+0)
MOVT	R0, #hi_addr(MP3_RST+0)
STR	R1, [R0, #0]
;MP3.c,61 :: 		while (DREQ == 0);
L_MP3_Reset6:
MOVW	R1, #lo_addr(DREQ+0)
MOVT	R1, #hi_addr(DREQ+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_MP3_Reset7
IT	AL
BAL	L_MP3_Reset6
L_MP3_Reset7:
;MP3.c,63 :: 		MP3_SCI_Write(SCI_MODE_ADDR, 0x0800);
MOVW	R1, #2048
MOVS	R0, _SCI_MODE_ADDR
BL	_MP3_SCI_Write+0
;MP3.c,64 :: 		MP3_SCI_Write(SCI_BASS_ADDR, 0x7A00);
MOVW	R1, #31232
MOVS	R0, _SCI_BASS_ADDR
BL	_MP3_SCI_Write+0
;MP3.c,65 :: 		MP3_SCI_Write(SCI_CLOCKF_ADDR, 0x2000);   // default 12 288 000 Hz
MOVW	R1, #8192
MOVS	R0, _SCI_CLOCKF_ADDR
BL	_MP3_SCI_Write+0
;MP3.c,67 :: 		volume_left  = 0; //0x3F;
MOVS	R1, #0
MOVW	R0, #lo_addr(_volume_left+0)
MOVT	R0, #hi_addr(_volume_left+0)
STRB	R1, [R0, #0]
;MP3.c,68 :: 		volume_right = 0; //0x3F;
MOVS	R1, #0
MOVW	R0, #lo_addr(_volume_right+0)
MOVT	R0, #hi_addr(_volume_right+0)
STRB	R1, [R0, #0]
;MP3.c,69 :: 		MP3_Set_Volume(volume_left, volume_right);
MOVS	R1, #0
MOVS	R0, #0
BL	_MP3_Set_Volume+0
;MP3.c,70 :: 		}
L_end_MP3_Reset:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _MP3_Reset
_MP3_Start:
;MP3.c,79 :: 		void MP3_Start(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MP3.c,82 :: 		GPIO_Digital_Output(&GPIO_PORTA, _GPIO_PINMASK_7);
MOVS	R1, #128
MOVW	R0, #lo_addr(GPIO_PORTA+0)
MOVT	R0, #hi_addr(GPIO_PORTA+0)
BL	_GPIO_Digital_Output+0
;MP3.c,85 :: 		GPIO_Digital_Output(&GPIO_PORTF, _GPIO_PINMASK_5);
MOVS	R1, #32
MOVW	R0, #lo_addr(GPIO_PORTF+0)
MOVT	R0, #hi_addr(GPIO_PORTF+0)
BL	_GPIO_Digital_Output+0
;MP3.c,86 :: 		GPIO_Digital_Input (&GPIO_PORTF, _GPIO_PINMASK_4);
MOVS	R1, #16
MOVW	R0, #lo_addr(GPIO_PORTF+0)
MOVT	R0, #hi_addr(GPIO_PORTF+0)
BL	_GPIO_Digital_Input+0
;MP3.c,87 :: 		GPIO_Digital_Output(&GPIO_PORTF, _GPIO_PINMASK_0);
MOVS	R1, #1
MOVW	R0, #lo_addr(GPIO_PORTF+0)
MOVT	R0, #hi_addr(GPIO_PORTF+0)
BL	_GPIO_Digital_Output+0
;MP3.c,88 :: 		GPIO_Digital_Output(&GPIO_PORTF, _GPIO_PINMASK_1);
MOVS	R1, #2
MOVW	R0, #lo_addr(GPIO_PORTF+0)
MOVT	R0, #hi_addr(GPIO_PORTF+0)
BL	_GPIO_Digital_Output+0
;MP3.c,90 :: 		MP3_CS_Direction  = 1;               // Configure MP3_CS as output
MOVS	R2, #1
SXTB	R2, R2
MOVW	R0, #lo_addr(MP3_CS_Direction+0)
MOVT	R0, #hi_addr(MP3_CS_Direction+0)
STR	R2, [R0, #0]
;MP3.c,91 :: 		MP3_CS            = 1;               // Deselect MP3_CS
MOVW	R0, #lo_addr(MP3_CS+0)
MOVT	R0, #hi_addr(MP3_CS+0)
STR	R2, [R0, #0]
;MP3.c,92 :: 		MP3_RST_Direction = 1;               // Configure MP3_RST as output
MOVW	R0, #lo_addr(MP3_RST_Direction+0)
MOVT	R0, #hi_addr(MP3_RST_Direction+0)
STR	R2, [R0, #0]
;MP3.c,93 :: 		MP3_RST           = 1;               // Set MP3_RST pin
MOVW	R0, #lo_addr(MP3_RST+0)
MOVT	R0, #hi_addr(MP3_RST+0)
STR	R2, [R0, #0]
;MP3.c,95 :: 		DREQ_Direction    = 0;               // Configure DREQ as input
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(DREQ_Direction+0)
MOVT	R0, #hi_addr(DREQ_Direction+0)
STR	R1, [R0, #0]
;MP3.c,96 :: 		XDCS_Direction   = 1;               // Configure XDCS as output
MOVW	R0, #lo_addr(XDCS_Direction+0)
MOVT	R0, #hi_addr(XDCS_Direction+0)
STR	R2, [R0, #0]
;MP3.c,97 :: 		XDCS             = 0;               // Clear XDCS
MOVW	R0, #lo_addr(XDCS+0)
MOVT	R0, #hi_addr(XDCS+0)
STR	R1, [R0, #0]
;MP3.c,98 :: 		XDCS             = 1;               // Clear XDCS
STR	R2, [R0, #0]
;MP3.c,101 :: 		SPI0_Init_Advanced(2000000, _SPI_MASTER, _SPI_8_BIT, &_GPIO_MODULE_SPI0_A245);
MOVW	R3, #lo_addr(__GPIO_MODULE_SPI0_A245+0)
MOVT	R3, #hi_addr(__GPIO_MODULE_SPI0_A245+0)
MOVW	R2, #7
MOVW	R1, #0
MOVW	R0, #33920
MOVT	R0, #30
BL	_SPI0_Init_Advanced+0
;MP3.c,103 :: 		MP3_Init();
BL	_MP3_Init+0
;MP3.c,104 :: 		Delay_ms(1000);
MOVW	R7, #13823
MOVT	R7, #366
NOP
NOP
L_MP3_Start8:
SUBS	R7, R7, #1
BNE	L_MP3_Start8
NOP
NOP
;MP3.c,105 :: 		MP3_InitSDBuffer();
BL	_MP3_InitSDBuffer+0
;MP3.c,106 :: 		Delay_ms(1000);
MOVW	R7, #13823
MOVT	R7, #366
NOP
NOP
L_MP3_Start10:
SUBS	R7, R7, #1
BNE	L_MP3_Start10
NOP
NOP
;MP3.c,107 :: 		}
L_end_MP3_Start:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MP3_Start
_MP3_FinishedPlayback:
;MP3.c,109 :: 		void MP3_FinishedPlayback(void)
SUB	SP, SP, #12
STR	LR, [SP, #0]
;MP3.c,117 :: 		endFillByte = MP3_wram_read(MP3_para_endFillByte);
MOVW	R0, _MP3_para_endFillByte
BL	_MP3_wram_read+0
;MP3.c,119 :: 		endFillByte = endFillByte ^ 0x00FF;
UXTB	R0, R0
EOR	R0, R0, #255
STRB	R0, [SP, #8]
;MP3.c,120 :: 		for (n = 0; n < 2052; n++)
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [SP, #4]
L_MP3_FinishedPlayback12:
LDRSH	R1, [SP, #4]
MOVW	R0, #2052
CMP	R1, R0
IT	GE
BGE	L_MP3_FinishedPlayback13
;MP3.c,121 :: 		MP3_SDI_Write(endFillByte);
LDRB	R0, [SP, #8]
BL	_MP3_SDI_Write+0
;MP3.c,120 :: 		for (n = 0; n < 2052; n++)
LDRSH	R0, [SP, #4]
ADDS	R0, R0, #1
STRH	R0, [SP, #4]
;MP3.c,121 :: 		MP3_SDI_Write(endFillByte);
IT	AL
BAL	L_MP3_FinishedPlayback12
L_MP3_FinishedPlayback13:
;MP3.c,124 :: 		sciModeByte = MP3_SCI_ReadSingle(SCI_MODE_ADDR);
MOVS	R0, _SCI_MODE_ADDR
BL	_MP3_SCI_ReadSingle+0
;MP3.c,125 :: 		sciModeByte |= SM_CANCEL;
ORR	R0, R0, #8
STRH	R0, [SP, #10]
;MP3.c,126 :: 		MP3_SCI_Write(SCI_MODE_ADDR, sciModeByte);
UXTH	R1, R0
MOVS	R0, _SCI_MODE_ADDR
BL	_MP3_SCI_Write+0
;MP3.c,129 :: 		for (i = 0; i < 64; i++)
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [SP, #6]
L_MP3_FinishedPlayback15:
LDRSH	R0, [SP, #6]
CMP	R0, #64
IT	GE
BGE	L_MP3_FinishedPlayback16
;MP3.c,132 :: 		for (n = 0; n < 32; n++)
MOVS	R0, #0
SXTH	R0, R0
STRH	R0, [SP, #4]
L_MP3_FinishedPlayback18:
LDRSH	R0, [SP, #4]
CMP	R0, #32
IT	GE
BGE	L_MP3_FinishedPlayback19
;MP3.c,133 :: 		MP3_SDI_Write(endFillByte);
LDRB	R0, [SP, #8]
BL	_MP3_SDI_Write+0
;MP3.c,132 :: 		for (n = 0; n < 32; n++)
LDRSH	R0, [SP, #4]
ADDS	R0, R0, #1
STRH	R0, [SP, #4]
;MP3.c,133 :: 		MP3_SDI_Write(endFillByte);
IT	AL
BAL	L_MP3_FinishedPlayback18
L_MP3_FinishedPlayback19:
;MP3.c,135 :: 		sciModeByte = MP3_SCI_ReadSingle(SCI_MODE_ADDR);
MOVS	R0, _SCI_MODE_ADDR
BL	_MP3_SCI_ReadSingle+0
STRH	R0, [SP, #10]
;MP3.c,136 :: 		if ((sciModeByte & SM_CANCEL) == 0x0000)
AND	R0, R0, #8
UXTH	R0, R0
CMP	R0, #0
IT	NE
BNE	L_MP3_FinishedPlayback21
;MP3.c,138 :: 		break;
IT	AL
BAL	L_MP3_FinishedPlayback16
;MP3.c,139 :: 		}
L_MP3_FinishedPlayback21:
;MP3.c,129 :: 		for (i = 0; i < 64; i++)
LDRSH	R0, [SP, #6]
ADDS	R0, R0, #1
STRH	R0, [SP, #6]
;MP3.c,140 :: 		}
IT	AL
BAL	L_MP3_FinishedPlayback15
L_MP3_FinishedPlayback16:
;MP3.c,142 :: 		if ((sciModeByte & SM_CANCEL) == 0x0000)
LDRH	R0, [SP, #10]
AND	R0, R0, #8
UXTH	R0, R0
CMP	R0, #0
IT	NE
BNE	L_MP3_FinishedPlayback22
;MP3.c,146 :: 		UART0_Write_Text("Song sucessfully sent. Terminating OK");
MOVW	R0, #lo_addr(?lstr1_MP3+0)
MOVT	R0, #hi_addr(?lstr1_MP3+0)
BL	_UART0_Write_Text+0
;MP3.c,147 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;MP3.c,148 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;MP3.c,149 :: 		MP3_SCI_Write(SCI_DECODE_TIME_ADDR, 0x0000);
MOVS	R1, #0
MOVS	R0, _SCI_DECODE_TIME_ADDR
BL	_MP3_SCI_Write+0
;MP3.c,150 :: 		}
IT	AL
BAL	L_MP3_FinishedPlayback23
L_MP3_FinishedPlayback22:
;MP3.c,155 :: 		UART0_Write_Text("SM CANCEL hasn't cleared after sending 2048 bytes, do software reset");
MOVW	R0, #lo_addr(?lstr2_MP3+0)
MOVT	R0, #hi_addr(?lstr2_MP3+0)
BL	_UART0_Write_Text+0
;MP3.c,156 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;MP3.c,157 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;MP3.c,158 :: 		MP3_Reset();
BL	_MP3_Reset+0
;MP3.c,159 :: 		}
L_MP3_FinishedPlayback23:
;MP3.c,160 :: 		}
L_end_MP3_FinishedPlayback:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _MP3_FinishedPlayback
_MP3_StopPlayback:
;MP3.c,162 :: 		void MP3_StopPlayback(void)
SUB	SP, SP, #12
STR	LR, [SP, #0]
;MP3.c,164 :: 		unsigned char firstBuffer = CurrentBuffer;
MOVW	R1, #lo_addr(_CurrentBuffer+0)
MOVT	R1, #hi_addr(_CurrentBuffer+0)
LDR	R0, [R1, #0]
STRB	R0, [SP, #6]
;MP3.c,165 :: 		char readyToBreak = 0;
MOVS	R0, #0
STRB	R0, [SP, #9]
;MP3.c,170 :: 		sciModeByte = MP3_SCI_ReadSingle(SCI_MODE_ADDR);
MOVS	R0, _SCI_MODE_ADDR
BL	_MP3_SCI_ReadSingle+0
;MP3.c,171 :: 		sciModeByte |= SM_CANCEL;
UXTB	R0, R0
ORR	R0, R0, #8
UXTB	R0, R0
STRB	R0, [SP, #8]
;MP3.c,172 :: 		MP3_SCI_Write(SCI_MODE_ADDR, sciModeByte);
UXTB	R1, R0
MOVS	R0, _SCI_MODE_ADDR
BL	_MP3_SCI_Write+0
;MP3.c,175 :: 		while ((readyToBreak == 0) || (readyToBreak == 1 && CurrentBuffer == firstBuffer))
L_MP3_StopPlayback24:
LDRB	R0, [SP, #9]
CMP	R0, #0
IT	EQ
BEQ	L__MP3_StopPlayback52
LDRB	R0, [SP, #9]
CMP	R0, #1
IT	NE
BNE	L__MP3_StopPlayback51
MOVW	R0, #lo_addr(_CurrentBuffer+0)
MOVT	R0, #hi_addr(_CurrentBuffer+0)
LDR	R1, [R0, #0]
LDRB	R0, [SP, #6]
CMP	R1, R0
IT	NE
BNE	L__MP3_StopPlayback50
IT	AL
BAL	L__MP3_StopPlayback48
L__MP3_StopPlayback51:
L__MP3_StopPlayback50:
IT	AL
BAL	L_MP3_StopPlayback25
L__MP3_StopPlayback48:
L__MP3_StopPlayback52:
;MP3.c,177 :: 		Ethernet_Intern_doPacket();   // process incoming Ethernet packets
BL	_Ethernet_Intern_doPacket+0
;MP3.c,179 :: 		sciModeByte = MP3_SCI_ReadSingle(SCI_MODE_ADDR);
MOVS	R0, _SCI_MODE_ADDR
BL	_MP3_SCI_ReadSingle+0
STRB	R0, [SP, #8]
;MP3.c,180 :: 		if ((sciModeByte & SM_CANCEL) == 0x0000)
UXTB	R0, R0
AND	R0, R0, #8
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_MP3_StopPlayback30
;MP3.c,182 :: 		break;
IT	AL
BAL	L_MP3_StopPlayback25
;MP3.c,183 :: 		}
L_MP3_StopPlayback30:
;MP3.c,184 :: 		if (CurrentBuffer != firstBuffer) readyToBreak = 1;
MOVW	R0, #lo_addr(_CurrentBuffer+0)
MOVT	R0, #hi_addr(_CurrentBuffer+0)
LDR	R1, [R0, #0]
LDRB	R0, [SP, #6]
CMP	R1, R0
IT	EQ
BEQ	L_MP3_StopPlayback31
MOVS	R0, #1
STRB	R0, [SP, #9]
L_MP3_StopPlayback31:
;MP3.c,185 :: 		}
IT	AL
BAL	L_MP3_StopPlayback24
L_MP3_StopPlayback25:
;MP3.c,187 :: 		if ((sciModeByte & SM_CANCEL) == 0x0000)
LDRB	R0, [SP, #8]
AND	R0, R0, #8
UXTB	R0, R0
CMP	R0, #0
IT	NE
BNE	L_MP3_StopPlayback32
;MP3.c,191 :: 		endFillByte = MP3_wram_read(MP3_para_endFillByte);
MOVW	R0, _MP3_para_endFillByte
BL	_MP3_wram_read+0
;MP3.c,193 :: 		endFillByte = endFillByte ^0x00FF;
UXTB	R0, R0
EOR	R0, R0, #255
STRB	R0, [SP, #7]
;MP3.c,194 :: 		for (n = 0; n < 2052; n++)
; n start address is: 8 (R2)
MOVS	R2, #0
SXTH	R2, R2
; n end address is: 8 (R2)
SXTH	R1, R2
L_MP3_StopPlayback33:
; n start address is: 4 (R1)
MOVW	R0, #2052
CMP	R1, R0
IT	GE
BGE	L_MP3_StopPlayback34
;MP3.c,195 :: 		MP3_SDI_Write(endFillByte);
STRH	R1, [SP, #4]
LDRB	R0, [SP, #7]
BL	_MP3_SDI_Write+0
LDRSH	R1, [SP, #4]
;MP3.c,194 :: 		for (n = 0; n < 2052; n++)
ADDS	R0, R1, #1
; n end address is: 4 (R1)
; n start address is: 8 (R2)
SXTH	R2, R0
;MP3.c,195 :: 		MP3_SDI_Write(endFillByte);
SXTH	R1, R2
; n end address is: 8 (R2)
IT	AL
BAL	L_MP3_StopPlayback33
L_MP3_StopPlayback34:
;MP3.c,198 :: 		UART0_Write_Text("Song sucessfully stopped.");
MOVW	R0, #lo_addr(?lstr3_MP3+0)
MOVT	R0, #hi_addr(?lstr3_MP3+0)
BL	_UART0_Write_Text+0
;MP3.c,199 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;MP3.c,200 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;MP3.c,201 :: 		MP3_SCI_Write(SCI_DECODE_TIME_ADDR, 0x0000);
MOVS	R1, #0
MOVS	R0, _SCI_DECODE_TIME_ADDR
BL	_MP3_SCI_Write+0
;MP3.c,202 :: 		}
IT	AL
BAL	L_MP3_StopPlayback36
L_MP3_StopPlayback32:
;MP3.c,207 :: 		UART0_Write_Text("SM CANCEL hasn't cleared after sending 2048 bytes, do software reset");
MOVW	R0, #lo_addr(?lstr4_MP3+0)
MOVT	R0, #hi_addr(?lstr4_MP3+0)
BL	_UART0_Write_Text+0
;MP3.c,208 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;MP3.c,209 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;MP3.c,210 :: 		MP3_Reset();
BL	_MP3_Reset+0
;MP3.c,211 :: 		}
L_MP3_StopPlayback36:
;MP3.c,212 :: 		}
L_end_MP3_StopPlayback:
LDR	LR, [SP, #0]
ADD	SP, SP, #12
BX	LR
; end of _MP3_StopPlayback
_MP3_InitSDBuffer:
;MP3.c,214 :: 		void MP3_InitSDBuffer(void)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;MP3.c,217 :: 		unsigned char ErrCount = 0;
MOVS	R0, #0
STRB	R0, [SP, #4]
;MP3.c,224 :: 		&_GPIO_MODULE_SPI0_A245);
MOVW	R3, #lo_addr(__GPIO_MODULE_SPI0_A245+0)
MOVT	R3, #hi_addr(__GPIO_MODULE_SPI0_A245+0)
;MP3.c,223 :: 		_SPI_8_BIT | _SPI_CLK_IDLE_HIGH | _SPI_SECOND_CLK_EDGE_TRANSITION,
MOVS	R2, #199
;MP3.c,222 :: 		_SPI_MASTER,
MOVW	R1, #0
;MP3.c,221 :: 		SPI0_Init_Advanced(400000,
MOVW	R0, #6784
MOVT	R0, #6
;MP3.c,224 :: 		&_GPIO_MODULE_SPI0_A245);
BL	_SPI0_Init_Advanced+0
;MP3.c,226 :: 		SDSave_Disabled = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(_SDSave_Disabled+0)
MOVT	R0, #hi_addr(_SDSave_Disabled+0)
STR	R1, [R0, #0]
;MP3.c,232 :: 		err = FAT32_Init();
BL	_FAT32_Init+0
; err start address is: 4 (R1)
SXTB	R1, R0
;MP3.c,234 :: 		if (err < 0)        //
CMP	R0, #0
IT	GE
BGE	L_MP3_InitSDBuffer37
; err end address is: 4 (R1)
;MP3.c,236 :: 		while(err < 0 && ErrCount < 5)  //  ...retry each half second
L_MP3_InitSDBuffer38:
; err start address is: 4 (R1)
CMP	R1, #0
IT	GE
BGE	L__MP3_InitSDBuffer47
; err end address is: 4 (R1)
LDRB	R0, [SP, #4]
CMP	R0, #5
IT	CS
BCS	L__MP3_InitSDBuffer46
L__MP3_InitSDBuffer45:
;MP3.c,238 :: 		err = FAT32_Init();
BL	_FAT32_Init+0
; err start address is: 4 (R1)
SXTB	R1, R0
;MP3.c,239 :: 		Delay_ms(500);
MOVW	R7, #6910
MOVT	R7, #183
NOP
NOP
L_MP3_InitSDBuffer42:
SUBS	R7, R7, #1
BNE	L_MP3_InitSDBuffer42
NOP
NOP
NOP
NOP
;MP3.c,240 :: 		ErrCount++;
LDRB	R0, [SP, #4]
ADDS	R0, R0, #1
STRB	R0, [SP, #4]
;MP3.c,241 :: 		}
; err end address is: 4 (R1)
IT	AL
BAL	L_MP3_InitSDBuffer38
;MP3.c,236 :: 		while(err < 0 && ErrCount < 5)  //  ...retry each half second
L__MP3_InitSDBuffer47:
L__MP3_InitSDBuffer46:
;MP3.c,242 :: 		}
L_MP3_InitSDBuffer37:
;MP3.c,244 :: 		if (ErrCount >= 5)
LDRB	R0, [SP, #4]
CMP	R0, #5
IT	CC
BCC	L_MP3_InitSDBuffer44
;MP3.c,245 :: 		SDSave_Disabled = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(_SDSave_Disabled+0)
MOVT	R0, #hi_addr(_SDSave_Disabled+0)
STR	R1, [R0, #0]
L_MP3_InitSDBuffer44:
;MP3.c,250 :: 		&_GPIO_MODULE_SPI0_A245);
MOVW	R3, #lo_addr(__GPIO_MODULE_SPI0_A245+0)
MOVT	R3, #hi_addr(__GPIO_MODULE_SPI0_A245+0)
;MP3.c,249 :: 		_SPI_8_BIT | _SPI_CLK_IDLE_HIGH | _SPI_SECOND_CLK_EDGE_TRANSITION,
MOVS	R2, #199
;MP3.c,248 :: 		_SPI_MASTER,
MOVW	R1, #0
;MP3.c,247 :: 		SPI0_Init_Advanced(10000000,
MOVW	R0, #38528
MOVT	R0, #152
;MP3.c,250 :: 		&_GPIO_MODULE_SPI0_A245);
BL	_SPI0_Init_Advanced+0
;MP3.c,251 :: 		}
L_end_MP3_InitSDBuffer:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _MP3_InitSDBuffer
