/**************************************************************************************************
* File: MP3_driver.h
* File Type: C - Header File
* Project Name: BrmBrrrrm
* Company: (c) mikroElektronika, 2011
* Revision History:
*     20111118:
*       - modified for mikroMedia for XMEGA HW revision 1.10 (JK);
* Description:
*     This module contains a set of functions that are used for communication with
*     VS1053E mp3 codec.
*       MCU:             ATxmega128A1
*                        http://www.atmel.com/dyn/resources/prod_documents/doc8067.pdf
*       Dev.Board:       Mikromedia_for_XMEGA
*                        http://www.mikroe.com/eng/products/view/688/mikromedia-for-xmega/
*       Oscillator:      Internal Clock, 32.0000 MHz
*       SW:              mikroC PRO for AVR
*                        http://www.mikroe.com/eng/products/view/228/mikroc-pro-for-avr/
* NOTES:
*     Mp3 codec use SPI bus to communicate with MCU.
**************************************************************************************************/

/**************************************************************************************************
* CODEC V1053E connections
**************************************************************************************************/
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

//SCI_MODE register bits as of p.38 of the datasheet
#define SM_DIFF                                     0x0001
#define SM_LAYER12                                  0x0002
#define SM_RESET                                    0x0004
#define SM_CANCEL                                   0x0008
#define SM_EARSPEAKER_LO                            0x0010
#define SM_TESTS                                    0x0020
#define SM_STREAM                                   0x0040
#define SM_EARSPEAKER_HI                            0x0080
#define SM_DACT                                     0x0100
#define SM_SDIORD                                   0x0200
#define SM_SDISHARE                                 0x0400
#define SM_SDINEW                                   0x0800
#define SM_ADPCM                                    0x1000
#define SM_B13                                      0x2000
#define SM_LINE1                                    0x4000
#define SM_CLK_RANGE                                0x8000

// Writes one byte to MP3 SCI
void MP3_SCI_Write(char address, unsigned int data_in);
// Reads words_count words from MP3 SCI
void MP3_SCI_Read(char start_address, char words_count, unsigned int *data_buffer);
unsigned int MP3_SCI_ReadSingle(char address);
// Write one byte to MP3 SDI
void MP3_SDI_Write(char data_);
// Write 32 bytes to MP3 SDI
void MP3_SDI_Write_32(char *data_);
// Set volume
void MP3_Set_Volume(char left, char right);

unsigned int MP3_wram_read(unsigned int address);
void MP3_wram_write(unsigned int address, unsigned int writeData);

/**************************************************************************************************
* End of File
**************************************************************************************************/