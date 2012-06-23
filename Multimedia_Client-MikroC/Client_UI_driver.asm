_InitializeObjects:
;Client_UI_driver.c,136 :: 		void InitializeObjects() {
SUB	SP, SP, #4
;Client_UI_driver.c,137 :: 		LoadingScreen.Color                     = 0xFFFF;
MOVW	R1, #65535
MOVW	R0, #lo_addr(_LoadingScreen+0)
MOVT	R0, #hi_addr(_LoadingScreen+0)
STRH	R1, [R0, #0]
;Client_UI_driver.c,138 :: 		LoadingScreen.Width                     = 320;
MOVW	R1, #320
MOVW	R0, #lo_addr(_LoadingScreen+2)
MOVT	R0, #hi_addr(_LoadingScreen+2)
STRH	R1, [R0, #0]
;Client_UI_driver.c,139 :: 		LoadingScreen.Height                    = 240;
MOVS	R1, #240
MOVW	R0, #lo_addr(_LoadingScreen+4)
MOVT	R0, #hi_addr(_LoadingScreen+4)
STRH	R1, [R0, #0]
;Client_UI_driver.c,140 :: 		LoadingScreen.LabelsCount               = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_LoadingScreen+8)
MOVT	R0, #hi_addr(_LoadingScreen+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,141 :: 		LoadingScreen.Labels                    = Screen1_Labels;
MOVW	R1, #lo_addr(_Screen1_Labels+0)
MOVT	R1, #hi_addr(_Screen1_Labels+0)
MOVW	R0, #lo_addr(_LoadingScreen+12)
MOVT	R0, #hi_addr(_LoadingScreen+12)
STR	R1, [R0, #0]
;Client_UI_driver.c,142 :: 		LoadingScreen.ImagesCount               = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_LoadingScreen+16)
MOVT	R0, #hi_addr(_LoadingScreen+16)
STRH	R1, [R0, #0]
;Client_UI_driver.c,143 :: 		LoadingScreen.Images                    = Screen1_Images;
MOVW	R1, #lo_addr(_Screen1_Images+0)
MOVT	R1, #hi_addr(_Screen1_Images+0)
MOVW	R0, #lo_addr(_LoadingScreen+20)
MOVT	R0, #hi_addr(_LoadingScreen+20)
STR	R1, [R0, #0]
;Client_UI_driver.c,144 :: 		LoadingScreen.ObjectsCount              = 2;
MOVS	R1, #2
MOVW	R0, #lo_addr(_LoadingScreen+6)
MOVT	R0, #hi_addr(_LoadingScreen+6)
STRB	R1, [R0, #0]
;Client_UI_driver.c,146 :: 		MainScreen.Color                     = 0xE79F;
MOVW	R1, #59295
MOVW	R0, #lo_addr(_MainScreen+0)
MOVT	R0, #hi_addr(_MainScreen+0)
STRH	R1, [R0, #0]
;Client_UI_driver.c,147 :: 		MainScreen.Width                     = 320;
MOVW	R1, #320
MOVW	R0, #lo_addr(_MainScreen+2)
MOVT	R0, #hi_addr(_MainScreen+2)
STRH	R1, [R0, #0]
;Client_UI_driver.c,148 :: 		MainScreen.Height                    = 240;
MOVS	R1, #240
MOVW	R0, #lo_addr(_MainScreen+4)
MOVT	R0, #hi_addr(_MainScreen+4)
STRH	R1, [R0, #0]
;Client_UI_driver.c,149 :: 		MainScreen.LabelsCount               = 13;
MOVS	R1, #13
MOVW	R0, #lo_addr(_MainScreen+8)
MOVT	R0, #hi_addr(_MainScreen+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,150 :: 		MainScreen.Labels                    = Screen2_Labels;
MOVW	R1, #lo_addr(_Screen2_Labels+0)
MOVT	R1, #hi_addr(_Screen2_Labels+0)
MOVW	R0, #lo_addr(_MainScreen+12)
MOVT	R0, #hi_addr(_MainScreen+12)
STR	R1, [R0, #0]
;Client_UI_driver.c,151 :: 		MainScreen.ImagesCount               = 2;
MOVS	R1, #2
MOVW	R0, #lo_addr(_MainScreen+16)
MOVT	R0, #hi_addr(_MainScreen+16)
STRH	R1, [R0, #0]
;Client_UI_driver.c,152 :: 		MainScreen.Images                    = Screen2_Images;
MOVW	R1, #lo_addr(_Screen2_Images+0)
MOVT	R1, #hi_addr(_Screen2_Images+0)
MOVW	R0, #lo_addr(_MainScreen+20)
MOVT	R0, #hi_addr(_MainScreen+20)
STR	R1, [R0, #0]
;Client_UI_driver.c,153 :: 		MainScreen.ObjectsCount              = 15;
MOVS	R1, #15
MOVW	R0, #lo_addr(_MainScreen+6)
MOVT	R0, #hi_addr(_MainScreen+6)
STRB	R1, [R0, #0]
;Client_UI_driver.c,156 :: 		Image1.OwnerScreen     = &LoadingScreen;
MOVW	R1, #lo_addr(_LoadingScreen+0)
MOVT	R1, #hi_addr(_LoadingScreen+0)
MOVW	R0, #lo_addr(_Image1+0)
MOVT	R0, #hi_addr(_Image1+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,157 :: 		Image1.Order          = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+4)
MOVT	R0, #hi_addr(_Image1+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,158 :: 		Image1.Left           = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+6)
MOVT	R0, #hi_addr(_Image1+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,159 :: 		Image1.Top            = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+8)
MOVT	R0, #hi_addr(_Image1+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,160 :: 		Image1.Width          = 320;
MOVW	R1, #320
MOVW	R0, #lo_addr(_Image1+10)
MOVT	R0, #hi_addr(_Image1+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,161 :: 		Image1.Height         = 240;
MOVS	R1, #240
MOVW	R0, #lo_addr(_Image1+12)
MOVT	R0, #hi_addr(_Image1+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,162 :: 		Image1.Picture_Type   = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+22)
MOVT	R0, #hi_addr(_Image1+22)
STRB	R1, [R0, #0]
;Client_UI_driver.c,163 :: 		Image1.Picture_Ratio  = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Image1+23)
MOVT	R0, #hi_addr(_Image1+23)
STRB	R1, [R0, #0]
;Client_UI_driver.c,164 :: 		Image1.Picture_Name   = LoadingScreen_bmp;
MOVW	R1, #lo_addr(_LoadingScreen_bmp+0)
MOVT	R1, #hi_addr(_LoadingScreen_bmp+0)
MOVW	R0, #lo_addr(_Image1+16)
MOVT	R0, #hi_addr(_Image1+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,165 :: 		Image1.Visible        = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Image1+20)
MOVT	R0, #hi_addr(_Image1+20)
STRB	R1, [R0, #0]
;Client_UI_driver.c,166 :: 		Image1.Active         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+21)
MOVT	R0, #hi_addr(_Image1+21)
STRB	R1, [R0, #0]
;Client_UI_driver.c,167 :: 		Image1.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+24)
MOVT	R0, #hi_addr(_Image1+24)
STR	R1, [R0, #0]
;Client_UI_driver.c,168 :: 		Image1.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+28)
MOVT	R0, #hi_addr(_Image1+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,169 :: 		Image1.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+32)
MOVT	R0, #hi_addr(_Image1+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,170 :: 		Image1.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image1+36)
MOVT	R0, #hi_addr(_Image1+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,172 :: 		Label1.OwnerScreen     = &LoadingScreen;
MOVW	R1, #lo_addr(_LoadingScreen+0)
MOVT	R1, #hi_addr(_LoadingScreen+0)
MOVW	R0, #lo_addr(_Label1+0)
MOVT	R0, #hi_addr(_Label1+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,173 :: 		Label1.Order          = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Label1+4)
MOVT	R0, #hi_addr(_Label1+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,174 :: 		Label1.Left           = 108;
MOVS	R1, #108
MOVW	R0, #lo_addr(_Label1+6)
MOVT	R0, #hi_addr(_Label1+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,175 :: 		Label1.Top            = 148;
MOVS	R1, #148
MOVW	R0, #lo_addr(_Label1+8)
MOVT	R0, #hi_addr(_Label1+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,176 :: 		Label1.Width          = 54;
MOVS	R1, #54
MOVW	R0, #lo_addr(_Label1+10)
MOVT	R0, #hi_addr(_Label1+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,177 :: 		Label1.Height         = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_Label1+12)
MOVT	R0, #hi_addr(_Label1+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,178 :: 		Label1.Visible        = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Label1+26)
MOVT	R0, #hi_addr(_Label1+26)
STRB	R1, [R0, #0]
;Client_UI_driver.c,179 :: 		Label1.Active         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label1+27)
MOVT	R0, #hi_addr(_Label1+27)
STRB	R1, [R0, #0]
;Client_UI_driver.c,180 :: 		Label1.Caption        = Label1_Caption;
MOVW	R1, #lo_addr(_Label1_Caption+0)
MOVT	R1, #hi_addr(_Label1_Caption+0)
MOVW	R0, #lo_addr(_Label1+16)
MOVT	R0, #hi_addr(_Label1+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,181 :: 		Label1.FontName       = Tahoma11x13_Regular;
MOVW	R2, #lo_addr(_Tahoma11x13_Regular+0)
MOVT	R2, #hi_addr(_Tahoma11x13_Regular+0)
MOVW	R0, #lo_addr(_Label1+20)
MOVT	R0, #hi_addr(_Label1+20)
STR	R2, [R0, #0]
;Client_UI_driver.c,182 :: 		Label1.Font_Color     = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label1+24)
MOVT	R0, #hi_addr(_Label1+24)
STRH	R1, [R0, #0]
;Client_UI_driver.c,183 :: 		Label1.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label1+28)
MOVT	R0, #hi_addr(_Label1+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,184 :: 		Label1.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label1+32)
MOVT	R0, #hi_addr(_Label1+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,185 :: 		Label1.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label1+36)
MOVT	R0, #hi_addr(_Label1+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,186 :: 		Label1.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label1+40)
MOVT	R0, #hi_addr(_Label1+40)
STR	R1, [R0, #0]
;Client_UI_driver.c,188 :: 		Image2.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_Image2+0)
MOVT	R0, #hi_addr(_Image2+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,189 :: 		Image2.Order          = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image2+4)
MOVT	R0, #hi_addr(_Image2+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,190 :: 		Image2.Left           = 242;
MOVS	R1, #242
MOVW	R0, #lo_addr(_Image2+6)
MOVT	R0, #hi_addr(_Image2+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,191 :: 		Image2.Top            = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image2+8)
MOVT	R0, #hi_addr(_Image2+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,192 :: 		Image2.Width          = 78;
MOVS	R1, #78
MOVW	R0, #lo_addr(_Image2+10)
MOVT	R0, #hi_addr(_Image2+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,193 :: 		Image2.Height         = 77;
MOVS	R1, #77
MOVW	R0, #lo_addr(_Image2+12)
MOVT	R0, #hi_addr(_Image2+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,194 :: 		Image2.Picture_Type   = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image2+22)
MOVT	R0, #hi_addr(_Image2+22)
STRB	R1, [R0, #0]
;Client_UI_driver.c,195 :: 		Image2.Picture_Ratio  = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Image2+23)
MOVT	R0, #hi_addr(_Image2+23)
STRB	R1, [R0, #0]
;Client_UI_driver.c,196 :: 		Image2.Picture_Name   = SmallLogo_bmp;
MOVW	R1, #lo_addr(_SmallLogo_bmp+0)
MOVT	R1, #hi_addr(_SmallLogo_bmp+0)
MOVW	R0, #lo_addr(_Image2+16)
MOVT	R0, #hi_addr(_Image2+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,197 :: 		Image2.Visible        = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Image2+20)
MOVT	R0, #hi_addr(_Image2+20)
STRB	R1, [R0, #0]
;Client_UI_driver.c,198 :: 		Image2.Active         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image2+21)
MOVT	R0, #hi_addr(_Image2+21)
STRB	R1, [R0, #0]
;Client_UI_driver.c,199 :: 		Image2.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image2+24)
MOVT	R0, #hi_addr(_Image2+24)
STR	R1, [R0, #0]
;Client_UI_driver.c,200 :: 		Image2.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image2+28)
MOVT	R0, #hi_addr(_Image2+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,201 :: 		Image2.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image2+32)
MOVT	R0, #hi_addr(_Image2+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,202 :: 		Image2.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image2+36)
MOVT	R0, #hi_addr(_Image2+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,204 :: 		Label2.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_Label2+0)
MOVT	R0, #hi_addr(_Label2+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,205 :: 		Label2.Order          = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Label2+4)
MOVT	R0, #hi_addr(_Label2+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,206 :: 		Label2.Left           = 10;
MOVS	R1, #10
MOVW	R0, #lo_addr(_Label2+6)
MOVT	R0, #hi_addr(_Label2+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,207 :: 		Label2.Top            = 8;
MOVS	R1, #8
MOVW	R0, #lo_addr(_Label2+8)
MOVT	R0, #hi_addr(_Label2+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,208 :: 		Label2.Width          = 50;
MOVS	R1, #50
MOVW	R0, #lo_addr(_Label2+10)
MOVT	R0, #hi_addr(_Label2+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,209 :: 		Label2.Height         = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_Label2+12)
MOVT	R0, #hi_addr(_Label2+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,210 :: 		Label2.Visible        = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Label2+26)
MOVT	R0, #hi_addr(_Label2+26)
STRB	R1, [R0, #0]
;Client_UI_driver.c,211 :: 		Label2.Active         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label2+27)
MOVT	R0, #hi_addr(_Label2+27)
STRB	R1, [R0, #0]
;Client_UI_driver.c,212 :: 		Label2.Caption        = Label2_Caption;
MOVW	R1, #lo_addr(_Label2_Caption+0)
MOVT	R1, #hi_addr(_Label2_Caption+0)
MOVW	R0, #lo_addr(_Label2+16)
MOVT	R0, #hi_addr(_Label2+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,213 :: 		Label2.FontName       = Tahoma13x13_Bold;
MOVW	R1, #lo_addr(_Tahoma13x13_Bold+0)
MOVT	R1, #hi_addr(_Tahoma13x13_Bold+0)
MOVW	R0, #lo_addr(_Label2+20)
MOVT	R0, #hi_addr(_Label2+20)
STR	R1, [R0, #0]
;Client_UI_driver.c,214 :: 		Label2.Font_Color     = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label2+24)
MOVT	R0, #hi_addr(_Label2+24)
STRH	R1, [R0, #0]
;Client_UI_driver.c,215 :: 		Label2.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label2+28)
MOVT	R0, #hi_addr(_Label2+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,216 :: 		Label2.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label2+32)
MOVT	R0, #hi_addr(_Label2+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,217 :: 		Label2.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label2+36)
MOVT	R0, #hi_addr(_Label2+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,218 :: 		Label2.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label2+40)
MOVT	R0, #hi_addr(_Label2+40)
STR	R1, [R0, #0]
;Client_UI_driver.c,220 :: 		File1.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_File1+0)
MOVT	R0, #hi_addr(_File1+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,221 :: 		File1.Order          = 2;
MOVS	R1, #2
MOVW	R0, #lo_addr(_File1+4)
MOVT	R0, #hi_addr(_File1+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,222 :: 		File1.Left           = 30;
MOVS	R1, #30
MOVW	R0, #lo_addr(_File1+6)
MOVT	R0, #hi_addr(_File1+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,223 :: 		File1.Top            = 28;
MOVS	R1, #28
MOVW	R0, #lo_addr(_File1+8)
MOVT	R0, #hi_addr(_File1+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,224 :: 		File1.Width          = 18;
MOVS	R1, #18
MOVW	R0, #lo_addr(_File1+10)
MOVT	R0, #hi_addr(_File1+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,225 :: 		File1.Height         = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_File1+12)
MOVT	R0, #hi_addr(_File1+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,226 :: 		File1.Visible        = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File1+26)
MOVT	R0, #hi_addr(_File1+26)
STRB	R1, [R0, #0]
;Client_UI_driver.c,227 :: 		File1.Active         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_File1+27)
MOVT	R0, #hi_addr(_File1+27)
STRB	R1, [R0, #0]
;Client_UI_driver.c,228 :: 		File1.Caption        = File1_Caption;
MOVW	R1, #lo_addr(_File1_Caption+0)
MOVT	R1, #hi_addr(_File1_Caption+0)
MOVW	R0, #lo_addr(_File1+16)
MOVT	R0, #hi_addr(_File1+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,229 :: 		File1.FontName       = Tahoma11x13_Regular;
MOVW	R0, #lo_addr(_File1+20)
MOVT	R0, #hi_addr(_File1+20)
STR	R2, [R0, #0]
;Client_UI_driver.c,230 :: 		File1.Font_Color     = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File1+24)
MOVT	R0, #hi_addr(_File1+24)
STRH	R1, [R0, #0]
;Client_UI_driver.c,231 :: 		File1.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File1+28)
MOVT	R0, #hi_addr(_File1+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,232 :: 		File1.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File1+32)
MOVT	R0, #hi_addr(_File1+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,233 :: 		File1.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File1+36)
MOVT	R0, #hi_addr(_File1+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,234 :: 		File1.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File1+40)
MOVT	R0, #hi_addr(_File1+40)
STR	R1, [R0, #0]
;Client_UI_driver.c,236 :: 		File2.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_File2+0)
MOVT	R0, #hi_addr(_File2+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,237 :: 		File2.Order          = 3;
MOVS	R1, #3
MOVW	R0, #lo_addr(_File2+4)
MOVT	R0, #hi_addr(_File2+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,238 :: 		File2.Left           = 30;
MOVS	R1, #30
MOVW	R0, #lo_addr(_File2+6)
MOVT	R0, #hi_addr(_File2+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,239 :: 		File2.Top            = 44;
MOVS	R1, #44
MOVW	R0, #lo_addr(_File2+8)
MOVT	R0, #hi_addr(_File2+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,240 :: 		File2.Width          = 11;
MOVS	R1, #11
MOVW	R0, #lo_addr(_File2+10)
MOVT	R0, #hi_addr(_File2+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,241 :: 		File2.Height         = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_File2+12)
MOVT	R0, #hi_addr(_File2+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,242 :: 		File2.Visible        = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File2+26)
MOVT	R0, #hi_addr(_File2+26)
STRB	R1, [R0, #0]
;Client_UI_driver.c,243 :: 		File2.Active         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_File2+27)
MOVT	R0, #hi_addr(_File2+27)
STRB	R1, [R0, #0]
;Client_UI_driver.c,244 :: 		File2.Caption        = File2_Caption;
MOVW	R1, #lo_addr(_File2_Caption+0)
MOVT	R1, #hi_addr(_File2_Caption+0)
MOVW	R0, #lo_addr(_File2+16)
MOVT	R0, #hi_addr(_File2+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,245 :: 		File2.FontName       = Tahoma11x13_Regular;
MOVW	R0, #lo_addr(_File2+20)
MOVT	R0, #hi_addr(_File2+20)
STR	R2, [R0, #0]
;Client_UI_driver.c,246 :: 		File2.Font_Color     = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File2+24)
MOVT	R0, #hi_addr(_File2+24)
STRH	R1, [R0, #0]
;Client_UI_driver.c,247 :: 		File2.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File2+28)
MOVT	R0, #hi_addr(_File2+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,248 :: 		File2.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File2+32)
MOVT	R0, #hi_addr(_File2+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,249 :: 		File2.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File2+36)
MOVT	R0, #hi_addr(_File2+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,250 :: 		File2.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File2+40)
MOVT	R0, #hi_addr(_File2+40)
STR	R1, [R0, #0]
;Client_UI_driver.c,252 :: 		Image3.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_Image3+0)
MOVT	R0, #hi_addr(_Image3+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,253 :: 		Image3.Order          = 4;
MOVS	R1, #4
MOVW	R0, #lo_addr(_Image3+4)
MOVT	R0, #hi_addr(_Image3+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,254 :: 		Image3.Left           = 10;
MOVS	R1, #10
MOVW	R0, #lo_addr(_Image3+6)
MOVT	R0, #hi_addr(_Image3+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,255 :: 		Image3.Top            = 28;
MOVS	R1, #28
MOVW	R0, #lo_addr(_Image3+8)
MOVT	R0, #hi_addr(_Image3+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,256 :: 		Image3.Width          = 14;
MOVS	R1, #14
MOVW	R0, #lo_addr(_Image3+10)
MOVT	R0, #hi_addr(_Image3+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,257 :: 		Image3.Height         = 14;
MOVS	R1, #14
MOVW	R0, #lo_addr(_Image3+12)
MOVT	R0, #hi_addr(_Image3+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,258 :: 		Image3.Picture_Type   = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image3+22)
MOVT	R0, #hi_addr(_Image3+22)
STRB	R1, [R0, #0]
;Client_UI_driver.c,259 :: 		Image3.Picture_Ratio  = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Image3+23)
MOVT	R0, #hi_addr(_Image3+23)
STRB	R1, [R0, #0]
;Client_UI_driver.c,260 :: 		Image3.Picture_Name   = Forward_bmp;
MOVW	R1, #lo_addr(_Forward_bmp+0)
MOVT	R1, #hi_addr(_Forward_bmp+0)
MOVW	R0, #lo_addr(_Image3+16)
MOVT	R0, #hi_addr(_Image3+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,261 :: 		Image3.Visible        = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Image3+20)
MOVT	R0, #hi_addr(_Image3+20)
STRB	R1, [R0, #0]
;Client_UI_driver.c,262 :: 		Image3.Active         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image3+21)
MOVT	R0, #hi_addr(_Image3+21)
STRB	R1, [R0, #0]
;Client_UI_driver.c,263 :: 		Image3.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image3+24)
MOVT	R0, #hi_addr(_Image3+24)
STR	R1, [R0, #0]
;Client_UI_driver.c,264 :: 		Image3.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image3+28)
MOVT	R0, #hi_addr(_Image3+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,265 :: 		Image3.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image3+32)
MOVT	R0, #hi_addr(_Image3+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,266 :: 		Image3.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Image3+36)
MOVT	R0, #hi_addr(_Image3+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,268 :: 		File3.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_File3+0)
MOVT	R0, #hi_addr(_File3+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,269 :: 		File3.Order          = 5;
MOVS	R1, #5
MOVW	R0, #lo_addr(_File3+4)
MOVT	R0, #hi_addr(_File3+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,270 :: 		File3.Left           = 30;
MOVS	R1, #30
MOVW	R0, #lo_addr(_File3+6)
MOVT	R0, #hi_addr(_File3+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,271 :: 		File3.Top            = 60;
MOVS	R1, #60
MOVW	R0, #lo_addr(_File3+8)
MOVT	R0, #hi_addr(_File3+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,272 :: 		File3.Width          = 11;
MOVS	R1, #11
MOVW	R0, #lo_addr(_File3+10)
MOVT	R0, #hi_addr(_File3+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,273 :: 		File3.Height         = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_File3+12)
MOVT	R0, #hi_addr(_File3+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,274 :: 		File3.Visible        = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File3+26)
MOVT	R0, #hi_addr(_File3+26)
STRB	R1, [R0, #0]
;Client_UI_driver.c,275 :: 		File3.Active         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_File3+27)
MOVT	R0, #hi_addr(_File3+27)
STRB	R1, [R0, #0]
;Client_UI_driver.c,276 :: 		File3.Caption        = File3_Caption;
MOVW	R1, #lo_addr(_File3_Caption+0)
MOVT	R1, #hi_addr(_File3_Caption+0)
MOVW	R0, #lo_addr(_File3+16)
MOVT	R0, #hi_addr(_File3+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,277 :: 		File3.FontName       = Tahoma11x13_Regular;
MOVW	R0, #lo_addr(_File3+20)
MOVT	R0, #hi_addr(_File3+20)
STR	R2, [R0, #0]
;Client_UI_driver.c,278 :: 		File3.Font_Color     = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File3+24)
MOVT	R0, #hi_addr(_File3+24)
STRH	R1, [R0, #0]
;Client_UI_driver.c,279 :: 		File3.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File3+28)
MOVT	R0, #hi_addr(_File3+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,280 :: 		File3.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File3+32)
MOVT	R0, #hi_addr(_File3+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,281 :: 		File3.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File3+36)
MOVT	R0, #hi_addr(_File3+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,282 :: 		File3.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File3+40)
MOVT	R0, #hi_addr(_File3+40)
STR	R1, [R0, #0]
;Client_UI_driver.c,284 :: 		File4.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_File4+0)
MOVT	R0, #hi_addr(_File4+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,285 :: 		File4.Order          = 6;
MOVS	R1, #6
MOVW	R0, #lo_addr(_File4+4)
MOVT	R0, #hi_addr(_File4+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,286 :: 		File4.Left           = 30;
MOVS	R1, #30
MOVW	R0, #lo_addr(_File4+6)
MOVT	R0, #hi_addr(_File4+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,287 :: 		File4.Top            = 76;
MOVS	R1, #76
MOVW	R0, #lo_addr(_File4+8)
MOVT	R0, #hi_addr(_File4+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,288 :: 		File4.Width          = 11;
MOVS	R1, #11
MOVW	R0, #lo_addr(_File4+10)
MOVT	R0, #hi_addr(_File4+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,289 :: 		File4.Height         = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_File4+12)
MOVT	R0, #hi_addr(_File4+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,290 :: 		File4.Visible        = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File4+26)
MOVT	R0, #hi_addr(_File4+26)
STRB	R1, [R0, #0]
;Client_UI_driver.c,291 :: 		File4.Active         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_File4+27)
MOVT	R0, #hi_addr(_File4+27)
STRB	R1, [R0, #0]
;Client_UI_driver.c,292 :: 		File4.Caption        = File4_Caption;
MOVW	R1, #lo_addr(_File4_Caption+0)
MOVT	R1, #hi_addr(_File4_Caption+0)
MOVW	R0, #lo_addr(_File4+16)
MOVT	R0, #hi_addr(_File4+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,293 :: 		File4.FontName       = Tahoma11x13_Regular;
MOVW	R0, #lo_addr(_File4+20)
MOVT	R0, #hi_addr(_File4+20)
STR	R2, [R0, #0]
;Client_UI_driver.c,294 :: 		File4.Font_Color     = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File4+24)
MOVT	R0, #hi_addr(_File4+24)
STRH	R1, [R0, #0]
;Client_UI_driver.c,295 :: 		File4.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File4+28)
MOVT	R0, #hi_addr(_File4+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,296 :: 		File4.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File4+32)
MOVT	R0, #hi_addr(_File4+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,297 :: 		File4.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File4+36)
MOVT	R0, #hi_addr(_File4+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,298 :: 		File4.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File4+40)
MOVT	R0, #hi_addr(_File4+40)
STR	R1, [R0, #0]
;Client_UI_driver.c,300 :: 		File5.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_File5+0)
MOVT	R0, #hi_addr(_File5+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,301 :: 		File5.Order          = 7;
MOVS	R1, #7
MOVW	R0, #lo_addr(_File5+4)
MOVT	R0, #hi_addr(_File5+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,302 :: 		File5.Left           = 30;
MOVS	R1, #30
MOVW	R0, #lo_addr(_File5+6)
MOVT	R0, #hi_addr(_File5+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,303 :: 		File5.Top            = 92;
MOVS	R1, #92
MOVW	R0, #lo_addr(_File5+8)
MOVT	R0, #hi_addr(_File5+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,304 :: 		File5.Width          = 11;
MOVS	R1, #11
MOVW	R0, #lo_addr(_File5+10)
MOVT	R0, #hi_addr(_File5+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,305 :: 		File5.Height         = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_File5+12)
MOVT	R0, #hi_addr(_File5+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,306 :: 		File5.Visible        = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File5+26)
MOVT	R0, #hi_addr(_File5+26)
STRB	R1, [R0, #0]
;Client_UI_driver.c,307 :: 		File5.Active         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_File5+27)
MOVT	R0, #hi_addr(_File5+27)
STRB	R1, [R0, #0]
;Client_UI_driver.c,308 :: 		File5.Caption        = File5_Caption;
MOVW	R1, #lo_addr(_File5_Caption+0)
MOVT	R1, #hi_addr(_File5_Caption+0)
MOVW	R0, #lo_addr(_File5+16)
MOVT	R0, #hi_addr(_File5+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,309 :: 		File5.FontName       = Tahoma11x13_Regular;
MOVW	R0, #lo_addr(_File5+20)
MOVT	R0, #hi_addr(_File5+20)
STR	R2, [R0, #0]
;Client_UI_driver.c,310 :: 		File5.Font_Color     = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File5+24)
MOVT	R0, #hi_addr(_File5+24)
STRH	R1, [R0, #0]
;Client_UI_driver.c,311 :: 		File5.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File5+28)
MOVT	R0, #hi_addr(_File5+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,312 :: 		File5.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File5+32)
MOVT	R0, #hi_addr(_File5+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,313 :: 		File5.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File5+36)
MOVT	R0, #hi_addr(_File5+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,314 :: 		File5.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File5+40)
MOVT	R0, #hi_addr(_File5+40)
STR	R1, [R0, #0]
;Client_UI_driver.c,316 :: 		File6.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_File6+0)
MOVT	R0, #hi_addr(_File6+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,317 :: 		File6.Order          = 8;
MOVS	R1, #8
MOVW	R0, #lo_addr(_File6+4)
MOVT	R0, #hi_addr(_File6+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,318 :: 		File6.Left           = 30;
MOVS	R1, #30
MOVW	R0, #lo_addr(_File6+6)
MOVT	R0, #hi_addr(_File6+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,319 :: 		File6.Top            = 108;
MOVS	R1, #108
MOVW	R0, #lo_addr(_File6+8)
MOVT	R0, #hi_addr(_File6+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,320 :: 		File6.Width          = 11;
MOVS	R1, #11
MOVW	R0, #lo_addr(_File6+10)
MOVT	R0, #hi_addr(_File6+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,321 :: 		File6.Height         = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_File6+12)
MOVT	R0, #hi_addr(_File6+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,322 :: 		File6.Visible        = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File6+26)
MOVT	R0, #hi_addr(_File6+26)
STRB	R1, [R0, #0]
;Client_UI_driver.c,323 :: 		File6.Active         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_File6+27)
MOVT	R0, #hi_addr(_File6+27)
STRB	R1, [R0, #0]
;Client_UI_driver.c,324 :: 		File6.Caption        = File6_Caption;
MOVW	R1, #lo_addr(_File6_Caption+0)
MOVT	R1, #hi_addr(_File6_Caption+0)
MOVW	R0, #lo_addr(_File6+16)
MOVT	R0, #hi_addr(_File6+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,325 :: 		File6.FontName       = Tahoma11x13_Regular;
MOVW	R0, #lo_addr(_File6+20)
MOVT	R0, #hi_addr(_File6+20)
STR	R2, [R0, #0]
;Client_UI_driver.c,326 :: 		File6.Font_Color     = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File6+24)
MOVT	R0, #hi_addr(_File6+24)
STRH	R1, [R0, #0]
;Client_UI_driver.c,327 :: 		File6.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File6+28)
MOVT	R0, #hi_addr(_File6+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,328 :: 		File6.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File6+32)
MOVT	R0, #hi_addr(_File6+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,329 :: 		File6.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File6+36)
MOVT	R0, #hi_addr(_File6+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,330 :: 		File6.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File6+40)
MOVT	R0, #hi_addr(_File6+40)
STR	R1, [R0, #0]
;Client_UI_driver.c,332 :: 		File7.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_File7+0)
MOVT	R0, #hi_addr(_File7+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,333 :: 		File7.Order          = 9;
MOVS	R1, #9
MOVW	R0, #lo_addr(_File7+4)
MOVT	R0, #hi_addr(_File7+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,334 :: 		File7.Left           = 30;
MOVS	R1, #30
MOVW	R0, #lo_addr(_File7+6)
MOVT	R0, #hi_addr(_File7+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,335 :: 		File7.Top            = 124;
MOVS	R1, #124
MOVW	R0, #lo_addr(_File7+8)
MOVT	R0, #hi_addr(_File7+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,336 :: 		File7.Width          = 11;
MOVS	R1, #11
MOVW	R0, #lo_addr(_File7+10)
MOVT	R0, #hi_addr(_File7+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,337 :: 		File7.Height         = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_File7+12)
MOVT	R0, #hi_addr(_File7+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,338 :: 		File7.Visible        = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File7+26)
MOVT	R0, #hi_addr(_File7+26)
STRB	R1, [R0, #0]
;Client_UI_driver.c,339 :: 		File7.Active         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_File7+27)
MOVT	R0, #hi_addr(_File7+27)
STRB	R1, [R0, #0]
;Client_UI_driver.c,340 :: 		File7.Caption        = File7_Caption;
MOVW	R1, #lo_addr(_File7_Caption+0)
MOVT	R1, #hi_addr(_File7_Caption+0)
MOVW	R0, #lo_addr(_File7+16)
MOVT	R0, #hi_addr(_File7+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,341 :: 		File7.FontName       = Tahoma11x13_Regular;
MOVW	R0, #lo_addr(_File7+20)
MOVT	R0, #hi_addr(_File7+20)
STR	R2, [R0, #0]
;Client_UI_driver.c,342 :: 		File7.Font_Color     = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File7+24)
MOVT	R0, #hi_addr(_File7+24)
STRH	R1, [R0, #0]
;Client_UI_driver.c,343 :: 		File7.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File7+28)
MOVT	R0, #hi_addr(_File7+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,344 :: 		File7.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File7+32)
MOVT	R0, #hi_addr(_File7+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,345 :: 		File7.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File7+36)
MOVT	R0, #hi_addr(_File7+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,346 :: 		File7.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File7+40)
MOVT	R0, #hi_addr(_File7+40)
STR	R1, [R0, #0]
;Client_UI_driver.c,348 :: 		File8.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_File8+0)
MOVT	R0, #hi_addr(_File8+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,349 :: 		File8.Order          = 10;
MOVS	R1, #10
MOVW	R0, #lo_addr(_File8+4)
MOVT	R0, #hi_addr(_File8+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,350 :: 		File8.Left           = 30;
MOVS	R1, #30
MOVW	R0, #lo_addr(_File8+6)
MOVT	R0, #hi_addr(_File8+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,351 :: 		File8.Top            = 140;
MOVS	R1, #140
MOVW	R0, #lo_addr(_File8+8)
MOVT	R0, #hi_addr(_File8+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,352 :: 		File8.Width          = 11;
MOVS	R1, #11
MOVW	R0, #lo_addr(_File8+10)
MOVT	R0, #hi_addr(_File8+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,353 :: 		File8.Height         = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_File8+12)
MOVT	R0, #hi_addr(_File8+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,354 :: 		File8.Visible        = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File8+26)
MOVT	R0, #hi_addr(_File8+26)
STRB	R1, [R0, #0]
;Client_UI_driver.c,355 :: 		File8.Active         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_File8+27)
MOVT	R0, #hi_addr(_File8+27)
STRB	R1, [R0, #0]
;Client_UI_driver.c,356 :: 		File8.Caption        = File8_Caption;
MOVW	R1, #lo_addr(_File8_Caption+0)
MOVT	R1, #hi_addr(_File8_Caption+0)
MOVW	R0, #lo_addr(_File8+16)
MOVT	R0, #hi_addr(_File8+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,357 :: 		File8.FontName       = Tahoma11x13_Regular;
MOVW	R0, #lo_addr(_File8+20)
MOVT	R0, #hi_addr(_File8+20)
STR	R2, [R0, #0]
;Client_UI_driver.c,358 :: 		File8.Font_Color     = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File8+24)
MOVT	R0, #hi_addr(_File8+24)
STRH	R1, [R0, #0]
;Client_UI_driver.c,359 :: 		File8.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File8+28)
MOVT	R0, #hi_addr(_File8+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,360 :: 		File8.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File8+32)
MOVT	R0, #hi_addr(_File8+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,361 :: 		File8.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File8+36)
MOVT	R0, #hi_addr(_File8+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,362 :: 		File8.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File8+40)
MOVT	R0, #hi_addr(_File8+40)
STR	R1, [R0, #0]
;Client_UI_driver.c,364 :: 		File9.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_File9+0)
MOVT	R0, #hi_addr(_File9+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,365 :: 		File9.Order          = 11;
MOVS	R1, #11
MOVW	R0, #lo_addr(_File9+4)
MOVT	R0, #hi_addr(_File9+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,366 :: 		File9.Left           = 30;
MOVS	R1, #30
MOVW	R0, #lo_addr(_File9+6)
MOVT	R0, #hi_addr(_File9+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,367 :: 		File9.Top            = 156;
MOVS	R1, #156
MOVW	R0, #lo_addr(_File9+8)
MOVT	R0, #hi_addr(_File9+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,368 :: 		File9.Width          = 11;
MOVS	R1, #11
MOVW	R0, #lo_addr(_File9+10)
MOVT	R0, #hi_addr(_File9+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,369 :: 		File9.Height         = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_File9+12)
MOVT	R0, #hi_addr(_File9+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,370 :: 		File9.Visible        = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File9+26)
MOVT	R0, #hi_addr(_File9+26)
STRB	R1, [R0, #0]
;Client_UI_driver.c,371 :: 		File9.Active         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_File9+27)
MOVT	R0, #hi_addr(_File9+27)
STRB	R1, [R0, #0]
;Client_UI_driver.c,372 :: 		File9.Caption        = File9_Caption;
MOVW	R1, #lo_addr(_File9_Caption+0)
MOVT	R1, #hi_addr(_File9_Caption+0)
MOVW	R0, #lo_addr(_File9+16)
MOVT	R0, #hi_addr(_File9+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,373 :: 		File9.FontName       = Tahoma11x13_Regular;
MOVW	R0, #lo_addr(_File9+20)
MOVT	R0, #hi_addr(_File9+20)
STR	R2, [R0, #0]
;Client_UI_driver.c,374 :: 		File9.Font_Color     = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File9+24)
MOVT	R0, #hi_addr(_File9+24)
STRH	R1, [R0, #0]
;Client_UI_driver.c,375 :: 		File9.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File9+28)
MOVT	R0, #hi_addr(_File9+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,376 :: 		File9.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File9+32)
MOVT	R0, #hi_addr(_File9+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,377 :: 		File9.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File9+36)
MOVT	R0, #hi_addr(_File9+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,378 :: 		File9.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File9+40)
MOVT	R0, #hi_addr(_File9+40)
STR	R1, [R0, #0]
;Client_UI_driver.c,380 :: 		File10.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_File10+0)
MOVT	R0, #hi_addr(_File10+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,381 :: 		File10.Order          = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_File10+4)
MOVT	R0, #hi_addr(_File10+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,382 :: 		File10.Left           = 30;
MOVS	R1, #30
MOVW	R0, #lo_addr(_File10+6)
MOVT	R0, #hi_addr(_File10+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,383 :: 		File10.Top            = 172;
MOVS	R1, #172
MOVW	R0, #lo_addr(_File10+8)
MOVT	R0, #hi_addr(_File10+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,384 :: 		File10.Width          = 11;
MOVS	R1, #11
MOVW	R0, #lo_addr(_File10+10)
MOVT	R0, #hi_addr(_File10+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,385 :: 		File10.Height         = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_File10+12)
MOVT	R0, #hi_addr(_File10+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,386 :: 		File10.Visible        = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File10+26)
MOVT	R0, #hi_addr(_File10+26)
STRB	R1, [R0, #0]
;Client_UI_driver.c,387 :: 		File10.Active         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_File10+27)
MOVT	R0, #hi_addr(_File10+27)
STRB	R1, [R0, #0]
;Client_UI_driver.c,388 :: 		File10.Caption        = File10_Caption;
MOVW	R1, #lo_addr(_File10_Caption+0)
MOVT	R1, #hi_addr(_File10_Caption+0)
MOVW	R0, #lo_addr(_File10+16)
MOVT	R0, #hi_addr(_File10+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,389 :: 		File10.FontName       = Tahoma11x13_Regular;
MOVW	R0, #lo_addr(_File10+20)
MOVT	R0, #hi_addr(_File10+20)
STR	R2, [R0, #0]
;Client_UI_driver.c,390 :: 		File10.Font_Color     = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File10+24)
MOVT	R0, #hi_addr(_File10+24)
STRH	R1, [R0, #0]
;Client_UI_driver.c,391 :: 		File10.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File10+28)
MOVT	R0, #hi_addr(_File10+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,392 :: 		File10.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File10+32)
MOVT	R0, #hi_addr(_File10+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,393 :: 		File10.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File10+36)
MOVT	R0, #hi_addr(_File10+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,394 :: 		File10.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File10+40)
MOVT	R0, #hi_addr(_File10+40)
STR	R1, [R0, #0]
;Client_UI_driver.c,396 :: 		File11.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_File11+0)
MOVT	R0, #hi_addr(_File11+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,397 :: 		File11.Order          = 13;
MOVS	R1, #13
MOVW	R0, #lo_addr(_File11+4)
MOVT	R0, #hi_addr(_File11+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,398 :: 		File11.Left           = 30;
MOVS	R1, #30
MOVW	R0, #lo_addr(_File11+6)
MOVT	R0, #hi_addr(_File11+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,399 :: 		File11.Top            = 188;
MOVS	R1, #188
MOVW	R0, #lo_addr(_File11+8)
MOVT	R0, #hi_addr(_File11+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,400 :: 		File11.Width          = 11;
MOVS	R1, #11
MOVW	R0, #lo_addr(_File11+10)
MOVT	R0, #hi_addr(_File11+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,401 :: 		File11.Height         = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_File11+12)
MOVT	R0, #hi_addr(_File11+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,402 :: 		File11.Visible        = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File11+26)
MOVT	R0, #hi_addr(_File11+26)
STRB	R1, [R0, #0]
;Client_UI_driver.c,403 :: 		File11.Active         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_File11+27)
MOVT	R0, #hi_addr(_File11+27)
STRB	R1, [R0, #0]
;Client_UI_driver.c,404 :: 		File11.Caption        = File11_Caption;
MOVW	R1, #lo_addr(_File11_Caption+0)
MOVT	R1, #hi_addr(_File11_Caption+0)
MOVW	R0, #lo_addr(_File11+16)
MOVT	R0, #hi_addr(_File11+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,405 :: 		File11.FontName       = Tahoma11x13_Regular;
MOVW	R0, #lo_addr(_File11+20)
MOVT	R0, #hi_addr(_File11+20)
STR	R2, [R0, #0]
;Client_UI_driver.c,406 :: 		File11.Font_Color     = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File11+24)
MOVT	R0, #hi_addr(_File11+24)
STRH	R1, [R0, #0]
;Client_UI_driver.c,407 :: 		File11.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File11+28)
MOVT	R0, #hi_addr(_File11+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,408 :: 		File11.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File11+32)
MOVT	R0, #hi_addr(_File11+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,409 :: 		File11.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File11+36)
MOVT	R0, #hi_addr(_File11+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,410 :: 		File11.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_File11+40)
MOVT	R0, #hi_addr(_File11+40)
STR	R1, [R0, #0]
;Client_UI_driver.c,412 :: 		Label3.OwnerScreen     = &MainScreen;
MOVW	R1, #lo_addr(_MainScreen+0)
MOVT	R1, #hi_addr(_MainScreen+0)
MOVW	R0, #lo_addr(_Label3+0)
MOVT	R0, #hi_addr(_Label3+0)
STR	R1, [R0, #0]
;Client_UI_driver.c,413 :: 		Label3.Order          = 14;
MOVS	R1, #14
MOVW	R0, #lo_addr(_Label3+4)
MOVT	R0, #hi_addr(_Label3+4)
STRB	R1, [R0, #0]
;Client_UI_driver.c,414 :: 		Label3.Left           = 30;
MOVS	R1, #30
MOVW	R0, #lo_addr(_Label3+6)
MOVT	R0, #hi_addr(_Label3+6)
STRH	R1, [R0, #0]
;Client_UI_driver.c,415 :: 		Label3.Top            = 204;
MOVS	R1, #204
MOVW	R0, #lo_addr(_Label3+8)
MOVT	R0, #hi_addr(_Label3+8)
STRH	R1, [R0, #0]
;Client_UI_driver.c,416 :: 		Label3.Width          = 11;
MOVS	R1, #11
MOVW	R0, #lo_addr(_Label3+10)
MOVT	R0, #hi_addr(_Label3+10)
STRH	R1, [R0, #0]
;Client_UI_driver.c,417 :: 		Label3.Height         = 12;
MOVS	R1, #12
MOVW	R0, #lo_addr(_Label3+12)
MOVT	R0, #hi_addr(_Label3+12)
STRH	R1, [R0, #0]
;Client_UI_driver.c,418 :: 		Label3.Visible        = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label3+26)
MOVT	R0, #hi_addr(_Label3+26)
STRB	R1, [R0, #0]
;Client_UI_driver.c,419 :: 		Label3.Active         = 1;
MOVS	R1, #1
MOVW	R0, #lo_addr(_Label3+27)
MOVT	R0, #hi_addr(_Label3+27)
STRB	R1, [R0, #0]
;Client_UI_driver.c,420 :: 		Label3.Caption        = Label3_Caption;
MOVW	R1, #lo_addr(_Label3_Caption+0)
MOVT	R1, #hi_addr(_Label3_Caption+0)
MOVW	R0, #lo_addr(_Label3+16)
MOVT	R0, #hi_addr(_Label3+16)
STR	R1, [R0, #0]
;Client_UI_driver.c,421 :: 		Label3.FontName       = Tahoma11x13_Regular;
MOVW	R0, #lo_addr(_Label3+20)
MOVT	R0, #hi_addr(_Label3+20)
STR	R2, [R0, #0]
;Client_UI_driver.c,422 :: 		Label3.Font_Color     = 0x0000;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label3+24)
MOVT	R0, #hi_addr(_Label3+24)
STRH	R1, [R0, #0]
;Client_UI_driver.c,423 :: 		Label3.OnUpPtr         = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label3+28)
MOVT	R0, #hi_addr(_Label3+28)
STR	R1, [R0, #0]
;Client_UI_driver.c,424 :: 		Label3.OnDownPtr       = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label3+32)
MOVT	R0, #hi_addr(_Label3+32)
STR	R1, [R0, #0]
;Client_UI_driver.c,425 :: 		Label3.OnClickPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label3+36)
MOVT	R0, #hi_addr(_Label3+36)
STR	R1, [R0, #0]
;Client_UI_driver.c,426 :: 		Label3.OnPressPtr      = 0;
MOVS	R1, #0
MOVW	R0, #lo_addr(_Label3+40)
MOVT	R0, #hi_addr(_Label3+40)
STR	R1, [R0, #0]
;Client_UI_driver.c,427 :: 		}
L_end_InitializeObjects:
ADD	SP, SP, #4
BX	LR
; end of _InitializeObjects
Client_UI_driver_IsInsideObject:
;Client_UI_driver.c,429 :: 		static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) { // static
; Top start address is: 12 (R3)
; Left start address is: 8 (R2)
; Y start address is: 4 (R1)
; X start address is: 0 (R0)
SUB	SP, SP, #4
;Client_UI_driver.c,430 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
; Top end address is: 12 (R3)
; Left end address is: 8 (R2)
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
; X start address is: 0 (R0)
; Y start address is: 4 (R1)
; Left start address is: 8 (R2)
; Top start address is: 12 (R3)
; Width start address is: 20 (R5)
LDRH	R5, [SP, #4]
; Height start address is: 24 (R6)
LDRH	R6, [SP, #8]
CMP	R2, R0
IT	HI
BHI	L_Client_UI_driver_IsInsideObject34
ADDS	R4, R2, R5
UXTH	R4, R4
; Left end address is: 8 (R2)
; Width end address is: 20 (R5)
SUBS	R4, R4, #1
UXTH	R4, R4
CMP	R4, R0
IT	CC
BCC	L_Client_UI_driver_IsInsideObject33
; X end address is: 0 (R0)
;Client_UI_driver.c,431 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
CMP	R3, R1
IT	HI
BHI	L_Client_UI_driver_IsInsideObject32
ADDS	R4, R3, R6
UXTH	R4, R4
; Top end address is: 12 (R3)
; Height end address is: 24 (R6)
SUBS	R4, R4, #1
UXTH	R4, R4
CMP	R4, R1
IT	CC
BCC	L_Client_UI_driver_IsInsideObject31
; Y end address is: 4 (R1)
L_Client_UI_driver_IsInsideObject30:
;Client_UI_driver.c,432 :: 		return 1;
MOVS	R0, #1
IT	AL
BAL	L_end_IsInsideObject
;Client_UI_driver.c,430 :: 		if ( (Left<= X) && (Left+ Width - 1 >= X) &&
L_Client_UI_driver_IsInsideObject34:
L_Client_UI_driver_IsInsideObject33:
;Client_UI_driver.c,431 :: 		(Top <= Y)  && (Top + Height - 1 >= Y) )
L_Client_UI_driver_IsInsideObject32:
L_Client_UI_driver_IsInsideObject31:
;Client_UI_driver.c,434 :: 		return 0;
MOVS	R0, #0
;Client_UI_driver.c,435 :: 		}
L_end_IsInsideObject:
ADD	SP, SP, #4
BX	LR
; end of Client_UI_driver_IsInsideObject
_DrawLabel:
;Client_UI_driver.c,442 :: 		void DrawLabel(TLabel *ALabel) {
; ALabel start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;Client_UI_driver.c,444 :: 		x_pos = 0;
; ALabel end address is: 0 (R0)
; ALabel start address is: 0 (R0)
;Client_UI_driver.c,446 :: 		if (ALabel->Visible == 1) {
ADDW	R1, R0, #26
LDRB	R1, [R1, #0]
CMP	R1, #1
IT	NE
BNE	L_DrawLabel4
;Client_UI_driver.c,447 :: 		TFT_Set_Font(ALabel->FontName, ALabel->Font_Color, FO_HORIZONTAL);
ADDW	R1, R0, #24
LDRH	R1, [R1, #0]
UXTH	R2, R1
ADDW	R1, R0, #20
LDR	R1, [R1, #0]
STR	R0, [SP, #4]
MOV	R0, R1
UXTH	R1, R2
MOVS	R2, #0
BL	_TFT_Set_Font+0
LDR	R0, [SP, #4]
;Client_UI_driver.c,448 :: 		TFT_Write_Text_Return_Pos(ALabel->Caption, ALabel->Left, ALabel->Top);
ADDW	R1, R0, #8
LDRH	R1, [R1, #0]
UXTH	R3, R1
ADDS	R1, R0, #6
LDRH	R1, [R1, #0]
UXTH	R2, R1
ADDW	R1, R0, #16
LDR	R1, [R1, #0]
STR	R0, [SP, #4]
MOV	R0, R1
UXTH	R1, R2
UXTH	R2, R3
BL	_TFT_Write_Text_Return_Pos+0
LDR	R0, [SP, #4]
;Client_UI_driver.c,449 :: 		x_pos = ALabel->Left + ((int)(ALabel->Width - caption_length) / 2);
ADDS	R1, R0, #6
LDRH	R5, [R1, #0]
ADDW	R1, R0, #10
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_caption_length+0)
MOVT	R1, #hi_addr(_caption_length+0)
LDRH	R1, [R1, #0]
SUB	R1, R2, R1
SXTH	R1, R1
ASRS	R1, R1, #1
SXTH	R1, R1
ADDS	R4, R5, R1
; x_pos start address is: 24 (R6)
SXTH	R6, R4
;Client_UI_driver.c,450 :: 		y_pos = ALabel->Top + ((int)(ALabel->Height - caption_height) / 2);
ADDW	R1, R0, #8
LDRH	R3, [R1, #0]
ADDW	R1, R0, #12
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_caption_height+0)
MOVT	R1, #hi_addr(_caption_height+0)
LDRH	R1, [R1, #0]
SUB	R1, R2, R1
SXTH	R1, R1
ASRS	R1, R1, #1
SXTH	R1, R1
ADDS	R1, R3, R1
; y_pos start address is: 8 (R2)
SXTH	R2, R1
;Client_UI_driver.c,451 :: 		if (x_pos > ALabel->Left) {
SXTH	R1, R4
CMP	R1, R5
IT	LS
BLS	L_DrawLabel5
;Client_UI_driver.c,452 :: 		TFT_Write_Text(ALabel->Caption, x_pos, y_pos);
ADDW	R1, R0, #16
; ALabel end address is: 0 (R0)
LDR	R1, [R1, #0]
UXTH	R2, R2
; y_pos end address is: 8 (R2)
MOV	R0, R1
; x_pos end address is: 24 (R6)
UXTH	R1, R6
BL	_TFT_Write_Text+0
;Client_UI_driver.c,453 :: 		}
IT	AL
BAL	L_DrawLabel6
L_DrawLabel5:
;Client_UI_driver.c,455 :: 		TFT_Write_Text(ALabel->Caption, ALabel->Left, ALabel->Top);
; ALabel start address is: 0 (R0)
ADDW	R1, R0, #8
LDRH	R1, [R1, #0]
UXTH	R3, R1
ADDS	R1, R0, #6
LDRH	R1, [R1, #0]
UXTH	R2, R1
ADDW	R1, R0, #16
; ALabel end address is: 0 (R0)
LDR	R1, [R1, #0]
MOV	R0, R1
UXTH	R1, R2
UXTH	R2, R3
BL	_TFT_Write_Text+0
;Client_UI_driver.c,456 :: 		}
L_DrawLabel6:
;Client_UI_driver.c,457 :: 		}
L_DrawLabel4:
;Client_UI_driver.c,458 :: 		}
L_end_DrawLabel:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _DrawLabel
_DrawImage:
;Client_UI_driver.c,460 :: 		void DrawImage(TImage *AImage) {
; AImage start address is: 0 (R0)
SUB	SP, SP, #4
STR	LR, [SP, #0]
;Client_UI_driver.c,461 :: 		if (AImage->Visible) {
; AImage end address is: 0 (R0)
; AImage start address is: 0 (R0)
ADDW	R1, R0, #20
LDRB	R1, [R1, #0]
CMP	R1, #0
IT	EQ
BEQ	L_DrawImage7
;Client_UI_driver.c,462 :: 		TFT_Image(AImage->Left, AImage->Top, AImage->Picture_Name, AImage->Picture_Ratio);
ADDW	R1, R0, #23
LDRB	R1, [R1, #0]
UXTB	R4, R1
ADDW	R1, R0, #16
LDR	R1, [R1, #0]
MOV	R3, R1
ADDW	R1, R0, #8
LDRH	R1, [R1, #0]
UXTH	R2, R1
ADDS	R1, R0, #6
; AImage end address is: 0 (R0)
LDRH	R1, [R1, #0]
UXTH	R0, R1
UXTH	R1, R2
MOV	R2, R3
UXTB	R3, R4
BL	_TFT_Image+0
;Client_UI_driver.c,463 :: 		}
L_DrawImage7:
;Client_UI_driver.c,464 :: 		}
L_end_DrawImage:
LDR	LR, [SP, #0]
ADD	SP, SP, #4
BX	LR
; end of _DrawImage
_DrawScreen:
;Client_UI_driver.c,466 :: 		void DrawScreen(TScreen *aScreen) {
; aScreen start address is: 0 (R0)
SUB	SP, SP, #48
STR	LR, [SP, #0]
;Client_UI_driver.c,474 :: 		object_pressed = 0;
; aScreen end address is: 0 (R0)
; aScreen start address is: 0 (R0)
MOVS	R2, #0
MOVW	R1, #lo_addr(_object_pressed+0)
MOVT	R1, #hi_addr(_object_pressed+0)
STRB	R2, [R1, #0]
;Client_UI_driver.c,475 :: 		order = 0;
MOVS	R1, #0
STRB	R1, [SP, #4]
;Client_UI_driver.c,476 :: 		label_idx = 0;
MOVS	R1, #0
STRB	R1, [SP, #5]
;Client_UI_driver.c,477 :: 		image_idx = 0;
MOVS	R1, #0
STRB	R1, [SP, #12]
;Client_UI_driver.c,478 :: 		CurrentScreen = aScreen;
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
STR	R0, [R1, #0]
;Client_UI_driver.c,480 :: 		if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
ADDS	R1, R0, #2
; aScreen end address is: 0 (R0)
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_width+0)
MOVT	R1, #hi_addr(_display_width+0)
LDRH	R1, [R1, #0]
CMP	R1, R2
IT	NE
BNE	L__DrawScreen37
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #4
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_height+0)
MOVT	R1, #hi_addr(_display_height+0)
LDRH	R1, [R1, #0]
CMP	R1, R2
IT	NE
BNE	L__DrawScreen36
IT	AL
BAL	L_DrawScreen10
L__DrawScreen37:
L__DrawScreen36:
;Client_UI_driver.c,481 :: 		save_bled = TFT_BLED;
MOVW	R3, #lo_addr(GPIO_PORTA_DATA3_bit+0)
MOVT	R3, #hi_addr(GPIO_PORTA_DATA3_bit+0)
STR	R3, [SP, #44]
LDR	R1, [R3, #0]
STRB	R1, [SP, #20]
;Client_UI_driver.c,482 :: 		save_bled_direction = TFT_BLED_Direction;
MOVW	R2, #lo_addr(GPIO_PORTA_DIR3_bit+0)
MOVT	R2, #hi_addr(GPIO_PORTA_DIR3_bit+0)
STR	R2, [SP, #40]
LDR	R1, [R2, #0]
STRB	R1, [SP, #21]
;Client_UI_driver.c,483 :: 		TFT_BLED_Direction = 1;
MOVS	R1, #1
SXTB	R1, R1
STR	R1, [R2, #0]
;Client_UI_driver.c,484 :: 		TFT_BLED           = 0;
MOVS	R1, #0
SXTB	R1, R1
STR	R1, [R3, #0]
;Client_UI_driver.c,485 :: 		TFT_Init(CurrentScreen->Width, CurrentScreen->Height);
MOVW	R3, #lo_addr(_CurrentScreen+0)
MOVT	R3, #hi_addr(_CurrentScreen+0)
STR	R3, [SP, #36]
LDR	R1, [R3, #0]
ADDS	R1, R1, #4
LDRH	R1, [R1, #0]
UXTH	R2, R1
MOV	R1, R3
LDR	R1, [R1, #0]
ADDS	R1, R1, #2
LDRH	R1, [R1, #0]
UXTH	R0, R1
UXTH	R1, R2
BL	_TFT_Init+0
;Client_UI_driver.c,486 :: 		TFT_Fill_Screen(CurrentScreen->Color);
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
LDRH	R1, [R1, #0]
UXTH	R0, R1
BL	_TFT_Fill_Screen+0
;Client_UI_driver.c,487 :: 		display_width = CurrentScreen->Width;
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #2
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_width+0)
MOVT	R1, #hi_addr(_display_width+0)
STRH	R2, [R1, #0]
;Client_UI_driver.c,488 :: 		display_height = CurrentScreen->Height;
LDR	R1, [SP, #36]
LDR	R1, [R1, #0]
ADDS	R1, R1, #4
LDRH	R2, [R1, #0]
MOVW	R1, #lo_addr(_display_height+0)
MOVT	R1, #hi_addr(_display_height+0)
STRH	R2, [R1, #0]
;Client_UI_driver.c,489 :: 		TFT_BLED           = save_bled;
LDRB	R2, [SP, #20]
LDR	R1, [SP, #44]
STR	R2, [R1, #0]
;Client_UI_driver.c,490 :: 		TFT_BLED_Direction = save_bled_direction;
LDRB	R2, [SP, #21]
LDR	R1, [SP, #40]
STR	R2, [R1, #0]
;Client_UI_driver.c,491 :: 		}
IT	AL
BAL	L_DrawScreen11
L_DrawScreen10:
;Client_UI_driver.c,493 :: 		TFT_Fill_Screen(CurrentScreen->Color);
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
LDRH	R1, [R1, #0]
UXTH	R0, R1
BL	_TFT_Fill_Screen+0
L_DrawScreen11:
;Client_UI_driver.c,496 :: 		while (order < CurrentScreen->ObjectsCount) {
L_DrawScreen12:
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, R1, #6
LDRB	R2, [R1, #0]
LDRB	R1, [SP, #4]
CMP	R1, R2
IT	CS
BCS	L_DrawScreen13
;Client_UI_driver.c,497 :: 		if (label_idx < CurrentScreen->LabelsCount) {
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, #8
LDRH	R2, [R1, #0]
LDRB	R1, [SP, #5]
CMP	R1, R2
IT	CS
BCS	L_DrawScreen14
;Client_UI_driver.c,498 :: 		local_label = GetLabel(label_idx);
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, #12
LDR	R2, [R1, #0]
LDRB	R1, [SP, #5]
LSLS	R1, R1, #2
ADDS	R1, R2, R1
LDR	R1, [R1, #0]
STR	R1, [SP, #8]
;Client_UI_driver.c,499 :: 		if (order == local_label->Order) {
ADDS	R1, R1, #4
LDRB	R2, [R1, #0]
LDRB	R1, [SP, #4]
CMP	R1, R2
IT	NE
BNE	L_DrawScreen15
;Client_UI_driver.c,500 :: 		label_idx++;
LDRB	R1, [SP, #5]
ADDS	R1, R1, #1
STRB	R1, [SP, #5]
;Client_UI_driver.c,501 :: 		order++;
LDRB	R1, [SP, #4]
ADDS	R1, R1, #1
STRB	R1, [SP, #4]
;Client_UI_driver.c,502 :: 		DrawLabel(local_label);
LDR	R0, [SP, #8]
BL	_DrawLabel+0
;Client_UI_driver.c,503 :: 		}
L_DrawScreen15:
;Client_UI_driver.c,504 :: 		}
L_DrawScreen14:
;Client_UI_driver.c,506 :: 		if (image_idx  < CurrentScreen->ImagesCount) {
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, #16
LDRH	R2, [R1, #0]
LDRB	R1, [SP, #12]
CMP	R1, R2
IT	CS
BCS	L_DrawScreen16
;Client_UI_driver.c,507 :: 		local_image = GetImage(image_idx);
MOVW	R1, #lo_addr(_CurrentScreen+0)
MOVT	R1, #hi_addr(_CurrentScreen+0)
LDR	R1, [R1, #0]
ADDS	R1, #20
LDR	R2, [R1, #0]
LDRB	R1, [SP, #12]
LSLS	R1, R1, #2
ADDS	R1, R2, R1
LDR	R1, [R1, #0]
STR	R1, [SP, #16]
;Client_UI_driver.c,508 :: 		if (order == local_image->Order) {
ADDS	R1, R1, #4
LDRB	R2, [R1, #0]
LDRB	R1, [SP, #4]
CMP	R1, R2
IT	NE
BNE	L_DrawScreen17
;Client_UI_driver.c,509 :: 		image_idx++;
LDRB	R1, [SP, #12]
ADDS	R1, R1, #1
STRB	R1, [SP, #12]
;Client_UI_driver.c,510 :: 		order++;
LDRB	R1, [SP, #4]
ADDS	R1, R1, #1
STRB	R1, [SP, #4]
;Client_UI_driver.c,511 :: 		DrawImage(local_image);
LDR	R0, [SP, #16]
BL	_DrawImage+0
;Client_UI_driver.c,512 :: 		}
L_DrawScreen17:
;Client_UI_driver.c,513 :: 		}
L_DrawScreen16:
;Client_UI_driver.c,515 :: 		}
IT	AL
BAL	L_DrawScreen12
L_DrawScreen13:
;Client_UI_driver.c,516 :: 		}
L_end_DrawScreen:
LDR	LR, [SP, #0]
ADD	SP, SP, #48
BX	LR
; end of _DrawScreen
_Get_Object:
;Client_UI_driver.c,518 :: 		void Get_Object(unsigned int X, unsigned int Y) {
; Y start address is: 4 (R1)
; X start address is: 0 (R0)
SUB	SP, SP, #8
STR	LR, [SP, #0]
;Client_UI_driver.c,519 :: 		label_order         = -1;
; Y end address is: 4 (R1)
; X end address is: 0 (R0)
; X start address is: 0 (R0)
; Y start address is: 4 (R1)
MOVS	R3, #-1
SXTB	R3, R3
MOVW	R2, #lo_addr(_label_order+0)
MOVT	R2, #hi_addr(_label_order+0)
STRB	R3, [R2, #0]
;Client_UI_driver.c,520 :: 		image_order         = -1;
MOVS	R3, #-1
SXTB	R3, R3
MOVW	R2, #lo_addr(_image_order+0)
MOVT	R2, #hi_addr(_image_order+0)
STRB	R3, [R2, #0]
;Client_UI_driver.c,522 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->LabelsCount ; _object_count++ ) {
MOVS	R3, #0
SXTH	R3, R3
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
STRH	R3, [R2, #0]
; X end address is: 0 (R0)
; Y end address is: 4 (R1)
UXTH	R8, R0
UXTH	R7, R1
L_Get_Object18:
; Y start address is: 28 (R7)
; X start address is: 32 (R8)
MOVW	R2, #lo_addr(_CurrentScreen+0)
MOVT	R2, #hi_addr(_CurrentScreen+0)
LDR	R2, [R2, #0]
ADDS	R2, #8
LDRH	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, R3
IT	CS
BCS	L_Get_Object19
;Client_UI_driver.c,523 :: 		local_label = GetLabel(_object_count);
MOVW	R2, #lo_addr(_CurrentScreen+0)
MOVT	R2, #hi_addr(_CurrentScreen+0)
LDR	R2, [R2, #0]
ADDS	R2, #12
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
LSLS	R2, R2, #2
ADDS	R2, R3, R2
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(_local_label+0)
MOVT	R2, #hi_addr(_local_label+0)
STR	R3, [R2, #0]
;Client_UI_driver.c,524 :: 		if (local_label->Active == 1) {
ADDW	R2, R3, #27
LDRB	R2, [R2, #0]
CMP	R2, #1
IT	NE
BNE	L_Get_Object21
;Client_UI_driver.c,526 :: 		local_label->Width, local_label->Height) == 1) {
MOVW	R6, #lo_addr(_local_label+0)
MOVT	R6, #hi_addr(_local_label+0)
LDR	R2, [R6, #0]
ADDS	R2, #12
LDRH	R2, [R2, #0]
UXTH	R5, R2
MOV	R2, R6
LDR	R2, [R2, #0]
ADDS	R2, #10
LDRH	R2, [R2, #0]
UXTH	R4, R2
;Client_UI_driver.c,525 :: 		if (IsInsideObject(X, Y, local_label->Left, local_label->Top,
MOV	R2, R6
LDR	R2, [R2, #0]
ADDS	R2, #8
LDRH	R2, [R2, #0]
UXTH	R3, R2
MOV	R2, R6
LDR	R2, [R2, #0]
ADDS	R2, R2, #6
LDRH	R2, [R2, #0]
UXTH	R1, R7
UXTH	R0, R8
;Client_UI_driver.c,526 :: 		local_label->Width, local_label->Height) == 1) {
PUSH	(R5)
PUSH	(R4)
BL	Client_UI_driver_IsInsideObject+0
ADD	SP, SP, #8
CMP	R0, #1
IT	NE
BNE	L_Get_Object22
;Client_UI_driver.c,527 :: 		label_order = local_label->Order;
MOVW	R4, #lo_addr(_local_label+0)
MOVT	R4, #hi_addr(_local_label+0)
LDR	R2, [R4, #0]
ADDS	R2, R2, #4
LDRB	R3, [R2, #0]
MOVW	R2, #lo_addr(_label_order+0)
MOVT	R2, #hi_addr(_label_order+0)
STRB	R3, [R2, #0]
;Client_UI_driver.c,528 :: 		exec_label = local_label;
MOV	R2, R4
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(_exec_label+0)
MOVT	R2, #hi_addr(_exec_label+0)
STR	R3, [R2, #0]
;Client_UI_driver.c,529 :: 		}
L_Get_Object22:
;Client_UI_driver.c,530 :: 		}
L_Get_Object21:
;Client_UI_driver.c,522 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->LabelsCount ; _object_count++ ) {
MOVW	R3, #lo_addr(__object_count+0)
MOVT	R3, #hi_addr(__object_count+0)
LDRSH	R2, [R3, #0]
ADDS	R2, R2, #1
STRH	R2, [R3, #0]
;Client_UI_driver.c,531 :: 		}
IT	AL
BAL	L_Get_Object18
L_Get_Object19:
;Client_UI_driver.c,534 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->ImagesCount ; _object_count++ ) {
MOVS	R3, #0
SXTH	R3, R3
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
STRH	R3, [R2, #0]
; Y end address is: 28 (R7)
; X end address is: 32 (R8)
STRH	R8, [SP, #4]
UXTH	R8, R7
LDRH	R7, [SP, #4]
L_Get_Object23:
; Y start address is: 32 (R8)
; X start address is: 28 (R7)
; X start address is: 28 (R7)
; X end address is: 28 (R7)
; Y start address is: 32 (R8)
; Y end address is: 32 (R8)
MOVW	R2, #lo_addr(_CurrentScreen+0)
MOVT	R2, #hi_addr(_CurrentScreen+0)
LDR	R2, [R2, #0]
ADDS	R2, #16
LDRH	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
CMP	R2, R3
IT	CS
BCS	L_Get_Object24
; X end address is: 28 (R7)
; Y end address is: 32 (R8)
;Client_UI_driver.c,535 :: 		local_image = GetImage(_object_count);
; Y start address is: 32 (R8)
; X start address is: 28 (R7)
MOVW	R2, #lo_addr(_CurrentScreen+0)
MOVT	R2, #hi_addr(_CurrentScreen+0)
LDR	R2, [R2, #0]
ADDS	R2, #20
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R2, [R2, #0]
LSLS	R2, R2, #2
ADDS	R2, R3, R2
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(_local_image+0)
MOVT	R2, #hi_addr(_local_image+0)
STR	R3, [R2, #0]
;Client_UI_driver.c,536 :: 		if (local_image->Active == 1) {
ADDW	R2, R3, #21
LDRB	R2, [R2, #0]
CMP	R2, #1
IT	NE
BNE	L_Get_Object26
;Client_UI_driver.c,538 :: 		local_image->Width, local_image->Height) == 1) {
MOVW	R6, #lo_addr(_local_image+0)
MOVT	R6, #hi_addr(_local_image+0)
LDR	R2, [R6, #0]
ADDS	R2, #12
LDRH	R2, [R2, #0]
UXTH	R5, R2
MOV	R2, R6
LDR	R2, [R2, #0]
ADDS	R2, #10
LDRH	R2, [R2, #0]
UXTH	R4, R2
;Client_UI_driver.c,537 :: 		if (IsInsideObject(X, Y, local_image->Left, local_image->Top,
MOV	R2, R6
LDR	R2, [R2, #0]
ADDS	R2, #8
LDRH	R2, [R2, #0]
UXTH	R3, R2
MOV	R2, R6
LDR	R2, [R2, #0]
ADDS	R2, R2, #6
LDRH	R2, [R2, #0]
UXTH	R1, R8
UXTH	R0, R7
;Client_UI_driver.c,538 :: 		local_image->Width, local_image->Height) == 1) {
PUSH	(R5)
PUSH	(R4)
BL	Client_UI_driver_IsInsideObject+0
ADD	SP, SP, #8
CMP	R0, #1
IT	NE
BNE	L_Get_Object27
;Client_UI_driver.c,539 :: 		image_order = local_image->Order;
MOVW	R4, #lo_addr(_local_image+0)
MOVT	R4, #hi_addr(_local_image+0)
LDR	R2, [R4, #0]
ADDS	R2, R2, #4
LDRB	R3, [R2, #0]
MOVW	R2, #lo_addr(_image_order+0)
MOVT	R2, #hi_addr(_image_order+0)
STRB	R3, [R2, #0]
;Client_UI_driver.c,540 :: 		exec_image = local_image;
MOV	R2, R4
LDR	R3, [R2, #0]
MOVW	R2, #lo_addr(_exec_image+0)
MOVT	R2, #hi_addr(_exec_image+0)
STR	R3, [R2, #0]
;Client_UI_driver.c,541 :: 		}
L_Get_Object27:
;Client_UI_driver.c,542 :: 		}
L_Get_Object26:
;Client_UI_driver.c,534 :: 		for ( _object_count = 0 ; _object_count < CurrentScreen->ImagesCount ; _object_count++ ) {
MOVW	R3, #lo_addr(__object_count+0)
MOVT	R3, #hi_addr(__object_count+0)
LDRSH	R2, [R3, #0]
ADDS	R2, R2, #1
STRH	R2, [R3, #0]
;Client_UI_driver.c,543 :: 		}
; X end address is: 28 (R7)
; Y end address is: 32 (R8)
IT	AL
BAL	L_Get_Object23
L_Get_Object24:
;Client_UI_driver.c,545 :: 		_object_count = -1;
MOVW	R3, #65535
SXTH	R3, R3
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
STRH	R3, [R2, #0]
;Client_UI_driver.c,546 :: 		if (label_order >  _object_count )
MOVW	R2, #lo_addr(_label_order+0)
MOVT	R2, #hi_addr(_label_order+0)
LDRSB	R2, [R2, #0]
CMP	R2, #-1
IT	LE
BLE	L_Get_Object28
;Client_UI_driver.c,547 :: 		_object_count = label_order;
MOVW	R2, #lo_addr(_label_order+0)
MOVT	R2, #hi_addr(_label_order+0)
LDRSB	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
STRH	R3, [R2, #0]
L_Get_Object28:
;Client_UI_driver.c,548 :: 		if (image_order >  _object_count )
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
LDRSH	R3, [R2, #0]
MOVW	R2, #lo_addr(_image_order+0)
MOVT	R2, #hi_addr(_image_order+0)
LDRSB	R2, [R2, #0]
CMP	R2, R3
IT	LE
BLE	L_Get_Object29
;Client_UI_driver.c,549 :: 		_object_count = image_order;
MOVW	R2, #lo_addr(_image_order+0)
MOVT	R2, #hi_addr(_image_order+0)
LDRSB	R3, [R2, #0]
MOVW	R2, #lo_addr(__object_count+0)
MOVT	R2, #hi_addr(__object_count+0)
STRH	R3, [R2, #0]
L_Get_Object29:
;Client_UI_driver.c,550 :: 		}
L_end_Get_Object:
LDR	LR, [SP, #0]
ADD	SP, SP, #8
BX	LR
; end of _Get_Object
Client_UI_driver____?ag:
SUB	SP, SP, #4
L_end_Client_UI_driver___?ag:
ADD	SP, SP, #4
BX	LR
; end of Client_UI_driver____?ag
