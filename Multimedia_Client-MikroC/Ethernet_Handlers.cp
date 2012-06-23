#line 1 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/Ethernet_Handlers.c"
#line 1 "c:/tkj electronics/projects/b5-multimedia_streaming/mikroc projects/multimedia_client/__lib_fat32.h"
#line 29 "c:/tkj electronics/projects/b5-multimedia_streaming/mikroc projects/multimedia_client/__lib_fat32.h"
typedef unsigned short uint8;
typedef signed short int8;
typedef unsigned int uint16;
typedef signed int int16;
typedef unsigned long uint32;
typedef signed long int32;
typedef unsigned long long uint64;
typedef signed long long int64;

static const uint16 SECTOR_SIZE = 512;









static const uint8
 FILE_READ = 0x01,
 FILE_WRITE = 0x02,
 FILE_APPEND = 0x04;






static const uint8
 ATTR_NONE = 0x00,
 ATTR_READ_ONLY = 0x01,
 ATTR_HIDDEN = 0x02,
 ATTR_SYSTEM = 0x04,
 ATTR_VOLUME_ID = 0x08,
 ATTR_DIRECTORY = 0x10,
 ATTR_ARCHIVE = 0x20,
 ATTR_DEVICE = 0x40,

 ATTR_RESERVED = 0x80;

static const uint8
 ATTR_LONG_NAME = ATTR_READ_ONLY |
 ATTR_HIDDEN |
 ATTR_SYSTEM |
 ATTR_VOLUME_ID;

static const uint8
 ATTR_FILE_MASK = ATTR_READ_ONLY |
 ATTR_HIDDEN |
 ATTR_SYSTEM |
 ATTR_ARCHIVE,

 ATTR_LONG_NAME_MASK = ATTR_READ_ONLY |
 ATTR_HIDDEN |
 ATTR_SYSTEM |
 ATTR_VOLUME_ID |
 ATTR_DIRECTORY |
 ATTR_ARCHIVE;






static const int8



 OK = 0,
 ERROR = -1,
 FOUND = 1,



 E_READ = -1,
 E_WRITE = -2,
 E_INIT_CARD = -3,
 E_BOOT_SIGN = -4,
 E_BOOT_REC = -5,
 E_FILE_SYS_INFO = -6,
 E_DEVICE_SIZE = -7,
 E_FAT_TYPE = -8,



 E_LAST_ENTRY = -10,
 E_FREE_ENTRY = -11,
 E_CLUST_NUM = -12,
 E_NO_SWAP_SPACE = -13,
 E_NO_SPACE = -14,



 E_DIR_NAME = -20,
 E_ISNT_DIR = -21,
 E_DIR_EXISTS = -22,
 E_DIR_NOTFOUND = -23,
 E_DIR_NOTEMPTY = -24,



 E_FILE_NAME = -30,
 E_ISNT_FILE = -31,
 E_FILE_EXISTS = -32,
 E_FILE_NOTFOUND = -33,
 E_FILE_NOTEMPTY = -34,
 E_MAX_FILES = -35,
 E_FILE_NOTOPENED = -36,
 E_FILE_EOF = -37,
 E_FILE_READ = -38,
 E_FILE_WRITE = -39,
 E_FILE_HANDLE = -40,
 E_FILE_READ_ONLY = -41,
 E_FILE_OPENED = -42,



 E_TIME_YEAR = -50,
 E_TIME_MONTH = -51,
 E_TIME_DAY = -52,
 E_TIME_HOUR = -53,
 E_TIME_MINUTE = -54,
 E_TIME_SECOND = -55;



typedef struct
{
 uint8 State[1];
 uint8 __1[3];
 uint8 Type[1];
 uint8 __2[3];
 uint8 Boot[4];
 uint8 Size[4];
}
FAT32_PART;



typedef struct
{
 uint8 __1[446];
 FAT32_PART Part[4];
 uint8 BootSign[2];
}
FAT32_MBR;



typedef struct
{
 uint8 JmpCode[3];
 uint8 __1[8];
 uint8 BytesPSect[2];
 uint8 SectsPClust[1];
 uint8 Reserved[2];
 uint8 FATCopies[1];
 uint8 __2[4];
 uint8 MediaDesc[1];
 uint8 __3[10];
 uint8 Sects[4];
 uint8 SectsPFAT[4];
 uint8 Flags[2];
 uint8 __4[2];
 uint8 RootClust[4];
 uint8 FSISect[2];
 uint8 BootBackup[2];
 uint8 __5[14];
 uint8 ExtSign[1];
 uint8 __6[4];
 uint8 VolName[11];
 uint8 FATName[8];
 uint8 __7[420];
 uint8 BootSign[2];
}
FAT32_BR;



typedef struct
{
 uint8 LeadSig[4];
 uint8 __1[480];
 uint8 StrucSig[4];
 uint8 FreeCount[4];
 uint8 NextFree[4];
 uint8 __2[14];
 uint8 TrailSig[2];
}
FAT32_FSI;


typedef struct
{
 uint8 Entry[4];
}
FAT32_FATENT;



typedef struct
{
 uint8 NameExt[11];
 uint8 Attrib[1];
 uint8 __1[2];
 uint8 CTime[2];
 uint8 CDate[2];
 uint8 ATime[2];
 uint8 HiClust[2];
 uint8 MTime[2];
 uint8 MDate[2];
 uint8 LoClust[2];
 uint8 Size[4];
}
FAT32_DIRENT;



typedef uint32 __CLUSTER;
typedef uint32 __SECTOR;
typedef uint32 __ENTRY;

typedef int8 __HANDLE;



typedef struct
{
 uint16 Year;
 uint8 Month;
 uint8 Day;
 uint8 Hour;
 uint8 Minute;
 uint8 Second;
}
__TIME;



typedef struct
{
 uint8 State;
 uint8 Type;
 __SECTOR Boot;
 uint32 Size;
}
__PART;



typedef struct
{
 __PART Part[1];
 uint16 BytesPSect;
 uint8 SectsPClust;
 uint16 Reserved;
 uint8 FATCopies;
 uint32 SectsPFAT;
 uint16 Flags;
 __SECTOR FAT;
 __CLUSTER Root;
 __SECTOR Data;
 __SECTOR FSI;
 uint32 ClFreeCount;
 __CLUSTER ClNextFree;
}
__INFO;


typedef struct
{
 char NameExt[13];
 uint8 Attrib;

 uint32 Size;
 __CLUSTER _1stClust;

 __CLUSTER EntryClust;
 __ENTRY Entry;
}
__DIR;


typedef struct
{
 __CLUSTER _1stClust;
 __CLUSTER CurrClust;

 __CLUSTER EntryClust;
 __ENTRY Entry;

 uint32 Cursor;
 uint32 Length;

 uint8 Mode;
 uint8 Attr;
}
__FILE;
#line 332 "c:/tkj electronics/projects/b5-multimedia_streaming/mikroc projects/multimedia_client/__lib_fat32.h"
typedef struct
{
 __SECTOR fSectNum;
 char fSect[SECTOR_SIZE];
}
__RAW_SECTOR;


extern const char CRLF_F32[];
extern const uint8 FAT32_MAX_FILES;
extern const uint8 f32_fsi_template[SECTOR_SIZE];
extern const uint8 f32_br_template[SECTOR_SIZE];
extern __FILE fat32_fdesc[];
extern __RAW_SECTOR f32_sector;


extern int8 FAT32_Dev_Init (void);
extern int8 FAT32_Dev_Read_Sector (__SECTOR sc, char* buf);
extern int8 FAT32_Dev_Write_Sector (__SECTOR sc, char* buf);
extern int8 FAT32_Dev_Multi_Read_Stop();
extern int8 FAT32_Dev_Multi_Read_Sector(char* buf);
extern int8 FAT32_Dev_Multi_Read_Start(__SECTOR sc);
extern int8 FAT32_Put_Char (char ch);


int8 FAT32_Init (void);
int8 FAT32_Format (char *devLabel);
int8 FAT32_ScanDisk (uint32 *totClust, uint32 *freeClust, uint32 *badClust);
int8 FAT32_GetFreeSpace(uint32 *freeClusts, uint16 *bytesPerClust);

int8 FAT32_ChangeDir (char *dname);
int8 FAT32_MakeDir (char *dname);
int8 FAT32_Dir (void);
int8 FAT32_FindFirst (__DIR *pDE);
int8 FAT32_FindNext (__DIR *pDE);
int8 FAT32_Delete (char *fn);
int8 FAT32_DeleteRec (char *fn);
int8 FAT32_Exists (char *name);
int8 FAT32_Rename (char *oldName, char *newName);
int8 FAT32_Open (char *fn, uint8 mode);
int8 FAT32_Eof (__HANDLE fHandle);
int8 FAT32_Read (__HANDLE fHandle, char* rdBuf, uint16 len);
int8 FAT32_Write (__HANDLE fHandle, char* wrBuf, uint16 len);
int8 FAT32_Seek (__HANDLE fHandle, uint32 pos);
int8 FAT32_Tell (__HANDLE fHandle, uint32 *pPos);
int8 FAT32_Close (__HANDLE fHandle);
int8 FAT32_Size (char *fname, uint32 *pSize);
int8 FAT32_GetFileHandle(char *fname, __HANDLE *handle);

int8 FAT32_SetTime (__TIME *pTM);
int8 FAT32_IncTime (uint32 Sec);

int8 FAT32_GetCTime (char *fname, __TIME *pTM);
int8 FAT32_GetMTime (char *fname, __TIME *pTM);

int8 FAT32_SetAttr (char *fname, uint8 attr);
int8 FAT32_GetAttr (char *fname, uint8* attr);

int8 FAT32_GetError (void);

int8 FAT32_MakeSwap (char *name, __SECTOR nSc, __CLUSTER *pCl);
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
#line 8 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/Ethernet_Handlers.c"
unsigned char myMacAddr[6] = {0x32, 0x14, 0xA5, 0x76, 0x19, 0x3f};
unsigned char myIpAddr[4] = {192, 168, 0, 140 };
unsigned char gwIpAddr[4] = {192, 168, 0, 1 };
unsigned char ipMask[4] = {255, 255, 255, 0 };
unsigned char dnsIpAddr[4] = {192, 168, 0, 1 };

unsigned char *UniqueDeviceID = &myMacAddr[2];
const unsigned int localClientPort = 1111;
const unsigned char serverIpAddr[4] = {192, 168, 0, 50};
const unsigned int serverPort = 1111;

const code unsigned char httpHeader[] = "HTTP/1.1 200 OK\nContent-type: ";
const code unsigned char httpMimeTypeHTML[] = "text/html\n\n";
const code unsigned char webpageContent[] = "<h1>It works!</h1>";


unsigned char UDPTransmitBuffer[30];
unsigned char DeviceCID = 0xFF;
MultimediaState CurrentState = IDLE;
unsigned char FolderFileRequestIDCount;
unsigned char FoldersFilesToReceive;

unsigned long ReceivingFileLength;
unsigned int ReceivingFileDPL;
unsigned long ReceivingDividedPackages;
unsigned long ReceivingCurrentPackage;
unsigned long ReceivingPackageLeft;
unsigned int ReceivingImageWidth, ReceivingImageHeight;
unsigned int Xcord, Ycord;

unsigned long OldSecondsCounter;

unsigned char ErrorCounter;
 __HANDLE fileHandle;
#line 55 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/Ethernet_Handlers.c"
unsigned int Ethernet_Intern_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags *flags)
{
 unsigned int offset = 0;
 offset += Ethernet_Intern_writePayloadString(httpHeader, offset);
 offset += Ethernet_Intern_writePayloadString(httpMimeTypeHTML, offset);
 offset += Ethernet_Intern_writePayloadString(webpageContent, offset);
 return (offset);
}
#line 75 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/Ethernet_Handlers.c"
unsigned int Ethernet_Intern_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags *flags)
{
 unsigned char receiveBuffer[1480];
 unsigned char sendLength = 0;
 unsigned char CID, CMD;
 unsigned int DataLength;
 unsigned int tempI, tempI2;


 UART0_Write_Text("UDP Package received");
 UART0_Write(13);
 UART0_Write(10);


 if (reqLength > 1480)
 return 0;

 Ethernet_Intern_readPayloadBytes(receiveBuffer, 0, reqLength);



 if (receiveBuffer[reqLength-1] != Calculate_Checksum(receiveBuffer, (reqLength-1)))
 {

 UART0_Write_Text("Checksum error");
 UART0_Write(13);
 UART0_Write(10);


 return 0;
 }

 CID = receiveBuffer[0];
 if (CID != DeviceCID && CID != 0xFF)
 {

 UART0_Write_Text(" -> Package not for us");
 UART0_Write(13);
 UART0_Write(10);

 return 0;
 }

 CMD = receiveBuffer[1];
 DataLength = (receiveBuffer[2] << 8) | receiveBuffer[3];


 UART0_Write_Text(" -> Package CMD: ");
 ByteToStr(CMD, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write_Text(", Length: ");
 WordToStr(DataLength, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write(13);
 UART0_Write(10);


 if (CMD == 0x0D && DataLength > 5 && CurrentState == FILE_RECEIVE && DownloadMode == 0) {
 if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFileID) {
#line 155 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/Ethernet_Handlers.c"
 if (ReceivingCurrentPackage < ReceivingDividedPackages) {
 for (tempI = 0; tempI < (ReceivingFileDPL/BYTES_2_WRITE); tempI++) {
 MP3_SDI_Write_32(receiveBuffer + 9 + (tempI*BYTES_2_WRITE));
 }
 } else {
 for (tempI = 0; tempI < (ReceivingPackageLeft/BYTES_2_WRITE); tempI++) {
 MP3_SDI_Write_32(receiveBuffer[9 + (tempI*BYTES_2_WRITE)]);
 }
 tempI = (ReceivingPackageLeft/BYTES_2_WRITE);
 tempI *= BYTES_2_WRITE;
 for (tempI2 = 0; tempI2 < (ReceivingPackageLeft%BYTES_2_WRITE); tempI2++) {
 MP3_SDI_Write(receiveBuffer[9 + tempI + tempI2]);
 }
 }
 ReceivingCurrentPackage++;

 if (ReceivingCurrentPackage < ReceivingDividedPackages) {
 RequestNextAudioPackage();
 } else {
 AudioFinished();
 CurrentState = IDLE;
 }
 }
 }

 if (CMD == 0x0D && DataLength > 5 && CurrentState == FILE_RECEIVE && DownloadMode == 1) {
 if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFileID) {

 if (ReceivingCurrentPackage < ReceivingDividedPackages) {
 FAT32_Write(fileHandle, (receiveBuffer + 9), ReceivingFileDPL);
 } else {
 FAT32_Write(fileHandle, (receiveBuffer + 9), ReceivingPackageLeft);
 }
 ReceivingCurrentPackage++;

 if (ReceivingCurrentPackage < ReceivingDividedPackages) {
 RequestNextAudioPackage();
 } else {

 FAT32_Close(fileHandle);
 UART0_Write_Text("File saved");
 UART0_Write(13);
 UART0_Write(10);
 CurrentState = IDLE;
 }
 }
 }

 if (CMD == 0x1D && DataLength > 5 && CurrentState == IMAGE_RECEIVE) {
 if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFileID) {

 if (ReceivingCurrentPackage < ReceivingDividedPackages) {
 for (tempI = 0; tempI < ReceivingFileDPL; tempI += 2) {
 TFT_Dot(Xcord, Ycord, (((receiveBuffer[9 + tempI]) << 8) | (receiveBuffer[9 + tempI + 1])));
 Xcord++;
 if (Xcord == 320) {
 Ycord++;
 Xcord = 0;
 }
 }
 } else {

 }
 ReceivingCurrentPackage++;

 if (ReceivingCurrentPackage < ReceivingDividedPackages) {
 RequestNextImagePackage();
 } else {
 UART0_Write_Text("Image received");
 UART0_Write(13);
 UART0_Write(10);
 CurrentState = IMAGE_DISPLAY;
 }
 }
 }

 if (CMD == 0x40) {

 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x41;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 0;
 UDPTransmitBuffer[4] = Calculate_Checksum(UDPTransmitBuffer, 4);
 UART0_Write_Text("Pong sent");
 UART0_Write(13);
 UART0_Write(10);
 sendLength = 5;
 }

 if (CMD == 0x02 && DataLength == 5) {
 if (receiveBuffer[4] == UniqueDeviceID[0] && receiveBuffer[5] == UniqueDeviceID[1] && receiveBuffer[6] == UniqueDeviceID[2] && receiveBuffer[7] == UniqueDeviceID[3]) {
 DeviceCID = receiveBuffer[8];
 ByteToStr(DeviceCID, stringBuffer);
 UART0_Write_Text("Assigned CID: ");
 UART0_Write_Text(stringBuffer);
 UART0_Write(13);
 UART0_Write(10);
 FetchCID = 0;
 }
 }

 if (CMD == 0x04 && DataLength == 3 && CurrentState == FOLDER_RECEIVE) {
 if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFolderID) {
 FoldersFilesToReceive = receiveBuffer[6];
 if (CurrentFolderID > 0) {
 FilesList[0].ID = PreviousFolderID;
 FilesList[0].Type = 'F';
 memcpy(FilesList[0].Name, "../", 3);
 FilesList[0].NameLength = 3;
 }
 FolderFileRequestIDCount = 0;
 ByteToStr(FoldersFilesToReceive, stringBuffer);
 UART0_Write_Text("Folder/file count to receive: ");
 UART0_Write_Text(stringBuffer);
 UART0_Write(13);
 UART0_Write(10);

 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x05;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 3;
 UDPTransmitBuffer[4] = (CurrentFolderID & 0xFF00) >> 8;
 UDPTransmitBuffer[5] = (CurrentFolderID & 0xFF);
 UDPTransmitBuffer[6] = 0;
 UDPTransmitBuffer[7] = Calculate_Checksum(UDPTransmitBuffer, 7);
 sendLength = 8;

 halfSecondCountdownTimer = 5;
 ErrorCounter = 0;
 }
 }

 if (CMD == 0x06 && DataLength > 5 && CurrentState == FOLDER_RECEIVE) {
 if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFolderID) {
 if (FolderFileRequestIDCount < 199) {
 if (CurrentFolderID == 0) {
 FilesList[FolderFileRequestIDCount].ID = (receiveBuffer[6] << 8) | receiveBuffer[7];
 FilesList[FolderFileRequestIDCount].Type = receiveBuffer[8];
 memcpy(FilesList[FolderFileRequestIDCount].Name, (receiveBuffer+9), (DataLength-5));
 FilesList[FolderFileRequestIDCount].Name[(DataLength-5)] = 0x00;
 FilesList[FolderFileRequestIDCount].NameLength = (DataLength-5);
 } else {
 FilesList[FolderFileRequestIDCount+1].ID = (receiveBuffer[6] << 8) | receiveBuffer[7];
 FilesList[FolderFileRequestIDCount+1].Type = receiveBuffer[8];
 memcpy(FilesList[FolderFileRequestIDCount+1].Name, (receiveBuffer+9), (DataLength-5));
 FilesList[FolderFileRequestIDCount+1].Name[(DataLength-5)] = 0x00;
 FilesList[FolderFileRequestIDCount+1].NameLength = (DataLength-5);
 }
 }

 UART0_Write_Text("Item ID #");
 WordToStr((receiveBuffer[6] << 8) | receiveBuffer[7], stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write_Text(" of type (");
 UART0_Write(receiveBuffer[8]);
 UART0_Write_Text("): ");
 memcpy(stringBuffer, (receiveBuffer+9), (DataLength-5));
 stringBuffer[(DataLength-5)] = 0;
 UART0_Write_Text(stringBuffer);

 UART0_Write(13);
 UART0_Write(10);

 FolderFileRequestIDCount++;
 if (FolderFileRequestIDCount < FoldersFilesToReceive) {

 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x05;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 3;
 UDPTransmitBuffer[4] = (CurrentFolderID & 0xFF00) >> 8;
 UDPTransmitBuffer[5] = (CurrentFolderID & 0xFF);
 UDPTransmitBuffer[6] = FolderFileRequestIDCount;
 UDPTransmitBuffer[7] = Calculate_Checksum(UDPTransmitBuffer, 7);
 sendLength = 8;

 halfSecondCountdownTimer = 5;
 ErrorCounter = 0;
 } else {
 if (CurrentFolderID == 0) {
 FilesListCount = FoldersFilesToReceive;
 } else {
 FilesListCount = FoldersFilesToReceive + 1;
 }

 if (FilesListCount < 12) {
 for (tempI = FilesListCount; tempI < 12; tempI++) {
 FilesList[tempI].ID = 0;
 FilesList[tempI].Type = 0;
 FilesList[tempI].NameLength = 0;
 }
 }

 CurrentState = IDLE;
 UI_UpdateFolderName();
 UI_UpdateFilesList();
 UI_ResetCursorPos();
 }
 }
 }

 if (CMD == 0x0B && DataLength == 11 && CurrentState == FILE_RECEIVE) {
 if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFileID) {
 ReceivingFileLength = ((long)receiveBuffer[6] << 24) | ((long)receiveBuffer[7] << 16) | ((long)receiveBuffer[8] << 8) | ((long)receiveBuffer[9]);
 ReceivingFileDPL = (((long)receiveBuffer[10] << 8) | (long)receiveBuffer[11]);
 ReceivingDividedPackages = ((long)receiveBuffer[12] << 16) | ((long)receiveBuffer[13] << 8) | ((long)receiveBuffer[14]);
 ReceivingPackageLeft = ReceivingFileLength - (ReceivingDividedPackages * ReceivingFileDPL);

 ReceivingCurrentPackage = 0;

 UART0_Write_Text("File #");
 ByteToStr(CurrentFileID, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write_Text(" of ");
 LongToStr(ReceivingFileLength, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write_Text(" bytes");
 UART0_Write(13);
 UART0_Write(10);
 UART0_Write_Text("DPL: ");
 IntToStr(ReceivingFileDPL, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write_Text(" making it divided in ");
 LongToStr(ReceivingDividedPackages, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write_Text(" packages");
 UART0_Write(13);
 UART0_Write(10);


 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x0C;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 5;
 UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) > 8;
 UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
 UDPTransmitBuffer[6] = (ReceivingCurrentPackage & 0xFF0000) >> 16;
 UDPTransmitBuffer[7] = (ReceivingCurrentPackage & 0xFF00) >> 8;
 UDPTransmitBuffer[8] = (ReceivingCurrentPackage & 0xFF);
 UDPTransmitBuffer[9] = Calculate_Checksum(UDPTransmitBuffer, 9);
 sendLength = 10;

 UART0_Write_Text("Requesting file package ");
 LongToStr(ReceivingCurrentPackage, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write('/');
 LongToStr(ReceivingDividedPackages, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write(13);
 UART0_Write(10);

 CurrentBuffer = 0;
 CurrentBuffer1MaxPos = 0;
 CurrentBuffer2MaxPos = 0;
 CurrentBufferPos = 0;
 FirstBufferFill = 1;

 halfSecondCountdownTimer = 5;
 ErrorCounter = 0;
 }
 }

 if (CMD == 0x1B && DataLength == 11 && CurrentState == IMAGE_RECEIVE) {
 if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFileID) {
 ReceivingImageWidth = (((long)receiveBuffer[6] << 8) | (long)receiveBuffer[7]);
 ReceivingImageHeight = (((long)receiveBuffer[8] << 8) | (long)receiveBuffer[9]);
 ReceivingFileDPL = (((long)receiveBuffer[10] << 8) | (long)receiveBuffer[11]);
 ReceivingDividedPackages = ((long)receiveBuffer[12] << 16) | ((long)receiveBuffer[13] << 8) | ((long)receiveBuffer[14]);
 ReceivingFileLength = ReceivingImageWidth * ReceivingImageHeight * 2;
 ReceivingPackageLeft = ReceivingFileLength - (ReceivingDividedPackages * ReceivingFileDPL);

 ReceivingCurrentPackage = 0;

 UART0_Write_Text("File #");
 ByteToStr(CurrentFileID, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write_Text(" of ");
 LongToStr(ReceivingFileLength, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write_Text(" bytes");
 UART0_Write(13);
 UART0_Write(10);
 UART0_Write_Text("DPL: ");
 IntToStr(ReceivingFileDPL, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write_Text(" making it divided in ");
 LongToStr(ReceivingDividedPackages, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write_Text(" packages");
 UART0_Write(13);
 UART0_Write(10);


 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x1C;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 5;
 UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) > 8;
 UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
 UDPTransmitBuffer[6] = (ReceivingCurrentPackage & 0xFF0000) >> 16;
 UDPTransmitBuffer[7] = (ReceivingCurrentPackage & 0xFF00) >> 8;
 UDPTransmitBuffer[8] = (ReceivingCurrentPackage & 0xFF);
 UDPTransmitBuffer[9] = Calculate_Checksum(UDPTransmitBuffer, 9);
 sendLength = 10;

 UART0_Write_Text("Requesting file package ");
 LongToStr(ReceivingCurrentPackage, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write('/');
 LongToStr(ReceivingDividedPackages, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write(13);
 UART0_Write(10);

 halfSecondCountdownTimer = 5;
 ErrorCounter = 0;
 }
 }

 if (sendLength > 0) {
 delay_ms(10);
 Ethernet_Intern_writePayloadBytes(UDPTransmitBuffer, 0, sendLength);
 }

 return (sendLength);
}

unsigned char Calculate_Checksum(unsigned char *UDP_Package, unsigned int length)
{
 unsigned int i;
 unsigned int temp = 0;

 for (i = 0; i < length; i++)
 {
 temp += UDP_Package[i];
 }

 temp = temp & 0xFF;
 temp ^= 0xFF;
 return temp;
}

void RequestRootFolder()
{
 CurrentFolderID = 0;
 memcpy(CurrentFolderName, "[ROOT]", 7);
 CurrentState = FOLDER_RECEIVE;

 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x03;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 2;
 UDPTransmitBuffer[4] = (CurrentFolderID & 0xFF00) >> 8;
 UDPTransmitBuffer[5] = (CurrentFolderID & 0xFF);
 UDPTransmitBuffer[6] = Calculate_Checksum(UDPTransmitBuffer, 6);
 Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 7);

 halfSecondCountdownTimer = 5;
 ErrorCounter = 0;
}


void RequestFolderContent(unsigned int FolderID, unsigned char * folderName, unsigned char folderNameLength)
{
 PreviousFolderID = CurrentFolderID;
 CurrentFolderID = FolderID;
 CurrentState = FOLDER_RECEIVE;

 if (FolderID == 0) {
 memcpy(CurrentFolderName, "[ROOT]", 7);
 } else {
 memcpy(CurrentFolderName, folderName, folderNameLength);
 CurrentFolderName[folderNameLength] = 0x00;
 }

 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x03;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 2;
 UDPTransmitBuffer[4] = (CurrentFolderID & 0xFF00) >> 8;
 UDPTransmitBuffer[5] = (CurrentFolderID & 0xFF);
 UDPTransmitBuffer[6] = Calculate_Checksum(UDPTransmitBuffer, 6);
 Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 7);

 halfSecondCountdownTimer = 5;
 ErrorCounter = 0;
}

void PlayAudio(unsigned int AudioID)
{
 CurrentFileID = AudioID;
 CurrentState = FILE_RECEIVE;

 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x0A;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 2;
 UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
 UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
 UDPTransmitBuffer[6] = Calculate_Checksum(UDPTransmitBuffer, 6);
 Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 7);

 halfSecondCountdownTimer = 5;
 ErrorCounter = 0;
}

void SaveAudio(unsigned int AudioID, unsigned char * FileName)
{
 fileHandle = FAT32_Open(FileName, FILE_WRITE);
 CurrentFileID = AudioID;
 CurrentState = FILE_RECEIVE;

 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x0A;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 2;
 UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
 UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
 UDPTransmitBuffer[6] = Calculate_Checksum(UDPTransmitBuffer, 6);
 Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 7);

 halfSecondCountdownTimer = 5;
 ErrorCounter = 0;
}

void AudioFinished(void)
{

 MP3_Reset();
 UART0_Write_Text("Finished playing");
 UART0_Write(13);
 UART0_Write(10);
}

void TerminateAudio(void)
{

 MP3_Reset();
 UART0_Write_Text("Stopped playing");
 UART0_Write(13);
 UART0_Write(10);
}

void RequestNextAudioPackage()
{

 UART0_Write_Text("Requesting package ");
 LongToStr(ReceivingCurrentPackage, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write_Text(" of ");
 LongToStr(ReceivingDividedPackages, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write(13);
 UART0_Write(10);



 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x0C;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 5;
 UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
 UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
 UDPTransmitBuffer[6] = (ReceivingCurrentPackage & 0xFF0000) >> 16;
 UDPTransmitBuffer[7] = (ReceivingCurrentPackage & 0xFF00) >> 8;
 UDPTransmitBuffer[8] = (ReceivingCurrentPackage & 0xFF);
 UDPTransmitBuffer[9] = Calculate_Checksum(UDPTransmitBuffer, 9);
 Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 10);
 halfSecondCountdownTimer = 5;
 ErrorCounter = 0;
}

void DisplayImage(unsigned int ImageID)
{
 CurrentFileID = ImageID;
 CurrentState = IMAGE_RECEIVE;

 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x1A;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 2;
 UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
 UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
 UDPTransmitBuffer[6] = Calculate_Checksum(UDPTransmitBuffer, 6);
 Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 7);

 halfSecondCountdownTimer = 60;
 ErrorCounter = 0;

 Xcord = 0;
 Ycord = 0;
 TFT_Fill_Screen(CL_BLACK);
 TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
 TFT_Write_Text("Loading image...", 110, 110);
}

void RequestNextImagePackage()
{

 UART0_Write_Text("Requesting package ");
 LongToStr(ReceivingCurrentPackage, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write_Text(" of ");
 LongToStr(ReceivingDividedPackages, stringBuffer);
 UART0_Write_Text(stringBuffer);
 UART0_Write(13);
 UART0_Write(10);



 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x1C;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 5;
 UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
 UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
 UDPTransmitBuffer[6] = (ReceivingCurrentPackage & 0xFF0000) >> 16;
 UDPTransmitBuffer[7] = (ReceivingCurrentPackage & 0xFF00) >> 8;
 UDPTransmitBuffer[8] = (ReceivingCurrentPackage & 0xFF);
 UDPTransmitBuffer[9] = Calculate_Checksum(UDPTransmitBuffer, 9);
 Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 10);
 halfSecondCountdownTimer = 5;
 ErrorCounter = 0;
}

void KeepAlive_Handler(void)
{
 unsigned char tempI;

 if (CurrentState == FILE_RECEIVE && halfSecondCountdownTimer == 0) {
 ErrorCounter++;

 if (ErrorCounter < 5) {

 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x0C;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 5;
 UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
 UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
 UDPTransmitBuffer[6] = (ReceivingCurrentPackage & 0xFF0000) >> 16;
 UDPTransmitBuffer[7] = (ReceivingCurrentPackage & 0xFF00) >> 8;
 UDPTransmitBuffer[8] = (ReceivingCurrentPackage & 0xFF);
 UDPTransmitBuffer[9] = Calculate_Checksum(UDPTransmitBuffer, 9);
 Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 10);
 halfSecondCountdownTimer = 5;
 } else {
 TerminateAudio();
 CurrentState = IDLE;
 }
 }

 if (CurrentState == IMAGE_RECEIVE && halfSecondCountdownTimer == 0) {
 ErrorCounter++;

 if (ErrorCounter < 5) {

 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x1C;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 5;
 UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
 UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
 UDPTransmitBuffer[6] = (ReceivingCurrentPackage & 0xFF0000) >> 16;
 UDPTransmitBuffer[7] = (ReceivingCurrentPackage & 0xFF00) >> 8;
 UDPTransmitBuffer[8] = (ReceivingCurrentPackage & 0xFF);
 UDPTransmitBuffer[9] = Calculate_Checksum(UDPTransmitBuffer, 9);
 Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 10);
 halfSecondCountdownTimer = 5;
 } else {
 UI_ShowMainScreen();
 UI_UpdateFolderName();
 UI_UpdateFilesList();
 UI_ResetCursorPos();
 CurrentState = IDLE;
 }
 }

 if (CurrentState == FOLDER_RECEIVE && halfSecondCountdownTimer == 0) {
 ErrorCounter++;

 if (ErrorCounter < 5) {

 UDPTransmitBuffer[0] = DeviceCID;
 UDPTransmitBuffer[1] = 0x05;
 UDPTransmitBuffer[2] = 0;
 UDPTransmitBuffer[3] = 3;
 UDPTransmitBuffer[4] = CurrentFolderID >> 8;
 UDPTransmitBuffer[5] = (CurrentFolderID & 0xFF);
 UDPTransmitBuffer[6] = 0;
 UDPTransmitBuffer[7] = Calculate_Checksum(UDPTransmitBuffer, 7);
 Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 8);

 halfSecondCountdownTimer = 5;
 } else {
 FilesListCount = FolderFileRequestIDCount;

 if (FilesListCount < 12) {
 for (tempI = FilesListCount; tempI < 12; tempI++) {
 FilesList[tempI].ID = 0;
 FilesList[tempI].Type = 0;
 FilesList[tempI].NameLength = 0;
 }
 }

 CurrentState = IDLE;
 UI_UpdateFolderName();
 UI_UpdateFilesList();
 UI_ResetCursorPos();
 }
 }
}
