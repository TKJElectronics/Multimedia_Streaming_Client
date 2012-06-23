#define _ETHERNET_LED_LINK_OK                    0
#define _ETHERNET_LED_RXTX_ACTIVITY              1
#define _ETHERNET_LED_100BASE_TX                 5
#define _ETHERNET_LED_10BASE_T                   6
#define _ETHERNET_LED_FULL_DUPLEX                7
#define _ETHERNET_LED_LINK_OK_AND_RXTX_ACTIVITY  8


#define _ETHERNET_MULTICAST   0b1
#define _ETHERNET_CRC         0b10

#define _ETHERNET_HALFDUPLEX   0b1
#define _ETHERNET_FULLDUPLEX   0b10
#define _ETHERNET_SPD10        0b100
#define _ETHERNET_SPD100       0b1000
#define _ETHERNET_AUTO_NEGOTIATION    0b10000
#define _ETHERNET_MANUAL_NEGOTIATION  0b100000

// PHY Register Offsets
#define _PHY_REG_CONTROL_MR0  0
#define _PHY_REG_STATUS_MR1   0x1
#define _PHY_REG_IDENTIFIER_1_MR2   0x2
#define _PHY_REG_IDENTIFIER_2_MR3   0x3
#define _PHY_REG_AUTO_NEG_ADVERTISEMENT_MR4   0x4
#define _PHY_REG_AUTO_NEG_PAGE_ABILITY_MR5   0x5
#define _PHY_REG_AUTO_NEG_EXPANSION_MR6   0x6
#define _PHY_REG_VENDOR_SPECIFIC_MR16   0x10
#define _PHY_REG_MODE_CONTROL_STATUS_MR17   0x11
#define _PHY_REG_SPECIAL_CONTROL_STATUS_MR27   0x1B
#define _PHY_REG_INTERRUPT_STATUS_MR29   0x1D
#define _PHY_REG_INTERRUPT_MASK30   0x1E
#define _PHY_REG_SPECIAL_CONTROL_STATUS_MR31   0x1F

#define NO_ADDR 0xFFFF

/*
 * library globals
 */
typedef struct {
    unsigned char valid; // valid/invalid entry flag
    unsigned long tmr; // timestamp
    unsigned char ip[4]; // IP address
    unsigned char mac[6]; // MAC address behind the IP address
} Ethernet_Intern_arpCacheStruct;

extern Ethernet_Intern_arpCacheStruct Ethernet_Intern_arpCache[]; // ARP cash, 3 entries max

extern unsigned char Ethernet_Intern_macAddr[6]; // MAC address of the controller
extern unsigned char Ethernet_Intern_ipAddr[4]; // IP address of the device
extern unsigned char Ethernet_Intern_gwIpAddr[4]; // GW
extern unsigned char Ethernet_Intern_ipMask[4]; // network mask
extern unsigned char Ethernet_Intern_dnsIpAddr[4]; // DNS serveur IP
extern unsigned char Ethernet_Intern_rmtIpAddr[4]; // remote IP Address of host (DNS server reply)

extern unsigned long Ethernet_Intern_userTimerSec; // must be incremented by user 1 time per second

typedef struct {
    unsigned canCloseTCP : 1;
    unsigned isBroadcast : 1;
} TEthInternPktFlags;

/*
 * prototypes for public functions
 */
//extern  void            Ethernet_Intern_Init(unsigned char *resetPort, unsigned char resetBit, unsigned char *CSport, unsigned char CSbit, unsigned char *mac, unsigned char *ip, unsigned char fullDuplex);
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


extern unsigned char   myMacAddr[6];
extern unsigned char   myIpAddr[4];
extern unsigned char   gwIpAddr[4];
extern unsigned char   ipMask[4];
extern unsigned char   dnsIpAddr[4];

//extern const unsigned char   UniqueDeviceID[4];
extern unsigned char  *UniqueDeviceID;
extern const unsigned int    localClientPort;
extern const unsigned char   serverIpAddr[4];
extern const unsigned int    serverPort;

/* 
 * Own function prototypes
 */
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

/* Div. variables */
extern unsigned char UDPTransmitBuffer[30];
extern unsigned char DeviceCID;
extern MultimediaState CurrentState;
extern unsigned char CurrentFolderID;
extern unsigned char CurrentFolderName[31];
extern unsigned char PreviousFolderID;
extern unsigned char FolderFileRequestIDCount;
extern unsigned char FoldersFilesToReceive; // Folder count to receive

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

/* Div. variables end */
 
unsigned int  Ethernet_Intern_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags *flags);
unsigned int  Ethernet_Intern_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags *flags);
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