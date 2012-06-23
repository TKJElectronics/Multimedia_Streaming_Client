typedef struct {
  unsigned int ID;
  unsigned char Type;
  unsigned char Name[32];
  unsigned char NameLength;
} FolderContent;

extern bit SDSave_Disabled;

extern unsigned char CurrentFolderID;
extern unsigned char CurrentFolderName[31];

extern FolderContent FilesList[200];
extern unsigned char FilesListCount;

void UI_Setup();
void UI_ShowMainScreen();
void UI_LoadingScreen(unsigned char *LoadingText);
void UI_Handler();
void UI_UpdateFilesList();
void UI_UpdateFolderName(void);
void UI_ResetCursorPos(void);