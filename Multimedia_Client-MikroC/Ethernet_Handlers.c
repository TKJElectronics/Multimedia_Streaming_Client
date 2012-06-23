#include "__Lib_FAT32.h"
#include "Ethernet_Handlers.h"
#include "MP3.h"
#include "UserInterface.h"

#define DEBUGGING_ENABLED

unsigned char   myMacAddr[6] = {0x32, 0x14, 0xA5, 0x76, 0x19, 0x3f};   // my MAC address
unsigned char   myIpAddr[4]  = {192, 168,  0, 140 };                   // my IP address
unsigned char   gwIpAddr[4]  = {192, 168,  0, 1 };                   // gateway (router) IP address
unsigned char   ipMask[4]    = {255, 255, 255,  0 };                   // network mask (for example : 255.255.255.0)
unsigned char   dnsIpAddr[4] = {192, 168,  0,  1 };                   // DNS server IP address

unsigned char  *UniqueDeviceID = &myMacAddr[2]; //&SYSCTL_DID0;
const unsigned int    localClientPort  = 1111;
const unsigned char   serverIpAddr[4]  = {192, 168, 0, 50};  // remote IP address
const unsigned int    serverPort   = 1111;

const code unsigned char httpHeader[] = "HTTP/1.1 200 OK\nContent-type: ";  // HTTP header
const code unsigned char httpMimeTypeHTML[] = "text/html\n\n";              // HTML MIME type
const code unsigned char webpageContent[] = "<h1>It works!</h1>";              // HTML MIME type

/* Div. variables */
unsigned char UDPTransmitBuffer[30];
unsigned char DeviceCID = 0xFF; // Init CID
MultimediaState CurrentState = IDLE;
unsigned char FolderFileRequestIDCount; // Increasing when folders/files are requested (request next package)
unsigned char FoldersFilesToReceive; // Folders/files count to receive

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

/* Div. variables end */

 /*
 * this function is called by the library
 * the user accesses to the TCP request by call Ethernet_Intern_readPayloadBytes
 * the user puts data in the transmit buffer by successive calls to Ethernet_Intern_writePayloadByte()
 * the function must return the length in bytes of the UDP reply, or 0 if nothing to transmit
 *
 * if you don't need to reply to HTTP requests,
 * just define this function with a return(0) as single statement
 *
 */
unsigned int    Ethernet_Intern_UserTCP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags *flags)
{
     unsigned int  offset = 0;     // possition in payload buffer
     offset += Ethernet_Intern_writePayloadString(httpHeader, offset);            // HTTP header
     offset += Ethernet_Intern_writePayloadString(httpMimeTypeHTML, offset);   // with text MIME type
     offset += Ethernet_Intern_writePayloadString(webpageContent, offset);   // write HTML test content
     return (offset);
}


/*
 * this function is called by the library
 * the user accesses to the UDP request by call Ethernet_Intern_readPayloadBytes
 * the user puts data in the transmit buffer by successive calls to Ethernet_Intern_writePayloadByte()
 * the function must return the length in bytes of the UDP reply, or 0 if nothing to transmit
 *
 * if you don't need to reply to UDP requests,
 * just define this function with a return(0) as single statement
 *
 */
unsigned int    Ethernet_Intern_UserUDP(unsigned char *remoteHost, unsigned int remotePort, unsigned int localPort, unsigned int reqLength, TEthInternPktFlags *flags)
{
     unsigned char receiveBuffer[1480];                 // we want receive packet with payload up to 20 bytes
     unsigned char sendLength = 0;
     unsigned char CID, CMD;
     unsigned int DataLength;
     unsigned int tempI, tempI2;
     
     #ifdef DEBUGGING_ENABLED
     UART0_Write_Text("UDP Package received");
     UART0_Write(13);
     UART0_Write(10);
     #endif
     
     if (reqLength > 1480) // maybe add something about specific port
        return 0; // something is wrong with the length - we will only receive packages up to 64 bytes
     
     Ethernet_Intern_readPayloadBytes(receiveBuffer, 0, reqLength);
     
     /* Parse received data */
     // Calculate and compare checksum
     if (receiveBuffer[reqLength-1] != Calculate_Checksum(receiveBuffer, (reqLength-1)))
     {
        #ifdef DEBUGGING_ENABLED
        UART0_Write_Text("Checksum error");
        UART0_Write(13);
        UART0_Write(10);
        #endif
        
        return 0; // Checksum error
     }
        
     CID = receiveBuffer[0];
     if (CID != DeviceCID && CID != 0xFF)
     {
        #ifdef DEBUGGING_ENABLED
        UART0_Write_Text(" -> Package not for us");
        UART0_Write(13);
        UART0_Write(10);
        #endif
        return 0; // This package is not dedicated for us
     }

     CMD = receiveBuffer[1];
     DataLength = (receiveBuffer[2] << 8) | receiveBuffer[3];
     
     #ifdef DEBUGGING_ENABLED
     UART0_Write_Text(" -> Package CMD: ");
     ByteToStr(CMD, stringBuffer);
     UART0_Write_Text(stringBuffer);
     UART0_Write_Text(", Length: ");
     WordToStr(DataLength, stringBuffer);
     UART0_Write_Text(stringBuffer);
     UART0_Write(13);
     UART0_Write(10);
     #endif
     
     if (CMD == 0x0D && DataLength > 5 && CurrentState == FILE_RECEIVE && DownloadMode == 0) {
        if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFileID) {
           // Play the audio content

           /* Multi-buffer usage - not fully implemented yet */
           /*if (ReceivingCurrentPackage < ReceivingDividedPackages) { // all "full" packages - which means not the last "Left" one
              if (CurrentBuffer || FirstBufferFill) { // CurrentBuffer = 1 - AudioBuffer1 is being used
                memcpy(AudioBuffer2, receiveBuffer, ReceivingFileDPL);
                CurrentBuffer2MaxPos = ReceivingFileDPL;
                if (FirstBufferFill) FirstBufferFill = 0;
              } else {
                memcpy(AudioBuffer1, receiveBuffer, ReceivingFileDPL);
                CurrentBuffer1MaxPos = ReceivingFileDPL;
              }
           } else {
              if (CurrentBuffer) {
                memcpy(AudioBuffer2, receiveBuffer, ReceivingPackageLeft);
                CurrentBuffer2MaxPos = ReceivingPackageLeft;
              } else {
                memcpy(AudioBuffer1, receiveBuffer, ReceivingPackageLeft);
                CurrentBuffer1MaxPos = ReceivingPackageLeft;
              }
           }*/
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
           ReceivingCurrentPackage++; // Increase count - indicates that we have received the name of a folder/file

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
           // Save the audio content
           if (ReceivingCurrentPackage < ReceivingDividedPackages) {
             FAT32_Write(fileHandle, (receiveBuffer + 9), ReceivingFileDPL);
           } else {
             FAT32_Write(fileHandle, (receiveBuffer + 9), ReceivingPackageLeft);
           }
           ReceivingCurrentPackage++; // Increase count - indicates that we have received the name of a folder/file

           if (ReceivingCurrentPackage < ReceivingDividedPackages) {
              RequestNextAudioPackage();
           } else {
              // Audio finished saving, Do playback
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
           // Display image/pixel data
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
             // Last package
           }
           ReceivingCurrentPackage++; // Increase count - indicates that we have received the name of a folder/file

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
     
     if (CMD == 0x40) { // Ping command
        // Reply to ping
        UDPTransmitBuffer[0] = DeviceCID;
        UDPTransmitBuffer[1] = 0x41; // Ping reply
        UDPTransmitBuffer[2] = 0; // Data length = 0
        UDPTransmitBuffer[3] = 0; // Data length = 0
        UDPTransmitBuffer[4] = Calculate_Checksum(UDPTransmitBuffer, 4);
        UART0_Write_Text("Pong sent");
        UART0_Write(13);
        UART0_Write(10);
        sendLength = 5;
     }
     
     if (CMD == 0x02 && DataLength == 5) { // Check communication response - response length is OK
        if (receiveBuffer[4] == UniqueDeviceID[0] && receiveBuffer[5] == UniqueDeviceID[1] && receiveBuffer[6] == UniqueDeviceID[2] && receiveBuffer[7] == UniqueDeviceID[3]) { // This Check communication response is dedicated for us
          DeviceCID = receiveBuffer[8]; // Save assigned CID
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
           if (CurrentFolderID > 0) { // If not ROOT folder add "../" link
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
           // Request first folder/file name
           UDPTransmitBuffer[0] = DeviceCID;
           UDPTransmitBuffer[1] = 0x05; // Request folder/file name
           UDPTransmitBuffer[2] = 0; // Data length = 3
           UDPTransmitBuffer[3] = 3; // Data length = 3
           UDPTransmitBuffer[4] = (CurrentFolderID & 0xFF00) >> 8;
           UDPTransmitBuffer[5] = (CurrentFolderID & 0xFF);
           UDPTransmitBuffer[6] = 0;
           UDPTransmitBuffer[7] = Calculate_Checksum(UDPTransmitBuffer, 7);
           sendLength = 8;
           
           halfSecondCountdownTimer = 5; // Make sure download is kept alive
           ErrorCounter = 0;
        }
     }
     
     if (CMD == 0x06 && DataLength > 5 && CurrentState == FOLDER_RECEIVE) {
        if (((receiveBuffer[4] << 8) | receiveBuffer[5]) == CurrentFolderID) {
           if (FolderFileRequestIDCount < 199) { // Fill into files list buffer
             if (CurrentFolderID == 0) { // ROOT Folder = No "../" item
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
           stringBuffer[(DataLength-5)] = 0; // Terminate string
           UART0_Write_Text(stringBuffer);
        
           UART0_Write(13);
           UART0_Write(10);
           
           FolderFileRequestIDCount++; // Increase count - indicates that we have received the name of a folder/file
           if (FolderFileRequestIDCount < FoldersFilesToReceive) {
             // Request next folder/file name
             UDPTransmitBuffer[0] = DeviceCID;
             UDPTransmitBuffer[1] = 0x05; // Request folder/file name
             UDPTransmitBuffer[2] = 0; // Data length = 3
             UDPTransmitBuffer[3] = 3; // Data length = 3
             UDPTransmitBuffer[4] = (CurrentFolderID & 0xFF00) >> 8;
             UDPTransmitBuffer[5] = (CurrentFolderID & 0xFF);
             UDPTransmitBuffer[6] = FolderFileRequestIDCount;
             UDPTransmitBuffer[7] = Calculate_Checksum(UDPTransmitBuffer, 7);
             sendLength = 8;
             
             halfSecondCountdownTimer = 5; // Make sure download is kept alive
             ErrorCounter = 0;
           } else {
             if (CurrentFolderID == 0) {
               FilesListCount = FoldersFilesToReceive;
             } else {
               FilesListCount = FoldersFilesToReceive + 1;
             }

             if (FilesListCount < 12) { // Empty the rest of the files list
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
           
           ReceivingCurrentPackage = 0; // Start with first data content package
           
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
           
           // Request first package of file data
           UDPTransmitBuffer[0] = DeviceCID;
           UDPTransmitBuffer[1] = 0x0C; // Request folder/file name
           UDPTransmitBuffer[2] = 0; // Data length = 5
           UDPTransmitBuffer[3] = 5; // Data length = 5
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

           CurrentBuffer = 0; // Start using AudioBuffer2
           CurrentBuffer1MaxPos = 0;
           CurrentBuffer2MaxPos = 0;
           CurrentBufferPos = 0;
           FirstBufferFill = 1;
           
           halfSecondCountdownTimer = 5; // Make sure download is kept alive
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

           ReceivingCurrentPackage = 0; // Start with first data content package

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

           // Request first package of file data
           UDPTransmitBuffer[0] = DeviceCID;
           UDPTransmitBuffer[1] = 0x1C; // Request folder/file name
           UDPTransmitBuffer[2] = 0; // Data length = 5
           UDPTransmitBuffer[3] = 5; // Data length = 5
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
       delay_ms(10); // Make a bit delay between sending packages to limit server stress (not getting the packet)
       Ethernet_Intern_writePayloadBytes(UDPTransmitBuffer, 0, sendLength);
     }
     
     return (sendLength);
}

unsigned char Calculate_Checksum(unsigned char *UDP_Package, unsigned int length) // Length without Checksum byte
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

  UDPTransmitBuffer[0] = DeviceCID; // Empty CID (Request for new CID)
  UDPTransmitBuffer[1] = 0x03; // Request files/folders list
  UDPTransmitBuffer[2] = 0; // Data length
  UDPTransmitBuffer[3] = 2; // Data length
  UDPTransmitBuffer[4] = (CurrentFolderID & 0xFF00) >> 8;
  UDPTransmitBuffer[5] = (CurrentFolderID & 0xFF);
  UDPTransmitBuffer[6] = Calculate_Checksum(UDPTransmitBuffer, 6);
  Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 7);
  
  halfSecondCountdownTimer = 5;
  ErrorCounter = 0;
}

/* Only 1-deep folder structure works at the moment! */
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

  UDPTransmitBuffer[0] = DeviceCID; // Empty CID (Request for new CID)
  UDPTransmitBuffer[1] = 0x03; // Request files/folders list
  UDPTransmitBuffer[2] = 0; // Data length
  UDPTransmitBuffer[3] = 2; // Data length
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

  UDPTransmitBuffer[0] = DeviceCID; // Empty CID (Request for new CID)
  UDPTransmitBuffer[1] = 0x0A; // Request file information and length
  UDPTransmitBuffer[2] = 0; // Data length
  UDPTransmitBuffer[3] = 2; // Data length
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
  
  UDPTransmitBuffer[0] = DeviceCID; // Empty CID (Request for new CID)
  UDPTransmitBuffer[1] = 0x0A; // Request file information and length
  UDPTransmitBuffer[2] = 0; // Data length
  UDPTransmitBuffer[3] = 2; // Data length
  UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
  UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
  UDPTransmitBuffer[6] = Calculate_Checksum(UDPTransmitBuffer, 6);
  Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 7);
  
  halfSecondCountdownTimer = 5;
  ErrorCounter = 0;
}

void AudioFinished(void)
{
  //MP3_FinishedPlayback();  //Not working as supposed to yet - only one/first playback possible
  MP3_Reset();
  UART0_Write_Text("Finished playing");
  UART0_Write(13);
  UART0_Write(10);
}

void TerminateAudio(void)
{
  //MP3_StopPlayback(); //Not working as supposed to yet - only one/first playback possible
  MP3_Reset();
  UART0_Write_Text("Stopped playing");
  UART0_Write(13);
  UART0_Write(10);
}

void RequestNextAudioPackage()
{
              #ifdef DEBUGGING_ENABLED
              UART0_Write_Text("Requesting package ");
              LongToStr(ReceivingCurrentPackage, stringBuffer);
              UART0_Write_Text(stringBuffer);
              UART0_Write_Text(" of ");
              LongToStr(ReceivingDividedPackages, stringBuffer);
              UART0_Write_Text(stringBuffer);
              UART0_Write(13);
              UART0_Write(10);
              #endif

              // Request next package of file data
              UDPTransmitBuffer[0] = DeviceCID;
              UDPTransmitBuffer[1] = 0x0C; // Request folder/file name
              UDPTransmitBuffer[2] = 0; // Data length = 5
              UDPTransmitBuffer[3] = 5; // Data length = 5
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

  UDPTransmitBuffer[0] = DeviceCID; // Empty CID (Request for new CID)
  UDPTransmitBuffer[1] = 0x1A; // Request file information and length
  UDPTransmitBuffer[2] = 0; // Data length
  UDPTransmitBuffer[3] = 2; // Data length
  UDPTransmitBuffer[4] = (CurrentFileID & 0xFF00) >> 8;
  UDPTransmitBuffer[5] = (CurrentFileID & 0xFF);
  UDPTransmitBuffer[6] = Calculate_Checksum(UDPTransmitBuffer, 6);
  Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 7);

  halfSecondCountdownTimer = 60; // 30 seconds timeout
  ErrorCounter = 0;
  
  Xcord = 0;
  Ycord = 0;
  TFT_Fill_Screen(CL_BLACK);
  TFT_Set_Font(TFT_defaultFont, CL_WHITE, FO_HORIZONTAL);
  TFT_Write_Text("Loading image...", 110, 110);
}

void RequestNextImagePackage()
{
              #ifdef DEBUGGING_ENABLED
              UART0_Write_Text("Requesting package ");
              LongToStr(ReceivingCurrentPackage, stringBuffer);
              UART0_Write_Text(stringBuffer);
              UART0_Write_Text(" of ");
              LongToStr(ReceivingDividedPackages, stringBuffer);
              UART0_Write_Text(stringBuffer);
              UART0_Write(13);
              UART0_Write(10);
              #endif

              // Request next package of file data
              UDPTransmitBuffer[0] = DeviceCID;
              UDPTransmitBuffer[1] = 0x1C; // Request folder/file name
              UDPTransmitBuffer[2] = 0; // Data length = 5
              UDPTransmitBuffer[3] = 5; // Data length = 5
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
       // Request next package of file data
       UDPTransmitBuffer[0] = DeviceCID;
       UDPTransmitBuffer[1] = 0x0C; // Request folder/file name
       UDPTransmitBuffer[2] = 0; // Data length = 5
       UDPTransmitBuffer[3] = 5; // Data length = 5
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
       // Request next package of file data
       UDPTransmitBuffer[0] = DeviceCID;
       UDPTransmitBuffer[1] = 0x1C; // Request folder/file name
       UDPTransmitBuffer[2] = 0; // Data length = 5
       UDPTransmitBuffer[3] = 5; // Data length = 5
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
        // Request next folder/file name
        UDPTransmitBuffer[0] = DeviceCID;
        UDPTransmitBuffer[1] = 0x05; // Request folder/file name
        UDPTransmitBuffer[2] = 0; // Data length = 3
        UDPTransmitBuffer[3] = 3; // Data length = 3
        UDPTransmitBuffer[4] = CurrentFolderID >> 8;
        UDPTransmitBuffer[5] = (CurrentFolderID & 0xFF);
        UDPTransmitBuffer[6] = 0;
        UDPTransmitBuffer[7] = Calculate_Checksum(UDPTransmitBuffer, 7);
        Ethernet_Intern_sendUDP(serverIpAddr, localClientPort, serverPort, UDPTransmitBuffer, 8);

        halfSecondCountdownTimer = 5; // Make sure download is kept alive
     } else {
        FilesListCount = FolderFileRequestIDCount;

        if (FilesListCount < 12) { // Empty the rest of the files list
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