#line 1 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/MP3_driver.c"
#line 1 "c:/users/public/documents/mikroelektronika/mikroc pro for arm/include/built_in.h"
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
#line 35 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/MP3_driver.c"
sbit MP3_CS at GPIO_PORTF_DATA.B1;
sbit MP3_RST at GPIO_PORTF_DATA.B5;
sbit XDCS at GPIO_PORTF_DATA.B0;
sbit DREQ at GPIO_PORTF_DATA.B4;

sbit MP3_CS_Direction at GPIO_PORTF_DIR.B1;
sbit MP3_RST_Direction at GPIO_PORTF_DIR.B5;
sbit XDCS_Direction at GPIO_PORTF_DIR.B0;
sbit DREQ_Direction at GPIO_PORTF_DIR.B4;


const char WRITE_CODE = 0x02;
const char READ_CODE = 0x03;

const char SCI_BASE_ADDR = 0x00;
const char SCI_MODE_ADDR = 0x00;
const char SCI_STATUS_ADDR = 0x01;
const char SCI_BASS_ADDR = 0x02;
const char SCI_CLOCKF_ADDR = 0x03;
const char SCI_DECODE_TIME_ADDR = 0x04;
const char SCI_AUDATA_ADDR = 0x05;
const char SCI_WRAM_ADDR = 0x06;
const char SCI_WRAMADDR_ADDR = 0x07;
const char SCI_HDAT0_ADDR = 0x08;
const char SCI_HDAT1_ADDR = 0x09;
const char SCI_AIADDR_ADDR = 0x0A;
const char SCI_VOL_ADDR = 0x0B;
const char SCI_AICTRL0_ADDR = 0x0C;
const char SCI_AICTRL1_ADDR = 0x0D;
const char SCI_AICTRL2_ADDR = 0x0E;
const char SCI_AICTRL3_ADDR = 0x0F;

const int MP3_para_endFillByte = 0x1E06;
#line 78 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/MP3_driver.c"
void MP3_SCI_Write(char address, unsigned int data_in) {
 XDCS = 1;

 MP3_CS = 0;
 SPI0_Write(WRITE_CODE);
 SPI0_Write(address);
 SPI0_Write( ((char *)&data_in)[1] );
 SPI0_Write( ((char *)&data_in)[0] );
 MP3_CS = 1;
 while (DREQ == 0);
}
#line 97 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/MP3_driver.c"
void MP3_SCI_Read(char start_address, char words_count, unsigned int *data_buffer) {
 unsigned int temp;

 MP3_CS = 0;
 SPI0_Write(READ_CODE);
 SPI0_Write(start_address);

 while (words_count--) {
 temp = SPI0_Read(0);
 temp <<= 8;
 temp += SPI0_Read(0);
 *(data_buffer++) = temp;
 }
 MP3_CS = 1;
 while (DREQ == 0);
}

unsigned int MP3_SCI_ReadSingle(char address) {
 unsigned int temp;

 MP3_CS = 0;
 while (DREQ == 0);
 SPI0_Write(READ_CODE);
 SPI0_Write(address);

 temp = SPI0_Read(0);
 temp <<= 8;
 temp += SPI0_Read(0);

 MP3_CS = 1;
 return temp;
}
#line 137 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/MP3_driver.c"
void MP3_SDI_Write(char data_) {

 MP3_CS = 1;
 XDCS = 0;

 while (DREQ == 0);

 SPI0_Write(data_);
 XDCS = 1;
}
#line 155 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/MP3_driver.c"
void MP3_SDI_Write_32(char *data_) {
 char i;

 MP3_CS = 1;
 XDCS = 0;

 while (DREQ == 0);

 for (i=0; i<32; i++)
 SPI0_Write(data_[i]);

 XDCS = 1;
}
#line 176 "C:/TKJ Electronics/Projects/B5-Multimedia_Streaming/mikroC projects/Multimedia_Client/MP3_driver.c"
void MP3_Set_Volume(char left, char right) {
 unsigned int volume;

 volume = (left<<8) + right;
 MP3_SCI_Write(SCI_VOL_ADDR, volume);
}


unsigned int MP3_wram_read(unsigned int address) {
 unsigned int tmp1,tmp2;
 MP3_SCI_Write(SCI_WRAMADDR_ADDR,address);
 tmp1=MP3_SCI_ReadSingle(SCI_WRAM_ADDR);
 MP3_SCI_Write(SCI_WRAMADDR_ADDR,address);
 tmp2=MP3_SCI_ReadSingle(SCI_WRAM_ADDR);
 if (tmp1==tmp2) return tmp1;
 MP3_SCI_Write(SCI_WRAMADDR_ADDR,address);
 tmp1=MP3_SCI_ReadSingle(SCI_WRAM_ADDR);
 if (tmp1==tmp2) return tmp1;
 MP3_SCI_Write(SCI_WRAMADDR_ADDR,address);
 tmp1=MP3_SCI_ReadSingle(SCI_WRAM_ADDR);
 if (tmp1==tmp2) return tmp1;
 return tmp1;
}

void MP3_wram_write(unsigned int address, unsigned int writeData) {
 MP3_SCI_Write(SCI_WRAMADDR_ADDR, address);
 MP3_SCI_Write(SCI_WRAM_ADDR, writeData);
 return;
}
