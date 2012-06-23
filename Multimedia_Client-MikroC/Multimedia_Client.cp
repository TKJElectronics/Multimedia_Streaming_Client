#line 1 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/Multimedia_Client.c"
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
#line 5 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/Multimedia_Client.c"
void Audio_Handler();
void ReLeaseCID();
unsigned int CurrentFolderID;
unsigned char CurrentFolderName[31];
unsigned int CurrentFileID;
unsigned int PreviousFolderID;
bit SDSave_Disabled;

bit FetchCID;
unsigned char CountdownTimer;
unsigned char halfSecondCountdownTimer;

unsigned char ipAddr[4];
unsigned char stringBuffer[50];

bit DownloadMode;
unsigned char AudioBuffer1[1480];
unsigned char AudioBuffer2[1480];
bit CurrentBuffer;
bit FirstBufferFill;
unsigned int CurrentBufferPos;
unsigned int CurrentBuffer1MaxPos;
unsigned int CurrentBuffer2MaxPos;

unsigned long GlobalSecondsCounter;

unsigned char serialReceive;
bit DHCP_Finished;
unsigned char presTmr;

void SecondsInterrupt()
{
 Ethernet_Intern_userTimerSec++ ;

 if (CountdownTimer > 0) CountdownTimer--;

}

void SysTick_interrupt() iv IVT_FAULT_SYSTICK {
 presTmr++;

 if (((presTmr % 3) > 0) && (halfSecondCountdownTimer > 0)) halfSecondCountdownTimer--;
 if(presTmr == 6)
 {

 if (CountdownTimer > 0) CountdownTimer--;
 Ethernet_Intern_userTimerSec++ ;
 presTmr = 0;
 }
}

void main() {
 UI_Setup();

 CountdownTimer = 5;
 FetchCID = 1;
 GPIO_Digital_Output(&GPIO_PORTA, _GPIO_PINMASK_ALL);


 NVIC_ST_RELOAD = ((Get_Fosc_kHz() * 1000) / 6) - 1;
 NVIC_ST_CTRL_CLK_SRC_bit = 1;
 NVIC_ST_CTRL_ENABLE_bit = 1;
 NVIC_IntEnable(IVT_FAULT_SYSTICK);
 NVIC_ST_CTRL_INTEN_bit = 1;
 NVIC_SYS_PRI3 |= 0x00FF0000;
 EnableInterrupts();

 UART0_Init(115200);
 Delay_ms(100);

 UART0_Write(13);
 UART0_Write(10);
 UART0_Write_Text("Start");
 UART0_Write(13);
 UART0_Write(10);

 MP3_Start();


 GPIO_Config(&GPIO_PORTF, _GPIO_PINMASK_2 | _GPIO_PINMASK_3, _GPIO_DIR_NO_CHANGE, _GPIO_CFG_ALT_FUNCTION | _GPIO_CFG_DRIVE_8mA | _GPIO_CFG_DIGITAL_ENABLE, _GPIO_PINCODE_1);
 Ethernet_Intern_Init(myMacAddr, myIpAddr,  0b10000 );


 Delay_ms(2000);
 DHCP_Finished = 1;
 while (DHCP_Finished != 0) {
 DHCP_Finished = Ethernet_Intern_initDHCP(5);
 }

 UART0_Write_Text("DHCP IP: ");

 memcpy(ipAddr, Ethernet_Intern_getIpAddress(), 4);
 ByteToStr(ipAddr[0], stringBuffer);
 stringBuffer[3] = '.';
 ByteToStr(ipAddr[1], stringBuffer+4);
 stringBuffer[7] = '.';
 ByteToStr(ipAddr[2], stringBuffer+8);
 stringBuffer[11] = '.';
 ByteToStr(ipAddr[3], stringBuffer+12);
 stringBuffer[15] = 0;
 UART0_Write_Text(stringBuffer);
 UART0_Write(13);
 UART0_Write(10);

 UI_LoadingScreen("Connecting to server");

 while (FetchCID) {
 Ethernet_Intern_doPacket();
 if (CountdownTimer == 0)
 {
 UDPTransmitBuffer[0] = 0xFF;
 UDPTransmitBuffer[1] = 0x01;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 4;
 UDPTransmitBuffer[4] = UniqueDeviceID[0];
 UDPTransmitBuffer[5] = UniqueDeviceID[1];
 UDPTransmitBuffer[6] = UniqueDeviceID[2];
 UDPTransmitBuffer[7] = UniqueDeviceID[3];
 UDPTransmitBuffer[8] = Calculate_Checksum(&UDPTransmitBuffer, 8);
 Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 9);
 CountdownTimer = 5;
 }
 }

 UI_LoadingScreen("Getting files list");
 Delay_ms(1000);
 UI_ShowMainScreen();

 RequestRootFolder();
 CountdownTimer = 15;
 while ((FolderFileRequestIDCount < FoldersFilesToReceive) || (FoldersFilesToReceive == 0)) {
 Ethernet_Intern_doPacket();
 if (CountdownTimer == 0) {
 RequestRootFolder();
 CountdownTimer = 15;
 }
 KeepAlive_Handler();
 delay_ms(10);
 }
 while (CurrentState != IDLE);

 DownloadMode = 0;

 while(1)
 {
 if(Ethernet_Intern_doDHCPLeaseTime())
 Ethernet_Intern_renewDHCP(5);
 Ethernet_Intern_doPacket();

 UI_Handler();
 KeepAlive_Handler();


 if (UART0_Data_Ready())
 {
 serialReceive = UART0_Read();

 switch (serialReceive) {
 case 'c':
 UART0_Write_Text("Check communication");
 UART0_Write(13);
 UART0_Write(10);
 UDPTransmitBuffer[0] = 0xFF;
 UDPTransmitBuffer[1] = 0x01;
 UDPTransmitBuffer[2] = 4;
 UDPTransmitBuffer[3] = UniqueDeviceID[0];
 UDPTransmitBuffer[4] = UniqueDeviceID[1];
 UDPTransmitBuffer[5] = UniqueDeviceID[2];
 UDPTransmitBuffer[6] = UniqueDeviceID[3];
 UDPTransmitBuffer[7] = Calculate_Checksum(UDPTransmitBuffer, 7);
 Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 8);
 break;
 case 'l':
 UART0_Write_Text("Request folders");
 UART0_Write(13);
 UART0_Write(10);
 RequestRootFolder();
 break;
 case 'f':
 UART0_Write_Text("Request file #1");
 UART0_Write(13);
 UART0_Write(10);
 PlayAudio(1);
 break;
 case 's':
 UART0_Write_Text("Stopping...");
 UART0_Write(13);
 UART0_Write(10);
 CurrentState = IDLE;
 break;
 case 'r':
 UART0_Write_Text("Re-leasing Client ID");
 UART0_Write(13);
 UART0_Write(10);
 ReLeaseCID();
 break;
 }

 }

 }
}
#line 247 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/Multimedia_Client.c"
void ReLeaseCID()
{
 UDPTransmitBuffer[0] = 0xFF;
 UDPTransmitBuffer[1] = 0x01;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 4;
 UDPTransmitBuffer[4] = UniqueDeviceID[0];
 UDPTransmitBuffer[5] = UniqueDeviceID[1];
 UDPTransmitBuffer[6] = UniqueDeviceID[2];
 UDPTransmitBuffer[7] = UniqueDeviceID[3];
 UDPTransmitBuffer[8] = Calculate_Checksum(&UDPTransmitBuffer, 8);
 Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 9);
 CountdownTimer = 5;
 FetchCID = 1;
}
