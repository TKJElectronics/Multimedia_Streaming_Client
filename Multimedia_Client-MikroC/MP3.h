// Global Variables
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