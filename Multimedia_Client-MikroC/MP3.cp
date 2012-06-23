#line 1 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/MP3.c"
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
#line 1 "c:/tkj electronics/projects/b5-multimedia_streaming/mikroc projects/multimedia_client/mp3_driver.h"
#line 26 "c:/tkj electronics/projects/b5-multimedia_streaming/mikroc projects/multimedia_client/mp3_driver.h"
extern sbit Mmc_Chip_Select;
extern sbit MP3_CS;
extern sbit MP3_RST;
extern sbit XDCS;
extern sbit DREQ;

extern sbit Mmc_Chip_Select_Direction;
extern sbit MP3_CS_Direction;
extern sbit MP3_RST_Direction;
extern sbit XDCS_Direction;
extern sbit DREQ_Direction;

extern const char WRITE_CODE;
extern const char READ_CODE;

extern const char SCI_BASE_ADDR;
extern const char SCI_MODE_ADDR;
extern const char SCI_STATUS_ADDR;
extern const char SCI_BASS_ADDR;
extern const char SCI_CLOCKF_ADDR;
extern const char SCI_DECODE_TIME_ADDR;
extern const char SCI_AUDATA_ADDR;
extern const char SCI_WRAM_ADDR;
extern const char SCI_WRAMADDR_ADDR;
extern const char SCI_HDAT0_ADDR;
extern const char SCI_HDAT1_ADDR;
extern const char SCI_AIADDR_ADDR;
extern const char SCI_VOL_ADDR;
extern const char SCI_AICTRL0_ADDR;
extern const char SCI_AICTRL1_ADDR;
extern const char SCI_AICTRL2_ADDR;
extern const char SCI_AICTRL3_ADDR;

extern const int MP3_para_endFillByte;
#line 80 "c:/tkj electronics/projects/b5-multimedia_streaming/mikroc projects/multimedia_client/mp3_driver.h"
void MP3_SCI_Write(char address, unsigned int data_in);

void MP3_SCI_Read(char start_address, char words_count, unsigned int *data_buffer);
unsigned int MP3_SCI_ReadSingle(char address);

void MP3_SDI_Write(char data_);

void MP3_SDI_Write_32(char *data_);

void MP3_Set_Volume(char left, char right);

unsigned int MP3_wram_read(unsigned int address);
void MP3_wram_write(unsigned int address, unsigned int writeData);
#line 8 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/MP3.c"
sbit Mmc_Chip_Select_Direction at GPIO_PORTA_DIR7_bit;
sbit Mmc_Chip_Select at GPIO_PORTA_DATA7_bit;


const BYTES_2_WRITE = 32;
char volume_left, volume_right;
#line 23 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/MP3.c"
void MP3_Init(void)
{
 XDCS = 1;
 MP3_CS = 1;


 MP3_RST = 0;
 Delay_ms(10);
 MP3_RST = 1;

 while (DREQ == 0);

 MP3_SCI_Write(SCI_MODE_ADDR, 0x0800);
 MP3_SCI_Write(SCI_BASS_ADDR, 0x7A00);

 MP3_SCI_Write(SCI_CLOCKF_ADDR, 0x2000);


 volume_left = 0;
 volume_right = 0;
 MP3_Set_Volume(volume_left, volume_right);
}

void MP3_Reset(void)
{
 MP3_RST = 1;
 SPI0_Init_Advanced(400000,
 _SPI_MASTER,
 _SPI_8_BIT | _SPI_CLK_IDLE_HIGH | _SPI_SECOND_CLK_EDGE_TRANSITION,
 &_GPIO_MODULE_SPI0_A245);

 XDCS = 1;
 MP3_CS = 1;


 MP3_RST = 0;
 Delay_ms(10);
 MP3_RST = 1;
 while (DREQ == 0);

 MP3_SCI_Write(SCI_MODE_ADDR, 0x0800);
 MP3_SCI_Write(SCI_BASS_ADDR, 0x7A00);
 MP3_SCI_Write(SCI_CLOCKF_ADDR, 0x2000);

 volume_left = 0;
 volume_right = 0;
 MP3_Set_Volume(volume_left, volume_right);
}
#line 79 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/MP3.c"
void MP3_Start(void)
{

 GPIO_Digital_Output(&GPIO_PORTA, _GPIO_PINMASK_7);


 GPIO_Digital_Output(&GPIO_PORTF, _GPIO_PINMASK_5);
 GPIO_Digital_Input (&GPIO_PORTF, _GPIO_PINMASK_4);
 GPIO_Digital_Output(&GPIO_PORTF, _GPIO_PINMASK_0);
 GPIO_Digital_Output(&GPIO_PORTF, _GPIO_PINMASK_1);

 MP3_CS_Direction = 1;
 MP3_CS = 1;
 MP3_RST_Direction = 1;
 MP3_RST = 1;

 DREQ_Direction = 0;
 XDCS_Direction = 1;
 XDCS = 0;
 XDCS = 1;


 SPI0_Init_Advanced(2000000, _SPI_MASTER, _SPI_8_BIT, &_GPIO_MODULE_SPI0_A245);

 MP3_Init();
 Delay_ms(1000);
 MP3_InitSDBuffer();
 Delay_ms(1000);
}

void MP3_FinishedPlayback(void)
{
 int n, i;
 unsigned short endFillByte;
 unsigned int sciModeByte;



 endFillByte = MP3_wram_read(MP3_para_endFillByte);

 endFillByte = endFillByte ^ 0x00FF;
 for (n = 0; n < 2052; n++)
 MP3_SDI_Write(endFillByte);


 sciModeByte = MP3_SCI_ReadSingle(SCI_MODE_ADDR);
 sciModeByte |=  0x0008 ;
 MP3_SCI_Write(SCI_MODE_ADDR, sciModeByte);


 for (i = 0; i < 64; i++)
 {

 for (n = 0; n < 32; n++)
 MP3_SDI_Write(endFillByte);

 sciModeByte = MP3_SCI_ReadSingle(SCI_MODE_ADDR);
 if ((sciModeByte &  0x0008 ) == 0x0000)
 {
 break;
 }
 }

 if ((sciModeByte &  0x0008 ) == 0x0000)
 {


 UART0_Write_Text("Song sucessfully sent. Terminating OK");
 UART0_Write(13);
 UART0_Write(10);
 MP3_SCI_Write(SCI_DECODE_TIME_ADDR, 0x0000);
 }
 else
 {


 UART0_Write_Text("SM CANCEL hasn't cleared after sending 2048 bytes, do software reset");
 UART0_Write(13);
 UART0_Write(10);
 MP3_Reset();
 }
}

void MP3_StopPlayback(void)
{
 unsigned char firstBuffer = CurrentBuffer;
 char readyToBreak = 0;
 int i, n;
 unsigned short endFillByte;

 unsigned short sciModeByte;
 sciModeByte = MP3_SCI_ReadSingle(SCI_MODE_ADDR);
 sciModeByte |=  0x0008 ;
 MP3_SCI_Write(SCI_MODE_ADDR, sciModeByte);


 while ((readyToBreak == 0) || (readyToBreak == 1 && CurrentBuffer == firstBuffer))
 {
 Ethernet_Intern_doPacket();

 sciModeByte = MP3_SCI_ReadSingle(SCI_MODE_ADDR);
 if ((sciModeByte &  0x0008 ) == 0x0000)
 {
 break;
 }
 if (CurrentBuffer != firstBuffer) readyToBreak = 1;
 }

 if ((sciModeByte &  0x0008 ) == 0x0000)
 {


 endFillByte = MP3_wram_read(MP3_para_endFillByte);

 endFillByte = endFillByte ^0x00FF;
 for (n = 0; n < 2052; n++)
 MP3_SDI_Write(endFillByte);


 UART0_Write_Text("Song sucessfully stopped.");
 UART0_Write(13);
 UART0_Write(10);
 MP3_SCI_Write(SCI_DECODE_TIME_ADDR, 0x0000);
 }
 else
 {


 UART0_Write_Text("SM CANCEL hasn't cleared after sending 2048 bytes, do software reset");
 UART0_Write(13);
 UART0_Write(10);
 MP3_Reset();
 }
}

void MP3_InitSDBuffer(void)
{
 signed char err;
 unsigned char ErrCount = 0;



 SPI0_Init_Advanced(400000,
 _SPI_MASTER,
 _SPI_8_BIT | _SPI_CLK_IDLE_HIGH | _SPI_SECOND_CLK_EDGE_TRANSITION,
 &_GPIO_MODULE_SPI0_A245);

 SDSave_Disabled = 0;





 err = FAT32_Init();

 if (err < 0)
 {
 while(err < 0 && ErrCount < 5)
 {
 err = FAT32_Init();
 Delay_ms(500);
 ErrCount++;
 }
 }

 if (ErrCount >= 5)
 SDSave_Disabled = 1;

 SPI0_Init_Advanced(10000000,
 _SPI_MASTER,
 _SPI_8_BIT | _SPI_CLK_IDLE_HIGH | _SPI_SECOND_CLK_EDGE_TRANSITION,
 &_GPIO_MODULE_SPI0_A245);
}
