#ifndef __FAT32__

#define __FAT32__

#ifdef __MIKROC_PRO_FOR_PIC32__
  #define __PIC32__
#endif

#ifdef __MIKROC_PRO_FOR_PIC__
  #define __PIC__
#endif

#ifdef __MIKROC_PRO_FOR_DSPIC__
  #define __dsPIC__
#endif

#ifdef __MIKROC_PRO_FOR_AVR__
  #define __AVR__
#endif

#ifdef __MIKROC_PRO_FOR_ARM__
  #define __ARM__
#endif

#define CR 0x0D // carrige return
#define LF 0x0A // line feed

////////////////////////////////////////////////////////////////////////////////
typedef unsigned short      uint8;
typedef   signed short      int8;
typedef unsigned int        uint16;
typedef   signed int        int16;
typedef unsigned long       uint32;
typedef   signed long       int32;
typedef unsigned long long  uint64;
typedef   signed long long  int64;

static const uint16 SECTOR_SIZE = 512;

////////////////////////////////////////////////////////////////////////////////
//
//  modes of file operation:
//      - read   ( resets cursor to 0 )
//      - write  ( resets cursor to 0 )
//      - append ( leaves cursor as is )
//
////////////////////////////////////////////////////////////////////////////////
static const uint8  
    FILE_READ       = 0x01,
    FILE_WRITE      = 0x02,
    FILE_APPEND     = 0x04;
    
////////////////////////////////////////////////////////////////////////////////
//
//  file attributes
//
////////////////////////////////////////////////////////////////////////////////
static const uint8
    ATTR_NONE       = 0x00,
    ATTR_READ_ONLY  = 0x01,   // read-only file
    ATTR_HIDDEN     = 0x02,   // hidden file
    ATTR_SYSTEM     = 0x04,   // system file
    ATTR_VOLUME_ID  = 0x08,   // volume label
    ATTR_DIRECTORY  = 0x10,   // directory
    ATTR_ARCHIVE    = 0x20,   // archive file
    ATTR_DEVICE     = 0x40,   // device (internally set for character device names found in filespecs, 
                              //         never found on disk), must not be changed by disk tools.
    ATTR_RESERVED   = 0x80;   // reserved, must not be changed by disk tools.

static const uint8
    ATTR_LONG_NAME = ATTR_READ_ONLY |
                     ATTR_HIDDEN |
                     ATTR_SYSTEM |
                     ATTR_VOLUME_ID;  // long file name
                     
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

////////////////////////////////////////////////////////////////////////////////
//
//  status and error codes returned by functions
//
////////////////////////////////////////////////////////////////////////////////
static  const int8
    //////////////////////////
    //  general status
    //////////////////////////
    OK                  =   0,
    ERROR               =  -1,
    FOUND               =   1,
    //////////////////////////
    //  system errors
    //////////////////////////
    E_READ              =  -1,  // Error in raw read access to media.
    E_WRITE             =  -2,  // Error in raw write access to media.
    E_INIT_CARD         =  -3,  // Error in media initialization sequence.
    E_BOOT_SIGN         =  -4,  // Sector with boot record sign not found.
    E_BOOT_REC          =  -5,  // Boot record not found.
    E_FILE_SYS_INFO     =  -6,  // Error retrieving file system info.
    E_DEVICE_SIZE       =  -7,  // Error retrieving file size.
    E_FAT_TYPE          =  -8,  // Wrong file system.
    //////////////////////////
    //  space related errors
    //////////////////////////
    E_LAST_ENTRY        = -10,  // Last entry reached.
    E_FREE_ENTRY        = -11,  // Error finding free entry.
    E_CLUST_NUM         = -12,  // Invalid cluster number.
    E_NO_SWAP_SPACE     = -13,  // Not enough swap space.
    E_NO_SPACE          = -14,  // No more space in the media.
    //////////////////////////
    //  dir related errors
    //////////////////////////
    E_DIR_NAME          = -20,  // Bad directory name.
    E_ISNT_DIR          = -21,  // Not a directory.
    E_DIR_EXISTS        = -22,  // Directory already exists.
    E_DIR_NOTFOUND      = -23,  // Directory not found.
    E_DIR_NOTEMPTY      = -24,  // Directory not empty.
    //////////////////////////
    //  file related errors
    //////////////////////////
    E_FILE_NAME         = -30,  // Bad file name.
    E_ISNT_FILE         = -31,  // Not a file.
    E_FILE_EXISTS       = -32,  // File already exists.
    E_FILE_NOTFOUND     = -33,  // File not found.
    E_FILE_NOTEMPTY     = -34,  // File not empty.
    E_MAX_FILES         = -35,  // Maximum number of simultaniously opened files is reached.
    E_FILE_NOTOPENED    = -36,  // File is not opened.
    E_FILE_EOF          = -37,  // End of file is reached.
    E_FILE_READ         = -38,  // Error in file read operation.
    E_FILE_WRITE        = -39,  // Error in file write operation.
    E_FILE_HANDLE       = -40,  // Invalid file handle.
    E_FILE_READ_ONLY    = -41,  // Write access to read-only file.
    E_FILE_OPENED       = -42,  // Illegal access to already opened file (delete operation).
    //////////////////////////
    //  time related errors
    //////////////////////////
    E_TIME_YEAR         = -50,  // Bad year.
    E_TIME_MONTH        = -51,  // Bad month.
    E_TIME_DAY          = -52,  // Bad day.
    E_TIME_HOUR         = -53,  // Bad hour.
    E_TIME_MINUTE       = -54,  // Bad minute.
    E_TIME_SECOND       = -55;  // Bad second.
    
////////////////////////////////////////////////////////////////////////////////
// partition entry in MBR, 16B size
typedef struct
{
    uint8       State[1];       // partition state. ACTIVE=0x80, INACTIVE=0x00
    uint8       __1[3];
    uint8       Type[1];        // partition type.  FAT16=0x06, FAT32=0x0B
    uint8       __2[3];
    uint8       Boot[4];        // boot record sector number of partition
    uint8       Size[4];        // partition size in sectors
}
FAT32_PART;

////////////////////////////////////////////////////////////////////////////////
// MBR, 512B size
typedef struct
{
    uint8       __1[446];
    FAT32_PART  Part[4];
    uint8       BootSign[2];       // boot signature
}
FAT32_MBR;

////////////////////////////////////////////////////////////////////////////////
// Boot Record, 512B size
typedef struct
{
    uint8       JmpCode[3];         // only way to say for certain if it is boot sector
    uint8       __1[8];
    uint8       BytesPSect[2];      // # of bytes per sector
    uint8       SectsPClust[1];     // # of sectors per cluster
    uint8       Reserved[2];        // # of reserved sectors
    uint8       FATCopies[1];       // # of FAT copies
    uint8       __2[4];
    uint8       MediaDesc[1];       // media descriptor
    uint8       __3[10];
    uint8       Sects[4];           // # of sectors in partition
    uint8       SectsPFAT[4];       // # of sectors per FAT table
    uint8       Flags[2];           // flags
    uint8       __4[2];
    uint8       RootClust[4];       // number of root dir cluster
    uint8       FSISect[2];         // FSI sector (offset from boot)
    uint8       BootBackup[2];      // sector number of boot sector backup
    uint8       __5[14];
    uint8       ExtSign[1];         // extended signature - 0x29
    uint8       __6[4];
    uint8       VolName[11];        // volume name
    uint8       FATName[8];         // FAT name (FAT32)
    uint8       __7[420];
    uint8       BootSign[2];        // boot signature
}
FAT32_BR;

////////////////////////////////////////////////////////////////////////////////
// File System Info, 512B size
typedef struct
{
    uint8       LeadSig[4];
    uint8       __1[480];
    uint8       StrucSig[4];
    uint8       FreeCount[4];
    uint8       NextFree[4];
    uint8       __2[14];
    uint8       TrailSig[2];
}
FAT32_FSI;

////////////////////////////////////////////////////////////////////////////////
typedef struct
{
    uint8       Entry[4];
}
FAT32_FATENT;

////////////////////////////////////////////////////////////////////////////////
// directory entry, 32B size
typedef struct
{
    uint8       NameExt[11];    // file/directory name
    uint8       Attrib[1];      // file/directory attribute
    uint8       __1[2];
    uint8       CTime[2];       // create time
    uint8       CDate[2];       // create date
    uint8       ATime[2];
    uint8       HiClust[2];     //  <-------------------|
    uint8       MTime[2];       //  modification time   |
    uint8       MDate[2];       //  modification date   |
    uint8       LoClust[2];     //  <-------------------|----- 1st cluster of file/folder
    uint8       Size[4];        // file size
}
FAT32_DIRENT;
////////////////////////////////////////////////////////////////////////////////
////////////////////////////////////////////////////////////////////////////////

typedef uint32  __CLUSTER;
typedef uint32  __SECTOR;
typedef uint32  __ENTRY;

typedef int8    __HANDLE;

////////////////////////////////////////////////////////////////////////////////
// Time structure
typedef struct
{
    uint16      Year;
    uint8       Month;
    uint8       Day;
    uint8       Hour;
    uint8       Minute;
    uint8       Second;
}
__TIME;

////////////////////////////////////////////////////////////////////////////////
// Partition info
typedef struct
{
    uint8       State;  // partition status
    uint8       Type;   // partition type
    __SECTOR    Boot;   // partition start sector
    uint32      Size;   // partition size
}
__PART;

////////////////////////////////////////////////////////////////////////////////
// FS info
typedef struct
{
    __PART      Part[1];
    uint16      BytesPSect;  // bytes in sector
    uint8       SectsPClust; // sectors in one cluster
    uint16      Reserved;
    uint8       FATCopies;   // number of FAT table copies
    uint32      SectsPFAT;   // number of sectors in one FAT table
    uint16      Flags;
    __SECTOR    FAT;         // sector # of first FAT table
    __CLUSTER   Root;        // cluster # of root directory
    __SECTOR    Data;        // sector # of Data area
    __SECTOR    FSI;         // sector # of FSI sector (relative to boot sector)
    uint32      ClFreeCount; // free cluster count
    __CLUSTER   ClNextFree;  // last occupied cluster
}
__INFO;

////////////////////////////////////////////////////////////////////////////////
typedef struct
{
    char        NameExt[13];  // file/directory name
    uint8       Attrib;       // file/directory attribute
    
    uint32      Size;         // file/directory size
    __CLUSTER   _1stClust;    // file/directory start cluster
    
    __CLUSTER   EntryClust;   // file/directory entry cluster
    __ENTRY     Entry;        // file/derectory entry index in entry cluster
}
__DIR;

////////////////////////////////////////////////////////////////////////////////
typedef struct
{
    __CLUSTER   _1stClust;    // file start cluster
    __CLUSTER   CurrClust;    // current file cluster
    
    __CLUSTER   EntryClust;   // directory entry cluster
    __ENTRY     Entry;        // derectory entry number in the entry cluster
    
    uint32      Cursor;       // current file position (carret)
    uint32      Length;       // file size

    uint8       Mode;         // file open mode
    uint8       Attr;         // file atributes
}
__FILE;

/*
 * buffer for mmc/sd card sector r/w handling
 */
typedef struct
{
    __SECTOR        fSectNum;
    char            fSect[SECTOR_SIZE]; // sector buffer
} 
__RAW_SECTOR;

////////////////////////////////////////////////////////////////////////////////
extern const char   CRLF_F32[];
extern const uint8  FAT32_MAX_FILES;
extern const uint8  f32_fsi_template[SECTOR_SIZE];
extern const uint8  f32_br_template[SECTOR_SIZE];
extern       __FILE fat32_fdesc[];
extern       __RAW_SECTOR f32_sector;

////////////////////////////////////////////////////////////////////////////////
extern  int8 FAT32_Dev_Init         (void);
extern  int8 FAT32_Dev_Read_Sector  (__SECTOR sc, char* buf);
extern  int8 FAT32_Dev_Write_Sector (__SECTOR sc, char* buf);
extern  int8 FAT32_Dev_Multi_Read_Stop();
extern  int8 FAT32_Dev_Multi_Read_Sector(char* buf);
extern  int8 FAT32_Dev_Multi_Read_Start(__SECTOR sc);
extern  int8 FAT32_Put_Char         (char ch);

////////////////////////////////////////////////////////////////////////////////
int8    FAT32_Init      (void);
int8    FAT32_Format    (char *devLabel);
int8    FAT32_ScanDisk  (uint32 *totClust, uint32 *freeClust, uint32 *badClust);
int8    FAT32_GetFreeSpace(uint32 *freeClusts, uint16 *bytesPerClust);

int8    FAT32_ChangeDir (char *dname);
int8    FAT32_MakeDir   (char *dname);
int8    FAT32_Dir       (void);
int8    FAT32_FindFirst (__DIR *pDE);
int8    FAT32_FindNext  (__DIR *pDE);
int8    FAT32_Delete    (char *fn);
int8    FAT32_DeleteRec (char *fn);
int8    FAT32_Exists    (char *name);
int8    FAT32_Rename    (char *oldName, char *newName);
int8    FAT32_Open      (char *fn, uint8 mode);
int8    FAT32_Eof       (__HANDLE fHandle);
int8    FAT32_Read      (__HANDLE fHandle, char* rdBuf, uint16 len);
int8    FAT32_Write     (__HANDLE fHandle, char* wrBuf, uint16 len);
int8    FAT32_Seek      (__HANDLE fHandle, uint32 pos);
int8    FAT32_Tell      (__HANDLE fHandle, uint32 *pPos);
int8    FAT32_Close     (__HANDLE fHandle);
int8    FAT32_Size      (char *fname, uint32 *pSize);
int8    FAT32_GetFileHandle(char *fname, __HANDLE *handle);

int8    FAT32_SetTime   (__TIME *pTM);
int8    FAT32_IncTime   (uint32 Sec);

int8    FAT32_GetCTime  (char *fname, __TIME *pTM);
int8    FAT32_GetMTime  (char *fname, __TIME *pTM);

int8    FAT32_SetAttr   (char *fname, uint8 attr);
int8    FAT32_GetAttr   (char *fname, uint8* attr);

int8    FAT32_GetError  (void);

int8    FAT32_MakeSwap  (char *name, __SECTOR nSc, __CLUSTER *pCl);
////////////////////////////////////////////////////////////////////////////////

#endif