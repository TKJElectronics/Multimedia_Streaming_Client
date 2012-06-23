_MP3_SCI_Write:
;MP3_driver.c,78 :: 		void MP3_SCI_Write(char address, unsigned int data_in) {
; address start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;MP3_driver.c,79 :: 		XDCS = 1;
UXTB	R4, R0
STRH	R1, [SP, #4]
; address end address is: 0 (R0)
; address start address is: 16 (R4)
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R2, #hi_addr(GPIO_PORTF_DATA+0)
STR	R3, [R2, #0]
;MP3_driver.c,81 :: 		MP3_CS = 0;                    // select MP3 SCI
MOVS	R3, #0
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R2, #hi_addr(GPIO_PORTF_DATA+0)
STR	R3, [R2, #0]
;MP3_driver.c,82 :: 		SPI0_Write(WRITE_CODE);
MOVS	R0, #2
BL	_SPI0_Write+0
;MP3_driver.c,83 :: 		SPI0_Write(address);
UXTB	R0, R4
; address end address is: 16 (R4)
BL	_SPI0_Write+0
;MP3_driver.c,84 :: 		SPI0_Write(Hi(data_in));       // high byte
ADD	R2, SP, #4
ADDS	R2, R2, #1
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_SPI0_Write+0
;MP3_driver.c,85 :: 		SPI0_Write(Lo(data_in));       // low byte
ADD	R2, SP, #4
LDRB	R2, [R2, #0]
UXTH	R0, R2
BL	_SPI0_Write+0
;MP3_driver.c,86 :: 		MP3_CS = 1;                    // deselect MP3 SCI
MOVS	R3, #1
SXTB	R3, R3
MOVW	R2, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R2, #hi_addr(GPIO_PORTF_DATA+0)
STR	R3, [R2, #0]
;MP3_driver.c,87 :: 		while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
L_MP3_SCI_Write0:
MOVW	R3, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R3, #hi_addr(GPIO_PORTF_DATA+0)
LDR	R2, [R3, #0]
CMP	R2, #0
IT	NE
BNE	L_MP3_SCI_Write1
IT	AL
BAL	L_MP3_SCI_Write0
L_MP3_SCI_Write1:
;MP3_driver.c,88 :: 		}
L_end_MP3_SCI_Write:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _MP3_SCI_Write
_MP3_SCI_Read:
;MP3_driver.c,97 :: 		void MP3_SCI_Read(char start_address, char words_count, unsigned int *data_buffer) {
; data_buffer start address is: 8 (R2)
; words_count start address is: 4 (R1)
; start_address start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MP3_driver.c,100 :: 		MP3_CS = 0;                    // select MP3 SCI
UXTB	R5, R0
UXTB	R6, R1
MOV	R7, R2
; data_buffer end address is: 8 (R2)
; words_count end address is: 4 (R1)
; start_address end address is: 0 (R0)
; start_address start address is: 20 (R5)
; words_count start address is: 24 (R6)
; data_buffer start address is: 28 (R7)
MOVS	R4, #0
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R3, #hi_addr(GPIO_PORTF_DATA+0)
STR	R4, [R3, #0]
;MP3_driver.c,101 :: 		SPI0_Write(READ_CODE);
MOVS	R0, #3
BL	_SPI0_Write+0
;MP3_driver.c,102 :: 		SPI0_Write(start_address);
UXTB	R0, R5
; start_address end address is: 20 (R5)
BL	_SPI0_Write+0
; words_count end address is: 24 (R6)
; data_buffer end address is: 28 (R7)
UXTB	R0, R6
MOV	R6, R7
;MP3_driver.c,104 :: 		while (words_count--) {        // read words_count words byte per byte
L_MP3_SCI_Read2:
; data_buffer start address is: 24 (R6)
; words_count start address is: 20 (R5)
; words_count start address is: 0 (R0)
UXTB	R4, R0
SUBS	R3, R0, #1
; words_count end address is: 0 (R0)
; words_count start address is: 20 (R5)
UXTB	R5, R3
; words_count end address is: 20 (R5)
CMP	R4, #0
IT	EQ
BEQ	L_MP3_SCI_Read3
; words_count end address is: 20 (R5)
;MP3_driver.c,105 :: 		temp = SPI0_Read(0);
; words_count start address is: 20 (R5)
MOVS	R0, #0
BL	_SPI0_Read+0
;MP3_driver.c,106 :: 		temp <<= 8;
LSLS	R3, R0, #8
; temp start address is: 16 (R4)
UXTH	R4, R3
;MP3_driver.c,107 :: 		temp += SPI0_Read(0);
MOVS	R0, #0
BL	_SPI0_Read+0
ADDS	R3, R4, R0
; temp end address is: 16 (R4)
;MP3_driver.c,108 :: 		*(data_buffer++) = temp;
STRH	R3, [R6, #0]
ADDS	R6, R6, #2
;MP3_driver.c,109 :: 		}
UXTB	R0, R5
; words_count end address is: 20 (R5)
; data_buffer end address is: 24 (R6)
IT	AL
BAL	L_MP3_SCI_Read2
L_MP3_SCI_Read3:
;MP3_driver.c,110 :: 		MP3_CS = 1;                    // deselect MP3 SCI
MOVS	R4, #1
SXTB	R4, R4
MOVW	R3, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R3, #hi_addr(GPIO_PORTF_DATA+0)
STR	R4, [R3, #0]
;MP3_driver.c,111 :: 		while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
L_MP3_SCI_Read4:
MOVW	R4, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R4, #hi_addr(GPIO_PORTF_DATA+0)
LDR	R3, [R4, #0]
CMP	R3, #0
IT	NE
BNE	L_MP3_SCI_Read5
IT	AL
BAL	L_MP3_SCI_Read4
L_MP3_SCI_Read5:
;MP3_driver.c,112 :: 		}
L_end_MP3_SCI_Read:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MP3_SCI_Read
_MP3_SCI_ReadSingle:
;MP3_driver.c,114 :: 		unsigned int MP3_SCI_ReadSingle(char address) {
; address start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MP3_driver.c,117 :: 		MP3_CS = 0;                    // select MP3 SCI
; address end address is: 0 (R0)
; address start address is: 0 (R0)
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R1, #hi_addr(GPIO_PORTF_DATA+0)
STR	R2, [R1, #0]
; address end address is: 0 (R0)
UXTB	R3, R0
;MP3_driver.c,118 :: 		while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
L_MP3_SCI_ReadSingle6:
; address start address is: 12 (R3)
MOVW	R2, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R2, #hi_addr(GPIO_PORTF_DATA+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_MP3_SCI_ReadSingle7
IT	AL
BAL	L_MP3_SCI_ReadSingle6
L_MP3_SCI_ReadSingle7:
;MP3_driver.c,119 :: 		SPI0_Write(READ_CODE);
MOVS	R0, #3
BL	_SPI0_Write+0
;MP3_driver.c,120 :: 		SPI0_Write(address);
UXTB	R0, R3
; address end address is: 12 (R3)
BL	_SPI0_Write+0
;MP3_driver.c,122 :: 		temp = SPI0_Read(0);
MOVS	R0, #0
BL	_SPI0_Read+0
;MP3_driver.c,123 :: 		temp <<= 8;
LSLS	R1, R0, #8
; temp start address is: 16 (R4)
UXTH	R4, R1
;MP3_driver.c,124 :: 		temp += SPI0_Read(0);
MOVS	R0, #0
BL	_SPI0_Read+0
ADDS	R3, R4, R0
; temp end address is: 16 (R4)
;MP3_driver.c,126 :: 		MP3_CS = 1;                    // deselect MP3 SCI
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R1, #hi_addr(GPIO_PORTF_DATA+0)
STR	R2, [R1, #0]
;MP3_driver.c,127 :: 		return temp;
UXTH	R0, R3
;MP3_driver.c,128 :: 		}
L_end_MP3_SCI_ReadSingle:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MP3_SCI_ReadSingle
_MP3_SDI_Write:
;MP3_driver.c,137 :: 		void MP3_SDI_Write(char data_) {
; data_ start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MP3_driver.c,139 :: 		MP3_CS = 1;
; data_ end address is: 0 (R0)
; data_ start address is: 0 (R0)
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R1, #hi_addr(GPIO_PORTF_DATA+0)
STR	R2, [R1, #0]
;MP3_driver.c,140 :: 		XDCS = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R1, #hi_addr(GPIO_PORTF_DATA+0)
STR	R2, [R1, #0]
; data_ end address is: 0 (R0)
;MP3_driver.c,142 :: 		while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
L_MP3_SDI_Write8:
; data_ start address is: 0 (R0)
MOVW	R2, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R2, #hi_addr(GPIO_PORTF_DATA+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_MP3_SDI_Write9
IT	AL
BAL	L_MP3_SDI_Write8
L_MP3_SDI_Write9:
;MP3_driver.c,144 :: 		SPI0_Write(data_);
; data_ end address is: 0 (R0)
BL	_SPI0_Write+0
;MP3_driver.c,145 :: 		XDCS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R1, #hi_addr(GPIO_PORTF_DATA+0)
STR	R2, [R1, #0]
;MP3_driver.c,146 :: 		}
L_end_MP3_SDI_Write:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MP3_SDI_Write
_MP3_SDI_Write_32:
;MP3_driver.c,155 :: 		void MP3_SDI_Write_32(char *data_) {
; data_ start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MP3_driver.c,158 :: 		MP3_CS = 1;
; data_ end address is: 0 (R0)
; data_ start address is: 0 (R0)
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R1, #hi_addr(GPIO_PORTF_DATA+0)
STR	R2, [R1, #0]
;MP3_driver.c,159 :: 		XDCS = 0;
MOVS	R2, #0
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R1, #hi_addr(GPIO_PORTF_DATA+0)
STR	R2, [R1, #0]
; data_ end address is: 0 (R0)
;MP3_driver.c,161 :: 		while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
L_MP3_SDI_Write_3210:
; data_ start address is: 0 (R0)
MOVW	R2, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R2, #hi_addr(GPIO_PORTF_DATA+0)
LDR	R1, [R2, #0]
CMP	R1, #0
IT	NE
BNE	L_MP3_SDI_Write_3211
IT	AL
BAL	L_MP3_SDI_Write_3210
L_MP3_SDI_Write_3211:
;MP3_driver.c,163 :: 		for (i=0; i<32; i++)
; i start address is: 16 (R4)
MOVS	R4, #0
; data_ end address is: 0 (R0)
; i end address is: 16 (R4)
MOV	R3, R0
L_MP3_SDI_Write_3212:
; i start address is: 16 (R4)
; data_ start address is: 12 (R3)
; data_ start address is: 12 (R3)
; data_ end address is: 12 (R3)
CMP	R4, #32
IT	CS
BCS	L_MP3_SDI_Write_3213
; data_ end address is: 12 (R3)
;MP3_driver.c,164 :: 		SPI0_Write(data_[i]);
; data_ start address is: 12 (R3)
ADDS	R1, R3, R4
LDRB	R1, [R1, #0]
UXTH	R0, R1
BL	_SPI0_Write+0
;MP3_driver.c,163 :: 		for (i=0; i<32; i++)
ADDS	R4, R4, #1
UXTB	R4, R4
;MP3_driver.c,164 :: 		SPI0_Write(data_[i]);
; data_ end address is: 12 (R3)
; i end address is: 16 (R4)
IT	AL
BAL	L_MP3_SDI_Write_3212
L_MP3_SDI_Write_3213:
;MP3_driver.c,166 :: 		XDCS = 1;
MOVS	R2, #1
SXTB	R2, R2
MOVW	R1, #lo_addr(GPIO_PORTF_DATA+0)
MOVT	R1, #hi_addr(GPIO_PORTF_DATA+0)
STR	R2, [R1, #0]
;MP3_driver.c,167 :: 		}
L_end_MP3_SDI_Write_32:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MP3_SDI_Write_32
_MP3_Set_Volume:
;MP3_driver.c,176 :: 		void MP3_Set_Volume(char left, char right) {
; right start address is: 4 (R1)
; left start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MP3_driver.c,179 :: 		volume = (left<<8) + right;             // calculate value
; right end address is: 4 (R1)
; left end address is: 0 (R0)
; left start address is: 0 (R0)
; right start address is: 4 (R1)
LSLS	R2, R0, #8
UXTH	R2, R2
; left end address is: 0 (R0)
ADDS	R2, R2, R1
; right end address is: 4 (R1)
;MP3_driver.c,180 :: 		MP3_SCI_Write(SCI_VOL_ADDR, volume);    // Write value to VOL register
UXTH	R1, R2
MOVS	R0, #11
BL	_MP3_SCI_Write+0
;MP3_driver.c,181 :: 		}
L_end_MP3_Set_Volume:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MP3_Set_Volume
_MP3_wram_read:
;MP3_driver.c,184 :: 		unsigned int MP3_wram_read(unsigned int address) {
; address start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MP3_driver.c,186 :: 		MP3_SCI_Write(SCI_WRAMADDR_ADDR,address);
UXTH	R6, R0
; address end address is: 0 (R0)
; address start address is: 24 (R6)
UXTH	R1, R6
MOVS	R0, #7
BL	_MP3_SCI_Write+0
;MP3_driver.c,187 :: 		tmp1=MP3_SCI_ReadSingle(SCI_WRAM_ADDR);
MOVS	R0, #6
BL	_MP3_SCI_ReadSingle+0
; tmp1 start address is: 28 (R7)
UXTH	R7, R0
;MP3_driver.c,188 :: 		MP3_SCI_Write(SCI_WRAMADDR_ADDR,address);
UXTH	R1, R6
MOVS	R0, #7
BL	_MP3_SCI_Write+0
;MP3_driver.c,189 :: 		tmp2=MP3_SCI_ReadSingle(SCI_WRAM_ADDR);
MOVS	R0, #6
BL	_MP3_SCI_ReadSingle+0
; tmp2 start address is: 20 (R5)
UXTH	R5, R0
;MP3_driver.c,190 :: 		if (tmp1==tmp2) return tmp1;
CMP	R7, R0
IT	NE
BNE	L_MP3_wram_read15
; address end address is: 24 (R6)
; tmp2 end address is: 20 (R5)
UXTH	R0, R7
; tmp1 end address is: 28 (R7)
IT	AL
BAL	L_end_MP3_wram_read
L_MP3_wram_read15:
;MP3_driver.c,191 :: 		MP3_SCI_Write(SCI_WRAMADDR_ADDR,address);
; tmp2 start address is: 20 (R5)
; address start address is: 24 (R6)
UXTH	R1, R6
MOVS	R0, #7
BL	_MP3_SCI_Write+0
;MP3_driver.c,192 :: 		tmp1=MP3_SCI_ReadSingle(SCI_WRAM_ADDR);
MOVS	R0, #6
BL	_MP3_SCI_ReadSingle+0
; tmp1 start address is: 4 (R1)
UXTH	R1, R0
;MP3_driver.c,193 :: 		if (tmp1==tmp2) return tmp1;
CMP	R0, R5
IT	NE
BNE	L_MP3_wram_read16
; address end address is: 24 (R6)
; tmp2 end address is: 20 (R5)
UXTH	R0, R1
; tmp1 end address is: 4 (R1)
IT	AL
BAL	L_end_MP3_wram_read
L_MP3_wram_read16:
;MP3_driver.c,194 :: 		MP3_SCI_Write(SCI_WRAMADDR_ADDR,address);
; tmp2 start address is: 20 (R5)
; address start address is: 24 (R6)
UXTH	R1, R6
; address end address is: 24 (R6)
MOVS	R0, #7
BL	_MP3_SCI_Write+0
;MP3_driver.c,195 :: 		tmp1=MP3_SCI_ReadSingle(SCI_WRAM_ADDR);
MOVS	R0, #6
BL	_MP3_SCI_ReadSingle+0
; tmp1 start address is: 4 (R1)
UXTH	R1, R0
;MP3_driver.c,196 :: 		if (tmp1==tmp2) return tmp1;
CMP	R0, R5
IT	NE
BNE	L_MP3_wram_read17
; tmp2 end address is: 20 (R5)
UXTH	R0, R1
; tmp1 end address is: 4 (R1)
IT	AL
BAL	L_end_MP3_wram_read
L_MP3_wram_read17:
;MP3_driver.c,197 :: 		return tmp1;
; tmp1 start address is: 4 (R1)
UXTH	R0, R1
; tmp1 end address is: 4 (R1)
;MP3_driver.c,198 :: 		}
L_end_MP3_wram_read:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MP3_wram_read
_MP3_wram_write:
;MP3_driver.c,200 :: 		void MP3_wram_write(unsigned int address, unsigned int writeData) {
; writeData start address is: 4 (R1)
; address start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;MP3_driver.c,201 :: 		MP3_SCI_Write(SCI_WRAMADDR_ADDR, address);
UXTH	R5, R1
; writeData end address is: 4 (R1)
; address end address is: 0 (R0)
; address start address is: 0 (R0)
; writeData start address is: 20 (R5)
UXTH	R1, R0
; address end address is: 0 (R0)
MOVS	R0, #7
BL	_MP3_SCI_Write+0
;MP3_driver.c,202 :: 		MP3_SCI_Write(SCI_WRAM_ADDR, writeData);
UXTH	R1, R5
; writeData end address is: 20 (R5)
MOVS	R0, #6
BL	_MP3_SCI_Write+0
;MP3_driver.c,203 :: 		return;
;MP3_driver.c,204 :: 		}
L_end_MP3_wram_write:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _MP3_wram_write
