_Ethernet_Intern_UserTCP:
;Ethernet_Handlers.c,55 :: 		unsigned int    Ethernet_Intern_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags *flags)
; flags start address is: 16 (R4)
SUB	SP, SP, #20
STR	LR, [SP, #0]
;Ethernet_Handlers.c,57 :: 		unsigned int  offset = 0;     // possition in payload buffer
LDR	R4, [SP, #20]
; flags end address is: 16 (R4)
; offset start address is: 20 (R5)
MOVW	R5, #0
;Ethernet_Handlers.c,58 :: 		offset += Ethernet_Intern_writePayloadString(httpHeader, offset);            // HTTP header
UXTH	R1, R5
MOVW	R0, #lo_addr(_httpHeader+0)
MOVT	R0, #hi_addr(_httpHeader+0)
BL	_Ethernet_Intern_writePayloadString+0
ADDS	R4, R5, R0
UXTH	R5, R4
;Ethernet_Handlers.c,59 :: 		offset += Ethernet_Intern_writePayloadString(httpMimeTypeHTML, offset);   // with text MIME type
UXTH	R1, R4
MOVW	R0, #lo_addr(_httpMimeTypeHTML+0)
MOVT	R0, #hi_addr(_httpMimeTypeHTML+0)
BL	_Ethernet_Intern_writePayloadString+0
ADDS	R4, R5, R0
UXTH	R5, R4
;Ethernet_Handlers.c,60 :: 		offset += Ethernet_Intern_writePayloadString(webpageContent, offset);   // write HTML test content
UXTH	R1, R4
MOVW	R0, #lo_addr(_webpageContent+0)
MOVT	R0, #hi_addr(_webpageContent+0)
BL	_Ethernet_Intern_writePayloadString+0
ADDS	R4, R5, R0
; offset end address is: 20 (R5)
;Ethernet_Handlers.c,61 :: 		return (offset);
UXTH	R0, R4
;Ethernet_Handlers.c,62 :: 		}
L_end_Ethernet_Intern_UserTCP:
LDR	LR, [SP, #0]
ADD	SP, SP, #20
BX	LR
; end of _Ethernet_Intern_UserTCP
_Ethernet_Intern_UserUDP:
;Ethernet_Handlers.c,75 :: 		unsigned int    Ethernet_Intern_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags *flags)
; flags start address is: 4294967295 (R1073741823)
; reqLength start address is: 12 (R3)
SUBW	SP, SP, #1524
STR	LR, [SP, #0]
;Ethernet_Handlers.c,78 :: 		unsigned char sendLength = 0;
UXTH	R5, R3
; flags end address is: 4294967295 (R1073741823)
; reqLength end address is: 12 (R3)
; reqLength start address is: 20 (R5)
; flags start address is: 16 (R4)
LDR	R4, [SP, #1524]
; flags end address is: 16 (R4)
MOVS	R4, #0
STRB	R4, [SP, #1492]
;Ethernet_Handlers.c,84 :: 		UART0_Write_Text("UDP Package received");
MOVW	R4, #lo_addr(?lstr1_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr1_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,85 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,86 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,89 :: 		if (reqLength > 1480) // maybe add something about specific port
CMP	R5, #1480
IT	LS
BLS	L_Ethernet_Intern_UserUDP0
; reqLength end address is: 20 (R5)
;Ethernet_Handlers.c,90 :: 		return 0; // something is wrong with the length - we will only receive packages up to 64 bytes
MOVS	R0, #0
IT	AL
BAL	L_end_Ethernet_Intern_UserUDP
L_Ethernet_Intern_UserUDP0:
;Ethernet_Handlers.c,92 :: 		Ethernet_Intern_readPayloadBytes(receiveBuffer, 0, reqLength);
; reqLength start address is: 20 (R5)
ADD	R4, SP, #8
UXTH	R2, R5
MOVS	R1, #0
MOV	R0, R4
BL	_Ethernet_Intern_readPayloadBytes+0
;Ethernet_Handlers.c,96 :: 		if (receiveBuffer[reqLength-1] != Calculate_Checksum(receiveBuffer, (reqLength-1)))
SUBS	R6, R5, #1
UXTH	R6, R6
; reqLength end address is: 20 (R5)
ADD	R5, SP, #8
ADDS	R4, R5, R6
LDRB	R4, [R4, #0]
STRB	R4, [SP, #1516]
UXTH	R1, R6
MOV	R0, R5
BL	_Calculate_Checksum+0
LDRB	R4, [SP, #1516]
CMP	R4, R0
IT	EQ
BEQ	L_Ethernet_Intern_UserUDP1
;Ethernet_Handlers.c,99 :: 		UART0_Write_Text("Checksum error");
MOVW	R4, #lo_addr(?lstr2_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr2_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,100 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,101 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,104 :: 		return 0; // Checksum error
MOVS	R0, #0
IT	AL
BAL	L_end_Ethernet_Intern_UserUDP
;Ethernet_Handlers.c,105 :: 		}
L_Ethernet_Intern_UserUDP1:
;Ethernet_Handlers.c,107 :: 		CID = receiveBuffer[0];
ADD	R4, SP, #8
LDRB	R5, [R4, #0]
; CID start address is: 0 (R0)
UXTB	R0, R5
;Ethernet_Handlers.c,108 :: 		if (CID != DeviceCID && CID != 0xFF)
MOVW	R4, #lo_addr(_DeviceCID+0)
MOVT	R4, #hi_addr(_DeviceCID+0)
LDRB	R4, [R4, #0]
CMP	R5, R4
IT	EQ
BEQ	L__Ethernet_Intern_UserUDP115
CMP	R0, #255
IT	EQ
BEQ	L__Ethernet_Intern_UserUDP114
; CID end address is: 0 (R0)
L__Ethernet_Intern_UserUDP113:
;Ethernet_Handlers.c,111 :: 		UART0_Write_Text(" -> Package not for us");
MOVW	R4, #lo_addr(?lstr3_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr3_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,112 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,113 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,115 :: 		return 0; // This package is not dedicated for us
MOVS	R0, #0
IT	AL
BAL	L_end_Ethernet_Intern_UserUDP
;Ethernet_Handlers.c,108 :: 		if (CID != DeviceCID && CID != 0xFF)
L__Ethernet_Intern_UserUDP115:
L__Ethernet_Intern_UserUDP114:
;Ethernet_Handlers.c,118 :: 		CMD = receiveBuffer[1];
ADD	R6, SP, #8
ADDS	R4, R6, #1
LDRB	R4, [R4, #0]
STRB	R4, [SP, #1488]
;Ethernet_Handlers.c,119 :: 		DataLength = (receiveBuffer[2] << 8) | receiveBuffer[3];
ADDS	R4, R6, #2
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
UXTH	R5, R5
ADDS	R4, R6, #3
LDRB	R4, [R4, #0]
ORR	R4, R5, R4, LSL #0
STRH	R4, [SP, #1490]
;Ethernet_Handlers.c,122 :: 		UART0_Write_Text(" -> Package CMD: ");
MOVW	R4, #lo_addr(?lstr4_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr4_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,123 :: 		ByteToStr(CMD, stringBuffer);
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
LDRB	R0, [SP, #1488]
BL	_ByteToStr+0
;Ethernet_Handlers.c,124 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,125 :: 		UART0_Write_Text(", Length: ");
MOVW	R4, #lo_addr(?lstr5_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr5_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,126 :: 		WordToStr(DataLength, stringBuffer);
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
LDRH	R0, [SP, #1490]
BL	_WordToStr+0
;Ethernet_Handlers.c,127 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,128 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,129 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,132 :: 		if (CMD == 0x0D && DataLength > 5 && CurrentState == FILE_RECEIVE && DownloadMode == 0) {
LDRB	R4, [SP, #1488]
CMP	R4, #13
IT	NE
BNE	L__Ethernet_Intern_UserUDP119
LDRH	R4, [SP, #1490]
CMP	R4, #5
IT	LS
BLS	L__Ethernet_Intern_UserUDP118
MOVW	R4, #lo_addr(_CurrentState+0)
MOVT	R4, #hi_addr(_CurrentState+0)
LDRB	R4, [R4, #0]
CMP	R4, #2
IT	NE
BNE	L__Ethernet_Intern_UserUDP117
MOVW	R5, #lo_addr(_DownloadMode+0)
MOVT	R5, #hi_addr(_DownloadMode+0)
LDR	R4, [R5, #0]
CMP	R4, #0
IT	NE
BNE	L__Ethernet_Intern_UserUDP116
L__Ethernet_Intern_UserUDP112:
;Ethernet_Handlers.c,133 :: 		if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFileID) {
ADD	R6, SP, #8
ADDS	R4, R6, #4
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
UXTH	R5, R5
ADDS	R4, R6, #5
LDRB	R4, [R4, #0]
ORRS	R5, R4
UXTH	R5, R5
MOVW	R4, #lo_addr(_CurrentFileID+0)
MOVT	R4, #hi_addr(_CurrentFileID+0)
LDRH	R4, [R4, #0]
CMP	R5, R4
IT	NE
BNE	L_Ethernet_Intern_UserUDP8
;Ethernet_Handlers.c,155 :: 		if (ReceivingCurrentPackage < ReceivingDividedPackages) {
MOVW	R4, #lo_addr(_ReceivingDividedPackages+0)
MOVT	R4, #hi_addr(_ReceivingDividedPackages+0)
LDR	R5, [R4, #0]
MOVW	R4, #lo_addr(_ReceivingCurrentPackage+0)
MOVT	R4, #hi_addr(_ReceivingCurrentPackage+0)
LDR	R4, [R4, #0]
CMP	R4, R5
IT	CS
BCS	L_Ethernet_Intern_UserUDP9
;Ethernet_Handlers.c,156 :: 		for (tempI = 0; tempI < (ReceivingFileDPL/BYTES_2_WRITE); tempI++) {
; tempI start address is: 0 (R0)
MOVS	R0, #0
; tempI end address is: 0 (R0)
L_Ethernet_Intern_UserUDP10:
; tempI start address is: 0 (R0)
MOVW	R4, #lo_addr(_ReceivingFileDPL+0)
MOVT	R4, #hi_addr(_ReceivingFileDPL+0)
LDRH	R5, [R4, #0]
MOVW	R4, _BYTES_2_WRITE
UDIV	R4, R5, R4
UXTH	R4, R4
CMP	R0, R4
IT	CS
BCS	L_Ethernet_Intern_UserUDP11
;Ethernet_Handlers.c,157 :: 		MP3_SDI_Write_32(receiveBuffer + 9 + (tempI*BYTES_2_WRITE));
ADD	R4, SP, #8
ADDW	R5, R4, #9
MOVW	R4, _BYTES_2_WRITE
MULS	R4, R0, R4
UXTH	R4, R4
ADDS	R4, R5, R4
STRH	R0, [SP, #4]
MOV	R0, R4
BL	_MP3_SDI_Write_32+0
LDRH	R0, [SP, #4]
;Ethernet_Handlers.c,156 :: 		for (tempI = 0; tempI < (ReceivingFileDPL/BYTES_2_WRITE); tempI++) {
ADDS	R0, R0, #1
UXTH	R0, R0
;Ethernet_Handlers.c,158 :: 		}
; tempI end address is: 0 (R0)
IT	AL
BAL	L_Ethernet_Intern_UserUDP10
L_Ethernet_Intern_UserUDP11:
;Ethernet_Handlers.c,159 :: 		} else {
IT	AL
BAL	L_Ethernet_Intern_UserUDP13
L_Ethernet_Intern_UserUDP9:
;Ethernet_Handlers.c,160 :: 		for (tempI = 0; tempI < (ReceivingPackageLeft/BYTES_2_WRITE); tempI++) {
; tempI start address is: 12 (R3)
MOVS	R3, #0
; tempI end address is: 12 (R3)
UXTH	R0, R3
L_Ethernet_Intern_UserUDP14:
; tempI start address is: 0 (R0)
MOVW	R4, #lo_addr(_ReceivingPackageLeft+0)
MOVT	R4, #hi_addr(_ReceivingPackageLeft+0)
LDR	R5, [R4, #0]
MOVW	R4, _BYTES_2_WRITE
MOVT	R4, _BYTES_2_WRITE+2
UDIV	R4, R5, R4
CMP	R0, R4
IT	CS
BCS	L_Ethernet_Intern_UserUDP15
;Ethernet_Handlers.c,161 :: 		MP3_SDI_Write_32(receiveBuffer[9 + (tempI*BYTES_2_WRITE)]);
MOVW	R4, _BYTES_2_WRITE
MULS	R4, R0, R4
UXTH	R4, R4
ADDW	R5, R4, #9
UXTH	R5, R5
ADD	R4, SP, #8
ADDS	R4, R4, R5
LDRB	R4, [R4, #0]
STRH	R0, [SP, #4]
MOV	R0, R4
BL	_MP3_SDI_Write_32+0
LDRH	R0, [SP, #4]
;Ethernet_Handlers.c,160 :: 		for (tempI = 0; tempI < (ReceivingPackageLeft/BYTES_2_WRITE); tempI++) {
ADDS	R3, R0, #1
UXTH	R3, R3
; tempI end address is: 0 (R0)
; tempI start address is: 12 (R3)
;Ethernet_Handlers.c,162 :: 		}
UXTH	R0, R3
; tempI end address is: 12 (R3)
IT	AL
BAL	L_Ethernet_Intern_UserUDP14
L_Ethernet_Intern_UserUDP15:
;Ethernet_Handlers.c,163 :: 		tempI = (ReceivingPackageLeft/BYTES_2_WRITE);
MOVW	R4, #lo_addr(_ReceivingPackageLeft+0)
MOVT	R4, #hi_addr(_ReceivingPackageLeft+0)
LDR	R5, [R4, #0]
MOVW	R4, _BYTES_2_WRITE
MOVT	R4, _BYTES_2_WRITE+2
UDIV	R4, R5, R4
;Ethernet_Handlers.c,164 :: 		tempI *= BYTES_2_WRITE;
UXTH	R5, R4
MOVW	R4, _BYTES_2_WRITE
MUL	R0, R5, R4
UXTH	R0, R0
; tempI start address is: 0 (R0)
;Ethernet_Handlers.c,165 :: 		for (tempI2 = 0; tempI2 < (ReceivingPackageLeft%BYTES_2_WRITE); tempI2++) {
; tempI2 start address is: 28 (R7)
MOVS	R7, #0
; tempI2 end address is: 28 (R7)
UXTH	R1, R7
L_Ethernet_Intern_UserUDP17:
; tempI2 start address is: 4 (R1)
; tempI start address is: 0 (R0)
; tempI end address is: 0 (R0)
MOVW	R4, #lo_addr(_ReceivingPackageLeft+0)
MOVT	R4, #hi_addr(_ReceivingPackageLeft+0)
LDR	R6, [R4, #0]
MOVW	R5, _BYTES_2_WRITE
MOVT	R5, _BYTES_2_WRITE+2
UDIV	R4, R6, R5
MLS	R4, R5, R4, R6
CMP	R1, R4
IT	CS
BCS	L_Ethernet_Intern_UserUDP18
; tempI end address is: 0 (R0)
;Ethernet_Handlers.c,166 :: 		MP3_SDI_Write(receiveBuffer[9 + tempI + tempI2]);
; tempI start address is: 0 (R0)
ADDW	R4, R0, #9
UXTH	R4, R4
ADDS	R5, R4, R1
UXTH	R5, R5
ADD	R4, SP, #8
ADDS	R4, R4, R5
LDRB	R4, [R4, #0]
STRH	R0, [SP, #4]
STRH	R1, [SP, #6]
UXTB	R0, R4
BL	_MP3_SDI_Write+0
LDRH	R1, [SP, #6]
LDRH	R0, [SP, #4]
;Ethernet_Handlers.c,165 :: 		for (tempI2 = 0; tempI2 < (ReceivingPackageLeft%BYTES_2_WRITE); tempI2++) {
ADDS	R4, R1, #1
; tempI2 end address is: 4 (R1)
; tempI2 start address is: 28 (R7)
UXTH	R7, R4
;Ethernet_Handlers.c,167 :: 		}
; tempI2 end address is: 28 (R7)
; tempI end address is: 0 (R0)
UXTH	R1, R7
IT	AL
BAL	L_Ethernet_Intern_UserUDP17
L_Ethernet_Intern_UserUDP18:
;Ethernet_Handlers.c,168 :: 		}
L_Ethernet_Intern_UserUDP13:
;Ethernet_Handlers.c,169 :: 		ReceivingCurrentPackage++; // Increase count - indicates that we have received the name of a folder/file
MOVW	R6, #lo_addr(_ReceivingCurrentPackage+0)
MOVT	R6, #hi_addr(_ReceivingCurrentPackage+0)
LDR	R4, [R6, #0]
ADDS	R5, R4, #1
STR	R5, [R6, #0]
;Ethernet_Handlers.c,171 :: 		if (ReceivingCurrentPackage < ReceivingDividedPackages) {
MOVW	R4, #lo_addr(_ReceivingDividedPackages+0)
MOVT	R4, #hi_addr(_ReceivingDividedPackages+0)
LDR	R4, [R4, #0]
CMP	R5, R4
IT	CS
BCS	L_Ethernet_Intern_UserUDP20
;Ethernet_Handlers.c,172 :: 		RequestNextAudioPackage();
BL	_RequestNextAudioPackage+0
;Ethernet_Handlers.c,173 :: 		} else {
IT	AL
BAL	L_Ethernet_Intern_UserUDP21
L_Ethernet_Intern_UserUDP20:
;Ethernet_Handlers.c,174 :: 		AudioFinished();
BL	_AudioFinished+0
;Ethernet_Handlers.c,175 :: 		CurrentState = IDLE;
MOVS	R5, #0
MOVW	R4, #lo_addr(_CurrentState+0)
MOVT	R4, #hi_addr(_CurrentState+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,176 :: 		}
L_Ethernet_Intern_UserUDP21:
;Ethernet_Handlers.c,177 :: 		}
L_Ethernet_Intern_UserUDP8:
;Ethernet_Handlers.c,132 :: 		if (CMD == 0x0D && DataLength > 5 && CurrentState == FILE_RECEIVE && DownloadMode == 0) {
L__Ethernet_Intern_UserUDP119:
L__Ethernet_Intern_UserUDP118:
L__Ethernet_Intern_UserUDP117:
L__Ethernet_Intern_UserUDP116:
;Ethernet_Handlers.c,180 :: 		if (CMD == 0x0D && DataLength > 5 && CurrentState == FILE_RECEIVE && DownloadMode == 1) {
LDRB	R4, [SP, #1488]
CMP	R4, #13
IT	NE
BNE	L__Ethernet_Intern_UserUDP123
LDRH	R4, [SP, #1490]
CMP	R4, #5
IT	LS
BLS	L__Ethernet_Intern_UserUDP122
MOVW	R4, #lo_addr(_CurrentState+0)
MOVT	R4, #hi_addr(_CurrentState+0)
LDRB	R4, [R4, #0]
CMP	R4, #2
IT	NE
BNE	L__Ethernet_Intern_UserUDP121
MOVW	R5, #lo_addr(_DownloadMode+0)
MOVT	R5, #hi_addr(_DownloadMode+0)
LDR	R4, [R5, #0]
CMP	R4, #0
IT	EQ
BEQ	L__Ethernet_Intern_UserUDP120
L__Ethernet_Intern_UserUDP111:
;Ethernet_Handlers.c,181 :: 		if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFileID) {
ADD	R6, SP, #8
ADDS	R4, R6, #4
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
UXTH	R5, R5
ADDS	R4, R6, #5
LDRB	R4, [R4, #0]
ORRS	R5, R4
UXTH	R5, R5
MOVW	R4, #lo_addr(_CurrentFileID+0)
MOVT	R4, #hi_addr(_CurrentFileID+0)
LDRH	R4, [R4, #0]
CMP	R5, R4
IT	NE
BNE	L_Ethernet_Intern_UserUDP25
;Ethernet_Handlers.c,183 :: 		if (ReceivingCurrentPackage < ReceivingDividedPackages) {
MOVW	R4, #lo_addr(_ReceivingDividedPackages+0)
MOVT	R4, #hi_addr(_ReceivingDividedPackages+0)
LDR	R5, [R4, #0]
MOVW	R4, #lo_addr(_ReceivingCurrentPackage+0)
MOVT	R4, #hi_addr(_ReceivingCurrentPackage+0)
LDR	R4, [R4, #0]
CMP	R4, R5
IT	CS
BCS	L_Ethernet_Intern_UserUDP26
;Ethernet_Handlers.c,184 :: 		FAT32_Write(fileHandle, (receiveBuffer + 9), ReceivingFileDPL);
MOVW	R4, #lo_addr(_ReceivingFileDPL+0)
MOVT	R4, #hi_addr(_ReceivingFileDPL+0)
LDRH	R6, [R4, #0]
ADD	R4, SP, #8
ADDW	R5, R4, #9
MOVW	R4, #lo_addr(_fileHandle+0)
MOVT	R4, #hi_addr(_fileHandle+0)
LDRSB	R4, [R4, #0]
UXTH	R2, R6
MOV	R1, R5
SXTB	R0, R4
BL	_FAT32_Write+0
;Ethernet_Handlers.c,185 :: 		} else {
IT	AL
BAL	L_Ethernet_Intern_UserUDP27
L_Ethernet_Intern_UserUDP26:
;Ethernet_Handlers.c,186 :: 		FAT32_Write(fileHandle, (receiveBuffer + 9), ReceivingPackageLeft);
MOVW	R4, #lo_addr(_ReceivingPackageLeft+0)
MOVT	R4, #hi_addr(_ReceivingPackageLeft+0)
LDR	R6, [R4, #0]
ADD	R4, SP, #8
ADDW	R5, R4, #9
MOVW	R4, #lo_addr(_fileHandle+0)
MOVT	R4, #hi_addr(_fileHandle+0)
LDRSB	R4, [R4, #0]
UXTH	R2, R6
MOV	R1, R5
SXTB	R0, R4
BL	_FAT32_Write+0
;Ethernet_Handlers.c,187 :: 		}
L_Ethernet_Intern_UserUDP27:
;Ethernet_Handlers.c,188 :: 		ReceivingCurrentPackage++; // Increase count - indicates that we have received the name of a folder/file
MOVW	R6, #lo_addr(_ReceivingCurrentPackage+0)
MOVT	R6, #hi_addr(_ReceivingCurrentPackage+0)
LDR	R4, [R6, #0]
ADDS	R5, R4, #1
STR	R5, [R6, #0]
;Ethernet_Handlers.c,190 :: 		if (ReceivingCurrentPackage < ReceivingDividedPackages) {
MOVW	R4, #lo_addr(_ReceivingDividedPackages+0)
MOVT	R4, #hi_addr(_ReceivingDividedPackages+0)
LDR	R4, [R4, #0]
CMP	R5, R4
IT	CS
BCS	L_Ethernet_Intern_UserUDP28
;Ethernet_Handlers.c,191 :: 		RequestNextAudioPackage();
BL	_RequestNextAudioPackage+0
;Ethernet_Handlers.c,192 :: 		} else {
IT	AL
BAL	L_Ethernet_Intern_UserUDP29
L_Ethernet_Intern_UserUDP28:
;Ethernet_Handlers.c,194 :: 		FAT32_Close(fileHandle);
MOVW	R4, #lo_addr(_fileHandle+0)
MOVT	R4, #hi_addr(_fileHandle+0)
LDRSB	R4, [R4, #0]
SXTB	R0, R4
BL	_FAT32_Close+0
;Ethernet_Handlers.c,195 :: 		UART0_Write_Text("File saved");
MOVW	R4, #lo_addr(?lstr6_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr6_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,196 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,197 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,198 :: 		CurrentState = IDLE;
MOVS	R5, #0
MOVW	R4, #lo_addr(_CurrentState+0)
MOVT	R4, #hi_addr(_CurrentState+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,199 :: 		}
L_Ethernet_Intern_UserUDP29:
;Ethernet_Handlers.c,200 :: 		}
L_Ethernet_Intern_UserUDP25:
;Ethernet_Handlers.c,180 :: 		if (CMD == 0x0D && DataLength > 5 && CurrentState == FILE_RECEIVE && DownloadMode == 1) {
L__Ethernet_Intern_UserUDP123:
L__Ethernet_Intern_UserUDP122:
L__Ethernet_Intern_UserUDP121:
L__Ethernet_Intern_UserUDP120:
;Ethernet_Handlers.c,203 :: 		if (CMD == 0x1D && DataLength > 5 && CurrentState == IMAGE_RECEIVE) {
LDRB	R4, [SP, #1488]
CMP	R4, #29
IT	NE
BNE	L__Ethernet_Intern_UserUDP126
LDRH	R4, [SP, #1490]
CMP	R4, #5
IT	LS
BLS	L__Ethernet_Intern_UserUDP125
MOVW	R4, #lo_addr(_CurrentState+0)
MOVT	R4, #hi_addr(_CurrentState+0)
LDRB	R4, [R4, #0]
CMP	R4, #4
IT	NE
BNE	L__Ethernet_Intern_UserUDP124
L__Ethernet_Intern_UserUDP110:
;Ethernet_Handlers.c,204 :: 		if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFileID) {
ADD	R6, SP, #8
ADDS	R4, R6, #4
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
UXTH	R5, R5
ADDS	R4, R6, #5
LDRB	R4, [R4, #0]
ORRS	R5, R4
UXTH	R5, R5
MOVW	R4, #lo_addr(_CurrentFileID+0)
MOVT	R4, #hi_addr(_CurrentFileID+0)
LDRH	R4, [R4, #0]
CMP	R5, R4
IT	NE
BNE	L_Ethernet_Intern_UserUDP33
;Ethernet_Handlers.c,206 :: 		if (ReceivingCurrentPackage < ReceivingDividedPackages) {
MOVW	R4, #lo_addr(_ReceivingDividedPackages+0)
MOVT	R4, #hi_addr(_ReceivingDividedPackages+0)
LDR	R5, [R4, #0]
MOVW	R4, #lo_addr(_ReceivingCurrentPackage+0)
MOVT	R4, #hi_addr(_ReceivingCurrentPackage+0)
LDR	R4, [R4, #0]
CMP	R4, R5
IT	CS
BCS	L_Ethernet_Intern_UserUDP34
;Ethernet_Handlers.c,207 :: 		for (tempI = 0; tempI < ReceivingFileDPL; tempI += 2) {
; tempI start address is: 12 (R3)
MOVS	R3, #0
; tempI end address is: 12 (R3)
UXTH	R0, R3
L_Ethernet_Intern_UserUDP35:
; tempI start address is: 0 (R0)
MOVW	R4, #lo_addr(_ReceivingFileDPL+0)
MOVT	R4, #hi_addr(_ReceivingFileDPL+0)
LDRH	R4, [R4, #0]
CMP	R0, R4
IT	CS
BCS	L_Ethernet_Intern_UserUDP36
;Ethernet_Handlers.c,208 :: 		TFT_Dot(Xcord, Ycord, (((receiveBuffer[9 + tempI]) << 8) | (receiveBuffer[9 + tempI + 1])));
ADDW	R7, R0, #9
UXTH	R7, R7
ADD	R6, SP, #8
ADDS	R4, R6, R7
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
UXTH	R5, R5
ADDS	R4, R7, #1
UXTH	R4, R4
ADDS	R4, R6, R4
LDRB	R4, [R4, #0]
ORR	R6, R5, R4, LSL #0
MOVW	R4, #lo_addr(_Ycord+0)
MOVT	R4, #hi_addr(_Ycord+0)
LDRH	R5, [R4, #0]
MOVW	R4, #lo_addr(_Xcord+0)
MOVT	R4, #hi_addr(_Xcord+0)
LDRH	R4, [R4, #0]
STRH	R0, [SP, #4]
UXTH	R2, R6
SXTH	R1, R5
SXTH	R0, R4
BL	_TFT_Dot+0
LDRH	R0, [SP, #4]
;Ethernet_Handlers.c,209 :: 		Xcord++;
MOVW	R5, #lo_addr(_Xcord+0)
MOVT	R5, #hi_addr(_Xcord+0)
LDRH	R4, [R5, #0]
ADDS	R4, R4, #1
UXTH	R4, R4
STRH	R4, [R5, #0]
;Ethernet_Handlers.c,210 :: 		if (Xcord == 320) {
CMP	R4, #320
IT	NE
BNE	L_Ethernet_Intern_UserUDP38
;Ethernet_Handlers.c,211 :: 		Ycord++;
MOVW	R5, #lo_addr(_Ycord+0)
MOVT	R5, #hi_addr(_Ycord+0)
LDRH	R4, [R5, #0]
ADDS	R4, R4, #1
STRH	R4, [R5, #0]
;Ethernet_Handlers.c,212 :: 		Xcord = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_Xcord+0)
MOVT	R4, #hi_addr(_Xcord+0)
STRH	R5, [R4, #0]
;Ethernet_Handlers.c,213 :: 		}
L_Ethernet_Intern_UserUDP38:
;Ethernet_Handlers.c,207 :: 		for (tempI = 0; tempI < ReceivingFileDPL; tempI += 2) {
ADDS	R3, R0, #2
UXTH	R3, R3
; tempI end address is: 0 (R0)
; tempI start address is: 12 (R3)
;Ethernet_Handlers.c,214 :: 		}
UXTH	R0, R3
; tempI end address is: 12 (R3)
IT	AL
BAL	L_Ethernet_Intern_UserUDP35
L_Ethernet_Intern_UserUDP36:
;Ethernet_Handlers.c,215 :: 		} else {
IT	AL
BAL	L_Ethernet_Intern_UserUDP39
L_Ethernet_Intern_UserUDP34:
;Ethernet_Handlers.c,217 :: 		}
L_Ethernet_Intern_UserUDP39:
;Ethernet_Handlers.c,218 :: 		ReceivingCurrentPackage++; // Increase count - indicates that we have received the name of a folder/file
MOVW	R6, #lo_addr(_ReceivingCurrentPackage+0)
MOVT	R6, #hi_addr(_ReceivingCurrentPackage+0)
LDR	R4, [R6, #0]
ADDS	R5, R4, #1
STR	R5, [R6, #0]
;Ethernet_Handlers.c,220 :: 		if (ReceivingCurrentPackage < ReceivingDividedPackages) {
MOVW	R4, #lo_addr(_ReceivingDividedPackages+0)
MOVT	R4, #hi_addr(_ReceivingDividedPackages+0)
LDR	R4, [R4, #0]
CMP	R5, R4
IT	CS
BCS	L_Ethernet_Intern_UserUDP40
;Ethernet_Handlers.c,221 :: 		RequestNextImagePackage();
BL	_RequestNextImagePackage+0
;Ethernet_Handlers.c,222 :: 		} else {
IT	AL
BAL	L_Ethernet_Intern_UserUDP41
L_Ethernet_Intern_UserUDP40:
;Ethernet_Handlers.c,223 :: 		UART0_Write_Text("Image received");
MOVW	R4, #lo_addr(?lstr7_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr7_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,224 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,225 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,226 :: 		CurrentState = IMAGE_DISPLAY;
MOVS	R5, #5
MOVW	R4, #lo_addr(_CurrentState+0)
MOVT	R4, #hi_addr(_CurrentState+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,227 :: 		}
L_Ethernet_Intern_UserUDP41:
;Ethernet_Handlers.c,228 :: 		}
L_Ethernet_Intern_UserUDP33:
;Ethernet_Handlers.c,203 :: 		if (CMD == 0x1D && DataLength > 5 && CurrentState == IMAGE_RECEIVE) {
L__Ethernet_Intern_UserUDP126:
L__Ethernet_Intern_UserUDP125:
L__Ethernet_Intern_UserUDP124:
;Ethernet_Handlers.c,231 :: 		if (CMD == 0x40) { // Ping command
LDRB	R4, [SP, #1488]
CMP	R4, #64
IT	NE
BNE	L_Ethernet_Intern_UserUDP42
;Ethernet_Handlers.c,233 :: 		UDPTransmitBuffer[0] = DeviceCID;
MOVW	R4, #lo_addr(_DeviceCID+0)
MOVT	R4, #hi_addr(_DeviceCID+0)
LDRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,234 :: 		UDPTransmitBuffer[1] = 0x41; // Ping reply
MOVS	R5, #65
MOVW	R4, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+1)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,235 :: 		UDPTransmitBuffer[2] = 0; // Data length = 0
MOVS	R5, #0
MOVW	R4, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+2)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,236 :: 		UDPTransmitBuffer[3] = 0; // Data length = 0
MOVS	R5, #0
MOVW	R4, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+3)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,237 :: 		UDPTransmitBuffer[4] = Calculate_Checksum(UDPTransmitBuffer, 4);
MOVS	R1, #4
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R4, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+4)
STRB	R0, [R4, #0]
;Ethernet_Handlers.c,238 :: 		UART0_Write_Text("Pong sent");
MOVW	R4, #lo_addr(?lstr8_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr8_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,239 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,240 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,241 :: 		sendLength = 5;
MOVS	R4, #5
STRB	R4, [SP, #1492]
;Ethernet_Handlers.c,242 :: 		}
L_Ethernet_Intern_UserUDP42:
;Ethernet_Handlers.c,244 :: 		if (CMD == 0x02 && DataLength == 5) { // Check communication response - response length is OK
LDRB	R4, [SP, #1488]
CMP	R4, #2
IT	NE
BNE	L__Ethernet_Intern_UserUDP132
LDRH	R4, [SP, #1490]
CMP	R4, #5
IT	NE
BNE	L__Ethernet_Intern_UserUDP131
L__Ethernet_Intern_UserUDP109:
;Ethernet_Handlers.c,245 :: 		if (receiveBuffer[4] == UniqueDeviceID[0] && receiveBuffer[5] == UniqueDeviceID[1] && receiveBuffer[6] == UniqueDeviceID[2] && receiveBuffer[7] == UniqueDeviceID[3]) { // This Check communication response is dedicated for us
ADD	R4, SP, #8
ADDS	R4, R4, #4
LDRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_UniqueDeviceID+0)
MOVT	R4, #hi_addr(_UniqueDeviceID+0)
LDR	R4, [R4, #0]
LDRB	R4, [R4, #0]
CMP	R5, R4
IT	NE
BNE	L__Ethernet_Intern_UserUDP130
ADD	R4, SP, #8
ADDS	R6, R4, #5
MOVW	R4, #lo_addr(_UniqueDeviceID+0)
MOVT	R4, #hi_addr(_UniqueDeviceID+0)
LDR	R4, [R4, #0]
ADDS	R4, R4, #1
LDRB	R5, [R4, #0]
LDRB	R4, [R6, #0]
CMP	R4, R5
IT	NE
BNE	L__Ethernet_Intern_UserUDP129
ADD	R4, SP, #8
ADDS	R6, R4, #6
MOVW	R4, #lo_addr(_UniqueDeviceID+0)
MOVT	R4, #hi_addr(_UniqueDeviceID+0)
LDR	R4, [R4, #0]
ADDS	R4, R4, #2
LDRB	R5, [R4, #0]
LDRB	R4, [R6, #0]
CMP	R4, R5
IT	NE
BNE	L__Ethernet_Intern_UserUDP128
ADD	R4, SP, #8
ADDS	R6, R4, #7
MOVW	R4, #lo_addr(_UniqueDeviceID+0)
MOVT	R4, #hi_addr(_UniqueDeviceID+0)
LDR	R4, [R4, #0]
ADDS	R4, R4, #3
LDRB	R5, [R4, #0]
LDRB	R4, [R6, #0]
CMP	R4, R5
IT	NE
BNE	L__Ethernet_Intern_UserUDP127
L__Ethernet_Intern_UserUDP108:
;Ethernet_Handlers.c,246 :: 		DeviceCID = receiveBuffer[8]; // Save assigned CID
ADD	R4, SP, #8
ADDS	R4, #8
LDRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_DeviceCID+0)
MOVT	R4, #hi_addr(_DeviceCID+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,247 :: 		ByteToStr(DeviceCID, stringBuffer);
UXTB	R4, R5
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
UXTB	R0, R4
BL	_ByteToStr+0
;Ethernet_Handlers.c,248 :: 		UART0_Write_Text("Assigned CID: ");
MOVW	R4, #lo_addr(?lstr9_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr9_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,249 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,250 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,251 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,252 :: 		FetchCID = 0;
MOVS	R5, #0
SXTB	R5, R5
MOVW	R4, #lo_addr(_FetchCID+0)
MOVT	R4, #hi_addr(_FetchCID+0)
STR	R5, [R4, #0]
;Ethernet_Handlers.c,245 :: 		if (receiveBuffer[4] == UniqueDeviceID[0] && receiveBuffer[5] == UniqueDeviceID[1] && receiveBuffer[6] == UniqueDeviceID[2] && receiveBuffer[7] == UniqueDeviceID[3]) { // This Check communication response is dedicated for us
L__Ethernet_Intern_UserUDP130:
L__Ethernet_Intern_UserUDP129:
L__Ethernet_Intern_UserUDP128:
L__Ethernet_Intern_UserUDP127:
;Ethernet_Handlers.c,244 :: 		if (CMD == 0x02 && DataLength == 5) { // Check communication response - response length is OK
L__Ethernet_Intern_UserUDP132:
L__Ethernet_Intern_UserUDP131:
;Ethernet_Handlers.c,256 :: 		if (CMD == 0x04 && DataLength == 3 && CurrentState == FOLDER_RECEIVE) {
LDRB	R4, [SP, #1488]
CMP	R4, #4
IT	NE
BNE	L__Ethernet_Intern_UserUDP135
LDRH	R4, [SP, #1490]
CMP	R4, #3
IT	NE
BNE	L__Ethernet_Intern_UserUDP134
MOVW	R4, #lo_addr(_CurrentState+0)
MOVT	R4, #hi_addr(_CurrentState+0)
LDRB	R4, [R4, #0]
CMP	R4, #1
IT	NE
BNE	L__Ethernet_Intern_UserUDP133
L__Ethernet_Intern_UserUDP107:
;Ethernet_Handlers.c,257 :: 		if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFolderID) {
ADD	R6, SP, #8
ADDS	R4, R6, #4
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
UXTH	R5, R5
ADDS	R4, R6, #5
LDRB	R4, [R4, #0]
ORRS	R5, R4
UXTH	R5, R5
MOVW	R4, #lo_addr(_CurrentFolderID+0)
MOVT	R4, #hi_addr(_CurrentFolderID+0)
LDRB	R4, [R4, #0]
CMP	R5, R4
IT	NE
BNE	L_Ethernet_Intern_UserUDP52
;Ethernet_Handlers.c,258 :: 		FoldersFilesToReceive = receiveBuffer[6];
ADD	R4, SP, #8
ADDS	R4, R4, #6
LDRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_FoldersFilesToReceive+0)
MOVT	R4, #hi_addr(_FoldersFilesToReceive+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,259 :: 		if (CurrentFolderID > 0) { // If not ROOT folder add "../" link
MOVW	R4, #lo_addr(_CurrentFolderID+0)
MOVT	R4, #hi_addr(_CurrentFolderID+0)
LDRB	R4, [R4, #0]
CMP	R4, #0
IT	LS
BLS	L_Ethernet_Intern_UserUDP53
;Ethernet_Handlers.c,260 :: 		FilesList[0].ID = PreviousFolderID;
MOVW	R4, #lo_addr(_PreviousFolderID+0)
MOVT	R4, #hi_addr(_PreviousFolderID+0)
LDRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_FilesList+0)
MOVT	R4, #hi_addr(_FilesList+0)
STRH	R5, [R4, #0]
;Ethernet_Handlers.c,261 :: 		FilesList[0].Type = 'F';
MOVS	R5, #70
MOVW	R4, #lo_addr(_FilesList+2)
MOVT	R4, #hi_addr(_FilesList+2)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,262 :: 		memcpy(FilesList[0].Name, "../", 3);
MOVW	R4, #lo_addr(?lstr10_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr10_Ethernet_Handlers+0)
MOVS	R2, #3
SXTH	R2, R2
MOV	R1, R4
MOVW	R0, #lo_addr(_FilesList+3)
MOVT	R0, #hi_addr(_FilesList+3)
BL	_memcpy+0
;Ethernet_Handlers.c,263 :: 		FilesList[0].NameLength = 3;
MOVS	R5, #3
MOVW	R4, #lo_addr(_FilesList+35)
MOVT	R4, #hi_addr(_FilesList+35)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,264 :: 		}
L_Ethernet_Intern_UserUDP53:
;Ethernet_Handlers.c,265 :: 		FolderFileRequestIDCount = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_FolderFileRequestIDCount+0)
MOVT	R4, #hi_addr(_FolderFileRequestIDCount+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,266 :: 		ByteToStr(FoldersFilesToReceive, stringBuffer);
MOVW	R4, #lo_addr(_FoldersFilesToReceive+0)
MOVT	R4, #hi_addr(_FoldersFilesToReceive+0)
LDRB	R4, [R4, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
UXTB	R0, R4
BL	_ByteToStr+0
;Ethernet_Handlers.c,267 :: 		UART0_Write_Text("Folder/file count to receive: ");
MOVW	R4, #lo_addr(?lstr11_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr11_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,268 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,269 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,270 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,272 :: 		UDPTransmitBuffer[0] = DeviceCID;
MOVW	R4, #lo_addr(_DeviceCID+0)
MOVT	R4, #hi_addr(_DeviceCID+0)
LDRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,273 :: 		UDPTransmitBuffer[1] = 0x05; // Request folder/file name
MOVS	R5, #5
MOVW	R4, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+1)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,274 :: 		UDPTransmitBuffer[2] = 0; // Data length = 3
MOVS	R5, #0
MOVW	R4, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+2)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,275 :: 		UDPTransmitBuffer[3] = 3; // Data length = 3
MOVS	R5, #3
MOVW	R4, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+3)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,276 :: 		UDPTransmitBuffer[4] = (CurrentFolderID & 0xFF00) >> 8;
MOVW	R6, #lo_addr(_CurrentFolderID+0)
MOVT	R6, #hi_addr(_CurrentFolderID+0)
LDRB	R4, [R6, #0]
AND	R4, R4, #65280
UXTH	R4, R4
LSRS	R5, R4, #8
MOVW	R4, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+4)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,277 :: 		UDPTransmitBuffer[5] = (CurrentFolderID & 0xFF);
MOV	R4, R6
LDRB	R4, [R4, #0]
AND	R5, R4, #255
MOVW	R4, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+5)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,278 :: 		UDPTransmitBuffer[6] = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+6)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,279 :: 		UDPTransmitBuffer[7] = Calculate_Checksum(UDPTransmitBuffer, 7);
MOVS	R1, #7
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R4, #lo_addr(_UDPTransmitBuffer+7)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+7)
STRB	R0, [R4, #0]
;Ethernet_Handlers.c,280 :: 		sendLength = 8;
MOVS	R4, #8
STRB	R4, [SP, #1492]
;Ethernet_Handlers.c,282 :: 		halfSecondCountdownTimer = 5; // Make sure download is kept alive
MOVS	R5, #5
MOVW	R4, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R4, #hi_addr(_halfSecondCountdownTimer+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,283 :: 		ErrorCounter = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_ErrorCounter+0)
MOVT	R4, #hi_addr(_ErrorCounter+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,284 :: 		}
L_Ethernet_Intern_UserUDP52:
;Ethernet_Handlers.c,256 :: 		if (CMD == 0x04 && DataLength == 3 && CurrentState == FOLDER_RECEIVE) {
L__Ethernet_Intern_UserUDP135:
L__Ethernet_Intern_UserUDP134:
L__Ethernet_Intern_UserUDP133:
;Ethernet_Handlers.c,287 :: 		if (CMD == 0x06 && DataLength > 5 && CurrentState == FOLDER_RECEIVE) {
LDRB	R4, [SP, #1488]
CMP	R4, #6
IT	NE
BNE	L__Ethernet_Intern_UserUDP138
LDRH	R4, [SP, #1490]
CMP	R4, #5
IT	LS
BLS	L__Ethernet_Intern_UserUDP137
MOVW	R4, #lo_addr(_CurrentState+0)
MOVT	R4, #hi_addr(_CurrentState+0)
LDRB	R4, [R4, #0]
CMP	R4, #1
IT	NE
BNE	L__Ethernet_Intern_UserUDP136
L__Ethernet_Intern_UserUDP106:
;Ethernet_Handlers.c,288 :: 		if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFolderID) {
ADD	R6, SP, #8
ADDS	R4, R6, #4
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
UXTH	R5, R5
ADDS	R4, R6, #5
LDRB	R4, [R4, #0]
ORRS	R5, R4
UXTH	R5, R5
MOVW	R4, #lo_addr(_CurrentFolderID+0)
MOVT	R4, #hi_addr(_CurrentFolderID+0)
LDRB	R4, [R4, #0]
CMP	R5, R4
IT	NE
BNE	L_Ethernet_Intern_UserUDP57
;Ethernet_Handlers.c,289 :: 		if (FolderFileRequestIDCount < 199) { // Fill into files list buffer
MOVW	R4, #lo_addr(_FolderFileRequestIDCount+0)
MOVT	R4, #hi_addr(_FolderFileRequestIDCount+0)
LDRB	R4, [R4, #0]
CMP	R4, #199
IT	CS
BCS	L_Ethernet_Intern_UserUDP58
;Ethernet_Handlers.c,290 :: 		if (CurrentFolderID == 0) { // ROOT Folder = No "../" item
MOVW	R4, #lo_addr(_CurrentFolderID+0)
MOVT	R4, #hi_addr(_CurrentFolderID+0)
LDRB	R4, [R4, #0]
CMP	R4, #0
IT	NE
BNE	L_Ethernet_Intern_UserUDP59
;Ethernet_Handlers.c,291 :: 		FilesList[FolderFileRequestIDCount].ID = (receiveBuffer[6] << 8) | receiveBuffer[7];
MOVW	R8, #lo_addr(_FolderFileRequestIDCount+0)
MOVT	R8, #hi_addr(_FolderFileRequestIDCount+0)
STR	R8, [SP, #1516]
LDRB	R5, [R8, #0]
MOVS	R4, #36
MULS	R5, R4, R5
MOVW	R4, #lo_addr(_FilesList+0)
MOVT	R4, #hi_addr(_FilesList+0)
ADDS	R7, R4, R5
ADD	R6, SP, #8
ADDS	R4, R6, #6
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
UXTH	R5, R5
ADDS	R4, R6, #7
LDRB	R4, [R4, #0]
ORR	R4, R5, R4, LSL #0
STRH	R4, [R7, #0]
;Ethernet_Handlers.c,292 :: 		FilesList[FolderFileRequestIDCount].Type = receiveBuffer[8];
MOV	R4, R8
LDRB	R5, [R4, #0]
MOVS	R4, #36
MULS	R5, R4, R5
MOVW	R4, #lo_addr(_FilesList+0)
MOVT	R4, #hi_addr(_FilesList+0)
ADDS	R4, R4, R5
ADDS	R5, R4, #2
ADDW	R4, R6, #8
LDRB	R4, [R4, #0]
STRB	R4, [R5, #0]
;Ethernet_Handlers.c,293 :: 		memcpy(FilesList[FolderFileRequestIDCount].Name, (receiveBuffer+9), (DataLength-5));
LDRH	R4, [SP, #1490]
SUBS	R7, R4, #5
ADDS	R6, #9
MOV	R4, R8
LDRB	R5, [R4, #0]
MOVS	R4, #36
MULS	R5, R4, R5
MOVW	R4, #lo_addr(_FilesList+0)
MOVT	R4, #hi_addr(_FilesList+0)
ADDS	R4, R4, R5
ADDS	R4, R4, #3
SXTH	R2, R7
MOV	R1, R6
MOV	R0, R4
BL	_memcpy+0
;Ethernet_Handlers.c,294 :: 		FilesList[FolderFileRequestIDCount].Name[(DataLength-5)] = 0x00;
MOVW	R4, #lo_addr(_FolderFileRequestIDCount+0)
MOVT	R4, #hi_addr(_FolderFileRequestIDCount+0)
LDRB	R5, [R4, #0]
MOVS	R4, #36
MULS	R5, R4, R5
MOVW	R4, #lo_addr(_FilesList+0)
MOVT	R4, #hi_addr(_FilesList+0)
ADDS	R4, R4, R5
ADDS	R5, R4, #3
LDRH	R4, [SP, #1490]
SUBS	R4, R4, #5
UXTH	R4, R4
ADDS	R5, R5, R4
MOVS	R4, #0
STRB	R4, [R5, #0]
;Ethernet_Handlers.c,295 :: 		FilesList[FolderFileRequestIDCount].NameLength = (DataLength-5);
LDR	R4, [SP, #1516]
LDRB	R5, [R4, #0]
MOVS	R4, #36
MULS	R5, R4, R5
MOVW	R4, #lo_addr(_FilesList+0)
MOVT	R4, #hi_addr(_FilesList+0)
ADDS	R4, R4, R5
ADDW	R5, R4, #35
LDRH	R4, [SP, #1490]
SUBS	R4, R4, #5
STRB	R4, [R5, #0]
;Ethernet_Handlers.c,296 :: 		} else {
IT	AL
BAL	L_Ethernet_Intern_UserUDP60
L_Ethernet_Intern_UserUDP59:
;Ethernet_Handlers.c,297 :: 		FilesList[FolderFileRequestIDCount+1].ID = (receiveBuffer[6] << 8) | receiveBuffer[7];
MOVW	R8, #lo_addr(_FolderFileRequestIDCount+0)
MOVT	R8, #hi_addr(_FolderFileRequestIDCount+0)
STR	R8, [SP, #1516]
LDRB	R4, [R8, #0]
ADDS	R5, R4, #1
SXTH	R5, R5
MOVS	R4, #36
MULS	R5, R4, R5
MOVW	R4, #lo_addr(_FilesList+0)
MOVT	R4, #hi_addr(_FilesList+0)
ADDS	R7, R4, R5
ADD	R6, SP, #8
ADDS	R4, R6, #6
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
UXTH	R5, R5
ADDS	R4, R6, #7
LDRB	R4, [R4, #0]
ORR	R4, R5, R4, LSL #0
STRH	R4, [R7, #0]
;Ethernet_Handlers.c,298 :: 		FilesList[FolderFileRequestIDCount+1].Type = receiveBuffer[8];
MOV	R4, R8
LDRB	R4, [R4, #0]
ADDS	R5, R4, #1
SXTH	R5, R5
MOVS	R4, #36
MULS	R5, R4, R5
MOVW	R4, #lo_addr(_FilesList+0)
MOVT	R4, #hi_addr(_FilesList+0)
ADDS	R4, R4, R5
ADDS	R5, R4, #2
ADDW	R4, R6, #8
LDRB	R4, [R4, #0]
STRB	R4, [R5, #0]
;Ethernet_Handlers.c,299 :: 		memcpy(FilesList[FolderFileRequestIDCount+1].Name, (receiveBuffer+9), (DataLength-5));
LDRH	R4, [SP, #1490]
SUBS	R7, R4, #5
ADDS	R6, #9
MOV	R4, R8
LDRB	R4, [R4, #0]
ADDS	R5, R4, #1
SXTH	R5, R5
MOVS	R4, #36
MULS	R5, R4, R5
MOVW	R4, #lo_addr(_FilesList+0)
MOVT	R4, #hi_addr(_FilesList+0)
ADDS	R4, R4, R5
ADDS	R4, R4, #3
SXTH	R2, R7
MOV	R1, R6
MOV	R0, R4
BL	_memcpy+0
;Ethernet_Handlers.c,300 :: 		FilesList[FolderFileRequestIDCount+1].Name[(DataLength-5)] = 0x00;
MOVW	R4, #lo_addr(_FolderFileRequestIDCount+0)
MOVT	R4, #hi_addr(_FolderFileRequestIDCount+0)
LDRB	R4, [R4, #0]
ADDS	R5, R4, #1
SXTH	R5, R5
MOVS	R4, #36
MULS	R5, R4, R5
MOVW	R4, #lo_addr(_FilesList+0)
MOVT	R4, #hi_addr(_FilesList+0)
ADDS	R4, R4, R5
ADDS	R5, R4, #3
LDRH	R4, [SP, #1490]
SUBS	R4, R4, #5
UXTH	R4, R4
ADDS	R5, R5, R4
MOVS	R4, #0
STRB	R4, [R5, #0]
;Ethernet_Handlers.c,301 :: 		FilesList[FolderFileRequestIDCount+1].NameLength = (DataLength-5);
LDR	R4, [SP, #1516]
LDRB	R4, [R4, #0]
ADDS	R5, R4, #1
SXTH	R5, R5
MOVS	R4, #36
MULS	R5, R4, R5
MOVW	R4, #lo_addr(_FilesList+0)
MOVT	R4, #hi_addr(_FilesList+0)
ADDS	R4, R4, R5
ADDW	R5, R4, #35
LDRH	R4, [SP, #1490]
SUBS	R4, R4, #5
STRB	R4, [R5, #0]
;Ethernet_Handlers.c,302 :: 		}
L_Ethernet_Intern_UserUDP60:
;Ethernet_Handlers.c,303 :: 		}
L_Ethernet_Intern_UserUDP58:
;Ethernet_Handlers.c,305 :: 		UART0_Write_Text("Item ID #");
MOVW	R4, #lo_addr(?lstr12_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr12_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,306 :: 		WordToStr((receiveBuffer[6] << 8) | receiveBuffer[7], stringBuffer);
ADD	R6, SP, #8
ADDS	R4, R6, #6
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
UXTH	R5, R5
ADDS	R4, R6, #7
LDRB	R4, [R4, #0]
ORR	R4, R5, R4, LSL #0
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
UXTH	R0, R4
BL	_WordToStr+0
;Ethernet_Handlers.c,307 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,308 :: 		UART0_Write_Text(" of type (");
MOVW	R4, #lo_addr(?lstr13_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr13_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,309 :: 		UART0_Write(receiveBuffer[8]);
ADD	R4, SP, #8
ADDS	R4, #8
LDRB	R4, [R4, #0]
UXTH	R0, R4
BL	_UART0_Write+0
;Ethernet_Handlers.c,310 :: 		UART0_Write_Text("): ");
MOVW	R4, #lo_addr(?lstr14_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr14_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,311 :: 		memcpy(stringBuffer, (receiveBuffer+9), (DataLength-5));
LDRH	R4, [SP, #1490]
SUBS	R5, R4, #5
ADD	R4, SP, #8
ADDS	R4, #9
SXTH	R2, R5
MOV	R1, R4
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_memcpy+0
;Ethernet_Handlers.c,312 :: 		stringBuffer[(DataLength-5)] = 0; // Terminate string
LDRH	R4, [SP, #1490]
SUBS	R5, R4, #5
UXTH	R5, R5
MOVW	R4, #lo_addr(_stringBuffer+0)
MOVT	R4, #hi_addr(_stringBuffer+0)
ADDS	R5, R4, R5
MOVS	R4, #0
STRB	R4, [R5, #0]
;Ethernet_Handlers.c,313 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,315 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,316 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,318 :: 		FolderFileRequestIDCount++; // Increase count - indicates that we have received the name of a folder/file
MOVW	R6, #lo_addr(_FolderFileRequestIDCount+0)
MOVT	R6, #hi_addr(_FolderFileRequestIDCount+0)
LDRB	R4, [R6, #0]
ADDS	R5, R4, #1
UXTB	R5, R5
STRB	R5, [R6, #0]
;Ethernet_Handlers.c,319 :: 		if (FolderFileRequestIDCount < FoldersFilesToReceive) {
MOVW	R4, #lo_addr(_FoldersFilesToReceive+0)
MOVT	R4, #hi_addr(_FoldersFilesToReceive+0)
LDRB	R4, [R4, #0]
CMP	R5, R4
IT	CS
BCS	L_Ethernet_Intern_UserUDP61
;Ethernet_Handlers.c,321 :: 		UDPTransmitBuffer[0] = DeviceCID;
MOVW	R4, #lo_addr(_DeviceCID+0)
MOVT	R4, #hi_addr(_DeviceCID+0)
LDRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,322 :: 		UDPTransmitBuffer[1] = 0x05; // Request folder/file name
MOVS	R5, #5
MOVW	R4, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+1)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,323 :: 		UDPTransmitBuffer[2] = 0; // Data length = 3
MOVS	R5, #0
MOVW	R4, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+2)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,324 :: 		UDPTransmitBuffer[3] = 3; // Data length = 3
MOVS	R5, #3
MOVW	R4, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+3)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,325 :: 		UDPTransmitBuffer[4] = (CurrentFolderID & 0xFF00) >> 8;
MOVW	R6, #lo_addr(_CurrentFolderID+0)
MOVT	R6, #hi_addr(_CurrentFolderID+0)
LDRB	R4, [R6, #0]
AND	R4, R4, #65280
UXTH	R4, R4
LSRS	R5, R4, #8
MOVW	R4, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+4)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,326 :: 		UDPTransmitBuffer[5] = (CurrentFolderID & 0xFF);
MOV	R4, R6
LDRB	R4, [R4, #0]
AND	R5, R4, #255
MOVW	R4, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+5)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,327 :: 		UDPTransmitBuffer[6] = FolderFileRequestIDCount;
MOVW	R4, #lo_addr(_FolderFileRequestIDCount+0)
MOVT	R4, #hi_addr(_FolderFileRequestIDCount+0)
LDRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+6)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,328 :: 		UDPTransmitBuffer[7] = Calculate_Checksum(UDPTransmitBuffer, 7);
MOVS	R1, #7
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R4, #lo_addr(_UDPTransmitBuffer+7)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+7)
STRB	R0, [R4, #0]
;Ethernet_Handlers.c,329 :: 		sendLength = 8;
MOVS	R4, #8
STRB	R4, [SP, #1492]
;Ethernet_Handlers.c,331 :: 		halfSecondCountdownTimer = 5; // Make sure download is kept alive
MOVS	R5, #5
MOVW	R4, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R4, #hi_addr(_halfSecondCountdownTimer+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,332 :: 		ErrorCounter = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_ErrorCounter+0)
MOVT	R4, #hi_addr(_ErrorCounter+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,333 :: 		} else {
IT	AL
BAL	L_Ethernet_Intern_UserUDP62
L_Ethernet_Intern_UserUDP61:
;Ethernet_Handlers.c,334 :: 		if (CurrentFolderID == 0) {
MOVW	R4, #lo_addr(_CurrentFolderID+0)
MOVT	R4, #hi_addr(_CurrentFolderID+0)
LDRB	R4, [R4, #0]
CMP	R4, #0
IT	NE
BNE	L_Ethernet_Intern_UserUDP63
;Ethernet_Handlers.c,335 :: 		FilesListCount = FoldersFilesToReceive;
MOVW	R4, #lo_addr(_FoldersFilesToReceive+0)
MOVT	R4, #hi_addr(_FoldersFilesToReceive+0)
LDRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_FilesListCount+0)
MOVT	R4, #hi_addr(_FilesListCount+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,336 :: 		} else {
IT	AL
BAL	L_Ethernet_Intern_UserUDP64
L_Ethernet_Intern_UserUDP63:
;Ethernet_Handlers.c,337 :: 		FilesListCount = FoldersFilesToReceive + 1;
MOVW	R4, #lo_addr(_FoldersFilesToReceive+0)
MOVT	R4, #hi_addr(_FoldersFilesToReceive+0)
LDRB	R4, [R4, #0]
ADDS	R5, R4, #1
MOVW	R4, #lo_addr(_FilesListCount+0)
MOVT	R4, #hi_addr(_FilesListCount+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,338 :: 		}
L_Ethernet_Intern_UserUDP64:
;Ethernet_Handlers.c,340 :: 		if (FilesListCount < 12) { // Empty the rest of the files list
MOVW	R4, #lo_addr(_FilesListCount+0)
MOVT	R4, #hi_addr(_FilesListCount+0)
LDRB	R4, [R4, #0]
CMP	R4, #12
IT	CS
BCS	L_Ethernet_Intern_UserUDP65
;Ethernet_Handlers.c,341 :: 		for (tempI = FilesListCount; tempI < 12; tempI++) {
MOVW	R4, #lo_addr(_FilesListCount+0)
MOVT	R4, #hi_addr(_FilesListCount+0)
; tempI start address is: 12 (R3)
LDRB	R3, [R4, #0]
; tempI end address is: 12 (R3)
UXTH	R0, R3
L_Ethernet_Intern_UserUDP66:
; tempI start address is: 0 (R0)
CMP	R0, #12
IT	CS
BCS	L_Ethernet_Intern_UserUDP67
;Ethernet_Handlers.c,342 :: 		FilesList[tempI].ID = 0;
MOVS	R4, #36
MUL	R5, R4, R0
MOVW	R4, #lo_addr(_FilesList+0)
MOVT	R4, #hi_addr(_FilesList+0)
ADDS	R5, R4, R5
MOVS	R4, #0
STRH	R4, [R5, #0]
;Ethernet_Handlers.c,343 :: 		FilesList[tempI].Type = 0;
MOVS	R4, #36
MUL	R5, R4, R0
MOVW	R4, #lo_addr(_FilesList+0)
MOVT	R4, #hi_addr(_FilesList+0)
ADDS	R4, R4, R5
ADDS	R5, R4, #2
MOVS	R4, #0
STRB	R4, [R5, #0]
;Ethernet_Handlers.c,344 :: 		FilesList[tempI].NameLength = 0;
MOVS	R4, #36
MUL	R5, R4, R0
MOVW	R4, #lo_addr(_FilesList+0)
MOVT	R4, #hi_addr(_FilesList+0)
ADDS	R4, R4, R5
ADDW	R5, R4, #35
MOVS	R4, #0
STRB	R4, [R5, #0]
;Ethernet_Handlers.c,341 :: 		for (tempI = FilesListCount; tempI < 12; tempI++) {
ADDS	R4, R0, #1
; tempI end address is: 0 (R0)
; tempI start address is: 12 (R3)
UXTH	R3, R4
;Ethernet_Handlers.c,345 :: 		}
UXTH	R0, R3
; tempI end address is: 12 (R3)
IT	AL
BAL	L_Ethernet_Intern_UserUDP66
L_Ethernet_Intern_UserUDP67:
;Ethernet_Handlers.c,346 :: 		}
L_Ethernet_Intern_UserUDP65:
;Ethernet_Handlers.c,348 :: 		CurrentState = IDLE;
MOVS	R5, #0
MOVW	R4, #lo_addr(_CurrentState+0)
MOVT	R4, #hi_addr(_CurrentState+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,349 :: 		UI_UpdateFolderName();
BL	_UI_UpdateFolderName+0
;Ethernet_Handlers.c,350 :: 		UI_UpdateFilesList();
BL	_UI_UpdateFilesList+0
;Ethernet_Handlers.c,351 :: 		UI_ResetCursorPos();
BL	_UI_ResetCursorPos+0
;Ethernet_Handlers.c,352 :: 		}
L_Ethernet_Intern_UserUDP62:
;Ethernet_Handlers.c,353 :: 		}
L_Ethernet_Intern_UserUDP57:
;Ethernet_Handlers.c,287 :: 		if (CMD == 0x06 && DataLength > 5 && CurrentState == FOLDER_RECEIVE) {
L__Ethernet_Intern_UserUDP138:
L__Ethernet_Intern_UserUDP137:
L__Ethernet_Intern_UserUDP136:
;Ethernet_Handlers.c,356 :: 		if (CMD == 0x0B && DataLength == 11 && CurrentState == FILE_RECEIVE) {
LDRB	R4, [SP, #1488]
CMP	R4, #11
IT	NE
BNE	L__Ethernet_Intern_UserUDP141
LDRH	R4, [SP, #1490]
CMP	R4, #11
IT	NE
BNE	L__Ethernet_Intern_UserUDP140
MOVW	R4, #lo_addr(_CurrentState+0)
MOVT	R4, #hi_addr(_CurrentState+0)
LDRB	R4, [R4, #0]
CMP	R4, #2
IT	NE
BNE	L__Ethernet_Intern_UserUDP139
L__Ethernet_Intern_UserUDP105:
;Ethernet_Handlers.c,357 :: 		if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFileID) {
ADD	R6, SP, #8
ADDS	R4, R6, #4
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
UXTH	R5, R5
ADDS	R4, R6, #5
LDRB	R4, [R4, #0]
ORRS	R5, R4
UXTH	R5, R5
MOVW	R4, #lo_addr(_CurrentFileID+0)
MOVT	R4, #hi_addr(_CurrentFileID+0)
LDRH	R4, [R4, #0]
CMP	R5, R4
IT	NE
BNE	L_Ethernet_Intern_UserUDP72
;Ethernet_Handlers.c,358 :: 		ReceivingFileLength = ((long)receiveBuffer[6] << 24) | ((long)receiveBuffer[7] << 16) | ((long)receiveBuffer[8] << 8) | ((long)receiveBuffer[9]);
ADD	R8, SP, #8
ADD	R4, R8, #6
LDRB	R4, [R4, #0]
LSLS	R5, R4, #24
ADD	R4, R8, #7
LDRB	R4, [R4, #0]
LSLS	R4, R4, #16
ORRS	R5, R4
ADD	R4, R8, #8
LDRB	R4, [R4, #0]
LSLS	R4, R4, #8
ORRS	R5, R4
ADD	R4, R8, #9
LDRB	R4, [R4, #0]
ORR	R4, R5, R4, LSL #0
MOVW	R7, #lo_addr(_ReceivingFileLength+0)
MOVT	R7, #hi_addr(_ReceivingFileLength+0)
STR	R4, [R7, #0]
;Ethernet_Handlers.c,359 :: 		ReceivingFileDPL = (((long)receiveBuffer[10] << 8) | (long)receiveBuffer[11]);
ADD	R4, R8, #10
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
ADD	R4, R8, #11
LDRB	R4, [R4, #0]
ORR	R6, R5, R4, LSL #0
MOVW	R4, #lo_addr(_ReceivingFileDPL+0)
MOVT	R4, #hi_addr(_ReceivingFileDPL+0)
STRH	R6, [R4, #0]
;Ethernet_Handlers.c,360 :: 		ReceivingDividedPackages = ((long)receiveBuffer[12] << 16) | ((long)receiveBuffer[13] << 8) | ((long)receiveBuffer[14]);
ADD	R4, R8, #12
LDRB	R4, [R4, #0]
LSLS	R5, R4, #16
ADD	R4, R8, #13
LDRB	R4, [R4, #0]
LSLS	R4, R4, #8
ORRS	R5, R4
ADD	R4, R8, #14
LDRB	R4, [R4, #0]
ORRS	R5, R4
MOVW	R4, #lo_addr(_ReceivingDividedPackages+0)
MOVT	R4, #hi_addr(_ReceivingDividedPackages+0)
STR	R5, [R4, #0]
;Ethernet_Handlers.c,361 :: 		ReceivingPackageLeft = ReceivingFileLength - (ReceivingDividedPackages * ReceivingFileDPL);
UXTH	R4, R6
MULS	R5, R4, R5
MOV	R4, R7
LDR	R4, [R4, #0]
SUB	R5, R4, R5
MOVW	R4, #lo_addr(_ReceivingPackageLeft+0)
MOVT	R4, #hi_addr(_ReceivingPackageLeft+0)
STR	R5, [R4, #0]
;Ethernet_Handlers.c,363 :: 		ReceivingCurrentPackage = 0; // Start with first data content package
MOVS	R5, #0
MOVW	R4, #lo_addr(_ReceivingCurrentPackage+0)
MOVT	R4, #hi_addr(_ReceivingCurrentPackage+0)
STR	R4, [SP, #1520]
STR	R5, [R4, #0]
;Ethernet_Handlers.c,365 :: 		UART0_Write_Text("File #");
MOVW	R4, #lo_addr(?lstr15_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr15_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,366 :: 		ByteToStr(CurrentFileID, stringBuffer);
MOVW	R4, #lo_addr(_CurrentFileID+0)
MOVT	R4, #hi_addr(_CurrentFileID+0)
STR	R4, [SP, #1516]
LDRH	R4, [R4, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
UXTB	R0, R4
BL	_ByteToStr+0
;Ethernet_Handlers.c,367 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,368 :: 		UART0_Write_Text(" of ");
MOVW	R4, #lo_addr(?lstr16_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr16_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,369 :: 		LongToStr(ReceivingFileLength, stringBuffer);
MOVW	R4, #lo_addr(_ReceivingFileLength+0)
MOVT	R4, #hi_addr(_ReceivingFileLength+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
MOV	R0, R4
BL	_LongToStr+0
;Ethernet_Handlers.c,370 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,371 :: 		UART0_Write_Text(" bytes");
MOVW	R4, #lo_addr(?lstr17_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr17_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,372 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,373 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,374 :: 		UART0_Write_Text("DPL: ");
MOVW	R4, #lo_addr(?lstr18_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr18_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,375 :: 		IntToStr(ReceivingFileDPL, stringBuffer);
MOVW	R4, #lo_addr(_ReceivingFileDPL+0)
MOVT	R4, #hi_addr(_ReceivingFileDPL+0)
LDRH	R4, [R4, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
SXTH	R0, R4
BL	_IntToStr+0
;Ethernet_Handlers.c,376 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,377 :: 		UART0_Write_Text(" making it divided in ");
MOVW	R4, #lo_addr(?lstr19_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr19_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,378 :: 		LongToStr(ReceivingDividedPackages, stringBuffer);
MOVW	R4, #lo_addr(_ReceivingDividedPackages+0)
MOVT	R4, #hi_addr(_ReceivingDividedPackages+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
MOV	R0, R4
BL	_LongToStr+0
;Ethernet_Handlers.c,379 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,380 :: 		UART0_Write_Text(" packages");
MOVW	R4, #lo_addr(?lstr20_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr20_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,381 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,382 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,385 :: 		UDPTransmitBuffer[0] = DeviceCID;
MOVW	R4, #lo_addr(_DeviceCID+0)
MOVT	R4, #hi_addr(_DeviceCID+0)
LDRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,386 :: 		UDPTransmitBuffer[1] = 0x0C; // Request folder/file name
MOVS	R5, #12
MOVW	R4, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+1)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,387 :: 		UDPTransmitBuffer[2] = 0; // Data length = 5
MOVS	R5, #0
MOVW	R4, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+2)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,388 :: 		UDPTransmitBuffer[3] = 5; // Data length = 5
MOVS	R5, #5
MOVW	R4, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+3)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,389 :: 		UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) > 8;
LDR	R6, [SP, #1516]
MOV	R4, R6
LDRH	R4, [R4, #0]
AND	R4, R4, #65280
UXTH	R4, R4
CMP	R4, #8
MOVW	R5, #0
BLS	L__Ethernet_Intern_UserUDP156
MOVS	R5, #1
L__Ethernet_Intern_UserUDP156:
MOVW	R4, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+4)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,390 :: 		UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
MOV	R4, R6
LDRH	R4, [R4, #0]
AND	R5, R4, #255
MOVW	R4, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+5)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,391 :: 		UDPTransmitBuffer[6] = (ReceivingCurrentPackage & 0xFF0000) >> 16;
LDR	R6, [SP, #1520]
MOV	R4, R6
LDR	R4, [R4, #0]
AND	R4, R4, #16711680
LSRS	R5, R4, #16
MOVW	R4, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+6)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,392 :: 		UDPTransmitBuffer[7] = (ReceivingCurrentPackage & 0xFF00) >> 8;
MOV	R4, R6
LDR	R4, [R4, #0]
AND	R4, R4, #65280
LSRS	R5, R4, #8
MOVW	R4, #lo_addr(_UDPTransmitBuffer+7)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+7)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,393 :: 		UDPTransmitBuffer[8] = (ReceivingCurrentPackage & 0xFF);
MOV	R4, R6
LDR	R4, [R4, #0]
AND	R5, R4, #255
MOVW	R4, #lo_addr(_UDPTransmitBuffer+8)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+8)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,394 :: 		UDPTransmitBuffer[9] = Calculate_Checksum(UDPTransmitBuffer, 9);
MOVS	R1, #9
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R4, #lo_addr(_UDPTransmitBuffer+9)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+9)
STRB	R0, [R4, #0]
;Ethernet_Handlers.c,395 :: 		sendLength = 10;
MOVS	R4, #10
STRB	R4, [SP, #1492]
;Ethernet_Handlers.c,397 :: 		UART0_Write_Text("Requesting file package ");
MOVW	R4, #lo_addr(?lstr21_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr21_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,398 :: 		LongToStr(ReceivingCurrentPackage, stringBuffer);
MOVW	R4, #lo_addr(_ReceivingCurrentPackage+0)
MOVT	R4, #hi_addr(_ReceivingCurrentPackage+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
MOV	R0, R4
BL	_LongToStr+0
;Ethernet_Handlers.c,399 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,400 :: 		UART0_Write('/');
MOVS	R0, #47
BL	_UART0_Write+0
;Ethernet_Handlers.c,401 :: 		LongToStr(ReceivingDividedPackages, stringBuffer);
MOVW	R4, #lo_addr(_ReceivingDividedPackages+0)
MOVT	R4, #hi_addr(_ReceivingDividedPackages+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
MOV	R0, R4
BL	_LongToStr+0
;Ethernet_Handlers.c,402 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,403 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,404 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,406 :: 		CurrentBuffer = 0; // Start using AudioBuffer2
MOVS	R5, #0
SXTB	R5, R5
MOVW	R4, #lo_addr(_CurrentBuffer+0)
MOVT	R4, #hi_addr(_CurrentBuffer+0)
STR	R5, [R4, #0]
;Ethernet_Handlers.c,407 :: 		CurrentBuffer1MaxPos = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_CurrentBuffer1MaxPos+0)
MOVT	R4, #hi_addr(_CurrentBuffer1MaxPos+0)
STRH	R5, [R4, #0]
;Ethernet_Handlers.c,408 :: 		CurrentBuffer2MaxPos = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_CurrentBuffer2MaxPos+0)
MOVT	R4, #hi_addr(_CurrentBuffer2MaxPos+0)
STRH	R5, [R4, #0]
;Ethernet_Handlers.c,409 :: 		CurrentBufferPos = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_CurrentBufferPos+0)
MOVT	R4, #hi_addr(_CurrentBufferPos+0)
STRH	R5, [R4, #0]
;Ethernet_Handlers.c,410 :: 		FirstBufferFill = 1;
MOVS	R5, #1
SXTB	R5, R5
MOVW	R4, #lo_addr(_FirstBufferFill+0)
MOVT	R4, #hi_addr(_FirstBufferFill+0)
STR	R5, [R4, #0]
;Ethernet_Handlers.c,412 :: 		halfSecondCountdownTimer = 5; // Make sure download is kept alive
MOVS	R5, #5
MOVW	R4, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R4, #hi_addr(_halfSecondCountdownTimer+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,413 :: 		ErrorCounter = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_ErrorCounter+0)
MOVT	R4, #hi_addr(_ErrorCounter+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,414 :: 		}
L_Ethernet_Intern_UserUDP72:
;Ethernet_Handlers.c,356 :: 		if (CMD == 0x0B && DataLength == 11 && CurrentState == FILE_RECEIVE) {
L__Ethernet_Intern_UserUDP141:
L__Ethernet_Intern_UserUDP140:
L__Ethernet_Intern_UserUDP139:
;Ethernet_Handlers.c,417 :: 		if (CMD == 0x1B && DataLength == 11 && CurrentState == IMAGE_RECEIVE) {
LDRB	R4, [SP, #1488]
CMP	R4, #27
IT	NE
BNE	L__Ethernet_Intern_UserUDP144
LDRH	R4, [SP, #1490]
CMP	R4, #11
IT	NE
BNE	L__Ethernet_Intern_UserUDP143
MOVW	R4, #lo_addr(_CurrentState+0)
MOVT	R4, #hi_addr(_CurrentState+0)
LDRB	R4, [R4, #0]
CMP	R4, #4
IT	NE
BNE	L__Ethernet_Intern_UserUDP142
L__Ethernet_Intern_UserUDP104:
;Ethernet_Handlers.c,418 :: 		if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFileID) {
ADD	R6, SP, #8
ADDS	R4, R6, #4
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
UXTH	R5, R5
ADDS	R4, R6, #5
LDRB	R4, [R4, #0]
ORRS	R5, R4
UXTH	R5, R5
MOVW	R4, #lo_addr(_CurrentFileID+0)
MOVT	R4, #hi_addr(_CurrentFileID+0)
LDRH	R4, [R4, #0]
CMP	R5, R4
IT	NE
BNE	L_Ethernet_Intern_UserUDP76
;Ethernet_Handlers.c,419 :: 		ReceivingImageWidth = (((long)receiveBuffer[6] << 8) | (long)receiveBuffer[7]);
ADD	R7, SP, #8
ADDS	R4, R7, #6
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
ADDS	R4, R7, #7
LDRB	R4, [R4, #0]
ORR	R9, R5, R4, LSL #0
MOVW	R4, #lo_addr(_ReceivingImageWidth+0)
MOVT	R4, #hi_addr(_ReceivingImageWidth+0)
STRH	R9, [R4, #0]
;Ethernet_Handlers.c,420 :: 		ReceivingImageHeight = (((long)receiveBuffer[8] << 8) | (long)receiveBuffer[9]);
ADDW	R4, R7, #8
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
ADDW	R4, R7, #9
LDRB	R4, [R4, #0]
ORR	R6, R5, R4, LSL #0
MOVW	R4, #lo_addr(_ReceivingImageHeight+0)
MOVT	R4, #hi_addr(_ReceivingImageHeight+0)
STRH	R6, [R4, #0]
;Ethernet_Handlers.c,421 :: 		ReceivingFileDPL = (((long)receiveBuffer[10] << 8) | (long)receiveBuffer[11]);
ADDW	R4, R7, #10
LDRB	R4, [R4, #0]
LSLS	R5, R4, #8
ADDW	R4, R7, #11
LDRB	R4, [R4, #0]
ORR	R4, R5, R4, LSL #0
MOVW	R8, #lo_addr(_ReceivingFileDPL+0)
MOVT	R8, #hi_addr(_ReceivingFileDPL+0)
STRH	R4, [R8, #0]
;Ethernet_Handlers.c,422 :: 		ReceivingDividedPackages = ((long)receiveBuffer[12] << 16) | ((long)receiveBuffer[13] << 8) | ((long)receiveBuffer[14]);
ADDW	R4, R7, #12
LDRB	R4, [R4, #0]
LSLS	R5, R4, #16
ADDW	R4, R7, #13
LDRB	R4, [R4, #0]
LSLS	R4, R4, #8
ORRS	R5, R4
ADDW	R4, R7, #14
LDRB	R4, [R4, #0]
ORR	R4, R5, R4, LSL #0
MOVW	R7, #lo_addr(_ReceivingDividedPackages+0)
MOVT	R7, #hi_addr(_ReceivingDividedPackages+0)
STR	R4, [R7, #0]
;Ethernet_Handlers.c,423 :: 		ReceivingFileLength = ReceivingImageWidth * ReceivingImageHeight * 2;
UXTH	R5, R6
UXTH	R4, R9
MULS	R4, R5, R4
UXTH	R4, R4
LSLS	R4, R4, #1
UXTH	R4, R4
MOVW	R6, #lo_addr(_ReceivingFileLength+0)
MOVT	R6, #hi_addr(_ReceivingFileLength+0)
STR	R4, [R6, #0]
;Ethernet_Handlers.c,424 :: 		ReceivingPackageLeft = ReceivingFileLength - (ReceivingDividedPackages * ReceivingFileDPL);
MOV	R4, R8
LDRH	R5, [R4, #0]
MOV	R4, R7
LDR	R4, [R4, #0]
MULS	R5, R4, R5
MOV	R4, R6
LDR	R4, [R4, #0]
SUB	R5, R4, R5
MOVW	R4, #lo_addr(_ReceivingPackageLeft+0)
MOVT	R4, #hi_addr(_ReceivingPackageLeft+0)
STR	R5, [R4, #0]
;Ethernet_Handlers.c,426 :: 		ReceivingCurrentPackage = 0; // Start with first data content package
MOVS	R5, #0
MOVW	R4, #lo_addr(_ReceivingCurrentPackage+0)
MOVT	R4, #hi_addr(_ReceivingCurrentPackage+0)
STR	R4, [SP, #1520]
STR	R5, [R4, #0]
;Ethernet_Handlers.c,428 :: 		UART0_Write_Text("File #");
MOVW	R4, #lo_addr(?lstr22_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr22_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,429 :: 		ByteToStr(CurrentFileID, stringBuffer);
MOVW	R4, #lo_addr(_CurrentFileID+0)
MOVT	R4, #hi_addr(_CurrentFileID+0)
STR	R4, [SP, #1516]
LDRH	R4, [R4, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
UXTB	R0, R4
BL	_ByteToStr+0
;Ethernet_Handlers.c,430 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,431 :: 		UART0_Write_Text(" of ");
MOVW	R4, #lo_addr(?lstr23_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr23_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,432 :: 		LongToStr(ReceivingFileLength, stringBuffer);
MOVW	R4, #lo_addr(_ReceivingFileLength+0)
MOVT	R4, #hi_addr(_ReceivingFileLength+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
MOV	R0, R4
BL	_LongToStr+0
;Ethernet_Handlers.c,433 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,434 :: 		UART0_Write_Text(" bytes");
MOVW	R4, #lo_addr(?lstr24_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr24_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,435 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,436 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,437 :: 		UART0_Write_Text("DPL: ");
MOVW	R4, #lo_addr(?lstr25_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr25_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,438 :: 		IntToStr(ReceivingFileDPL, stringBuffer);
MOVW	R4, #lo_addr(_ReceivingFileDPL+0)
MOVT	R4, #hi_addr(_ReceivingFileDPL+0)
LDRH	R4, [R4, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
SXTH	R0, R4
BL	_IntToStr+0
;Ethernet_Handlers.c,439 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,440 :: 		UART0_Write_Text(" making it divided in ");
MOVW	R4, #lo_addr(?lstr26_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr26_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,441 :: 		LongToStr(ReceivingDividedPackages, stringBuffer);
MOVW	R4, #lo_addr(_ReceivingDividedPackages+0)
MOVT	R4, #hi_addr(_ReceivingDividedPackages+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
MOV	R0, R4
BL	_LongToStr+0
;Ethernet_Handlers.c,442 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,443 :: 		UART0_Write_Text(" packages");
MOVW	R4, #lo_addr(?lstr27_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr27_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,444 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,445 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,448 :: 		UDPTransmitBuffer[0] = DeviceCID;
MOVW	R4, #lo_addr(_DeviceCID+0)
MOVT	R4, #hi_addr(_DeviceCID+0)
LDRB	R5, [R4, #0]
MOVW	R4, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,449 :: 		UDPTransmitBuffer[1] = 0x1C; // Request folder/file name
MOVS	R5, #28
MOVW	R4, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+1)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,450 :: 		UDPTransmitBuffer[2] = 0; // Data length = 5
MOVS	R5, #0
MOVW	R4, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+2)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,451 :: 		UDPTransmitBuffer[3] = 5; // Data length = 5
MOVS	R5, #5
MOVW	R4, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+3)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,452 :: 		UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) > 8;
LDR	R6, [SP, #1516]
MOV	R4, R6
LDRH	R4, [R4, #0]
AND	R4, R4, #65280
UXTH	R4, R4
CMP	R4, #8
MOVW	R5, #0
BLS	L__Ethernet_Intern_UserUDP157
MOVS	R5, #1
L__Ethernet_Intern_UserUDP157:
MOVW	R4, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+4)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,453 :: 		UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
MOV	R4, R6
LDRH	R4, [R4, #0]
AND	R5, R4, #255
MOVW	R4, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+5)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,454 :: 		UDPTransmitBuffer[6] = (ReceivingCurrentPackage & 0xFF0000) >> 16;
LDR	R6, [SP, #1520]
MOV	R4, R6
LDR	R4, [R4, #0]
AND	R4, R4, #16711680
LSRS	R5, R4, #16
MOVW	R4, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+6)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,455 :: 		UDPTransmitBuffer[7] = (ReceivingCurrentPackage & 0xFF00) >> 8;
MOV	R4, R6
LDR	R4, [R4, #0]
AND	R4, R4, #65280
LSRS	R5, R4, #8
MOVW	R4, #lo_addr(_UDPTransmitBuffer+7)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+7)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,456 :: 		UDPTransmitBuffer[8] = (ReceivingCurrentPackage & 0xFF);
MOV	R4, R6
LDR	R4, [R4, #0]
AND	R5, R4, #255
MOVW	R4, #lo_addr(_UDPTransmitBuffer+8)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+8)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,457 :: 		UDPTransmitBuffer[9] = Calculate_Checksum(UDPTransmitBuffer, 9);
MOVS	R1, #9
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R4, #lo_addr(_UDPTransmitBuffer+9)
MOVT	R4, #hi_addr(_UDPTransmitBuffer+9)
STRB	R0, [R4, #0]
;Ethernet_Handlers.c,458 :: 		sendLength = 10;
MOVS	R4, #10
STRB	R4, [SP, #1492]
;Ethernet_Handlers.c,460 :: 		UART0_Write_Text("Requesting file package ");
MOVW	R4, #lo_addr(?lstr28_Ethernet_Handlers+0)
MOVT	R4, #hi_addr(?lstr28_Ethernet_Handlers+0)
MOV	R0, R4
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,461 :: 		LongToStr(ReceivingCurrentPackage, stringBuffer);
MOVW	R4, #lo_addr(_ReceivingCurrentPackage+0)
MOVT	R4, #hi_addr(_ReceivingCurrentPackage+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
MOV	R0, R4
BL	_LongToStr+0
;Ethernet_Handlers.c,462 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,463 :: 		UART0_Write('/');
MOVS	R0, #47
BL	_UART0_Write+0
;Ethernet_Handlers.c,464 :: 		LongToStr(ReceivingDividedPackages, stringBuffer);
MOVW	R4, #lo_addr(_ReceivingDividedPackages+0)
MOVT	R4, #hi_addr(_ReceivingDividedPackages+0)
LDR	R4, [R4, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
MOV	R0, R4
BL	_LongToStr+0
;Ethernet_Handlers.c,465 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,466 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,467 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,469 :: 		halfSecondCountdownTimer = 5;
MOVS	R5, #5
MOVW	R4, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R4, #hi_addr(_halfSecondCountdownTimer+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,470 :: 		ErrorCounter = 0;
MOVS	R5, #0
MOVW	R4, #lo_addr(_ErrorCounter+0)
MOVT	R4, #hi_addr(_ErrorCounter+0)
STRB	R5, [R4, #0]
;Ethernet_Handlers.c,471 :: 		}
L_Ethernet_Intern_UserUDP76:
;Ethernet_Handlers.c,417 :: 		if (CMD == 0x1B && DataLength == 11 && CurrentState == IMAGE_RECEIVE) {
L__Ethernet_Intern_UserUDP144:
L__Ethernet_Intern_UserUDP143:
L__Ethernet_Intern_UserUDP142:
;Ethernet_Handlers.c,474 :: 		if (sendLength > 0) {
LDRB	R4, [SP, #1492]
CMP	R4, #0
IT	LS
BLS	L_Ethernet_Intern_UserUDP77
;Ethernet_Handlers.c,475 :: 		delay_ms(10); // Make a bit delay between sending packages to limit server stress (not getting the packet)
MOVW	R7, #43391
MOVT	R7, #3
NOP
NOP
L_Ethernet_Intern_UserUDP78:
SUBS	R7, R7, #1
BNE	L_Ethernet_Intern_UserUDP78
NOP
NOP
;Ethernet_Handlers.c,476 :: 		Ethernet_Intern_writePayloadBytes(UDPTransmitBuffer, 0, sendLength);
LDRB	R2, [SP, #1492]
MOVS	R1, #0
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Ethernet_Intern_writePayloadBytes+0
;Ethernet_Handlers.c,477 :: 		}
L_Ethernet_Intern_UserUDP77:
;Ethernet_Handlers.c,479 :: 		return (sendLength);
LDRB	R0, [SP, #1492]
;Ethernet_Handlers.c,480 :: 		}
L_end_Ethernet_Intern_UserUDP:
LDR	LR, [SP, #0]
ADDW	SP, SP, #1524
BX	LR
; end of _Ethernet_Intern_UserUDP
_Calculate_Checksum:
;Ethernet_Handlers.c,482 :: 		unsigned char Calculate_Checksum(unsigned char *UDP_Package, unsigned int length) // Length without Checksum byte
; length start address is: 4 (R1)
; UDP_Package start address is: 0 (R0)
SUB	SP, SP, #4
;Ethernet_Handlers.c,485 :: 		unsigned int temp = 0;
; length end address is: 4 (R1)
; UDP_Package end address is: 0 (R0)
; UDP_Package start address is: 0 (R0)
; length start address is: 4 (R1)
; temp start address is: 16 (R4)
MOVW	R4, #0
;Ethernet_Handlers.c,487 :: 		for (i = 0; i < length; i++)
; i start address is: 12 (R3)
MOVS	R3, #0
; UDP_Package end address is: 0 (R0)
; length end address is: 4 (R1)
; temp end address is: 16 (R4)
; i end address is: 12 (R3)
STRH	R1, [SP, #0]
MOV	R1, R0
LDRH	R0, [SP, #0]
L_Calculate_Checksum80:
; i start address is: 12 (R3)
; UDP_Package start address is: 4 (R1)
; temp start address is: 16 (R4)
; length start address is: 0 (R0)
; UDP_Package start address is: 4 (R1)
; UDP_Package end address is: 4 (R1)
CMP	R3, R0
IT	CS
BCS	L_Calculate_Checksum81
; UDP_Package end address is: 4 (R1)
;Ethernet_Handlers.c,489 :: 		temp += UDP_Package[i];
; UDP_Package start address is: 4 (R1)
ADDS	R2, R1, R3
LDRB	R2, [R2, #0]
ADDS	R4, R4, R2
UXTH	R4, R4
;Ethernet_Handlers.c,487 :: 		for (i = 0; i < length; i++)
ADDS	R3, R3, #1
UXTH	R3, R3
;Ethernet_Handlers.c,490 :: 		}
; length end address is: 0 (R0)
; UDP_Package end address is: 4 (R1)
; i end address is: 12 (R3)
IT	AL
BAL	L_Calculate_Checksum80
L_Calculate_Checksum81:
;Ethernet_Handlers.c,492 :: 		temp = temp & 0xFF;
AND	R2, R4, #255
UXTH	R2, R2
; temp end address is: 16 (R4)
;Ethernet_Handlers.c,493 :: 		temp ^= 0xFF;
EOR	R2, R2, #255
;Ethernet_Handlers.c,494 :: 		return temp;
UXTB	R0, R2
;Ethernet_Handlers.c,495 :: 		}
L_end_Calculate_Checksum:
ADD	SP, SP, #4
BX	LR
; end of _Calculate_Checksum
_RequestRootFolder:
;Ethernet_Handlers.c,497 :: 		void RequestRootFolder()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;Ethernet_Handlers.c,499 :: 		CurrentFolderID = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CurrentFolderID+0)
MOVT	R0, #hi_addr(_CurrentFolderID+0)
STR	R0, [SP, #4]
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,500 :: 		memcpy(CurrentFolderName, "[ROOT]", 7);
MOVW	R0, #lo_addr(?lstr29_Ethernet_Handlers+0)
MOVT	R0, #hi_addr(?lstr29_Ethernet_Handlers+0)
MOVS	R2, #7
SXTH	R2, R2
MOV	R1, R0
MOVW	R0, #lo_addr(_CurrentFolderName+0)
MOVT	R0, #hi_addr(_CurrentFolderName+0)
BL	_memcpy+0
;Ethernet_Handlers.c,501 :: 		CurrentState = FOLDER_RECEIVE;
MOVS	R1, #1
MOVW	R0, #lo_addr(_CurrentState+0)
MOVT	R0, #hi_addr(_CurrentState+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,503 :: 		UDPTransmitBuffer[0] = DeviceCID; // Empty CID (Request for new CID)
MOVW	R0, #lo_addr(_DeviceCID+0)
MOVT	R0, #hi_addr(_DeviceCID+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,504 :: 		UDPTransmitBuffer[1] = 0x03; // Request files/folders list
MOVS	R1, #3
MOVW	R0, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+1)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,505 :: 		UDPTransmitBuffer[2] = 0; // Data length
MOVS	R1, #0
MOVW	R0, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+2)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,506 :: 		UDPTransmitBuffer[3] = 2; // Data length
MOVS	R1, #2
MOVW	R0, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+3)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,507 :: 		UDPTransmitBuffer[4] = (CurrentFolderID & 0xFF00) >> 8;
LDR	R2, [SP, #4]
MOV	R0, R2
LDRB	R0, [R0, #0]
AND	R0, R0, #65280
UXTH	R0, R0
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+4)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,508 :: 		UDPTransmitBuffer[5] = (CurrentFolderID & 0xFF);
MOV	R0, R2
LDRB	R0, [R0, #0]
AND	R1, R0, #255
MOVW	R0, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+5)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,509 :: 		UDPTransmitBuffer[6] = Calculate_Checksum(UDPTransmitBuffer, 6);
MOVS	R1, #6
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R1, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+6)
STRB	R0, [R1, #0]
;Ethernet_Handlers.c,510 :: 		Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 7);
MOVS	R0, #7
PUSH	(R0)
MOVW	R3, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+0)
MOVW	R2, #1111
MOVW	R1, #1111
MOVW	R0, #lo_addr(_serverIpAddr+0)
MOVT	R0, #hi_addr(_serverIpAddr+0)
BL	_Ethernet_Intern_sendUDP+0
ADD	SP, SP, #4
;Ethernet_Handlers.c,512 :: 		halfSecondCountdownTimer = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R0, #hi_addr(_halfSecondCountdownTimer+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,513 :: 		ErrorCounter = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ErrorCounter+0)
MOVT	R0, #hi_addr(_ErrorCounter+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,514 :: 		}
L_end_RequestRootFolder:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _RequestRootFolder
_RequestFolderContent:
;Ethernet_Handlers.c,517 :: 		void RequestFolderContent(unsigned int FolderID, unsigned char * folderName, unsigned char folderNameLength)
; folderNameLength start address is: 8 (R2)
; folderName start address is: 4 (R1)
; FolderID start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Ethernet_Handlers.c,519 :: 		PreviousFolderID = CurrentFolderID;
UXTB	R6, R2
; folderNameLength end address is: 8 (R2)
; folderName end address is: 4 (R1)
; FolderID end address is: 0 (R0)
; FolderID start address is: 0 (R0)
; folderName start address is: 4 (R1)
; folderNameLength start address is: 24 (R6)
MOVW	R5, #lo_addr(_CurrentFolderID+0)
MOVT	R5, #hi_addr(_CurrentFolderID+0)
LDRB	R4, [R5, #0]
MOVW	R3, #lo_addr(_PreviousFolderID+0)
MOVT	R3, #hi_addr(_PreviousFolderID+0)
STRB	R4, [R3, #0]
;Ethernet_Handlers.c,520 :: 		CurrentFolderID = FolderID;
STRB	R0, [R5, #0]
;Ethernet_Handlers.c,521 :: 		CurrentState = FOLDER_RECEIVE;
MOVS	R4, #1
MOVW	R3, #lo_addr(_CurrentState+0)
MOVT	R3, #hi_addr(_CurrentState+0)
STRB	R4, [R3, #0]
;Ethernet_Handlers.c,523 :: 		if (FolderID == 0) {
CMP	R0, #0
IT	NE
BNE	L_RequestFolderContent83
; FolderID end address is: 0 (R0)
; folderName end address is: 4 (R1)
; folderNameLength end address is: 24 (R6)
;Ethernet_Handlers.c,524 :: 		memcpy(CurrentFolderName, "[ROOT]", 7);
MOVW	R3, #lo_addr(?lstr30_Ethernet_Handlers+0)
MOVT	R3, #hi_addr(?lstr30_Ethernet_Handlers+0)
MOVS	R2, #7
SXTH	R2, R2
MOV	R1, R3
MOVW	R0, #lo_addr(_CurrentFolderName+0)
MOVT	R0, #hi_addr(_CurrentFolderName+0)
BL	_memcpy+0
;Ethernet_Handlers.c,525 :: 		} else {
IT	AL
BAL	L_RequestFolderContent84
L_RequestFolderContent83:
;Ethernet_Handlers.c,526 :: 		memcpy(CurrentFolderName, folderName, folderNameLength);
; folderNameLength start address is: 24 (R6)
; folderName start address is: 4 (R1)
UXTB	R2, R6
; folderName end address is: 4 (R1)
MOVW	R0, #lo_addr(_CurrentFolderName+0)
MOVT	R0, #hi_addr(_CurrentFolderName+0)
BL	_memcpy+0
;Ethernet_Handlers.c,527 :: 		CurrentFolderName[folderNameLength] = 0x00;
MOVW	R3, #lo_addr(_CurrentFolderName+0)
MOVT	R3, #hi_addr(_CurrentFolderName+0)
ADDS	R4, R3, R6
; folderNameLength end address is: 24 (R6)
MOVS	R3, #0
STRB	R3, [R4, #0]
;Ethernet_Handlers.c,528 :: 		}
L_RequestFolderContent84:
;Ethernet_Handlers.c,530 :: 		UDPTransmitBuffer[0] = DeviceCID; // Empty CID (Request for new CID)
MOVW	R3, #lo_addr(_DeviceCID+0)
MOVT	R3, #hi_addr(_DeviceCID+0)
LDRB	R4, [R3, #0]
MOVW	R3, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+0)
STRB	R4, [R3, #0]
;Ethernet_Handlers.c,531 :: 		UDPTransmitBuffer[1] = 0x03; // Request files/folders list
MOVS	R4, #3
MOVW	R3, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+1)
STRB	R4, [R3, #0]
;Ethernet_Handlers.c,532 :: 		UDPTransmitBuffer[2] = 0; // Data length
MOVS	R4, #0
MOVW	R3, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+2)
STRB	R4, [R3, #0]
;Ethernet_Handlers.c,533 :: 		UDPTransmitBuffer[3] = 2; // Data length
MOVS	R4, #2
MOVW	R3, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+3)
STRB	R4, [R3, #0]
;Ethernet_Handlers.c,534 :: 		UDPTransmitBuffer[4] = (CurrentFolderID & 0xFF00) >> 8;
MOVW	R5, #lo_addr(_CurrentFolderID+0)
MOVT	R5, #hi_addr(_CurrentFolderID+0)
LDRB	R3, [R5, #0]
AND	R3, R3, #65280
UXTH	R3, R3
LSRS	R4, R3, #8
MOVW	R3, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+4)
STRB	R4, [R3, #0]
;Ethernet_Handlers.c,535 :: 		UDPTransmitBuffer[5] = (CurrentFolderID & 0xFF);
MOV	R3, R5
LDRB	R3, [R3, #0]
AND	R4, R3, #255
MOVW	R3, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+5)
STRB	R4, [R3, #0]
;Ethernet_Handlers.c,536 :: 		UDPTransmitBuffer[6] = Calculate_Checksum(UDPTransmitBuffer, 6);
MOVS	R1, #6
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R3, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+6)
STRB	R0, [R3, #0]
;Ethernet_Handlers.c,537 :: 		Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 7);
MOVS	R3, #7
PUSH	(R3)
MOVW	R3, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+0)
MOVW	R2, #1111
MOVW	R1, #1111
MOVW	R0, #lo_addr(_serverIpAddr+0)
MOVT	R0, #hi_addr(_serverIpAddr+0)
BL	_Ethernet_Intern_sendUDP+0
ADD	SP, SP, #4
;Ethernet_Handlers.c,539 :: 		halfSecondCountdownTimer = 5;
MOVS	R4, #5
MOVW	R3, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R3, #hi_addr(_halfSecondCountdownTimer+0)
STRB	R4, [R3, #0]
;Ethernet_Handlers.c,540 :: 		ErrorCounter = 0;
MOVS	R4, #0
MOVW	R3, #lo_addr(_ErrorCounter+0)
MOVT	R3, #hi_addr(_ErrorCounter+0)
STRB	R4, [R3, #0]
;Ethernet_Handlers.c,541 :: 		}
L_end_RequestFolderContent:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _RequestFolderContent
_PlayAudio:
;Ethernet_Handlers.c,543 :: 		void PlayAudio(unsigned int AudioID)
; AudioID start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Ethernet_Handlers.c,545 :: 		CurrentFileID = AudioID;
; AudioID end address is: 0 (R0)
; AudioID start address is: 0 (R0)
MOVW	R1, #lo_addr(_CurrentFileID+0)
MOVT	R1, #hi_addr(_CurrentFileID+0)
STRH	R0, [R1, #0]
;Ethernet_Handlers.c,546 :: 		CurrentState = FILE_RECEIVE;
MOVS	R2, #2
MOVW	R1, #lo_addr(_CurrentState+0)
MOVT	R1, #hi_addr(_CurrentState+0)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,548 :: 		UDPTransmitBuffer[0] = DeviceCID; // Empty CID (Request for new CID)
MOVW	R1, #lo_addr(_DeviceCID+0)
MOVT	R1, #hi_addr(_DeviceCID+0)
LDRB	R2, [R1, #0]
MOVW	R1, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+0)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,549 :: 		UDPTransmitBuffer[1] = 0x0A; // Request file information and length
MOVS	R2, #10
MOVW	R1, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+1)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,550 :: 		UDPTransmitBuffer[2] = 0; // Data length
MOVS	R2, #0
MOVW	R1, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+2)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,551 :: 		UDPTransmitBuffer[3] = 2; // Data length
MOVS	R2, #2
MOVW	R1, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+3)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,552 :: 		UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
AND	R1, R0, #65280
UXTH	R1, R1
LSRS	R2, R1, #8
MOVW	R1, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+4)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,553 :: 		UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
AND	R2, R0, #255
; AudioID end address is: 0 (R0)
MOVW	R1, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+5)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,554 :: 		UDPTransmitBuffer[6] = Calculate_Checksum(UDPTransmitBuffer, 6);
MOVS	R1, #6
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R1, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+6)
STRB	R0, [R1, #0]
;Ethernet_Handlers.c,555 :: 		Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 7);
MOVS	R1, #7
PUSH	(R1)
MOVW	R3, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+0)
MOVW	R2, #1111
MOVW	R1, #1111
MOVW	R0, #lo_addr(_serverIpAddr+0)
MOVT	R0, #hi_addr(_serverIpAddr+0)
BL	_Ethernet_Intern_sendUDP+0
ADD	SP, SP, #4
;Ethernet_Handlers.c,557 :: 		halfSecondCountdownTimer = 5;
MOVS	R2, #5
MOVW	R1, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R1, #hi_addr(_halfSecondCountdownTimer+0)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,558 :: 		ErrorCounter = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ErrorCounter+0)
MOVT	R1, #hi_addr(_ErrorCounter+0)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,559 :: 		}
L_end_PlayAudio:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _PlayAudio
_SaveAudio:
;Ethernet_Handlers.c,561 :: 		void SaveAudio(unsigned int AudioID, unsigned char * FileName)
; FileName start address is: 4 (R1)
; AudioID start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;Ethernet_Handlers.c,563 :: 		fileHandle = FAT32_Open(FileName, FILE_WRITE);
STR	R1, [SP, #4]
UXTH	R1, R0
LDR	R0, [SP, #4]
; FileName end address is: 4 (R1)
; AudioID end address is: 0 (R0)
; AudioID start address is: 4 (R1)
; FileName start address is: 0 (R0)
STRH	R1, [SP, #4]
MOVS	R1, #2
; FileName end address is: 0 (R0)
BL	_FAT32_Open+0
LDRH	R1, [SP, #4]
MOVW	R2, #lo_addr(_fileHandle+0)
MOVT	R2, #hi_addr(_fileHandle+0)
STRB	R0, [R2, #0]
;Ethernet_Handlers.c,564 :: 		CurrentFileID = AudioID;
MOVW	R2, #lo_addr(_CurrentFileID+0)
MOVT	R2, #hi_addr(_CurrentFileID+0)
STRH	R1, [R2, #0]
;Ethernet_Handlers.c,565 :: 		CurrentState = FILE_RECEIVE;
MOVS	R3, #2
MOVW	R2, #lo_addr(_CurrentState+0)
MOVT	R2, #hi_addr(_CurrentState+0)
STRB	R3, [R2, #0]
;Ethernet_Handlers.c,567 :: 		UDPTransmitBuffer[0] = DeviceCID; // Empty CID (Request for new CID)
MOVW	R2, #lo_addr(_DeviceCID+0)
MOVT	R2, #hi_addr(_DeviceCID+0)
LDRB	R3, [R2, #0]
MOVW	R2, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R2, #hi_addr(_UDPTransmitBuffer+0)
STRB	R3, [R2, #0]
;Ethernet_Handlers.c,568 :: 		UDPTransmitBuffer[1] = 0x0A; // Request file information and length
MOVS	R3, #10
MOVW	R2, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R2, #hi_addr(_UDPTransmitBuffer+1)
STRB	R3, [R2, #0]
;Ethernet_Handlers.c,569 :: 		UDPTransmitBuffer[2] = 0; // Data length
MOVS	R3, #0
MOVW	R2, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R2, #hi_addr(_UDPTransmitBuffer+2)
STRB	R3, [R2, #0]
;Ethernet_Handlers.c,570 :: 		UDPTransmitBuffer[3] = 2; // Data length
MOVS	R3, #2
MOVW	R2, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R2, #hi_addr(_UDPTransmitBuffer+3)
STRB	R3, [R2, #0]
;Ethernet_Handlers.c,571 :: 		UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
AND	R2, R1, #65280
UXTH	R2, R2
LSRS	R3, R2, #8
MOVW	R2, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R2, #hi_addr(_UDPTransmitBuffer+4)
STRB	R3, [R2, #0]
;Ethernet_Handlers.c,572 :: 		UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
AND	R3, R1, #255
; AudioID end address is: 4 (R1)
MOVW	R2, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R2, #hi_addr(_UDPTransmitBuffer+5)
STRB	R3, [R2, #0]
;Ethernet_Handlers.c,573 :: 		UDPTransmitBuffer[6] = Calculate_Checksum(UDPTransmitBuffer, 6);
MOVS	R1, #6
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R2, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R2, #hi_addr(_UDPTransmitBuffer+6)
STRB	R0, [R2, #0]
;Ethernet_Handlers.c,574 :: 		Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 7);
MOVS	R2, #7
PUSH	(R2)
MOVW	R3, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+0)
MOVW	R2, #1111
MOVW	R1, #1111
MOVW	R0, #lo_addr(_serverIpAddr+0)
MOVT	R0, #hi_addr(_serverIpAddr+0)
BL	_Ethernet_Intern_sendUDP+0
ADD	SP, SP, #4
;Ethernet_Handlers.c,576 :: 		halfSecondCountdownTimer = 5;
MOVS	R3, #5
MOVW	R2, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R2, #hi_addr(_halfSecondCountdownTimer+0)
STRB	R3, [R2, #0]
;Ethernet_Handlers.c,577 :: 		ErrorCounter = 0;
MOVS	R3, #0
MOVW	R2, #lo_addr(_ErrorCounter+0)
MOVT	R2, #hi_addr(_ErrorCounter+0)
STRB	R3, [R2, #0]
;Ethernet_Handlers.c,578 :: 		}
L_end_SaveAudio:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _SaveAudio
_AudioFinished:
;Ethernet_Handlers.c,580 :: 		void AudioFinished(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Ethernet_Handlers.c,583 :: 		MP3_Reset();
BL	_MP3_Reset+0
;Ethernet_Handlers.c,584 :: 		UART0_Write_Text("Finished playing");
MOVW	R0, #lo_addr(?lstr31_Ethernet_Handlers+0)
MOVT	R0, #hi_addr(?lstr31_Ethernet_Handlers+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,585 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,586 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,587 :: 		}
L_end_AudioFinished:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _AudioFinished
_TerminateAudio:
;Ethernet_Handlers.c,589 :: 		void TerminateAudio(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Ethernet_Handlers.c,592 :: 		MP3_Reset();
BL	_MP3_Reset+0
;Ethernet_Handlers.c,593 :: 		UART0_Write_Text("Stopped playing");
MOVW	R0, #lo_addr(?lstr32_Ethernet_Handlers+0)
MOVT	R0, #hi_addr(?lstr32_Ethernet_Handlers+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,594 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,595 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,596 :: 		}
L_end_TerminateAudio:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _TerminateAudio
_RequestNextAudioPackage:
;Ethernet_Handlers.c,598 :: 		void RequestNextAudioPackage()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;Ethernet_Handlers.c,601 :: 		UART0_Write_Text("Requesting package ");
MOVW	R0, #lo_addr(?lstr33_Ethernet_Handlers+0)
MOVT	R0, #hi_addr(?lstr33_Ethernet_Handlers+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,602 :: 		LongToStr(ReceivingCurrentPackage, stringBuffer);
MOVW	R0, #lo_addr(_ReceivingCurrentPackage+0)
MOVT	R0, #hi_addr(_ReceivingCurrentPackage+0)
STR	R0, [SP, #4]
LDR	R0, [R0, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
BL	_LongToStr+0
;Ethernet_Handlers.c,603 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,604 :: 		UART0_Write_Text(" of ");
MOVW	R0, #lo_addr(?lstr34_Ethernet_Handlers+0)
MOVT	R0, #hi_addr(?lstr34_Ethernet_Handlers+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,605 :: 		LongToStr(ReceivingDividedPackages, stringBuffer);
MOVW	R0, #lo_addr(_ReceivingDividedPackages+0)
MOVT	R0, #hi_addr(_ReceivingDividedPackages+0)
LDR	R0, [R0, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
BL	_LongToStr+0
;Ethernet_Handlers.c,606 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,607 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,608 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,612 :: 		UDPTransmitBuffer[0] = DeviceCID;
MOVW	R0, #lo_addr(_DeviceCID+0)
MOVT	R0, #hi_addr(_DeviceCID+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,613 :: 		UDPTransmitBuffer[1] = 0x0C; // Request folder/file name
MOVS	R1, #12
MOVW	R0, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+1)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,614 :: 		UDPTransmitBuffer[2] = 0; // Data length = 5
MOVS	R1, #0
MOVW	R0, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+2)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,615 :: 		UDPTransmitBuffer[3] = 5; // Data length = 5
MOVS	R1, #5
MOVW	R0, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+3)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,616 :: 		UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
MOVW	R2, #lo_addr(_CurrentFileID+0)
MOVT	R2, #hi_addr(_CurrentFileID+0)
LDRH	R0, [R2, #0]
AND	R0, R0, #65280
UXTH	R0, R0
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+4)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,617 :: 		UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
MOV	R0, R2
LDRH	R0, [R0, #0]
AND	R1, R0, #255
MOVW	R0, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+5)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,618 :: 		UDPTransmitBuffer[6] = (ReceivingCurrentPackage & 0xFF0000) >> 16;
LDR	R2, [SP, #4]
MOV	R0, R2
LDR	R0, [R0, #0]
AND	R0, R0, #16711680
LSRS	R1, R0, #16
MOVW	R0, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+6)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,619 :: 		UDPTransmitBuffer[7] = (ReceivingCurrentPackage & 0xFF00) >> 8;
MOV	R0, R2
LDR	R0, [R0, #0]
AND	R0, R0, #65280
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(_UDPTransmitBuffer+7)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+7)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,620 :: 		UDPTransmitBuffer[8] = (ReceivingCurrentPackage & 0xFF);
MOV	R0, R2
LDR	R0, [R0, #0]
AND	R1, R0, #255
MOVW	R0, #lo_addr(_UDPTransmitBuffer+8)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+8)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,621 :: 		UDPTransmitBuffer[9] = Calculate_Checksum(UDPTransmitBuffer, 9);
MOVS	R1, #9
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R1, #lo_addr(_UDPTransmitBuffer+9)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+9)
STRB	R0, [R1, #0]
;Ethernet_Handlers.c,622 :: 		Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 10);
MOVS	R0, #10
PUSH	(R0)
MOVW	R3, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+0)
MOVW	R2, #1111
MOVW	R1, #1111
MOVW	R0, #lo_addr(_serverIpAddr+0)
MOVT	R0, #hi_addr(_serverIpAddr+0)
BL	_Ethernet_Intern_sendUDP+0
ADD	SP, SP, #4
;Ethernet_Handlers.c,623 :: 		halfSecondCountdownTimer = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R0, #hi_addr(_halfSecondCountdownTimer+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,624 :: 		ErrorCounter = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ErrorCounter+0)
MOVT	R0, #hi_addr(_ErrorCounter+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,625 :: 		}
L_end_RequestNextAudioPackage:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _RequestNextAudioPackage
_DisplayImage:
;Ethernet_Handlers.c,627 :: 		void DisplayImage(unsigned int ImageID)
; ImageID start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Ethernet_Handlers.c,629 :: 		CurrentFileID = ImageID;
; ImageID end address is: 0 (R0)
; ImageID start address is: 0 (R0)
MOVW	R1, #lo_addr(_CurrentFileID+0)
MOVT	R1, #hi_addr(_CurrentFileID+0)
STRH	R0, [R1, #0]
;Ethernet_Handlers.c,630 :: 		CurrentState = IMAGE_RECEIVE;
MOVS	R2, #4
MOVW	R1, #lo_addr(_CurrentState+0)
MOVT	R1, #hi_addr(_CurrentState+0)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,632 :: 		UDPTransmitBuffer[0] = DeviceCID; // Empty CID (Request for new CID)
MOVW	R1, #lo_addr(_DeviceCID+0)
MOVT	R1, #hi_addr(_DeviceCID+0)
LDRB	R2, [R1, #0]
MOVW	R1, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+0)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,633 :: 		UDPTransmitBuffer[1] = 0x1A; // Request file information and length
MOVS	R2, #26
MOVW	R1, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+1)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,634 :: 		UDPTransmitBuffer[2] = 0; // Data length
MOVS	R2, #0
MOVW	R1, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+2)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,635 :: 		UDPTransmitBuffer[3] = 2; // Data length
MOVS	R2, #2
MOVW	R1, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+3)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,636 :: 		UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
AND	R1, R0, #65280
UXTH	R1, R1
LSRS	R2, R1, #8
MOVW	R1, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+4)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,637 :: 		UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
AND	R2, R0, #255
; ImageID end address is: 0 (R0)
MOVW	R1, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+5)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,638 :: 		UDPTransmitBuffer[6] = Calculate_Checksum(UDPTransmitBuffer, 6);
MOVS	R1, #6
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R1, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+6)
STRB	R0, [R1, #0]
;Ethernet_Handlers.c,639 :: 		Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 7);
MOVS	R1, #7
PUSH	(R1)
MOVW	R3, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+0)
MOVW	R2, #1111
MOVW	R1, #1111
MOVW	R0, #lo_addr(_serverIpAddr+0)
MOVT	R0, #hi_addr(_serverIpAddr+0)
BL	_Ethernet_Intern_sendUDP+0
ADD	SP, SP, #4
;Ethernet_Handlers.c,641 :: 		halfSecondCountdownTimer = 60; // 30 seconds timeout
MOVS	R2, #60
MOVW	R1, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R1, #hi_addr(_halfSecondCountdownTimer+0)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,642 :: 		ErrorCounter = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_ErrorCounter+0)
MOVT	R1, #hi_addr(_ErrorCounter+0)
STRB	R2, [R1, #0]
;Ethernet_Handlers.c,644 :: 		Xcord = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_Xcord+0)
MOVT	R1, #hi_addr(_Xcord+0)
STRH	R2, [R1, #0]
;Ethernet_Handlers.c,645 :: 		Ycord = 0;
MOVS	R2, #0
MOVW	R1, #lo_addr(_Ycord+0)
MOVT	R1, #hi_addr(_Ycord+0)
STRH	R2, [R1, #0]
;Ethernet_Handlers.c,646 :: 		TFT_Fill_Screen(CL_BLACK);
MOVW	R0, #0
BL	_TFT_Fill_Screen+0
;Ethernet_Handlers.c,647 :: 		TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
MOVS	R2, #0
MOVW	R1, #65535
MOVW	R0, #lo_addr(_TFT_defaultFont+0)
MOVT	R0, #hi_addr(_TFT_defaultFont+0)
BL	_TFT_Set_Font+0
;Ethernet_Handlers.c,648 :: 		TFT_Write_Text("Loading image...", 110, 110);
MOVW	R1, #lo_addr(?lstr35_Ethernet_Handlers+0)
MOVT	R1, #hi_addr(?lstr35_Ethernet_Handlers+0)
MOVS	R2, #110
MOV	R0, R1
MOVS	R1, #110
BL	_TFT_Write_Text+0
;Ethernet_Handlers.c,649 :: 		}
L_end_DisplayImage:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _DisplayImage
_RequestNextImagePackage:
;Ethernet_Handlers.c,651 :: 		void RequestNextImagePackage()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;Ethernet_Handlers.c,654 :: 		UART0_Write_Text("Requesting package ");
MOVW	R0, #lo_addr(?lstr36_Ethernet_Handlers+0)
MOVT	R0, #hi_addr(?lstr36_Ethernet_Handlers+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,655 :: 		LongToStr(ReceivingCurrentPackage, stringBuffer);
MOVW	R0, #lo_addr(_ReceivingCurrentPackage+0)
MOVT	R0, #hi_addr(_ReceivingCurrentPackage+0)
STR	R0, [SP, #4]
LDR	R0, [R0, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
BL	_LongToStr+0
;Ethernet_Handlers.c,656 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,657 :: 		UART0_Write_Text(" of ");
MOVW	R0, #lo_addr(?lstr37_Ethernet_Handlers+0)
MOVT	R0, #hi_addr(?lstr37_Ethernet_Handlers+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,658 :: 		LongToStr(ReceivingDividedPackages, stringBuffer);
MOVW	R0, #lo_addr(_ReceivingDividedPackages+0)
MOVT	R0, #hi_addr(_ReceivingDividedPackages+0)
LDR	R0, [R0, #0]
MOVW	R1, #lo_addr(_stringBuffer+0)
MOVT	R1, #hi_addr(_stringBuffer+0)
BL	_LongToStr+0
;Ethernet_Handlers.c,659 :: 		UART0_Write_Text(stringBuffer);
MOVW	R0, #lo_addr(_stringBuffer+0)
MOVT	R0, #hi_addr(_stringBuffer+0)
BL	_UART0_Write_Text+0
;Ethernet_Handlers.c,660 :: 		UART0_Write(13);
MOVS	R0, #13
BL	_UART0_Write+0
;Ethernet_Handlers.c,661 :: 		UART0_Write(10);
MOVS	R0, #10
BL	_UART0_Write+0
;Ethernet_Handlers.c,665 :: 		UDPTransmitBuffer[0] = DeviceCID;
MOVW	R0, #lo_addr(_DeviceCID+0)
MOVT	R0, #hi_addr(_DeviceCID+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,666 :: 		UDPTransmitBuffer[1] = 0x1C; // Request folder/file name
MOVS	R1, #28
MOVW	R0, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+1)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,667 :: 		UDPTransmitBuffer[2] = 0; // Data length = 5
MOVS	R1, #0
MOVW	R0, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+2)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,668 :: 		UDPTransmitBuffer[3] = 5; // Data length = 5
MOVS	R1, #5
MOVW	R0, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+3)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,669 :: 		UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
MOVW	R2, #lo_addr(_CurrentFileID+0)
MOVT	R2, #hi_addr(_CurrentFileID+0)
LDRH	R0, [R2, #0]
AND	R0, R0, #65280
UXTH	R0, R0
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+4)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,670 :: 		UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
MOV	R0, R2
LDRH	R0, [R0, #0]
AND	R1, R0, #255
MOVW	R0, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+5)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,671 :: 		UDPTransmitBuffer[6] = (ReceivingCurrentPackage & 0xFF0000) >> 16;
LDR	R2, [SP, #4]
MOV	R0, R2
LDR	R0, [R0, #0]
AND	R0, R0, #16711680
LSRS	R1, R0, #16
MOVW	R0, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+6)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,672 :: 		UDPTransmitBuffer[7] = (ReceivingCurrentPackage & 0xFF00) >> 8;
MOV	R0, R2
LDR	R0, [R0, #0]
AND	R0, R0, #65280
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(_UDPTransmitBuffer+7)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+7)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,673 :: 		UDPTransmitBuffer[8] = (ReceivingCurrentPackage & 0xFF);
MOV	R0, R2
LDR	R0, [R0, #0]
AND	R1, R0, #255
MOVW	R0, #lo_addr(_UDPTransmitBuffer+8)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+8)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,674 :: 		UDPTransmitBuffer[9] = Calculate_Checksum(UDPTransmitBuffer, 9);
MOVS	R1, #9
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R1, #lo_addr(_UDPTransmitBuffer+9)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+9)
STRB	R0, [R1, #0]
;Ethernet_Handlers.c,675 :: 		Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 10);
MOVS	R0, #10
PUSH	(R0)
MOVW	R3, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+0)
MOVW	R2, #1111
MOVW	R1, #1111
MOVW	R0, #lo_addr(_serverIpAddr+0)
MOVT	R0, #hi_addr(_serverIpAddr+0)
BL	_Ethernet_Intern_sendUDP+0
ADD	SP, SP, #4
;Ethernet_Handlers.c,676 :: 		halfSecondCountdownTimer = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R0, #hi_addr(_halfSecondCountdownTimer+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,677 :: 		ErrorCounter = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_ErrorCounter+0)
MOVT	R0, #hi_addr(_ErrorCounter+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,678 :: 		}
L_end_RequestNextImagePackage:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _RequestNextImagePackage
_KeepAlive_Handler:
;Ethernet_Handlers.c,680 :: 		void KeepAlive_Handler(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Ethernet_Handlers.c,684 :: 		if (CurrentState == FILE_RECEIVE && halfSecondCountdownTimer == 0) {
MOVW	R0, #lo_addr(_CurrentState+0)
MOVT	R0, #hi_addr(_CurrentState+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L__KeepAlive_Handler149
MOVW	R0, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R0, #hi_addr(_halfSecondCountdownTimer+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__KeepAlive_Handler148
L__KeepAlive_Handler147:
;Ethernet_Handlers.c,685 :: 		ErrorCounter++;
MOVW	R1, #lo_addr(_ErrorCounter+0)
MOVT	R1, #hi_addr(_ErrorCounter+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
;Ethernet_Handlers.c,687 :: 		if (ErrorCounter < 5) {
CMP	R0, #5
IT	CS
BCS	L_KeepAlive_Handler88
;Ethernet_Handlers.c,689 :: 		UDPTransmitBuffer[0] = DeviceCID;
MOVW	R0, #lo_addr(_DeviceCID+0)
MOVT	R0, #hi_addr(_DeviceCID+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,690 :: 		UDPTransmitBuffer[1] = 0x0C; // Request folder/file name
MOVS	R1, #12
MOVW	R0, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+1)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,691 :: 		UDPTransmitBuffer[2] = 0; // Data length = 5
MOVS	R1, #0
MOVW	R0, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+2)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,692 :: 		UDPTransmitBuffer[3] = 5; // Data length = 5
MOVS	R1, #5
MOVW	R0, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+3)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,693 :: 		UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
MOVW	R2, #lo_addr(_CurrentFileID+0)
MOVT	R2, #hi_addr(_CurrentFileID+0)
LDRH	R0, [R2, #0]
AND	R0, R0, #65280
UXTH	R0, R0
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+4)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,694 :: 		UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
MOV	R0, R2
LDRH	R0, [R0, #0]
AND	R1, R0, #255
MOVW	R0, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+5)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,695 :: 		UDPTransmitBuffer[6] = (ReceivingCurrentPackage & 0xFF0000) >> 16;
MOVW	R2, #lo_addr(_ReceivingCurrentPackage+0)
MOVT	R2, #hi_addr(_ReceivingCurrentPackage+0)
LDR	R0, [R2, #0]
AND	R0, R0, #16711680
LSRS	R1, R0, #16
MOVW	R0, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+6)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,696 :: 		UDPTransmitBuffer[7] = (ReceivingCurrentPackage & 0xFF00) >> 8;
MOV	R0, R2
LDR	R0, [R0, #0]
AND	R0, R0, #65280
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(_UDPTransmitBuffer+7)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+7)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,697 :: 		UDPTransmitBuffer[8] = (ReceivingCurrentPackage & 0xFF);
MOV	R0, R2
LDR	R0, [R0, #0]
AND	R1, R0, #255
MOVW	R0, #lo_addr(_UDPTransmitBuffer+8)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+8)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,698 :: 		UDPTransmitBuffer[9] = Calculate_Checksum(UDPTransmitBuffer, 9);
MOVS	R1, #9
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R1, #lo_addr(_UDPTransmitBuffer+9)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+9)
STRB	R0, [R1, #0]
;Ethernet_Handlers.c,699 :: 		Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 10);
MOVS	R0, #10
PUSH	(R0)
MOVW	R3, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+0)
MOVW	R2, #1111
MOVW	R1, #1111
MOVW	R0, #lo_addr(_serverIpAddr+0)
MOVT	R0, #hi_addr(_serverIpAddr+0)
BL	_Ethernet_Intern_sendUDP+0
ADD	SP, SP, #4
;Ethernet_Handlers.c,700 :: 		halfSecondCountdownTimer = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R0, #hi_addr(_halfSecondCountdownTimer+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,701 :: 		} else {
IT	AL
BAL	L_KeepAlive_Handler89
L_KeepAlive_Handler88:
;Ethernet_Handlers.c,702 :: 		TerminateAudio();
BL	_TerminateAudio+0
;Ethernet_Handlers.c,703 :: 		CurrentState = IDLE;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CurrentState+0)
MOVT	R0, #hi_addr(_CurrentState+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,704 :: 		}
L_KeepAlive_Handler89:
;Ethernet_Handlers.c,684 :: 		if (CurrentState == FILE_RECEIVE && halfSecondCountdownTimer == 0) {
L__KeepAlive_Handler149:
L__KeepAlive_Handler148:
;Ethernet_Handlers.c,707 :: 		if (CurrentState == IMAGE_RECEIVE && halfSecondCountdownTimer == 0) {
MOVW	R0, #lo_addr(_CurrentState+0)
MOVT	R0, #hi_addr(_CurrentState+0)
LDRB	R0, [R0, #0]
CMP	R0, #4
IT	NE
BNE	L__KeepAlive_Handler151
MOVW	R0, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R0, #hi_addr(_halfSecondCountdownTimer+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__KeepAlive_Handler150
L__KeepAlive_Handler146:
;Ethernet_Handlers.c,708 :: 		ErrorCounter++;
MOVW	R1, #lo_addr(_ErrorCounter+0)
MOVT	R1, #hi_addr(_ErrorCounter+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
;Ethernet_Handlers.c,710 :: 		if (ErrorCounter < 5) {
CMP	R0, #5
IT	CS
BCS	L_KeepAlive_Handler93
;Ethernet_Handlers.c,712 :: 		UDPTransmitBuffer[0] = DeviceCID;
MOVW	R0, #lo_addr(_DeviceCID+0)
MOVT	R0, #hi_addr(_DeviceCID+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,713 :: 		UDPTransmitBuffer[1] = 0x1C; // Request folder/file name
MOVS	R1, #28
MOVW	R0, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+1)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,714 :: 		UDPTransmitBuffer[2] = 0; // Data length = 5
MOVS	R1, #0
MOVW	R0, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+2)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,715 :: 		UDPTransmitBuffer[3] = 5; // Data length = 5
MOVS	R1, #5
MOVW	R0, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+3)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,716 :: 		UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
MOVW	R2, #lo_addr(_CurrentFileID+0)
MOVT	R2, #hi_addr(_CurrentFileID+0)
LDRH	R0, [R2, #0]
AND	R0, R0, #65280
UXTH	R0, R0
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+4)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,717 :: 		UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
MOV	R0, R2
LDRH	R0, [R0, #0]
AND	R1, R0, #255
MOVW	R0, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+5)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,718 :: 		UDPTransmitBuffer[6] = (ReceivingCurrentPackage & 0xFF0000) >> 16;
MOVW	R2, #lo_addr(_ReceivingCurrentPackage+0)
MOVT	R2, #hi_addr(_ReceivingCurrentPackage+0)
LDR	R0, [R2, #0]
AND	R0, R0, #16711680
LSRS	R1, R0, #16
MOVW	R0, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+6)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,719 :: 		UDPTransmitBuffer[7] = (ReceivingCurrentPackage & 0xFF00) >> 8;
MOV	R0, R2
LDR	R0, [R0, #0]
AND	R0, R0, #65280
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(_UDPTransmitBuffer+7)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+7)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,720 :: 		UDPTransmitBuffer[8] = (ReceivingCurrentPackage & 0xFF);
MOV	R0, R2
LDR	R0, [R0, #0]
AND	R1, R0, #255
MOVW	R0, #lo_addr(_UDPTransmitBuffer+8)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+8)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,721 :: 		UDPTransmitBuffer[9] = Calculate_Checksum(UDPTransmitBuffer, 9);
MOVS	R1, #9
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R1, #lo_addr(_UDPTransmitBuffer+9)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+9)
STRB	R0, [R1, #0]
;Ethernet_Handlers.c,722 :: 		Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 10);
MOVS	R0, #10
PUSH	(R0)
MOVW	R3, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+0)
MOVW	R2, #1111
MOVW	R1, #1111
MOVW	R0, #lo_addr(_serverIpAddr+0)
MOVT	R0, #hi_addr(_serverIpAddr+0)
BL	_Ethernet_Intern_sendUDP+0
ADD	SP, SP, #4
;Ethernet_Handlers.c,723 :: 		halfSecondCountdownTimer = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R0, #hi_addr(_halfSecondCountdownTimer+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,724 :: 		} else {
IT	AL
BAL	L_KeepAlive_Handler94
L_KeepAlive_Handler93:
;Ethernet_Handlers.c,725 :: 		UI_ShowMainScreen();
BL	_UI_ShowMainScreen+0
;Ethernet_Handlers.c,726 :: 		UI_UpdateFolderName();
BL	_UI_UpdateFolderName+0
;Ethernet_Handlers.c,727 :: 		UI_UpdateFilesList();
BL	_UI_UpdateFilesList+0
;Ethernet_Handlers.c,728 :: 		UI_ResetCursorPos();
BL	_UI_ResetCursorPos+0
;Ethernet_Handlers.c,729 :: 		CurrentState = IDLE;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CurrentState+0)
MOVT	R0, #hi_addr(_CurrentState+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,730 :: 		}
L_KeepAlive_Handler94:
;Ethernet_Handlers.c,707 :: 		if (CurrentState == IMAGE_RECEIVE && halfSecondCountdownTimer == 0) {
L__KeepAlive_Handler151:
L__KeepAlive_Handler150:
;Ethernet_Handlers.c,733 :: 		if (CurrentState == FOLDER_RECEIVE && halfSecondCountdownTimer == 0) {
MOVW	R0, #lo_addr(_CurrentState+0)
MOVT	R0, #hi_addr(_CurrentState+0)
LDRB	R0, [R0, #0]
CMP	R0, #1
IT	NE
BNE	L__KeepAlive_Handler153
MOVW	R0, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R0, #hi_addr(_halfSecondCountdownTimer+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L__KeepAlive_Handler152
L__KeepAlive_Handler145:
;Ethernet_Handlers.c,734 :: 		ErrorCounter++;
MOVW	R1, #lo_addr(_ErrorCounter+0)
MOVT	R1, #hi_addr(_ErrorCounter+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
UXTB	R0, R0
STRB	R0, [R1, #0]
;Ethernet_Handlers.c,736 :: 		if (ErrorCounter < 5) {
CMP	R0, #5
IT	CS
BCS	L_KeepAlive_Handler98
;Ethernet_Handlers.c,738 :: 		UDPTransmitBuffer[0] = DeviceCID;
MOVW	R0, #lo_addr(_DeviceCID+0)
MOVT	R0, #hi_addr(_DeviceCID+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,739 :: 		UDPTransmitBuffer[1] = 0x05; // Request folder/file name
MOVS	R1, #5
MOVW	R0, #lo_addr(_UDPTransmitBuffer+1)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+1)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,740 :: 		UDPTransmitBuffer[2] = 0; // Data length = 3
MOVS	R1, #0
MOVW	R0, #lo_addr(_UDPTransmitBuffer+2)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+2)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,741 :: 		UDPTransmitBuffer[3] = 3; // Data length = 3
MOVS	R1, #3
MOVW	R0, #lo_addr(_UDPTransmitBuffer+3)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+3)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,742 :: 		UDPTransmitBuffer[4] = CurrentFolderID >> 8;
MOVW	R2, #lo_addr(_CurrentFolderID+0)
MOVT	R2, #hi_addr(_CurrentFolderID+0)
LDRB	R0, [R2, #0]
LSRS	R1, R0, #8
MOVW	R0, #lo_addr(_UDPTransmitBuffer+4)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+4)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,743 :: 		UDPTransmitBuffer[5] = (CurrentFolderID & 0xFF);
MOV	R0, R2
LDRB	R0, [R0, #0]
AND	R1, R0, #255
MOVW	R0, #lo_addr(_UDPTransmitBuffer+5)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+5)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,744 :: 		UDPTransmitBuffer[6] = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_UDPTransmitBuffer+6)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+6)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,745 :: 		UDPTransmitBuffer[7] = Calculate_Checksum(UDPTransmitBuffer, 7);
MOVS	R1, #7
MOVW	R0, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R0, #hi_addr(_UDPTransmitBuffer+0)
BL	_Calculate_Checksum+0
MOVW	R1, #lo_addr(_UDPTransmitBuffer+7)
MOVT	R1, #hi_addr(_UDPTransmitBuffer+7)
STRB	R0, [R1, #0]
;Ethernet_Handlers.c,746 :: 		Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 8);
MOVS	R0, #8
PUSH	(R0)
MOVW	R3, #lo_addr(_UDPTransmitBuffer+0)
MOVT	R3, #hi_addr(_UDPTransmitBuffer+0)
MOVW	R2, #1111
MOVW	R1, #1111
MOVW	R0, #lo_addr(_serverIpAddr+0)
MOVT	R0, #hi_addr(_serverIpAddr+0)
BL	_Ethernet_Intern_sendUDP+0
ADD	SP, SP, #4
;Ethernet_Handlers.c,748 :: 		halfSecondCountdownTimer = 5; // Make sure download is kept alive
MOVS	R1, #5
MOVW	R0, #lo_addr(_halfSecondCountdownTimer+0)
MOVT	R0, #hi_addr(_halfSecondCountdownTimer+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,749 :: 		} else {
IT	AL
BAL	L_KeepAlive_Handler99
L_KeepAlive_Handler98:
;Ethernet_Handlers.c,750 :: 		FilesListCount = FolderFileRequestIDCount;
MOVW	R2, #lo_addr(_FolderFileRequestIDCount+0)
MOVT	R2, #hi_addr(_FolderFileRequestIDCount+0)
LDRB	R1, [R2, #0]
MOVW	R0, #lo_addr(_FilesListCount+0)
MOVT	R0, #hi_addr(_FilesListCount+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,752 :: 		if (FilesListCount < 12) { // Empty the rest of the files list
MOV	R0, R2
LDRB	R0, [R0, #0]
CMP	R0, #12
IT	CS
BCS	L_KeepAlive_Handler100
;Ethernet_Handlers.c,753 :: 		for (tempI = FilesListCount; tempI < 12; tempI++) {
MOVW	R0, #lo_addr(_FilesListCount+0)
MOVT	R0, #hi_addr(_FilesListCount+0)
; tempI start address is: 8 (R2)
LDRB	R2, [R0, #0]
; tempI end address is: 8 (R2)
L_KeepAlive_Handler101:
; tempI start address is: 8 (R2)
CMP	R2, #12
IT	CS
BCS	L_KeepAlive_Handler102
;Ethernet_Handlers.c,754 :: 		FilesList[tempI].ID = 0;
MOVS	R0, #36
MUL	R1, R0, R2
MOVW	R0, #lo_addr(_FilesList+0)
MOVT	R0, #hi_addr(_FilesList+0)
ADDS	R1, R0, R1
MOVS	R0, #0
STRH	R0, [R1, #0]
;Ethernet_Handlers.c,755 :: 		FilesList[tempI].Type = 0;
MOVS	R0, #36
MUL	R1, R0, R2
MOVW	R0, #lo_addr(_FilesList+0)
MOVT	R0, #hi_addr(_FilesList+0)
ADDS	R0, R0, R1
ADDS	R1, R0, #2
MOVS	R0, #0
STRB	R0, [R1, #0]
;Ethernet_Handlers.c,756 :: 		FilesList[tempI].NameLength = 0;
MOVS	R0, #36
MUL	R1, R0, R2
MOVW	R0, #lo_addr(_FilesList+0)
MOVT	R0, #hi_addr(_FilesList+0)
ADDS	R0, R0, R1
ADDW	R1, R0, #35
MOVS	R0, #0
STRB	R0, [R1, #0]
;Ethernet_Handlers.c,753 :: 		for (tempI = FilesListCount; tempI < 12; tempI++) {
ADDS	R2, R2, #1
UXTB	R2, R2
;Ethernet_Handlers.c,757 :: 		}
; tempI end address is: 8 (R2)
IT	AL
BAL	L_KeepAlive_Handler101
L_KeepAlive_Handler102:
;Ethernet_Handlers.c,758 :: 		}
L_KeepAlive_Handler100:
;Ethernet_Handlers.c,760 :: 		CurrentState = IDLE;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CurrentState+0)
MOVT	R0, #hi_addr(_CurrentState+0)
STRB	R1, [R0, #0]
;Ethernet_Handlers.c,761 :: 		UI_UpdateFolderName();
BL	_UI_UpdateFolderName+0
;Ethernet_Handlers.c,762 :: 		UI_UpdateFilesList();
BL	_UI_UpdateFilesList+0
;Ethernet_Handlers.c,763 :: 		UI_ResetCursorPos();
BL	_UI_ResetCursorPos+0
;Ethernet_Handlers.c,764 :: 		}
L_KeepAlive_Handler99:
;Ethernet_Handlers.c,733 :: 		if (CurrentState == FOLDER_RECEIVE && halfSecondCountdownTimer == 0) {
L__KeepAlive_Handler153:
L__KeepAlive_Handler152:
;Ethernet_Handlers.c,766 :: 		}
L_end_KeepAlive_Handler:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _KeepAlive_Handler
Ethernet_Handlers____?ag:
SUB	SP, SP, #4
L_end_Ethernet_Handlers___?ag:
ADD	SP, SP, #4
BX	LR
; end of Ethernet_Handlers____?ag
