#line 1 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/UserInterface.c"
#line 1 "c:/tkj electronics/projects/b5-multimedia_streaming/mikroc projects/multimedia_client/userinterface.h"
typedef struct {
 unsigned int ID;
 unsigned char Type;
 unsigned char Name[32];
 unsigned char NameLength;
} FolderContent;

extern bit SDSave_Disabled;

extern unsigned char CurrentFolderID;
extern unsigned char CurrentFolderName[31];

extern FolderContent FilesList[200];
extern unsigned char FilesListCount;

void UI_Setup();
void UI_ShowMainScreen();
void UI_LoadingScreen(unsigned char *LoadingText);
void UI_Handler();
void UI_UpdateFilesList();
void UI_UpdateFolderName(void);
void UI_ResetCursorPos(void);
#line 1 "c:/tkj electronics/projects/b5-multimedia_streaming/mikroc projects/multimedia_client/client_ui_objects.h"
enum GlcdColor {_clClear, _clDraw, _clInvert};

typedef struct Screen TScreen;

typedef struct Label {
 TScreen* OwnerScreen;
 char Order;
 unsigned int Left;
 unsigned int Top;
 unsigned int Width;
 unsigned int Height;
 char *Caption;
 const char *FontName;
 unsigned int Font_Color;
 char Visible;
 char Active;
 void (*OnUpPtr)();
 void (*OnDownPtr)();
 void (*OnClickPtr)();
 void (*OnPressPtr)();
} TLabel;

typedef struct Image {
 TScreen* OwnerScreen;
 char Order;
 unsigned int Left;
 unsigned int Top;
 unsigned int Width;
 unsigned int Height;
 const char *Picture_Name;
 char Visible;
 char Active;
 char Picture_Type;
 char Picture_Ratio;
 void (*OnUpPtr)();
 void (*OnDownPtr)();
 void (*OnClickPtr)();
 void (*OnPressPtr)();
} TImage;

struct Screen {
 unsigned int Color;
 unsigned int Width;
 unsigned int Height;
 unsigned short ObjectsCount;
 unsigned int LabelsCount;
 TLabel * const code *Labels;
 unsigned int ImagesCount;
 TImage * const code *Images;
};

extern TScreen LoadingScreen;
extern TImage Image1;
extern TLabel Label1;
extern TLabel * const code Screen1_Labels[1];
extern TImage * const code Screen1_Images[1];


extern TScreen MainScreen;
extern TImage Image2;
extern TLabel Label2;
extern TLabel File1;
extern TLabel File2;
extern TImage Image3;
extern TLabel File3;
extern TLabel File4;
extern TLabel File5;
extern TLabel File6;
extern TLabel File7;
extern TLabel File8;
extern TLabel File9;
extern TLabel File10;
extern TLabel File11;
extern TLabel Label3;
extern TLabel * const code Screen2_Labels[13];
extern TImage * const code Screen2_Images[2];









extern char Label1_Caption[];
extern char Label2_Caption[];
extern char File1_Caption[];
extern char File2_Caption[];
extern char File3_Caption[];
extern char File4_Caption[];
extern char File5_Caption[];
extern char File6_Caption[];
extern char File7_Caption[];
extern char File8_Caption[];
extern char File9_Caption[];
extern char File10_Caption[];
extern char File11_Caption[];
extern char Label3_Caption[];




extern unsigned int Xcoord, Ycoord;
extern const ADC_THRESHOLD;
extern char PenDown;
extern void *PressedObject;
extern int PressedObjectType;
extern unsigned int caption_length, caption_height;
extern unsigned int display_width, display_height;

void DrawScreen(TScreen *aScreen);
void DrawLabel(TLabel *ALabel);
void DrawImage(TImage *AImage);
void Start_TP();
void InitializeObjects();
#line 1 "c:/tkj electronics/projects/b5-multimedia_streaming/mikroc projects/multimedia_client/client_ui_resources.h"
const code char Tahoma11x13_Regular[];
const code char Tahoma13x13_Bold[];
const code char LoadingScreen_bmp[153606];
const code char SmallLogo_bmp[12018];
const code char Forward_bmp[398];
#line 1 "c:/tkj electronics/projects/b5-multimedia_streaming/mikroc projects/multimedia_client/ethernet_handlers.h"
#line 39 "c:/tkj electronics/projects/b5-multimedia_streaming/mikroc projects/multimedia_client/ethernet_handlers.h"
typedef struct {
 unsigned char valid;
 unsigned long tmr;
 unsigned char ip[4];
 unsigned char mac[6];
} Ethernet_Intern_arpCacheStruct;

extern Ethernet_Intern_arpCacheStruct Ethernet_Intern_arpCache[];

extern unsigned char Ethernet_Intern_macAddr[6];
extern unsigned char Ethernet_Intern_ipAddr[4];
extern unsigned char Ethernet_Intern_gwIpAddr[4];
extern unsigned char Ethernet_Intern_ipMask[4];
extern unsigned char Ethernet_Intern_dnsIpAddr[4];
extern unsigned char Ethernet_Intern_rmtIpAddr[4];

extern unsigned long Ethernet_Intern_userTimerSec;

typedef struct {
 unsigned canCloseTCP : 1;
 unsigned isBroadcast : 1;
} TEthInternPktFlags;
#line 66 "c:/tkj electronics/projects/b5-multimedia_streaming/mikroc projects/multimedia_client/ethernet_handlers.h"
extern void Ethernet_Intern_Init(unsigned char *mac, unsigned char *ip, unsigned char fullDuplex);

extern unsigned char Ethernet_Intern_doPacket();
extern void Ethernet_Intern_putByte(unsigned char b);
extern void Ethernet_Intern_putBytes(unsigned char *ptr, unsigned int n);
extern void Ethernet_Intern_putConstBytes(const unsigned char *ptr, unsigned int n);
extern unsigned char Ethernet_Intern_getByte();
extern void Ethernet_Intern_getBytes(unsigned char *ptr, unsigned int addr, unsigned int n);
extern unsigned int Ethernet_Intern_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags * flags);
extern unsigned int Ethernet_Intern_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags * flags);
extern void Ethernet_Intern_confNetwork(char *ipMask, char *gwIpAddr, char *dnsIpAddr);


extern unsigned char myMacAddr[6];
extern unsigned char myIpAddr[4];
extern unsigned char gwIpAddr[4];
extern unsigned char ipMask[4];
extern unsigned char dnsIpAddr[4];


extern unsigned char *UniqueDeviceID;
extern const unsigned int localClientPort;
extern const unsigned char serverIpAddr[4];
extern const unsigned int serverPort;
#line 94 "c:/tkj electronics/projects/b5-multimedia_streaming/mikroc projects/multimedia_client/ethernet_handlers.h"
extern unsigned char stringBuffer[50];
extern bit FetchCID;
extern unsigned long GlobalSecondsCounter;
extern unsigned char CountdownTimer;
extern unsigned char halfSecondCountdownTimer;

typedef enum {
 IDLE,
 FOLDER_RECEIVE,
 FILE_RECEIVE,
 SAVED_PLAYBACK,
 IMAGE_RECEIVE,
 IMAGE_DISPLAY
} MultimediaState;


extern unsigned char UDPTransmitBuffer[30];
extern unsigned char DeviceCID;
extern MultimediaState CurrentState;
extern unsigned char CurrentFolderID;
extern unsigned char CurrentFolderName[31];
extern unsigned char PreviousFolderID;
extern unsigned char FolderFileRequestIDCount;
extern unsigned char FoldersFilesToReceive;

extern unsigned int CurrentFileID;
extern unsigned long ReceivingFileLength;
extern unsigned int ReceivingFileDPL;
extern unsigned long ReceivingDividedPackages;
extern unsigned long ReceivingCurrentPackage;
extern unsigned int ReceivingImageWidth, ReceivingImageHeight;

extern bit DownloadMode;
extern unsigned char AudioBuffer1[1480];
extern unsigned char AudioBuffer2[1480];
extern bit CurrentBuffer;
extern bit FirstBufferFill;
extern unsigned int CurrentBufferPos;
extern unsigned int CurrentBuffer1MaxPos;
extern unsigned int CurrentBuffer2MaxPos;



unsigned int Ethernet_Intern_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags *flags);
unsigned int Ethernet_Intern_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags *flags);
unsigned char Calculate_Checksum(unsigned char *UDP_Package, unsigned int length);

void void RequestRootFolder();
void RequestNextAudioPackage();
void RequestFolderContent(unsigned int FolderID, unsigned char * folderName, unsigned char folderNameLength);

void ReLeaseCID();
void PlayAudio(unsigned int AudioID);
void SaveAudio(unsigned int AudioID, unsigned char * FileName);
void AudioFinished(void);
void TerminateAudio(void);
void DisplayImage(unsigned int ImageID);
void RequestNextImagePackage();
void KeepAlive_Handler(void);
#line 1 "c:/tkj electronics/projects/b5-multimedia_streaming/mikroc projects/multimedia_client/mp3.h"

extern bit SDSave_Disabled;
extern const BYTES_2_WRITE;
extern char volume_left, volume_right;

void MP3_Init(void);
void MP3_Start(void);
void MP3_FinishedPlayback(void);
void MP3_StopPlayback(void);

void MP3_InitSDBuffer(void);
void MP3_Test(void);

extern void MP3_SCI_Write(char address, unsigned int data_in);
extern void MP3_SCI_Read(char start_address, char words_count, unsigned int *data_buffer);
extern void MP3_SDI_Write(char data_);
extern void MP3_SDI_Write_32(char *data_);
extern void MP3_SDI_Write_256(char *data_);
extern void MP3_Set_Volume(char left,char right);
extern void MP3_Reset(void);

extern void Audio_Handler();
extern bit CurrentBuffer;

extern sfr sbit Mmc_Chip_Select;
extern sfr sbit MP3_CS;
extern sfr sbit MP3_RST;
extern sfr sbit XDCS;
extern sfr sbit DREQ;

extern sfr sbit Mmc_Chip_Select_Direction;
extern sfr sbit MP3_CS_Direction;
extern sfr sbit MP3_RST_Direction;
extern sfr sbit XDCS_Direction;
extern sfr sbit DREQ_Direction;
#line 8 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/UserInterface.c"
sbit TFT_BACKLIGHT at GPIO_PORTA_DATA3_bit;

unsigned int oldstate_press, oldstate_right, oldstate_left, oldstate_up, oldstate_down;

sbit Joy_Up at GPIO_PORTB_DATA0_bit;
sbit Joy_Right at GPIO_PORTE_DATA4_bit;
sbit Joy_Down at GPIO_PORTE_DATA5_bit;
sbit Joy_Left at GPIO_PORTB_DATA7_bit;
sbit Joy_CP at GPIO_PORTH_DATA2_bit;

sbit Joy_Up_Direction at GPIO_PORTB_DIR0_bit;
sbit Joy_Right_Direction at GPIO_PORTE_DIR4_bit;
sbit Joy_Down_Direction at GPIO_PORTE_DIR5_bit;
sbit Joy_Left_Direction at GPIO_PORTB_DIR7_bit;
sbit Joy_CP_Direction at GPIO_PORTH_DIR2_bit;


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
 GPIO_Config(&GPIO_PORTA, 0b00001000, _GPIO_DIR_OUTPUT, _GPIO_CFG_DIGITAL_ENABLE | _GPIO_CFG_DRIVE_8mA, 0);
 TFT_BACKLIGHT = 0;

 GPIO_Unlock(_GPIO_COMMIT_PIN_B7);
 GPIO_Digital_Input(&GPIO_PORTB, _GPIO_PINMASK_0 | _GPIO_PINMASK_7);
 GPIO_Digital_Input(&GPIO_PORTE, _GPIO_PINMASK_4 | _GPIO_PINMASK_5);
 GPIO_Digital_Input(&GPIO_PORTH, _GPIO_PINMASK_2);
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

 if (Button(&GPIO_PORTB_DATA, 0, 1, 0))
 oldstate_up = 1;
 if (oldstate_up && Button(&GPIO_PORTB_DATA, 0, 1, 1)) {

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


 if (Button(&GPIO_PORTE_DATA, 5, 1, 0))
 oldstate_down = 1;
 if (oldstate_down && Button(&GPIO_PORTE_DATA, 5, 1, 1)) {

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


 if (Button(&GPIO_PORTH_DATA, 2, 1, 0))
 oldstate_press = 1;
 if (oldstate_press && Button(&GPIO_PORTH_DATA, 2, 1, 1)) {

 if (CurrentState == IMAGE_DISPLAY) {
 UI_ShowMainScreen();
 UI_UpdateFolderName();
 UI_UpdateFilesList();
 CurrentState = IDLE;
 } else if (CurrentState == IDLE) {
 if (FilesList[cursorPos+filesListOffset]->Type == 'A') {
 if (DownloadMode == 0)
 PlayAudio(FilesList[cursorPos+filesListOffset]->ID);
 else if (DownloadMode == 1 && SDSave_Disabled == 0)
 SaveAudio(FilesList[cursorPos+filesListOffset]->ID, FilesList[cursorPos+filesListOffset]->Name);
 } else if (FilesList[cursorPos+filesListOffset]->Type == 'F') {
 if (CurrentFolderID == 0 || FilesList[cursorPos+filesListOffset]->ID == 0)
 RequestFolderContent(FilesList[cursorPos+filesListOffset]->ID, FilesList[cursorPos+filesListOffset]->Name, FilesList[cursorPos+filesListOffset]->NameLength);
 } else if (FilesList[cursorPos+filesListOffset]->Type == 'I') {
 DisplayImage(FilesList[cursorPos+filesListOffset]->ID);
 }
 } else if (CurrentState == FILE_RECEIVE) {
 TerminateAudio();
 CurrentState = IDLE;
 }
 oldstate_press = 0;
 }


 if (Button(&GPIO_PORTE_DATA, 4, 1, 0))
 oldstate_right = 1;
 if (oldstate_right && Button(&GPIO_PORTE_DATA, 4, 1, 1)) {
 if (SDSave_Disabled == 0) {
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
