/**************************************************************************************************
* File: MP3_driver.c
* File Type: C - Source Code File
* (C) mikroElektronika, 2010-2011
* Revision History:
*  - Initial version
* Description:
*     This project demonstrates communication with VS1053B mp3 codec.
*     Program reads one mp3 file from MMC and sends it to VS1053B for decoding
*     and playing.
*     MMC and MP3_SCI share Hardware SPI module.
* Test configuration:
*      MCU:              LM3S9b95
                         http://www.ti.com/lit/ds/symlink/lm3s9b95.pdf
       dev.board:        EasyMx v7 for STELLARIS(R) ARM(R)
                         http://www.mikroe.com/eng/products/view/792/easymx-pro-v7-for-stellaris-arm/
                         ac:tft_touchpanel

*       Modules:         MP3 VS1053B on-board module
*                        
*       Oscillator:      Internal Clock, 80.0000 MHz
*       SW:              mikroC PRO for ARM
*                        http://www.mikroe.com/eng/products/view/228/mikroc-pro-for-arm/
* NOTES:
*     - Make sure that MMC card is properly formatted (to FAT16 or just FAT)
*       before testing it on this example.
*     - Make sure that MMC card contains appropriate mp3 file ( sound.mp3 ).
**************************************************************************************************/
#include <built_in.h>
#include "MP3_driver.h"

/**************************************************************************************************
* CODEC V1053E connections
**************************************************************************************************/
sbit MP3_CS                    at GPIO_PORTF_DATA.B1;
sbit MP3_RST                   at GPIO_PORTF_DATA.B5;
sbit XDCS                     at GPIO_PORTF_DATA.B0;
sbit DREQ                      at GPIO_PORTF_DATA.B4;

sbit MP3_CS_Direction          at GPIO_PORTF_DIR.B1;
sbit MP3_RST_Direction         at GPIO_PORTF_DIR.B5;
sbit XDCS_Direction           at GPIO_PORTF_DIR.B0;
sbit DREQ_Direction            at GPIO_PORTF_DIR.B4;

// VS1053E constants
const char WRITE_CODE           = 0x02;
const char READ_CODE            = 0x03;

const char SCI_BASE_ADDR        = 0x00;
const char SCI_MODE_ADDR        = 0x00;
const char SCI_STATUS_ADDR      = 0x01;
const char SCI_BASS_ADDR        = 0x02;
const char SCI_CLOCKF_ADDR      = 0x03;
const char SCI_DECODE_TIME_ADDR = 0x04;
const char SCI_AUDATA_ADDR      = 0x05;
const char SCI_WRAM_ADDR        = 0x06;
const char SCI_WRAMADDR_ADDR    = 0x07;
const char SCI_HDAT0_ADDR       = 0x08;
const char SCI_HDAT1_ADDR       = 0x09;
const char SCI_AIADDR_ADDR      = 0x0A;
const char SCI_VOL_ADDR         = 0x0B;
const char SCI_AICTRL0_ADDR     = 0x0C;
const char SCI_AICTRL1_ADDR     = 0x0D;
const char SCI_AICTRL2_ADDR     = 0x0E;
const char SCI_AICTRL3_ADDR     = 0x0F;

const int MP3_para_endFillByte = 0x1E06;



/**************************************************************************************************
* Function MP3_SCI_Write()
* -------------------------------------------------------------------------------------------------
* Overview: Function writes one byte to MP3 SCI
* Input: register address in codec, data
* Output: Nothing
**************************************************************************************************/
void MP3_SCI_Write(char address, unsigned int data_in) {
  XDCS = 1;

  MP3_CS = 0;                    // select MP3 SCI
  SPI0_Write(WRITE_CODE);
  SPI0_Write(address);
  SPI0_Write(Hi(data_in));       // high byte
  SPI0_Write(Lo(data_in));       // low byte
  MP3_CS = 1;                    // deselect MP3 SCI
  while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
}

/**************************************************************************************************
* Function MP3_SCI_Read()
* -------------------------------------------------------------------------------------------------
* Overview: Function reads words_count words from MP3 SCI
* Input: start address, word count to be read
* Output: words are stored to data_buffer
**************************************************************************************************/
void MP3_SCI_Read(char start_address, char words_count, unsigned int *data_buffer) {
  unsigned int temp;

  MP3_CS = 0;                    // select MP3 SCI
  SPI0_Write(READ_CODE);
  SPI0_Write(start_address);

  while (words_count--) {        // read words_count words byte per byte
    temp = SPI0_Read(0);
    temp <<= 8;
    temp += SPI0_Read(0);
    *(data_buffer++) = temp;
  }
  MP3_CS = 1;                    // deselect MP3 SCI
  while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
}

unsigned int MP3_SCI_ReadSingle(char address) {
  unsigned int temp;

  MP3_CS = 0;                    // select MP3 SCI
  while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI
  SPI0_Write(READ_CODE);
  SPI0_Write(address);

  temp = SPI0_Read(0);
  temp <<= 8;
  temp += SPI0_Read(0);

  MP3_CS = 1;                    // deselect MP3 SCI
  return temp;
}

/**************************************************************************************************
* Function MP3_SDI_Write()
* -------------------------------------------------------------------------------------------------
* Overview: Function write one byte to MP3 SDI
* Input: data to be writed
* Output: Nothing
**************************************************************************************************/
void MP3_SDI_Write(char data_) {

  MP3_CS = 1;
  XDCS = 0;

  while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI

  SPI0_Write(data_);
  XDCS = 1;
}

/**************************************************************************************************
* Function MP3_SDI_Write_32
* -------------------------------------------------------------------------------------------------
* Overview: Function Write 32 bytes to MP3 SDI
* Input: data buffer
* Output: Nothing
**************************************************************************************************/
void MP3_SDI_Write_32(char *data_) {
  char i;

  MP3_CS = 1;
  XDCS = 0;

  while (DREQ == 0);             // wait until DREQ becomes 1, see MP3 codec datasheet, Serial Protocol for SCI

  for (i=0; i<32; i++)
     SPI0_Write(data_[i]);
     
  XDCS = 1;
}

/**************************************************************************************************
* Function MP3_Set_Volume()
* -------------------------------------------------------------------------------------------------
* Overview: Function set volume on the left and right channel
* Input: left channel volume, right channel volume
* Output: Nothing
**************************************************************************************************/
void MP3_Set_Volume(char left, char right) {
  unsigned int volume;

  volume = (left<<8) + right;             // calculate value
  MP3_SCI_Write(SCI_VOL_ADDR, volume);    // Write value to VOL register
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

/**************************************************************************************************
* End of File
**************************************************************************************************/