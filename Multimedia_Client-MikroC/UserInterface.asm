_UI_Setup:
;UserInterface.c,48 :: 		void UI_Setup()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;UserInterface.c,50 :: 		GPIO_Config(&GPIO_PORTA, 0b00001000, _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE | _GPIO_CFG_DRIVE_8mA, 0); // Init back light GPIO
MOVS	R0, #0
PUSH	(R0)
MOVW	R3, #320
MOVS	R2, #1
MOVS	R1, #8
MOVW	R0, #lo_addr(GPIO_PORTA+0)
MOVT	R0, #hi_addr(GPIO_PORTA+0)
BL	_GPIO_Config+0
ADD	SP, SP, #4
;UserInterface.c,51 :: 		TFT_BACKLIGHT = 0;
MOVS	R1, #0
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIO_PORTA_DATA3_bit+0)
MOVT	R0, #hi_addr(GPIO_PORTA_DATA3_bit+0)
STR	R1, [R0, #0]
;UserInterface.c,53 :: 		GPIO_Unlock(_GPIO_COMMIT_PIN_B7);
MOVS	R0, #128
BL	_GPIO_Unlock+0
;UserInterface.c,54 :: 		GPIO_Digital_Input(&GPIO_PORTB, _GPIO_PINMASK_0 | _GPIO_PINMASK_7);    // Set Up and Left as digital input
MOVS	R1, #129
MOVW	R0, #lo_addr(GPIO_PORTB+0)
MOVT	R0, #hi_addr(GPIO_PORTB+0)
BL	_GPIO_Digital_Input+0
;UserInterface.c,55 :: 		GPIO_Digital_Input(&GPIO_PORTE, _GPIO_PINMASK_4 | _GPIO_PINMASK_5);    // Set Right and Down as digital input
MOVS	R1, #48
MOVW	R0, #lo_addr(GPIO_PORTE+0)
MOVT	R0, #hi_addr(GPIO_PORTE+0)
BL	_GPIO_Digital_Input+0
;UserInterface.c,56 :: 		GPIO_Digital_Input(&GPIO_PORTH, _GPIO_PINMASK_2);                      // Set Center as digital input
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIO_PORTH+0)
MOVT	R0, #hi_addr(GPIO_PORTH+0)
BL	_GPIO_Digital_Input+0
;UserInterface.c,57 :: 		Delay_100ms();
BL	_Delay_100ms+0
;UserInterface.c,58 :: 		TFT_Init(320, 240);
MOVS	R1, #240
MOVW	R0, #320
BL	_TFT_Init+0
;UserInterface.c,60 :: 		TFT_Fill_Screen(0);
MOVS	R0, #0
BL	_TFT_Fill_Screen+0
;UserInterface.c,61 :: 		InitializeObjects();
BL	_InitializeObjects+0
;UserInterface.c,62 :: 		display_width = LoadingScreen.Width;
MOVW	R0, #lo_addr(_LoadingScreen+2)
MOVT	R0, #hi_addr(_LoadingScreen+2)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_display_width+0)
MOVT	R0, #hi_addr(_display_width+0)
STRH	R1, [R0, #0]
;UserInterface.c,63 :: 		display_height = LoadingScreen.Height;
MOVW	R0, #lo_addr(_LoadingScreen+4)
MOVT	R0, #hi_addr(_LoadingScreen+4)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_display_height+0)
MOVT	R0, #hi_addr(_display_height+0)
STRH	R1, [R0, #0]
;UserInterface.c,64 :: 		UI_LoadingScreen("Fetching IP address");
MOVW	R0, #lo_addr(?lstr1_UserInterface+0)
MOVT	R0, #hi_addr(?lstr1_UserInterface+0)
BL	_UI_LoadingScreen+0
;UserInterface.c,66 :: 		TFT_BACKLIGHT = 1;
MOVS	R1, #1
SXTB	R1, R1
MOVW	R0, #lo_addr(GPIO_PORTA_DATA3_bit+0)
MOVT	R0, #hi_addr(GPIO_PORTA_DATA3_bit+0)
STR	R1, [R0, #0]
;UserInterface.c,67 :: 		}
L_end_UI_Setup:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _UI_Setup
_UI_LoadingScreen:
;UserInterface.c,69 :: 		void UI_LoadingScreen(unsigned char *LoadingText)
; LoadingText start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;UserInterface.c,71 :: 		Label1.Caption = LoadingText;
; LoadingText end address is: 0 (R0)
; LoadingText start address is: 0 (R0)
MOVW	R1, #lo_addr(_Label1+16)
MOVT	R1, #hi_addr(_Label1+16)
STR	R0, [R1, #0]
; LoadingText end address is: 0 (R0)
;UserInterface.c,72 :: 		DrawScreen(&LoadingScreen);
MOVW	R0, #lo_addr(_LoadingScreen+0)
MOVT	R0, #hi_addr(_LoadingScreen+0)
BL	_DrawScreen+0
;UserInterface.c,73 :: 		}
L_end_UI_LoadingScreen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _UI_LoadingScreen
_UI_ShowMainScreen:
;UserInterface.c,75 :: 		void UI_ShowMainScreen()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;UserInterface.c,77 :: 		DrawScreen(&MainScreen);
MOVW	R0, #lo_addr(_MainScreen+0)
MOVT	R0, #hi_addr(_MainScreen+0)
BL	_DrawScreen+0
;UserInterface.c,78 :: 		}
L_end_UI_ShowMainScreen:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _UI_ShowMainScreen
_UI_Handler:
;UserInterface.c,80 :: 		void UI_Handler()
SUB	SP, SP, #4
STR	LR, [SP, #0]
;UserInterface.c,83 :: 		if (Button(&GPIO_PORTB_DATA, 0, 1, 0))
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIO_PORTB_DATA+0)
MOVT	R0, #hi_addr(GPIO_PORTB_DATA+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_UI_Handler0
;UserInterface.c,84 :: 		oldstate_up = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_oldstate_up+0)
MOVT	R0, #hi_addr(_oldstate_up+0)
STRH	R1, [R0, #0]
L_UI_Handler0:
;UserInterface.c,85 :: 		if (oldstate_up && Button(&GPIO_PORTB_DATA, 0, 1, 1)) { // detect logical one to logical zero transition
MOVW	R0, #lo_addr(_oldstate_up+0)
MOVT	R0, #hi_addr(_oldstate_up+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__UI_Handler57
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #0
MOVW	R0, #lo_addr(GPIO_PORTB_DATA+0)
MOVT	R0, #hi_addr(GPIO_PORTB_DATA+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__UI_Handler56
L__UI_Handler55:
;UserInterface.c,87 :: 		if (cursorPos > 0) {
MOVW	R0, #lo_addr(_cursorPos+0)
MOVT	R0, #hi_addr(_cursorPos+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_UI_Handler4
;UserInterface.c,88 :: 		TFT_Set_Pen(MainScreen.Color, 0);
MOVW	R0, #lo_addr(_MainScreen+0)
MOVT	R0, #hi_addr(_MainScreen+0)
LDRH	R0, [R0, #0]
MOVS	R1, #0
BL	_TFT_Set_Pen+0
;UserInterface.c,89 :: 		TFT_Set_Brush(1, MainScreen.Color, 0, LEFT_TO_RIGHT, CL_WHITE, CL_WHITE);
MOVW	R2, #65535
MOVW	R1, #65535
MOVW	R0, #lo_addr(_MainScreen+0)
MOVT	R0, #hi_addr(_MainScreen+0)
LDRH	R0, [R0, #0]
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #0
UXTH	R1, R0
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;UserInterface.c,90 :: 		TFT_Rectangle(Image3.Left, Image3.Top, (Image3.Left+Image3.Width), (Image3.Top+Image3.Height));
MOVW	R0, #lo_addr(_Image3+12)
MOVT	R0, #hi_addr(_Image3+12)
LDRH	R1, [R0, #0]
MOVW	R5, #lo_addr(_Image3+8)
MOVT	R5, #hi_addr(_Image3+8)
LDRH	R0, [R5, #0]
ADDS	R4, R0, R1
MOVW	R0, #lo_addr(_Image3+10)
MOVT	R0, #hi_addr(_Image3+10)
LDRH	R1, [R0, #0]
MOVW	R3, #lo_addr(_Image3+6)
MOVT	R3, #hi_addr(_Image3+6)
LDRH	R0, [R3, #0]
ADDS	R2, R0, R1
MOV	R0, R5
LDRH	R1, [R0, #0]
MOV	R0, R3
LDRH	R0, [R0, #0]
SXTH	R3, R4
SXTH	R2, R2
BL	_TFT_Rectangle+0
;UserInterface.c,91 :: 		Image3.Top -= 16;
MOVW	R1, #lo_addr(_Image3+8)
MOVT	R1, #hi_addr(_Image3+8)
LDRH	R0, [R1, #0]
SUBS	R0, #16
STRH	R0, [R1, #0]
;UserInterface.c,92 :: 		DrawImage(&Image3);
MOVW	R0, #lo_addr(_Image3+0)
MOVT	R0, #hi_addr(_Image3+0)
BL	_DrawImage+0
;UserInterface.c,93 :: 		cursorPos--;
MOVW	R1, #lo_addr(_cursorPos+0)
MOVT	R1, #hi_addr(_cursorPos+0)
LDRB	R0, [R1, #0]
SUBS	R0, R0, #1
STRB	R0, [R1, #0]
;UserInterface.c,94 :: 		} else if (filesListOffset > 0) {
IT	AL
BAL	L_UI_Handler5
L_UI_Handler4:
MOVW	R0, #lo_addr(_filesListOffset+0)
MOVT	R0, #hi_addr(_filesListOffset+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	LS
BLS	L_UI_Handler6
;UserInterface.c,95 :: 		filesListOffset--;
MOVW	R1, #lo_addr(_filesListOffset+0)
MOVT	R1, #hi_addr(_filesListOffset+0)
LDRB	R0, [R1, #0]
SUBS	R0, R0, #1
STRB	R0, [R1, #0]
;UserInterface.c,96 :: 		UI_UpdateFilesList();
BL	_UI_UpdateFilesList+0
;UserInterface.c,97 :: 		}
L_UI_Handler6:
L_UI_Handler5:
;UserInterface.c,98 :: 		oldstate_up = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate_up+0)
MOVT	R0, #hi_addr(_oldstate_up+0)
STRH	R1, [R0, #0]
;UserInterface.c,85 :: 		if (oldstate_up && Button(&GPIO_PORTB_DATA, 0, 1, 1)) { // detect logical one to logical zero transition
L__UI_Handler57:
L__UI_Handler56:
;UserInterface.c,102 :: 		if (Button(&GPIO_PORTE_DATA, 5, 1, 0))
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #5
MOVW	R0, #lo_addr(GPIO_PORTE_DATA+0)
MOVT	R0, #hi_addr(GPIO_PORTE_DATA+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_UI_Handler7
;UserInterface.c,103 :: 		oldstate_down = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_oldstate_down+0)
MOVT	R0, #hi_addr(_oldstate_down+0)
STRH	R1, [R0, #0]
L_UI_Handler7:
;UserInterface.c,104 :: 		if (oldstate_down && Button(&GPIO_PORTE_DATA, 5, 1, 1)) { // detect logical one to logical zero transition
MOVW	R0, #lo_addr(_oldstate_down+0)
MOVT	R0, #hi_addr(_oldstate_down+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__UI_Handler61
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #5
MOVW	R0, #lo_addr(GPIO_PORTE_DATA+0)
MOVT	R0, #hi_addr(GPIO_PORTE_DATA+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__UI_Handler60
L__UI_Handler54:
;UserInterface.c,106 :: 		if (cursorPos < 11 && cursorPos < (FilesListCount-1)) {
MOVW	R0, #lo_addr(_cursorPos+0)
MOVT	R0, #hi_addr(_cursorPos+0)
LDRB	R0, [R0, #0]
CMP	R0, #11
IT	CS
BCS	L__UI_Handler59
MOVW	R0, #lo_addr(_FilesListCount+0)
MOVT	R0, #hi_addr(_FilesListCount+0)
LDRB	R0, [R0, #0]
SUBS	R1, R0, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_cursorPos+0)
MOVT	R0, #hi_addr(_cursorPos+0)
LDRB	R0, [R0, #0]
CMP	R0, R1
IT	GE
BGE	L__UI_Handler58
L__UI_Handler53:
;UserInterface.c,107 :: 		TFT_Set_Pen(MainScreen.Color, 0);
MOVW	R0, #lo_addr(_MainScreen+0)
MOVT	R0, #hi_addr(_MainScreen+0)
LDRH	R0, [R0, #0]
MOVS	R1, #0
BL	_TFT_Set_Pen+0
;UserInterface.c,108 :: 		TFT_Set_Brush(1, MainScreen.Color, 0, LEFT_TO_RIGHT, CL_WHITE, CL_WHITE);
MOVW	R2, #65535
MOVW	R1, #65535
MOVW	R0, #lo_addr(_MainScreen+0)
MOVT	R0, #hi_addr(_MainScreen+0)
LDRH	R0, [R0, #0]
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #0
UXTH	R1, R0
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;UserInterface.c,109 :: 		TFT_Rectangle(Image3.Left, Image3.Top, (Image3.Left+Image3.Width), (Image3.Top+Image3.Height));
MOVW	R0, #lo_addr(_Image3+12)
MOVT	R0, #hi_addr(_Image3+12)
LDRH	R1, [R0, #0]
MOVW	R5, #lo_addr(_Image3+8)
MOVT	R5, #hi_addr(_Image3+8)
LDRH	R0, [R5, #0]
ADDS	R4, R0, R1
MOVW	R0, #lo_addr(_Image3+10)
MOVT	R0, #hi_addr(_Image3+10)
LDRH	R1, [R0, #0]
MOVW	R3, #lo_addr(_Image3+6)
MOVT	R3, #hi_addr(_Image3+6)
LDRH	R0, [R3, #0]
ADDS	R2, R0, R1
MOV	R0, R5
LDRH	R1, [R0, #0]
MOV	R0, R3
LDRH	R0, [R0, #0]
SXTH	R3, R4
SXTH	R2, R2
BL	_TFT_Rectangle+0
;UserInterface.c,110 :: 		Image3.Top += 16;
MOVW	R1, #lo_addr(_Image3+8)
MOVT	R1, #hi_addr(_Image3+8)
LDRH	R0, [R1, #0]
ADDS	R0, #16
STRH	R0, [R1, #0]
;UserInterface.c,111 :: 		DrawImage(&Image3);
MOVW	R0, #lo_addr(_Image3+0)
MOVT	R0, #hi_addr(_Image3+0)
BL	_DrawImage+0
;UserInterface.c,112 :: 		cursorPos++;
MOVW	R1, #lo_addr(_cursorPos+0)
MOVT	R1, #hi_addr(_cursorPos+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
;UserInterface.c,113 :: 		} else if ((cursorPos+filesListOffset+1) < FilesListCount) {
IT	AL
BAL	L_UI_Handler14
;UserInterface.c,106 :: 		if (cursorPos < 11 && cursorPos < (FilesListCount-1)) {
L__UI_Handler59:
L__UI_Handler58:
;UserInterface.c,113 :: 		} else if ((cursorPos+filesListOffset+1) < FilesListCount) {
MOVW	R0, #lo_addr(_filesListOffset+0)
MOVT	R0, #hi_addr(_filesListOffset+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_cursorPos+0)
MOVT	R0, #hi_addr(_cursorPos+0)
LDRB	R0, [R0, #0]
ADDS	R0, R0, R1
SXTH	R0, R0
ADDS	R1, R0, #1
SXTH	R1, R1
MOVW	R0, #lo_addr(_FilesListCount+0)
MOVT	R0, #hi_addr(_FilesListCount+0)
LDRB	R0, [R0, #0]
CMP	R1, R0
IT	GE
BGE	L_UI_Handler15
;UserInterface.c,114 :: 		filesListOffset++;
MOVW	R1, #lo_addr(_filesListOffset+0)
MOVT	R1, #hi_addr(_filesListOffset+0)
LDRB	R0, [R1, #0]
ADDS	R0, R0, #1
STRB	R0, [R1, #0]
;UserInterface.c,115 :: 		UI_UpdateFilesList();
BL	_UI_UpdateFilesList+0
;UserInterface.c,116 :: 		}
L_UI_Handler15:
L_UI_Handler14:
;UserInterface.c,117 :: 		oldstate_down = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate_down+0)
MOVT	R0, #hi_addr(_oldstate_down+0)
STRH	R1, [R0, #0]
;UserInterface.c,104 :: 		if (oldstate_down && Button(&GPIO_PORTE_DATA, 5, 1, 1)) { // detect logical one to logical zero transition
L__UI_Handler61:
L__UI_Handler60:
;UserInterface.c,121 :: 		if (Button(&GPIO_PORTH_DATA, 2, 1, 0))
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #2
MOVW	R0, #lo_addr(GPIO_PORTH_DATA+0)
MOVT	R0, #hi_addr(GPIO_PORTH_DATA+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_UI_Handler16
;UserInterface.c,122 :: 		oldstate_press = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_oldstate_press+0)
MOVT	R0, #hi_addr(_oldstate_press+0)
STRH	R1, [R0, #0]
L_UI_Handler16:
;UserInterface.c,123 :: 		if (oldstate_press && Button(&GPIO_PORTH_DATA, 2, 1, 1)) { // detect logical one to logical zero transition
MOVW	R0, #lo_addr(_oldstate_press+0)
MOVT	R0, #hi_addr(_oldstate_press+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__UI_Handler67
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #2
MOVW	R0, #lo_addr(GPIO_PORTH_DATA+0)
MOVT	R0, #hi_addr(GPIO_PORTH_DATA+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__UI_Handler66
L__UI_Handler52:
;UserInterface.c,125 :: 		if (CurrentState == IMAGE_DISPLAY) {
MOVW	R0, #lo_addr(_CurrentState+0)
MOVT	R0, #hi_addr(_CurrentState+0)
LDRB	R0, [R0, #0]
CMP	R0, #5
IT	NE
BNE	L_UI_Handler20
;UserInterface.c,126 :: 		UI_ShowMainScreen();
BL	_UI_ShowMainScreen+0
;UserInterface.c,127 :: 		UI_UpdateFolderName();
BL	_UI_UpdateFolderName+0
;UserInterface.c,128 :: 		UI_UpdateFilesList();
BL	_UI_UpdateFilesList+0
;UserInterface.c,129 :: 		CurrentState = IDLE;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CurrentState+0)
MOVT	R0, #hi_addr(_CurrentState+0)
STRB	R1, [R0, #0]
;UserInterface.c,130 :: 		} else if (CurrentState == IDLE) {
IT	AL
BAL	L_UI_Handler21
L_UI_Handler20:
MOVW	R0, #lo_addr(_CurrentState+0)
MOVT	R0, #hi_addr(_CurrentState+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	NE
BNE	L_UI_Handler22
;UserInterface.c,131 :: 		if (FilesList[cursorPos+filesListOffset]->Type == 'A')  {
MOVW	R0, #lo_addr(_filesListOffset+0)
MOVT	R0, #hi_addr(_filesListOffset+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_cursorPos+0)
MOVT	R0, #hi_addr(_cursorPos+0)
LDRB	R0, [R0, #0]
ADDS	R1, R0, R1
SXTH	R1, R1
MOVS	R0, #36
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_FilesList+0)
MOVT	R0, #hi_addr(_FilesList+0)
ADDS	R0, R0, R1
ADDS	R0, R0, #2
LDRB	R0, [R0, #0]
CMP	R0, #65
IT	NE
BNE	L_UI_Handler23
;UserInterface.c,132 :: 		if (DownloadMode == 0)
MOVW	R1, #lo_addr(_DownloadMode+0)
MOVT	R1, #hi_addr(_DownloadMode+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_UI_Handler24
;UserInterface.c,133 :: 		PlayAudio(FilesList[cursorPos+filesListOffset]->ID);
MOVW	R0, #lo_addr(_filesListOffset+0)
MOVT	R0, #hi_addr(_filesListOffset+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_cursorPos+0)
MOVT	R0, #hi_addr(_cursorPos+0)
LDRB	R0, [R0, #0]
ADDS	R1, R0, R1
SXTH	R1, R1
MOVS	R0, #36
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_FilesList+0)
MOVT	R0, #hi_addr(_FilesList+0)
ADDS	R0, R0, R1
LDRH	R0, [R0, #0]
BL	_PlayAudio+0
IT	AL
BAL	L_UI_Handler25
L_UI_Handler24:
;UserInterface.c,134 :: 		else if (DownloadMode == 1 && SDSave_Disabled == 0)
MOVW	R1, #lo_addr(_DownloadMode+0)
MOVT	R1, #hi_addr(_DownloadMode+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	EQ
BEQ	L__UI_Handler63
MOVW	R1, #lo_addr(_SDSave_Disabled+0)
MOVT	R1, #hi_addr(_SDSave_Disabled+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L__UI_Handler62
L__UI_Handler51:
;UserInterface.c,135 :: 		SaveAudio(FilesList[cursorPos+filesListOffset]->ID, FilesList[cursorPos+filesListOffset]->Name);
MOVW	R0, #lo_addr(_filesListOffset+0)
MOVT	R0, #hi_addr(_filesListOffset+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_cursorPos+0)
MOVT	R0, #hi_addr(_cursorPos+0)
LDRB	R0, [R0, #0]
ADDS	R1, R0, R1
SXTH	R1, R1
MOVS	R0, #36
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_FilesList+0)
MOVT	R0, #hi_addr(_FilesList+0)
ADDS	R0, R0, R1
ADDS	R1, R0, #3
LDRH	R0, [R0, #0]
BL	_SaveAudio+0
;UserInterface.c,134 :: 		else if (DownloadMode == 1 && SDSave_Disabled == 0)
L__UI_Handler63:
L__UI_Handler62:
;UserInterface.c,135 :: 		SaveAudio(FilesList[cursorPos+filesListOffset]->ID, FilesList[cursorPos+filesListOffset]->Name);
L_UI_Handler25:
;UserInterface.c,136 :: 		} else if (FilesList[cursorPos+filesListOffset]->Type == 'F') {
IT	AL
BAL	L_UI_Handler29
L_UI_Handler23:
MOVW	R0, #lo_addr(_filesListOffset+0)
MOVT	R0, #hi_addr(_filesListOffset+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_cursorPos+0)
MOVT	R0, #hi_addr(_cursorPos+0)
LDRB	R0, [R0, #0]
ADDS	R1, R0, R1
SXTH	R1, R1
MOVS	R0, #36
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_FilesList+0)
MOVT	R0, #hi_addr(_FilesList+0)
ADDS	R0, R0, R1
ADDS	R0, R0, #2
LDRB	R0, [R0, #0]
CMP	R0, #70
IT	NE
BNE	L_UI_Handler30
;UserInterface.c,137 :: 		if (CurrentFolderID == 0 || FilesList[cursorPos+filesListOffset]->ID == 0) // Only possible to enter folders if we are in the ROOT folder currently (Only 1-level deep folder tree currently supported!)
MOVW	R0, #lo_addr(_CurrentFolderID+0)
MOVT	R0, #hi_addr(_CurrentFolderID+0)
LDRB	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__UI_Handler65
MOVW	R0, #lo_addr(_filesListOffset+0)
MOVT	R0, #hi_addr(_filesListOffset+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_cursorPos+0)
MOVT	R0, #hi_addr(_cursorPos+0)
LDRB	R0, [R0, #0]
ADDS	R1, R0, R1
SXTH	R1, R1
MOVS	R0, #36
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_FilesList+0)
MOVT	R0, #hi_addr(_FilesList+0)
ADDS	R0, R0, R1
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__UI_Handler64
IT	AL
BAL	L_UI_Handler33
L__UI_Handler65:
L__UI_Handler64:
;UserInterface.c,138 :: 		RequestFolderContent(FilesList[cursorPos+filesListOffset]->ID, FilesList[cursorPos+filesListOffset]->Name, FilesList[cursorPos+filesListOffset]->NameLength);
MOVW	R0, #lo_addr(_filesListOffset+0)
MOVT	R0, #hi_addr(_filesListOffset+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_cursorPos+0)
MOVT	R0, #hi_addr(_cursorPos+0)
LDRB	R0, [R0, #0]
ADDS	R1, R0, R1
SXTH	R1, R1
MOVS	R0, #36
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_FilesList+0)
MOVT	R0, #hi_addr(_FilesList+0)
ADDS	R3, R0, R1
ADDW	R0, R3, #35
LDRB	R0, [R0, #0]
UXTB	R2, R0
ADDS	R1, R3, #3
LDRH	R0, [R3, #0]
BL	_RequestFolderContent+0
L_UI_Handler33:
;UserInterface.c,139 :: 		} else if (FilesList[cursorPos+filesListOffset]->Type == 'I') {
IT	AL
BAL	L_UI_Handler34
L_UI_Handler30:
MOVW	R0, #lo_addr(_filesListOffset+0)
MOVT	R0, #hi_addr(_filesListOffset+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_cursorPos+0)
MOVT	R0, #hi_addr(_cursorPos+0)
LDRB	R0, [R0, #0]
ADDS	R1, R0, R1
SXTH	R1, R1
MOVS	R0, #36
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_FilesList+0)
MOVT	R0, #hi_addr(_FilesList+0)
ADDS	R0, R0, R1
ADDS	R0, R0, #2
LDRB	R0, [R0, #0]
CMP	R0, #73
IT	NE
BNE	L_UI_Handler35
;UserInterface.c,140 :: 		DisplayImage(FilesList[cursorPos+filesListOffset]->ID);
MOVW	R0, #lo_addr(_filesListOffset+0)
MOVT	R0, #hi_addr(_filesListOffset+0)
LDRB	R1, [R0, #0]
MOVW	R0, #lo_addr(_cursorPos+0)
MOVT	R0, #hi_addr(_cursorPos+0)
LDRB	R0, [R0, #0]
ADDS	R1, R0, R1
SXTH	R1, R1
MOVS	R0, #36
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_FilesList+0)
MOVT	R0, #hi_addr(_FilesList+0)
ADDS	R0, R0, R1
LDRH	R0, [R0, #0]
BL	_DisplayImage+0
;UserInterface.c,141 :: 		}
L_UI_Handler35:
L_UI_Handler34:
L_UI_Handler29:
;UserInterface.c,142 :: 		} else if (CurrentState == FILE_RECEIVE) { // Stop the playback
IT	AL
BAL	L_UI_Handler36
L_UI_Handler22:
MOVW	R0, #lo_addr(_CurrentState+0)
MOVT	R0, #hi_addr(_CurrentState+0)
LDRB	R0, [R0, #0]
CMP	R0, #2
IT	NE
BNE	L_UI_Handler37
;UserInterface.c,143 :: 		TerminateAudio();
BL	_TerminateAudio+0
;UserInterface.c,144 :: 		CurrentState = IDLE;
MOVS	R1, #0
MOVW	R0, #lo_addr(_CurrentState+0)
MOVT	R0, #hi_addr(_CurrentState+0)
STRB	R1, [R0, #0]
;UserInterface.c,145 :: 		}
L_UI_Handler37:
L_UI_Handler36:
L_UI_Handler21:
;UserInterface.c,146 :: 		oldstate_press = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate_press+0)
MOVT	R0, #hi_addr(_oldstate_press+0)
STRH	R1, [R0, #0]
;UserInterface.c,123 :: 		if (oldstate_press && Button(&GPIO_PORTH_DATA, 2, 1, 1)) { // detect logical one to logical zero transition
L__UI_Handler67:
L__UI_Handler66:
;UserInterface.c,150 :: 		if (Button(&GPIO_PORTE_DATA, 4, 1, 0))
MOVS	R3, #0
MOVS	R2, #1
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIO_PORTE_DATA+0)
MOVT	R0, #hi_addr(GPIO_PORTE_DATA+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L_UI_Handler38
;UserInterface.c,151 :: 		oldstate_right = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_oldstate_right+0)
MOVT	R0, #hi_addr(_oldstate_right+0)
STRH	R1, [R0, #0]
L_UI_Handler38:
;UserInterface.c,152 :: 		if (oldstate_right && Button(&GPIO_PORTE_DATA, 4, 1, 1)) { // detect logical one to logical zero transition
MOVW	R0, #lo_addr(_oldstate_right+0)
MOVT	R0, #hi_addr(_oldstate_right+0)
LDRH	R0, [R0, #0]
CMP	R0, #0
IT	EQ
BEQ	L__UI_Handler69
MOVS	R3, #1
MOVS	R2, #1
MOVS	R1, #4
MOVW	R0, #lo_addr(GPIO_PORTE_DATA+0)
MOVT	R0, #hi_addr(GPIO_PORTE_DATA+0)
BL	_Button+0
CMP	R0, #0
IT	EQ
BEQ	L__UI_Handler68
L__UI_Handler49:
;UserInterface.c,153 :: 		if (SDSave_Disabled == 0) { // Enabling the SD Saving mode (right click) is only possible if SD card is inserted
MOVW	R1, #lo_addr(_SDSave_Disabled+0)
MOVT	R1, #hi_addr(_SDSave_Disabled+0)
LDR	R0, [R1, #0]
CMP	R0, #0
IT	NE
BNE	L_UI_Handler42
;UserInterface.c,154 :: 		DownloadMode = ~DownloadMode;
MOVW	R1, #lo_addr(_DownloadMode+0)
MOVT	R1, #hi_addr(_DownloadMode+0)
LDR	R0, [R1, #0]
EOR	R0, R0, #1
STR	R0, [R1, #0]
;UserInterface.c,155 :: 		GPIO_PORTA_DATA6_bit = DownloadMode;
MOV	R0, R1
LDR	R1, [R0, #0]
MOVW	R0, #lo_addr(GPIO_PORTA_DATA6_bit+0)
MOVT	R0, #hi_addr(GPIO_PORTA_DATA6_bit+0)
STR	R1, [R0, #0]
;UserInterface.c,156 :: 		}
L_UI_Handler42:
;UserInterface.c,158 :: 		oldstate_right = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_oldstate_right+0)
MOVT	R0, #hi_addr(_oldstate_right+0)
STRH	R1, [R0, #0]
;UserInterface.c,152 :: 		if (oldstate_right && Button(&GPIO_PORTE_DATA, 4, 1, 1)) { // detect logical one to logical zero transition
L__UI_Handler69:
L__UI_Handler68:
;UserInterface.c,160 :: 		}
L_end_UI_Handler:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _UI_Handler
_UI_UpdateFilesList:
;UserInterface.c,162 :: 		void UI_UpdateFilesList()
SUB	SP, SP, #8
STR	LR, [SP, #0]
;UserInterface.c,165 :: 		for (i = 0; i < 12; i++) {
; i start address is: 24 (R6)
MOVS	R6, #0
; i end address is: 24 (R6)
L_UI_UpdateFilesList43:
; i start address is: 24 (R6)
CMP	R6, #12
IT	CS
BCS	L_UI_UpdateFilesList44
;UserInterface.c,166 :: 		memcpy(FileList_Labels[i]->Caption, FilesList[i+filesListOffset].Name, FilesList[i+filesListOffset].NameLength);
MOVW	R0, #lo_addr(_filesListOffset+0)
MOVT	R0, #hi_addr(_filesListOffset+0)
LDRB	R0, [R0, #0]
ADDS	R1, R6, R0
SXTH	R1, R1
MOVS	R0, #36
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_FilesList+0)
MOVT	R0, #hi_addr(_FilesList+0)
ADDS	R1, R0, R1
ADDW	R0, R1, #35
LDRB	R0, [R0, #0]
UXTB	R3, R0
ADDS	R2, R1, #3
LSLS	R1, R6, #2
MOVW	R0, #lo_addr(_FileList_Labels+0)
MOVT	R0, #hi_addr(_FileList_Labels+0)
ADDS	R0, R0, R1
LDR	R0, [R0, #0]
ADDS	R0, #16
LDR	R0, [R0, #0]
MOV	R1, R2
SXTH	R2, R3
BL	_memcpy+0
;UserInterface.c,167 :: 		FileList_Labels[i]->Caption[FilesList[i+filesListOffset].NameLength] = 0x00;
LSLS	R1, R6, #2
MOVW	R0, #lo_addr(_FileList_Labels+0)
MOVT	R0, #hi_addr(_FileList_Labels+0)
ADDS	R0, R0, R1
LDR	R0, [R0, #0]
ADDW	R2, R0, #16
MOVW	R0, #lo_addr(_filesListOffset+0)
MOVT	R0, #hi_addr(_filesListOffset+0)
LDRB	R0, [R0, #0]
ADDS	R1, R6, R0
SXTH	R1, R1
MOVS	R0, #36
MULS	R1, R0, R1
MOVW	R0, #lo_addr(_FilesList+0)
MOVT	R0, #hi_addr(_FilesList+0)
ADDS	R0, R0, R1
ADDS	R0, #35
LDRB	R1, [R0, #0]
LDR	R0, [R2, #0]
ADDS	R1, R0, R1
MOVS	R0, #0
STRB	R0, [R1, #0]
;UserInterface.c,165 :: 		for (i = 0; i < 12; i++) {
ADDS	R6, R6, #1
UXTB	R6, R6
;UserInterface.c,168 :: 		}
; i end address is: 24 (R6)
IT	AL
BAL	L_UI_UpdateFilesList43
L_UI_UpdateFilesList44:
;UserInterface.c,170 :: 		TFT_Set_Pen(MainScreen.Color, 0);
MOVW	R0, #lo_addr(_MainScreen+0)
MOVT	R0, #hi_addr(_MainScreen+0)
LDRH	R0, [R0, #0]
MOVS	R1, #0
BL	_TFT_Set_Pen+0
;UserInterface.c,171 :: 		TFT_Set_Brush(1, MainScreen.Color, 0, LEFT_TO_RIGHT, CL_WHITE, CL_WHITE);
MOVW	R2, #65535
MOVW	R1, #65535
MOVW	R0, #lo_addr(_MainScreen+0)
MOVT	R0, #hi_addr(_MainScreen+0)
LDRH	R0, [R0, #0]
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #0
UXTH	R1, R0
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;UserInterface.c,172 :: 		TFT_Rectangle(FileList_Labels[0]->Left, FileList_Labels[0]->Top, 240, 230);
MOVW	R0, #lo_addr(_File1+8)
MOVT	R0, #hi_addr(_File1+8)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_File1+6)
MOVT	R0, #hi_addr(_File1+6)
LDRH	R0, [R0, #0]
MOVS	R3, #230
SXTH	R3, R3
MOVS	R2, #240
SXTH	R2, R2
BL	_TFT_Rectangle+0
;UserInterface.c,173 :: 		TFT_Set_Font(FileList_Labels[0]->FontName, FileList_Labels[0]->Font_Color, FO_HORIZONTAL);
MOVW	R0, #lo_addr(_File1+24)
MOVT	R0, #hi_addr(_File1+24)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_File1+20)
MOVT	R0, #hi_addr(_File1+20)
LDR	R0, [R0, #0]
MOVS	R2, #0
BL	_TFT_Set_Font+0
;UserInterface.c,175 :: 		for (i = 0; i < 12; i++) {
; i start address is: 16 (R4)
MOVS	R4, #0
; i end address is: 16 (R4)
L_UI_UpdateFilesList46:
; i start address is: 16 (R4)
CMP	R4, #12
IT	CS
BCS	L_UI_UpdateFilesList47
;UserInterface.c,176 :: 		TFT_Write_Text(FileList_Labels[i]->Caption, FileList_Labels[i]->Left, FileList_Labels[i]->Top);
LSLS	R1, R4, #2
MOVW	R0, #lo_addr(_FileList_Labels+0)
MOVT	R0, #hi_addr(_FileList_Labels+0)
ADDS	R0, R0, R1
LDR	R3, [R0, #0]
ADDW	R0, R3, #8
LDRH	R0, [R0, #0]
UXTH	R2, R0
ADDS	R0, R3, #6
LDRH	R0, [R0, #0]
UXTH	R1, R0
ADDW	R0, R3, #16
LDR	R0, [R0, #0]
STRB	R4, [SP, #4]
BL	_TFT_Write_Text+0
LDRB	R4, [SP, #4]
;UserInterface.c,175 :: 		for (i = 0; i < 12; i++) {
ADDS	R4, R4, #1
UXTB	R4, R4
;UserInterface.c,177 :: 		}
; i end address is: 16 (R4)
IT	AL
BAL	L_UI_UpdateFilesList46
L_UI_UpdateFilesList47:
;UserInterface.c,178 :: 		}
L_end_UI_UpdateFilesList:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _UI_UpdateFilesList
_UI_UpdateFolderName:
;UserInterface.c,180 :: 		void UI_UpdateFolderName(void)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;UserInterface.c,182 :: 		TFT_Set_Pen(MainScreen.Color, 0);
MOVW	R0, #lo_addr(_MainScreen+0)
MOVT	R0, #hi_addr(_MainScreen+0)
LDRH	R0, [R0, #0]
MOVS	R1, #0
BL	_TFT_Set_Pen+0
;UserInterface.c,183 :: 		TFT_Set_Brush(1, MainScreen.Color, 0, LEFT_TO_RIGHT, CL_WHITE, CL_WHITE);
MOVW	R2, #65535
MOVW	R1, #65535
MOVW	R0, #lo_addr(_MainScreen+0)
MOVT	R0, #hi_addr(_MainScreen+0)
LDRH	R0, [R0, #0]
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #0
UXTH	R1, R0
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;UserInterface.c,184 :: 		TFT_Rectangle(Label2.Left, Label2.Top, 240, 22);
MOVW	R0, #lo_addr(_Label2+8)
MOVT	R0, #hi_addr(_Label2+8)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_Label2+6)
MOVT	R0, #hi_addr(_Label2+6)
LDRH	R0, [R0, #0]
MOVS	R3, #22
SXTH	R3, R3
MOVS	R2, #240
SXTH	R2, R2
BL	_TFT_Rectangle+0
;UserInterface.c,185 :: 		TFT_Set_Font(Label2.FontName, Label2.Font_Color, FO_HORIZONTAL);
MOVW	R0, #lo_addr(_Label2+24)
MOVT	R0, #hi_addr(_Label2+24)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_Label2+20)
MOVT	R0, #hi_addr(_Label2+20)
LDR	R0, [R0, #0]
MOVS	R2, #0
BL	_TFT_Set_Font+0
;UserInterface.c,186 :: 		TFT_Write_Text(CurrentFolderName, Label2.Left, Label2.Top);
MOVW	R0, #lo_addr(_Label2+8)
MOVT	R0, #hi_addr(_Label2+8)
LDRH	R1, [R0, #0]
MOVW	R0, #lo_addr(_Label2+6)
MOVT	R0, #hi_addr(_Label2+6)
LDRH	R0, [R0, #0]
UXTH	R2, R1
UXTH	R1, R0
MOVW	R0, #lo_addr(_CurrentFolderName+0)
MOVT	R0, #hi_addr(_CurrentFolderName+0)
BL	_TFT_Write_Text+0
;UserInterface.c,187 :: 		}
L_end_UI_UpdateFolderName:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _UI_UpdateFolderName
_UI_ResetCursorPos:
;UserInterface.c,189 :: 		void UI_ResetCursorPos(void)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;UserInterface.c,191 :: 		TFT_Set_Pen(MainScreen.Color, 0);
MOVW	R0, #lo_addr(_MainScreen+0)
MOVT	R0, #hi_addr(_MainScreen+0)
LDRH	R0, [R0, #0]
MOVS	R1, #0
BL	_TFT_Set_Pen+0
;UserInterface.c,192 :: 		TFT_Set_Brush(1, MainScreen.Color, 0, LEFT_TO_RIGHT, CL_WHITE, CL_WHITE);
MOVW	R2, #65535
MOVW	R1, #65535
MOVW	R0, #lo_addr(_MainScreen+0)
MOVT	R0, #hi_addr(_MainScreen+0)
LDRH	R0, [R0, #0]
PUSH	(R2)
PUSH	(R1)
MOVS	R3, #1
MOVS	R2, #0
UXTH	R1, R0
MOVS	R0, #1
BL	_TFT_Set_Brush+0
ADD	SP, SP, #8
;UserInterface.c,193 :: 		TFT_Rectangle(Image3.Left, Image3.Top, (Image3.Left+Image3.Width), (Image3.Top+Image3.Height));
MOVW	R0, #lo_addr(_Image3+12)
MOVT	R0, #hi_addr(_Image3+12)
LDRH	R1, [R0, #0]
MOVW	R5, #lo_addr(_Image3+8)
MOVT	R5, #hi_addr(_Image3+8)
STR	R5, [SP, #4]
LDRH	R0, [R5, #0]
ADDS	R4, R0, R1
MOVW	R0, #lo_addr(_Image3+10)
MOVT	R0, #hi_addr(_Image3+10)
LDRH	R1, [R0, #0]
MOVW	R3, #lo_addr(_Image3+6)
MOVT	R3, #hi_addr(_Image3+6)
LDRH	R0, [R3, #0]
ADDS	R2, R0, R1
MOV	R0, R5
LDRH	R1, [R0, #0]
MOV	R0, R3
LDRH	R0, [R0, #0]
SXTH	R3, R4
SXTH	R2, R2
BL	_TFT_Rectangle+0
;UserInterface.c,194 :: 		Image3.Left = 10;
MOVS	R1, #10
MOVW	R0, #lo_addr(_Image3+6)
MOVT	R0, #hi_addr(_Image3+6)
STRH	R1, [R0, #0]
;UserInterface.c,195 :: 		Image3.Top = 28;
MOVS	R1, #28
LDR	R0, [SP, #4]
STRH	R1, [R0, #0]
;UserInterface.c,196 :: 		DrawImage(&Image3);
MOVW	R0, #lo_addr(_Image3+0)
MOVT	R0, #hi_addr(_Image3+0)
BL	_DrawImage+0
;UserInterface.c,197 :: 		cursorPos = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_cursorPos+0)
MOVT	R0, #hi_addr(_cursorPos+0)
STRB	R1, [R0, #0]
;UserInterface.c,198 :: 		filesListOffset = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_filesListOffset+0)
MOVT	R0, #hi_addr(_filesListOffset+0)
STRB	R1, [R0, #0]
;UserInterface.c,199 :: 		}
L_end_UI_ResetCursorPos:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _UI_ResetCursorPos
UserInterface____?ag:
SUB	SP, SP, #4
L_end_UserInterface___?ag:
ADD	SP, SP, #4
BX	LR
; end of UserInterface____?ag
