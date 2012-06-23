#include "Ethernet_Handlers.h"
#include "MP3.h"
#include "UserInterface.h"

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

unsigned char ipAddr[4];  // user IP address buffer
unsigned char stringBuffer[50];

bit DownloadMode; // 0 == Buffered playback, 1 == Saved playback (SD)
unsigned char AudioBuffer1[1480];
unsigned char AudioBuffer2[1480];
bit CurrentBuffer; // CurrentBuffer = 1 - AudioBuffer1 is being used
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
    Ethernet_Intern_userTimerSec++ ;  // increment ethernet library counter
    //GPIO_PORTA_DATA7_bit = ~GPIO_PORTA_DATA7_bit;
    if (CountdownTimer > 0) CountdownTimer--;
    //GlobalSecondsCounter += 1; // Disabled for optimization - not used anywhere in the code
}

void SysTick_interrupt() iv IVT_FAULT_SYSTICK {
       presTmr++;

       if (((presTmr % 3) > 0) && (halfSecondCountdownTimer > 0)) halfSecondCountdownTimer--;
       if(presTmr == 6)                   // overflows 20 times per second
         {
           //SecondsInterrupt();
             if (CountdownTimer > 0) CountdownTimer--;
             Ethernet_Intern_userTimerSec++ ;  // increment ethernet library counter
           presTmr = 0;                  // reset prescaler
         }
}

void main() {
     UI_Setup();
     
     CountdownTimer = 5;
     FetchCID = 1;
     GPIO_Digital_Output(&GPIO_PORTA, _GPIO_PINMASK_ALL);
       
     /* Setup Systick */     // The clicks in the sound is caused by the SysTick, interrupting the Audio transmitting process! So to get rid of theese, the SysTick should be optimized
     NVIC_ST_RELOAD = ((Get_Fosc_kHz() * 1000) / 6) - 1;
     NVIC_ST_CTRL_CLK_SRC_bit = 1;
     NVIC_ST_CTRL_ENABLE_bit = 1;
     NVIC_IntEnable(IVT_FAULT_SYSTICK); // enable interrupt vector
     NVIC_ST_CTRL_INTEN_bit = 1;
     NVIC_SYS_PRI3 |= 0x00FF0000;
     EnableInterrupts();              // enable MCU core interrupts

     UART0_Init(115200);              // Initialize UART module at 56000 bps
     Delay_ms(100);                  // Wait for UART module to stabilize

     UART0_Write(13);
     UART0_Write(10);
     UART0_Write_Text("Start");
     UART0_Write(13);
     UART0_Write(10);
     
     MP3_Start();

     // Enable ethernet LED signal on PF3 and PF2.
     GPIO_Config(&GPIO_PORTF, _GPIO_PINMASK_2 | _GPIO_PINMASK_3, _GPIO_DIR_NO_CHANGE, _GPIO_CFG_ALT_FUNCTION | _GPIO_CFG_DRIVE_8mA | _GPIO_CFG_DIGITAL_ENABLE, _GPIO_PINCODE_1);
     Ethernet_Intern_Init(myMacAddr, myIpAddr, _ETHERNET_AUTO_NEGOTIATION);
     //Ethernet_Intern_confNetwork(ipMask, gwIpAddr, dnsIpAddr); // Static IP
     //DHCP Disabled
     Delay_ms(2000);
     DHCP_Finished = 1;
     while (DHCP_Finished != 0) {
        DHCP_Finished = Ethernet_Intern_initDHCP(5);
     }
     
     UART0_Write_Text("DHCP IP: ");

     memcpy(ipAddr, Ethernet_Intern_getIpAddress(), 4); // fetch IP address
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
       Ethernet_Intern_doPacket();   // process incoming Ethernet packets
       if (CountdownTimer == 0)
       {
           UDPTransmitBuffer[0] = 0xFF;
           UDPTransmitBuffer[1] = 0x01; // Ping reply
           UDPTransmitBuffer[2] = 0; // Data length = 4
           UDPTransmitBuffer[3] = 4; // Data length = 4
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
      Ethernet_Intern_doPacket();   // process incoming Ethernet packets
      if (CountdownTimer == 0)  {
          RequestRootFolder();
          CountdownTimer = 15;
      }
      KeepAlive_Handler(); // Make sure downloading and other things is kept alive and not stopped/paused not on purpose
      delay_ms(10);
    }
    while (CurrentState != IDLE);
    
    DownloadMode = 0;
    
     while(1)
     {
              if(Ethernet_Intern_doDHCPLeaseTime())
                Ethernet_Intern_renewDHCP(5); // it's time to renew the IP address lease, with 5 secs for a reply
              Ethernet_Intern_doPacket();   // process incoming Ethernet packets
              //Audio_Handler(); only for multi-buffer usage - currently not fully implemented
              UI_Handler();
              KeepAlive_Handler(); // Make sure downloading and other things is kept alive and not stopped/paused not on purpose

              // read data if ready
              if (UART0_Data_Ready())
              {
                 serialReceive = UART0_Read();
                 
                 switch (serialReceive) {
                        case 'c':
                          UART0_Write_Text("Check communication");
                          UART0_Write(13);
                          UART0_Write(10);
                          UDPTransmitBuffer[0] = 0xFF; // Empty CID (Request for new CID)
                          UDPTransmitBuffer[1] = 0x01; // Check communication (request CID) command
                          UDPTransmitBuffer[2] = 4; // Data length
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

/*
void Audio_Handler()
{
   if (CurrentState == FILE_RECEIVE) {
      if (CurrentBuffer) { // CurrentBuffer = 1 - AudioBuffer1 is being used
         if (CurrentBufferPos < CurrentBuffer1MaxPos) {
            MP3_SDI_Write_32(AudioBuffer1 + CurrentBufferPos);
            CurrentBufferPos += 32;
            //if ((CurrentBufferPos <= ((CurrentBuffer1MaxPos/2)+16)) && (CurrentBufferPos > ((CurrentBuffer1MaxPos/2)-16)) && (ReceivingCurrentPackage <= ReceivingDividedPackages)) {
            if (CurrentBufferPos == 128)
               RequestNextAudioPackage();
         } else {
            if (CurrentBuffer2MaxPos > 0) {
               CurrentBuffer = 0; // Switch buffer
               CurrentBuffer1MaxPos = 0; // Reset previous buffer
               MP3_SDI_Write_32(AudioBuffer2);  // Write first 32 bytes from buffer
               CurrentBufferPos = 32; // Set pos according to that
            }
         }
      } else {
         if (CurrentBufferPos < CurrentBuffer2MaxPos) {
            MP3_SDI_Write_32(AudioBuffer2 + CurrentBufferPos);
            CurrentBufferPos += 32;
            //if ((CurrentBufferPos <= ((CurrentBuffer2MaxPos/2)+16)) && (CurrentBufferPos > ((CurrentBuffer2MaxPos/2)-16)) && (ReceivingCurrentPackage <= ReceivingDividedPackages)) {
            if (CurrentBufferPos == 128)
               RequestNextAudioPackage();
         } else {
            if (CurrentBuffer1MaxPos > 0) {
               CurrentBuffer = 1; // Switch buffer
               CurrentBuffer2MaxPos = 0; // Reset previous buffer
               MP3_SDI_Write_32(AudioBuffer1);  // Write first 32 bytes from buffer
               CurrentBufferPos = 32; // Set pos according to that
            }
         }
      }
   }
} */


void ReLeaseCID()
{
  UDPTransmitBuffer[0] = 0xFF;
  UDPTransmitBuffer[1] = 0x01; // Ping reply
  UDPTransmitBuffer[2] = 0; // Data length = 4
  UDPTransmitBuffer[3] = 4; // Data length = 4
  UDPTransmitBuffer[4] = UniqueDeviceID[0];
  UDPTransmitBuffer[5] = UniqueDeviceID[1];
  UDPTransmitBuffer[6] = UniqueDeviceID[2];
  UDPTransmitBuffer[7] = UniqueDeviceID[3];
  UDPTransmitBuffer[8] = Calculate_Checksum(&UDPTransmitBuffer, 8);
  Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 9);
  CountdownTimer = 5;
  FetchCID = 1;
}