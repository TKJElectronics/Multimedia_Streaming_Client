enum GlcdColor {_clClear, _clDraw, _clInvert};

typedef struct Screen TScreen;

typedef struct  Label {
  TScreen*  OwnerScreen;
  char          Order;
  unsigned int  Left;
  unsigned int  Top;
  unsigned int  Width;
  unsigned int  Height;
  char          *Caption;
  const char    *FontName;
  unsigned int  Font_Color;
  char          Visible;
  char          Active;
  void          (*OnUpPtr)();
  void          (*OnDownPtr)();
  void          (*OnClickPtr)();
  void          (*OnPressPtr)();
} TLabel;

typedef struct  Image {
  TScreen*  OwnerScreen;
  char          Order;
  unsigned int  Left;
  unsigned int  Top;
  unsigned int  Width;
  unsigned int  Height;
  const char    *Picture_Name;
  char          Visible;
  char          Active;
  char          Picture_Type;
  char          Picture_Ratio;
  void          (*OnUpPtr)();
  void          (*OnDownPtr)();
  void          (*OnClickPtr)();
  void          (*OnPressPtr)();
} TImage;

struct Screen {
  unsigned int           Color;
  unsigned int           Width;
  unsigned int           Height;
  unsigned short         ObjectsCount;
  unsigned int           LabelsCount;
  TLabel                 * const code *Labels;
  unsigned int           ImagesCount;
  TImage                 * const code *Images;
};

extern   TScreen                LoadingScreen;
extern   TImage               Image1;
extern   TLabel                 Label1;
extern   TLabel                 * const code Screen1_Labels[1];
extern   TImage                 * const code Screen1_Images[1];


extern   TScreen                MainScreen;
extern   TImage               Image2;
extern   TLabel                 Label2;
extern   TLabel                 File1;
extern   TLabel                 File2;
extern   TImage               Image3;
extern   TLabel                 File3;
extern   TLabel                 File4;
extern   TLabel                 File5;
extern   TLabel                 File6;
extern   TLabel                 File7;
extern   TLabel                 File8;
extern   TLabel                 File9;
extern   TLabel                 File10;
extern   TLabel                 File11;
extern   TLabel                 Label3;
extern   TLabel                 * const code Screen2_Labels[13];
extern   TImage                 * const code Screen2_Images[2];



/////////////////////////
// Events Code Declarations
/////////////////////////

/////////////////////////////////
// Caption variables Declarations
extern char Label1_Caption[];
extern char Label2_Caption[];
extern char File1_Caption[];
extern char File2_Caption[];
extern char File3_Caption[];
extern char File4_Caption[];
extern char File5_Caption[];
extern char File6_Caption[];
extern char File7_Caption[];
extern char File8_Caption[];
extern char File9_Caption[];
extern char File10_Caption[];
extern char File11_Caption[];
extern char Label3_Caption[];
/////////////////////////////////

void DrawScreen(TScreen *aScreen);
void DrawLabel(TLabel *ALabel);
void DrawImage(TImage *AImage);
void Check_TP();
void Start_TP();
