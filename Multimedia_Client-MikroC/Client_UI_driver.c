#include "Client_UI_objects.h"
#include "Client_UI_resources.h"

// TFT module connections
char TFT_DataPort at GPIO_PORTJ_DATA;
sbit TFT_RST at GPIO_PORTH_DATA5_bit;
sbit TFT_RS at GPIO_PORTG_DATA7_bit;
sbit TFT_CS at GPIO_PORTH_DATA6_bit;
sbit TFT_RD at GPIO_PORTC_DATA5_bit;
sbit TFT_WR at GPIO_PORTH_DATA4_bit;
sbit TFT_BLED at GPIO_PORTA_DATA3_bit;
char TFT_DataPort_Direction at GPIO_PORTJ_DIR;
sbit TFT_RST_Direction at GPIO_PORTH_DIR5_bit;
sbit TFT_RS_Direction at GPIO_PORTG_DIR7_bit;
sbit TFT_CS_Direction at GPIO_PORTH_DIR6_bit;
sbit TFT_RD_Direction at GPIO_PORTC_DIR5_bit;
sbit TFT_WR_Direction at GPIO_PORTH_DIR4_bit;
sbit TFT_BLED_Direction at GPIO_PORTA_DIR3_bit;
// End TFT module connections

// Touch Panel module connections
sbit DriveX_Left at GPIO_PORTB_DATA4_bit;
sbit DriveX_Right at GPIO_PORTE_DATA0_bit;
sbit DriveY_Up at GPIO_PORTE_DATA1_bit;
sbit DriveY_Down at GPIO_PORTB_DATA5_bit;
sbit DriveX_Left_Direction at GPIO_PORTB_DIR4_bit;
sbit DriveX_Right_Direction at GPIO_PORTE_DIR0_bit;
sbit DriveY_Up_Direction at GPIO_PORTE_DIR1_bit;
sbit DriveY_Down_Direction at GPIO_PORTB_DIR5_bit;
// End Touch Panel module connections

// Global variables
unsigned int Xcoord, Ycoord;
const ADC_THRESHOLD = 750;
char PenDown;
void *PressedObject;
int PressedObjectType;
unsigned int caption_length, caption_height;
unsigned int display_width, display_height;

int _object_count;
unsigned short object_pressed;
TLabel *local_label;
TLabel *exec_label;
short label_order;
TImage *local_image;
TImage *exec_image;
short image_order;


/////////////////////////
  TScreen*  CurrentScreen;

  TScreen                LoadingScreen;
  TImage               Image1;
  TLabel                 Label1;
char Label1_Caption[21] = "Connecting to server";

  TLabel                 * const code Screen1_Labels[1]=
         {
         &Label1
         };
  TImage                 * const code Screen1_Images[1]=
         {
         &Image1
         };


  TScreen                MainScreen;
  TImage               Image2;
  TLabel                 Label2;
char Label2_Caption[7] = "[ROOT]";

  TLabel                 File1;
char File1_Caption[31] = "../";

  TLabel                 File2;
char File2_Caption[31] = ".";

  TImage               Image3;
  TLabel                 File3;
char File3_Caption[31] = ".";

  TLabel                 File4;
char File4_Caption[31] = ".";

  TLabel                 File5;
char File5_Caption[31] = ".";

  TLabel                 File6;
char File6_Caption[31] = ".";

  TLabel                 File7;
char File7_Caption[31] = ".";

  TLabel                 File8;
char File8_Caption[31] = ".";

  TLabel                 File9;
char File9_Caption[31] = ".";

  TLabel                 File10;
char File10_Caption[31] = ".";

  TLabel                 File11;
char File11_Caption[31] = ".";

  TLabel                 Label3;
char Label3_Caption[31] = ".";

  TLabel                 * const code Screen2_Labels[13]=
         {
         &Label2,
         &File1,
         &File2,
         &File3,
         &File4,
         &File5,
         &File6,
         &File7,
         &File8,
         &File9,
         &File10,
         &File11,
         &Label3
         };
  TImage                 * const code Screen2_Images[2]=
         {
         &Image2,
         &Image3
         };




void InitializeObjects() {
  LoadingScreen.Color                     = 0xFFFF;
  LoadingScreen.Width                     = 320;
  LoadingScreen.Height                    = 240;
  LoadingScreen.LabelsCount               = 1;
  LoadingScreen.Labels                    = Screen1_Labels;
  LoadingScreen.ImagesCount               = 1;
  LoadingScreen.Images                    = Screen1_Images;
  LoadingScreen.ObjectsCount              = 2;

  MainScreen.Color                     = 0xE79F;
  MainScreen.Width                     = 320;
  MainScreen.Height                    = 240;
  MainScreen.LabelsCount               = 13;
  MainScreen.Labels                    = Screen2_Labels;
  MainScreen.ImagesCount               = 2;
  MainScreen.Images                    = Screen2_Images;
  MainScreen.ObjectsCount              = 15;


  Image1.OwnerScreen     = &LoadingScreen;
  Image1.Order          = 0;
  Image1.Left           = 0;
  Image1.Top            = 0;
  Image1.Width          = 320;
  Image1.Height         = 240;
  Image1.Picture_Type   = 0;
  Image1.Picture_Ratio  = 1;
  Image1.Picture_Name   = LoadingScreen_bmp;
  Image1.Visible        = 1;
  Image1.Active         = 0;
  Image1.OnUpPtr         = 0;
  Image1.OnDownPtr       = 0;
  Image1.OnClickPtr      = 0;
  Image1.OnPressPtr      = 0;

  Label1.OwnerScreen     = &LoadingScreen;
  Label1.Order          = 1;
  Label1.Left           = 108;
  Label1.Top            = 148;
  Label1.Width          = 54;
  Label1.Height         = 12;
  Label1.Visible        = 1;
  Label1.Active         = 0;
  Label1.Caption        = Label1_Caption;
  Label1.FontName       = Tahoma11x13_Regular;
  Label1.Font_Color     = 0x0000;
  Label1.OnUpPtr         = 0;
  Label1.OnDownPtr       = 0;
  Label1.OnClickPtr      = 0;
  Label1.OnPressPtr      = 0;

  Image2.OwnerScreen     = &MainScreen;
  Image2.Order          = 0;
  Image2.Left           = 242;
  Image2.Top            = 0;
  Image2.Width          = 78;
  Image2.Height         = 77;
  Image2.Picture_Type   = 0;
  Image2.Picture_Ratio  = 1;
  Image2.Picture_Name   = SmallLogo_bmp;
  Image2.Visible        = 1;
  Image2.Active         = 0;
  Image2.OnUpPtr         = 0;
  Image2.OnDownPtr       = 0;
  Image2.OnClickPtr      = 0;
  Image2.OnPressPtr      = 0;

  Label2.OwnerScreen     = &MainScreen;
  Label2.Order          = 1;
  Label2.Left           = 10;
  Label2.Top            = 8;
  Label2.Width          = 50;
  Label2.Height         = 12;
  Label2.Visible        = 1;
  Label2.Active         = 0;
  Label2.Caption        = Label2_Caption;
  Label2.FontName       = Tahoma13x13_Bold;
  Label2.Font_Color     = 0x0000;
  Label2.OnUpPtr         = 0;
  Label2.OnDownPtr       = 0;
  Label2.OnClickPtr      = 0;
  Label2.OnPressPtr      = 0;

  File1.OwnerScreen     = &MainScreen;
  File1.Order          = 2;
  File1.Left           = 30;
  File1.Top            = 28;
  File1.Width          = 18;
  File1.Height         = 12;
  File1.Visible        = 0;
  File1.Active         = 1;
  File1.Caption        = File1_Caption;
  File1.FontName       = Tahoma11x13_Regular;
  File1.Font_Color     = 0x0000;
  File1.OnUpPtr         = 0;
  File1.OnDownPtr       = 0;
  File1.OnClickPtr      = 0;
  File1.OnPressPtr      = 0;

  File2.OwnerScreen     = &MainScreen;
  File2.Order          = 3;
  File2.Left           = 30;
  File2.Top            = 44;
  File2.Width          = 11;
  File2.Height         = 12;
  File2.Visible        = 0;
  File2.Active         = 1;
  File2.Caption        = File2_Caption;
  File2.FontName       = Tahoma11x13_Regular;
  File2.Font_Color     = 0x0000;
  File2.OnUpPtr         = 0;
  File2.OnDownPtr       = 0;
  File2.OnClickPtr      = 0;
  File2.OnPressPtr      = 0;

  Image3.OwnerScreen     = &MainScreen;
  Image3.Order          = 4;
  Image3.Left           = 10;
  Image3.Top            = 28;
  Image3.Width          = 14;
  Image3.Height         = 14;
  Image3.Picture_Type   = 0;
  Image3.Picture_Ratio  = 1;
  Image3.Picture_Name   = Forward_bmp;
  Image3.Visible        = 1;
  Image3.Active         = 0;
  Image3.OnUpPtr         = 0;
  Image3.OnDownPtr       = 0;
  Image3.OnClickPtr      = 0;
  Image3.OnPressPtr      = 0;

  File3.OwnerScreen     = &MainScreen;
  File3.Order          = 5;
  File3.Left           = 30;
  File3.Top            = 60;
  File3.Width          = 11;
  File3.Height         = 12;
  File3.Visible        = 0;
  File3.Active         = 1;
  File3.Caption        = File3_Caption;
  File3.FontName       = Tahoma11x13_Regular;
  File3.Font_Color     = 0x0000;
  File3.OnUpPtr         = 0;
  File3.OnDownPtr       = 0;
  File3.OnClickPtr      = 0;
  File3.OnPressPtr      = 0;

  File4.OwnerScreen     = &MainScreen;
  File4.Order          = 6;
  File4.Left           = 30;
  File4.Top            = 76;
  File4.Width          = 11;
  File4.Height         = 12;
  File4.Visible        = 0;
  File4.Active         = 1;
  File4.Caption        = File4_Caption;
  File4.FontName       = Tahoma11x13_Regular;
  File4.Font_Color     = 0x0000;
  File4.OnUpPtr         = 0;
  File4.OnDownPtr       = 0;
  File4.OnClickPtr      = 0;
  File4.OnPressPtr      = 0;

  File5.OwnerScreen     = &MainScreen;
  File5.Order          = 7;
  File5.Left           = 30;
  File5.Top            = 92;
  File5.Width          = 11;
  File5.Height         = 12;
  File5.Visible        = 0;
  File5.Active         = 1;
  File5.Caption        = File5_Caption;
  File5.FontName       = Tahoma11x13_Regular;
  File5.Font_Color     = 0x0000;
  File5.OnUpPtr         = 0;
  File5.OnDownPtr       = 0;
  File5.OnClickPtr      = 0;
  File5.OnPressPtr      = 0;

  File6.OwnerScreen     = &MainScreen;
  File6.Order          = 8;
  File6.Left           = 30;
  File6.Top            = 108;
  File6.Width          = 11;
  File6.Height         = 12;
  File6.Visible        = 0;
  File6.Active         = 1;
  File6.Caption        = File6_Caption;
  File6.FontName       = Tahoma11x13_Regular;
  File6.Font_Color     = 0x0000;
  File6.OnUpPtr         = 0;
  File6.OnDownPtr       = 0;
  File6.OnClickPtr      = 0;
  File6.OnPressPtr      = 0;

  File7.OwnerScreen     = &MainScreen;
  File7.Order          = 9;
  File7.Left           = 30;
  File7.Top            = 124;
  File7.Width          = 11;
  File7.Height         = 12;
  File7.Visible        = 0;
  File7.Active         = 1;
  File7.Caption        = File7_Caption;
  File7.FontName       = Tahoma11x13_Regular;
  File7.Font_Color     = 0x0000;
  File7.OnUpPtr         = 0;
  File7.OnDownPtr       = 0;
  File7.OnClickPtr      = 0;
  File7.OnPressPtr      = 0;

  File8.OwnerScreen     = &MainScreen;
  File8.Order          = 10;
  File8.Left           = 30;
  File8.Top            = 140;
  File8.Width          = 11;
  File8.Height         = 12;
  File8.Visible        = 0;
  File8.Active         = 1;
  File8.Caption        = File8_Caption;
  File8.FontName       = Tahoma11x13_Regular;
  File8.Font_Color     = 0x0000;
  File8.OnUpPtr         = 0;
  File8.OnDownPtr       = 0;
  File8.OnClickPtr      = 0;
  File8.OnPressPtr      = 0;

  File9.OwnerScreen     = &MainScreen;
  File9.Order          = 11;
  File9.Left           = 30;
  File9.Top            = 156;
  File9.Width          = 11;
  File9.Height         = 12;
  File9.Visible        = 0;
  File9.Active         = 1;
  File9.Caption        = File9_Caption;
  File9.FontName       = Tahoma11x13_Regular;
  File9.Font_Color     = 0x0000;
  File9.OnUpPtr         = 0;
  File9.OnDownPtr       = 0;
  File9.OnClickPtr      = 0;
  File9.OnPressPtr      = 0;

  File10.OwnerScreen     = &MainScreen;
  File10.Order          = 12;
  File10.Left           = 30;
  File10.Top            = 172;
  File10.Width          = 11;
  File10.Height         = 12;
  File10.Visible        = 0;
  File10.Active         = 1;
  File10.Caption        = File10_Caption;
  File10.FontName       = Tahoma11x13_Regular;
  File10.Font_Color     = 0x0000;
  File10.OnUpPtr         = 0;
  File10.OnDownPtr       = 0;
  File10.OnClickPtr      = 0;
  File10.OnPressPtr      = 0;

  File11.OwnerScreen     = &MainScreen;
  File11.Order          = 13;
  File11.Left           = 30;
  File11.Top            = 188;
  File11.Width          = 11;
  File11.Height         = 12;
  File11.Visible        = 0;
  File11.Active         = 1;
  File11.Caption        = File11_Caption;
  File11.FontName       = Tahoma11x13_Regular;
  File11.Font_Color     = 0x0000;
  File11.OnUpPtr         = 0;
  File11.OnDownPtr       = 0;
  File11.OnClickPtr      = 0;
  File11.OnPressPtr      = 0;

  Label3.OwnerScreen     = &MainScreen;
  Label3.Order          = 14;
  Label3.Left           = 30;
  Label3.Top            = 204;
  Label3.Width          = 11;
  Label3.Height         = 12;
  Label3.Visible        = 0;
  Label3.Active         = 1;
  Label3.Caption        = Label3_Caption;
  Label3.FontName       = Tahoma11x13_Regular;
  Label3.Font_Color     = 0x0000;
  Label3.OnUpPtr         = 0;
  Label3.OnDownPtr       = 0;
  Label3.OnClickPtr      = 0;
  Label3.OnPressPtr      = 0;
}

static char IsInsideObject (unsigned int X, unsigned int Y, unsigned int Left, unsigned int Top, unsigned int Width, unsigned int Height) { // static
  if ( (Left<= X) && (Left+ Width - 1 >= X) &&
       (Top <= Y)  && (Top + Height - 1 >= Y) )
    return 1;
  else
    return 0;
}


#define GetLabel(index)               CurrentScreen->Labels[index]
#define GetImage(index)               CurrentScreen->Images[index]


void DrawLabel(TLabel *ALabel) {
int x_pos, y_pos;
  x_pos = 0;
  y_pos = 0;
  if (ALabel->Visible == 1) {
    TFT_Set_Font(ALabel->FontName, ALabel->Font_Color, FO_HORIZONTAL);
    TFT_Write_Text_Return_Pos(ALabel->Caption, ALabel->Left, ALabel->Top);
    x_pos = ALabel->Left + ((int)(ALabel->Width - caption_length) / 2);
    y_pos = ALabel->Top + ((int)(ALabel->Height - caption_height) / 2);
    if (x_pos > ALabel->Left) {
      TFT_Write_Text(ALabel->Caption, x_pos, y_pos);
    }
    else {
      TFT_Write_Text(ALabel->Caption, ALabel->Left, ALabel->Top);
    }
  }
}

void DrawImage(TImage *AImage) {
  if (AImage->Visible) {
    TFT_Image(AImage->Left, AImage->Top, AImage->Picture_Name, AImage->Picture_Ratio);
  }
}

void DrawScreen(TScreen *aScreen) {
  unsigned short order;
  unsigned short label_idx;
  TLabel *local_label;
  unsigned short image_idx;
  TImage *local_image;
  char save_bled, save_bled_direction;

  object_pressed = 0;
  order = 0;
  label_idx = 0;
  image_idx = 0;
  CurrentScreen = aScreen;

  if ((display_width != CurrentScreen->Width) || (display_height != CurrentScreen->Height)) {
    save_bled = TFT_BLED;
    save_bled_direction = TFT_BLED_Direction;
    TFT_BLED_Direction = 1;
    TFT_BLED           = 0;
    TFT_Init(CurrentScreen->Width, CurrentScreen->Height);
    TFT_Fill_Screen(CurrentScreen->Color);
    display_width = CurrentScreen->Width;
    display_height = CurrentScreen->Height;
    TFT_BLED           = save_bled;
    TFT_BLED_Direction = save_bled_direction;
  }
  else
    TFT_Fill_Screen(CurrentScreen->Color);


  while (order < CurrentScreen->ObjectsCount) {
    if (label_idx < CurrentScreen->LabelsCount) {
      local_label = GetLabel(label_idx);
      if (order == local_label->Order) {
        label_idx++;
        order++;
        DrawLabel(local_label);
      }
    }

    if (image_idx  < CurrentScreen->ImagesCount) {
      local_image = GetImage(image_idx);
      if (order == local_image->Order) {
        image_idx++;
        order++;
        DrawImage(local_image);
      }
    }

  }
}

void Get_Object(unsigned int X, unsigned int Y) {
  label_order         = -1;
  image_order         = -1;
  //  Labels
  for ( _object_count = 0 ; _object_count < CurrentScreen->LabelsCount ; _object_count++ ) {
    local_label = GetLabel(_object_count);
    if (local_label->Active == 1) {
      if (IsInsideObject(X, Y, local_label->Left, local_label->Top,
                         local_label->Width, local_label->Height) == 1) {
        label_order = local_label->Order;
        exec_label = local_label;
      }
    }
  }

  //  Images
  for ( _object_count = 0 ; _object_count < CurrentScreen->ImagesCount ; _object_count++ ) {
    local_image = GetImage(_object_count);
    if (local_image->Active == 1) {
      if (IsInsideObject(X, Y, local_image->Left, local_image->Top,
                         local_image->Width, local_image->Height) == 1) {
        image_order = local_image->Order;
        exec_image = local_image;
      }
    }
  }

  _object_count = -1;
  if (label_order >  _object_count )
    _object_count = label_order;
  if (image_order >  _object_count )
    _object_count = image_order;
}