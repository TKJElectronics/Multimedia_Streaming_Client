#include "UserInterface.h"
#include "Client_UI_objects.h"
#include "Client_UI_resources.h"
#include "Ethernet_Handlers.h"

#include "MP3.h"

sbit TFT_BACKLIGHT at GPIO_PORTA_DATA3_bit;

unsigned int oldstate_press, oldstate_right, oldstate_left, oldstate_up, oldstate_down;
// Joystick connections
sbit Joy_Up     at GPIO_PORTB_DATA0_bit;
sbit Joy_Right  at GPIO_PORTE_DATA4_bit;
sbit Joy_Down   at GPIO_PORTE_DATA5_bit;
sbit Joy_Left   at GPIO_PORTB_DATA7_bit;
sbit Joy_CP     at GPIO_PORTH_DATA2_bit;

sbit Joy_Up_Direction     at GPIO_PORTB_DIR0_bit;
sbit Joy_Right_Direction  at GPIO_PORTE_DIR4_bit;
sbit Joy_Down_Direction   at GPIO_PORTE_DIR5_bit;
sbit Joy_Left_Direction   at GPIO_PORTB_DIR7_bit;
sbit Joy_CP_Direction     at GPIO_PORTH_DIR2_bit;
// End Joystick connections

FolderContent FilesList[200];
unsigned char FilesListCount;

  TLabel * const code FileList_Labels[12]=
         {
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
         
unsigned char cursorPos = 0;
unsigned char filesListOffset = 0;


void UI_Setup()
{
  GPIO_Config(&GPIO_PORTA, 0b00001000, _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE | _GPIO_CFG_DRIVE_8mA, 0); // Init back light GPIO
  TFT_BACKLIGHT = 0;
  // We need to Unlock PR7 before we can use it as GPIO (MCU specific)
  GPIO_Unlock(_GPIO_COMMIT_PIN_B7);
  GPIO_Digital_Input(&GPIO_PORTB, _GPIO_PINMASK_0 | _GPIO_PINMASK_7);    // Set Up and Left as digital input
  GPIO_Digital_Input(&GPIO_PORTE, _GPIO_PINMASK_4 | _GPIO_PINMASK_5);    // Set Right and Down as digital input
  GPIO_Digital_Input(&GPIO_PORTH, _GPIO_PINMASK_2);                      // Set Center as digital input
  Delay_100ms();
  TFT_Init(320, 240);
  
  TFT_Fill_Screen(0);
  InitializeObjects();
  display_width = LoadingScreen.Width;
  display_height = LoadingScreen.Height;
  UI_LoadingScreen("Fetching IP address");

  TFT_BACKLIGHT = 1;
}

void UI_LoadingScreen(unsigned char *LoadingText)
{
   Label1.Caption = LoadingText;
   DrawScreen(&LoadingScreen);
}

void UI_ShowMainScreen()
{
  DrawScreen(&MainScreen);
}

void UI_Handler()
{
    /* Up button */
    if (Button(&GPIO_PORTB_DATA, 0, 1, 0))
      oldstate_up = 1;
    if (oldstate_up && Button(&GPIO_PORTB_DATA, 0, 1, 1)) { // detect logical one to logical zero transition

      if (cursorPos > 0) {
        TFT_Set_Pen(MainScreen.Color, 0);
        TFT_Set_Brush(1, MainScreen.Color, 0, LEFT_TO_RIGHT, CL_WHITE, CL_WHITE);
        TFT_Rectangle(Image3.Left, Image3.Top, (Image3.Left+Image3.Width), (Image3.Top+Image3.Height));
        Image3.Top -= 16;
        DrawImage(&Image3);
        cursorPos--;
      } else if (filesListOffset > 0) {
        filesListOffset--;
        UI_UpdateFilesList();
      }
      oldstate_up = 0;
    }
    
    /* Down button */
    if (Button(&GPIO_PORTE_DATA, 5, 1, 0))
      oldstate_down = 1;
    if (oldstate_down && Button(&GPIO_PORTE_DATA, 5, 1, 1)) { // detect logical one to logical zero transition
      
      if (cursorPos < 11 && cursorPos < (FilesListCount-1)) {
        TFT_Set_Pen(MainScreen.Color, 0);
        TFT_Set_Brush(1, MainScreen.Color, 0, LEFT_TO_RIGHT, CL_WHITE, CL_WHITE);
        TFT_Rectangle(Image3.Left, Image3.Top, (Image3.Left+Image3.Width), (Image3.Top+Image3.Height));
        Image3.Top += 16;
        DrawImage(&Image3);
        cursorPos++;
      } else if ((cursorPos+filesListOffset+1) < FilesListCount) {
        filesListOffset++;
        UI_UpdateFilesList();
      }
      oldstate_down = 0;
    }
    
    /* Enter button */
    if (Button(&GPIO_PORTH_DATA, 2, 1, 0))
      oldstate_press = 1;
    if (oldstate_press && Button(&GPIO_PORTH_DATA, 2, 1, 1)) { // detect logical one to logical zero transition

      if (CurrentState == IMAGE_DISPLAY) {
        UI_ShowMainScreen();
        UI_UpdateFolderName();
        UI_UpdateFilesList();
        CurrentState = IDLE;
      } else if (CurrentState == IDLE) {
        if (FilesList[cursorPos+filesListOffset]->Type == 'A')  {
          if (DownloadMode == 0)
            PlayAudio(FilesList[cursorPos+filesListOffset]->ID);
          else if (DownloadMode == 1 && SDSave_Disabled == 0)
            SaveAudio(FilesList[cursorPos+filesListOffset]->ID, FilesList[cursorPos+filesListOffset]->Name);
        } else if (FilesList[cursorPos+filesListOffset]->Type == 'F') {
            if (CurrentFolderID == 0 || FilesList[cursorPos+filesListOffset]->ID == 0) // Only possible to enter folders if we are in the ROOT folder currently (Only 1-level deep folder tree currently supported!)
              RequestFolderContent(FilesList[cursorPos+filesListOffset]->ID, FilesList[cursorPos+filesListOffset]->Name, FilesList[cursorPos+filesListOffset]->NameLength);
        } else if (FilesList[cursorPos+filesListOffset]->Type == 'I') {
            DisplayImage(FilesList[cursorPos+filesListOffset]->ID);
        }
      } else if (CurrentState == FILE_RECEIVE) { // Stop the playback
        TerminateAudio();
        CurrentState = IDLE;
      }
      oldstate_press = 0;
    }
    
   /* Right button */
    if (Button(&GPIO_PORTE_DATA, 4, 1, 0))
      oldstate_right = 1;
    if (oldstate_right && Button(&GPIO_PORTE_DATA, 4, 1, 1)) { // detect logical one to logical zero transition
      if (SDSave_Disabled == 0) { // Enabling the SD Saving mode (right click) is only possible if SD card is inserted
        DownloadMode = ~DownloadMode;
        GPIO_PORTA_DATA6_bit = DownloadMode;
      }

      oldstate_right = 0;
    }
}

void UI_UpdateFilesList()
{
  unsigned char i;
  for (i = 0; i < 12; i++) {
    memcpy(FileList_Labels[i]->Caption, FilesList[i+filesListOffset].Name, FilesList[i+filesListOffset].NameLength);
    FileList_Labels[i]->Caption[FilesList[i+filesListOffset].NameLength] = 0x00;
  }
  
  TFT_Set_Pen(MainScreen.Color, 0);
  TFT_Set_Brush(1, MainScreen.Color, 0, LEFT_TO_RIGHT, CL_WHITE, CL_WHITE);
  TFT_Rectangle(FileList_Labels[0]->Left, FileList_Labels[0]->Top, 240, 230);
  TFT_Set_Font(FileList_Labels[0]->FontName, FileList_Labels[0]->Font_Color, FO_HORIZONTAL);

  for (i = 0; i < 12; i++) {
    TFT_Write_Text(FileList_Labels[i]->Caption, FileList_Labels[i]->Left, FileList_Labels[i]->Top);
  }
}

void UI_UpdateFolderName(void)
{
  TFT_Set_Pen(MainScreen.Color, 0);
  TFT_Set_Brush(1, MainScreen.Color, 0, LEFT_TO_RIGHT, CL_WHITE, CL_WHITE);
  TFT_Rectangle(Label2.Left, Label2.Top, 240, 22);
  TFT_Set_Font(Label2.FontName, Label2.Font_Color, FO_HORIZONTAL);
  TFT_Write_Text(CurrentFolderName, Label2.Left, Label2.Top);
}

void UI_ResetCursorPos(void)
{
  TFT_Set_Pen(MainScreen.Color, 0);
  TFT_Set_Brush(1, MainScreen.Color, 0, LEFT_TO_RIGHT, CL_WHITE, CL_WHITE);
  TFT_Rectangle(Image3.Left, Image3.Top, (Image3.Left+Image3.Width), (Image3.Top+Image3.Height));
  Image3.Left = 10;
  Image3.Top = 28;
  DrawImage(&Image3);
  cursorPos = 0;
  filesListOffset = 0;
}