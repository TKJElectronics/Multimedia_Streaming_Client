#include "__Lib_FAT32.h"
#include "MP3.h"
#include "MP3_driver.h"

/**************************************************************************************************
* MMC Chip Select connection
**************************************************************************************************/
sbit Mmc_Chip_Select_Direction at GPIO_PORTA_DIR7_bit;
sbit Mmc_Chip_Select           at GPIO_PORTA_DATA7_bit;

// Global Variables
const BYTES_2_WRITE = 32;
char volume_left, volume_right;

/**************************************************************************************************
* Function MC3_Init()
* -------------------------------------------------------------------------------------------------
* Overview: Function Initialize MP3 VS1053B codec
* Input: Nothing
* Output: Nothing
**************************************************************************************************/

void MP3_Init(void)
{
  XDCS = 1;
  MP3_CS = 1;

  // Hardware reset
  MP3_RST = 0;
  Delay_ms(10);
  MP3_RST = 1;

  while (DREQ == 0);

  MP3_SCI_Write(SCI_MODE_ADDR, 0x0800);
  MP3_SCI_Write(SCI_BASS_ADDR, 0x7A00);
  //MP3_SCI_Write(SCI_CLOCKF_ADDR, 0xF800);   // default 12 288 000 Hz
  MP3_SCI_Write(SCI_CLOCKF_ADDR, 0x2000);   // default 12 288 000 Hz

  // Maximum volume is 0x00 and total silence is 0xFE.
  volume_left  = 0; //0x3F;
  volume_right = 0; //0x3F;
  MP3_Set_Volume(volume_left, volume_right);
}

void MP3_Reset(void)
{
  MP3_RST           = 1;               // Set MP3_RST pin
  SPI0_Init_Advanced(400000,
                       _SPI_MASTER,
                       _SPI_8_BIT | _SPI_CLK_IDLE_HIGH | _SPI_SECOND_CLK_EDGE_TRANSITION,
                       &_GPIO_MODULE_SPI0_A245);
                       
  XDCS = 1;
  MP3_CS = 1;

  // Hardware reset
  MP3_RST = 0;
  Delay_ms(10);
  MP3_RST = 1;
  while (DREQ == 0);

  MP3_SCI_Write(SCI_MODE_ADDR, 0x0800);
  MP3_SCI_Write(SCI_BASS_ADDR, 0x7A00);
  MP3_SCI_Write(SCI_CLOCKF_ADDR, 0x2000);   // default 12 288 000 Hz

  volume_left  = 0; //0x3F;
  volume_right = 0; //0x3F;
  MP3_Set_Volume(volume_left, volume_right);
}

/**************************************************************************************************
* Function MP3_Start()
* -------------------------------------------------------------------------------------------------
* Overview: Function Initialize SPI to communicate with MP3 codec
* Input: Nothing
* Output: Nothing
**************************************************************************************************/
void MP3_Start(void)
{
  // SPI config
  GPIO_Digital_Output(&GPIO_PORTA, _GPIO_PINMASK_7);

  // MP3 config
  GPIO_Digital_Output(&GPIO_PORTF, _GPIO_PINMASK_5);
  GPIO_Digital_Input (&GPIO_PORTF, _GPIO_PINMASK_4);
  GPIO_Digital_Output(&GPIO_PORTF, _GPIO_PINMASK_0);
  GPIO_Digital_Output(&GPIO_PORTF, _GPIO_PINMASK_1);

  MP3_CS_Direction  = 1;               // Configure MP3_CS as output
  MP3_CS            = 1;               // Deselect MP3_CS
  MP3_RST_Direction = 1;               // Configure MP3_RST as output
  MP3_RST           = 1;               // Set MP3_RST pin

  DREQ_Direction    = 0;               // Configure DREQ as input
  XDCS_Direction   = 1;               // Configure XDCS as output
  XDCS             = 0;               // Clear XDCS
  XDCS             = 1;               // Clear XDCS

  // Initialize SPIC module
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
    //DEBUGOUT("VS1053b: Song terminating..\r\n");
    // send at least 2052 bytes of endFillByte[7:0].
    // read endFillByte  (0 .. 15) from wram
    endFillByte = MP3_wram_read(MP3_para_endFillByte);
    // clear endFillByte (8 .. 15)
    endFillByte = endFillByte ^ 0x00FF;
    for (n = 0; n < 2052; n++)
        MP3_SDI_Write(endFillByte);

    // set SCI MODE bit SM CANCEL
    sciModeByte = MP3_SCI_ReadSingle(SCI_MODE_ADDR);
    sciModeByte |= SM_CANCEL;
    MP3_SCI_Write(SCI_MODE_ADDR, sciModeByte);

    // send up 2048 bytes of endFillByte[7:0].
    for (i = 0; i < 64; i++)
    {
        // send at least 32 bytes of endFillByte[7:0]
        for (n = 0; n < 32; n++)
            MP3_SDI_Write(endFillByte);
        // read SCI MODE; if SM CANCEL is still set, repeat
        sciModeByte = MP3_SCI_ReadSingle(SCI_MODE_ADDR);
        if ((sciModeByte & SM_CANCEL) == 0x0000)
        {
            break;
        }
    }

    if ((sciModeByte & SM_CANCEL) == 0x0000)
    {
        //DEBUGOUT("VS1053b: Song sucessfully sent. Terminating OK\r\n");
        //DEBUGOUT("VS1053b: SCI MODE = %#x, SM_CANCEL = %#x\r\n", sciModeByte, sciModeByte & SM_CANCEL);
        UART0_Write_Text("Song sucessfully sent. Terminating OK");
        UART0_Write(13);
        UART0_Write(10);
        MP3_SCI_Write(SCI_DECODE_TIME_ADDR, 0x0000);
    }
    else
    {
        //DEBUGOUT("VS1053b: SM CANCEL hasn't cleared after sending 2048 bytes, do software reset\r\n");
        //DEBUGOUT("VS1053b: SCI MODE = %#x, SM_CANCEL = %#x\r\n", sciModeByte, sciModeByte & SM_CANCEL);
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
    // set SCI MODE bit SM CANCEL
    unsigned short sciModeByte;
    sciModeByte = MP3_SCI_ReadSingle(SCI_MODE_ADDR);
    sciModeByte |= SM_CANCEL;
    MP3_SCI_Write(SCI_MODE_ADDR, sciModeByte);

    // send up 2048 bytes of audio data.
    while ((readyToBreak == 0) || (readyToBreak == 1 && CurrentBuffer == firstBuffer))
    {
        Ethernet_Intern_doPacket();   // process incoming Ethernet packets
        // read SCI MODE; if SM CANCEL is still set, repeat
        sciModeByte = MP3_SCI_ReadSingle(SCI_MODE_ADDR);
        if ((sciModeByte & SM_CANCEL) == 0x0000)
        {
            break;
        }
        if (CurrentBuffer != firstBuffer) readyToBreak = 1;
    }

    if ((sciModeByte & SM_CANCEL) == 0x0000)
    {
        // send at least 2052 bytes of endFillByte[7:0].
        // read endFillByte  (0 .. 15) from wram
        endFillByte = MP3_wram_read(MP3_para_endFillByte);
        // clear endFillByte (8 .. 15)
        endFillByte = endFillByte ^0x00FF;
        for (n = 0; n < 2052; n++)
            MP3_SDI_Write(endFillByte);
        //DEBUGOUT("VS1053b: Song sucessfully stopped.\r\n");
        //DEBUGOUT("VS1053b: SCI MODE = %#x, SM_CANCEL = %#x\r\n", sciModeByte, sciModeByte & SM_CANCEL);
        UART0_Write_Text("Song sucessfully stopped.");
        UART0_Write(13);
        UART0_Write(10);
        MP3_SCI_Write(SCI_DECODE_TIME_ADDR, 0x0000);
    }
    else
    {
        //DEBUGOUT("VS1053b: SM CANCEL hasn't cleared after sending 2048 bytes, do software reset\r\n");
        //DEBUGOUT("VS1053b: SCI MODE = %#x, SM_CANCEL = %#x\r\n", sciModeByte, sciModeByte & SM_CANCEL);
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
    ///////////////////////////////////////
    //  SPI module initialization
    ///////////////////////////////////////
        SPI0_Init_Advanced(400000,
                       _SPI_MASTER,
                       _SPI_8_BIT | _SPI_CLK_IDLE_HIGH | _SPI_SECOND_CLK_EDGE_TRANSITION,
                       &_GPIO_MODULE_SPI0_A245);

    SDSave_Disabled = 0;
    ///////////////////////////////////////
    //  initialize storage device.
    //  optionally, we could format the device
    //  instead of just initializing it.
    ///////////////////////////////////////
    err = FAT32_Init();
    //err = FAT32_format("dev0");
    if (err < 0)        //
    {
        while(err < 0 && ErrCount < 5)  //  ...retry each half second
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


/*
unsigned long file_size;
const BUFFER_SIZE = 512;
char mp3_buffer[BUFFER_SIZE];

void MP3_Test(void) // SD card should be inserted
{
  __HANDLE fileHandle;
  signed char err;
  unsigned long i;

  fileHandle = FAT32_Open("enya.mp3", FILE_READ);
  if (fileHandle == 0) {
      FAT32_Size("enya.mp3", &file_size); // Call Reset before file reading,
                                          //   procedure returns size of the file
      // send file blocks to MP3 SDI
      while (file_size > BUFFER_SIZE)
      {
        FAT32_Read(fileHandle, mp3_buffer, BUFFER_SIZE);
        for (i=0; i<BUFFER_SIZE/BYTES_2_WRITE; i++) {
          MP3_SDI_Write_32(mp3_buffer + i*BYTES_2_WRITE);
        }

        file_size -= BUFFER_SIZE;
     }

      // send the rest of the file to MP3 SDI
      FAT32_Read(fileHandle, mp3_buffer, file_size);

      for (i=0; i<file_size; i++)
      {
        MP3_SDI_Write(mp3_buffer[i]);
      }

      err = FAT32_Close(fileHandle);
  }
}  */