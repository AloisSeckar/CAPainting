unit Unit1;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, ToolWin, ComCtrls, Menus, ExtDlgs, ImgList;

type
  TDrawStyle = (dsPen,dsLine,dsRect,dsFill,dsEl,dsEraser);
  TForm1 = class(TForm)
    MainMenu1: TMainMenu;
    ToolBar1: TToolBar;
    File1: TMenuItem;
    Exit1: TMenuItem;
    ToolButton4: TToolButton;
    Pen1: TMenuItem;
    SetColor1: TMenuItem;
    SetSize1: TMenuItem;
    ColorDialog1: TColorDialog;
    Shape1: TMenuItem;
    Pencil1: TMenuItem;
    Line1: TMenuItem;
    Rectangle1: TMenuItem;
    Ellipse1: TMenuItem;
    Screen: TImage;
    OpenPictureDialog1: TOpenPictureDialog;
    SavePictureDialog1: TSavePictureDialog;
    Open1: TMenuItem;
    Save1: TMenuItem;
    Reserve: TImage;
    ToolButton1: TToolButton;
    ToolButton2: TToolButton;
    ToolButton3: TToolButton;
    ToolButton5: TToolButton;
    ImageList1: TImageList;
    ToolButton6: TToolButton;
    ToolButton8: TToolButton;
    StatusBar1: TStatusBar;
    ToolButton7: TToolButton;
    ToolButton13: TToolButton;
    Eraser1: TMenuItem;
    ToolButton14: TToolButton;
    ToolButton15: TToolButton;
    ToolButton16: TToolButton;
    ToolButton17: TToolButton;
    Edit1: TMenuItem;
    Undo1: TMenuItem;
    Redo1: TMenuItem;
    ReserveF: TImage;
    New1: TMenuItem;
    IN1: TMenuItem;
    Decrease1: TMenuItem;
    ToolButton9: TToolButton;
    Fill1: TMenuItem;
    procedure Exit1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure ScrMouseDown(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure ScrMouseMove(Sender: TObject; Shift: TShiftState; X,
      Y: Integer);
    procedure SetColor1Click(Sender: TObject);
    procedure ScrMouseUp(Sender: TObject; Button: TMouseButton;
      Shift: TShiftState; X, Y: Integer);
    procedure NewClick(Sender: TObject);
    procedure Save1Click(Sender: TObject);
    procedure Open1Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure ToolButton2Click(Sender: TObject);
    procedure ToolButton3Click(Sender: TObject);
    procedure ToolButton5Click(Sender: TObject);
    procedure ToolButton13Click(Sender: TObject);
    procedure ToolButton14Click(Sender: TObject);
    procedure ToolButton15Click(Sender: TObject);
    procedure ToolButton16Click(Sender: TObject);
    procedure ToolButton8Click(Sender: TObject);
    procedure ToolButton7Click(Sender: TObject);
    procedure ToolButton9Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

var
  Form1: TForm1;
  DrawStyle: TDrawStyle;
  DrawState: boolean;
  DrawBegin: TPoint;
  DrawColor: TColor;
  DrawWidth: byte;

implementation

{$R *.dfm}

procedure TForm1.Exit1Click(Sender: TObject);
begin
Form1.Close;
end;

procedure TForm1.FormCreate(Sender: TObject);
begin
Form1.Doublebuffered:=true;
Screen.Canvas.Pen.Color:=clWhite;
Screen.Canvas.FloodFill(1,1,clBlack,fsSurface);
DrawStyle:=dsPen;
DrawState:=false;
DrawColor:=clBlack;
DrawWidth:=1;
Screen.Canvas.Pen.Color:=clBlack;
end;

procedure TForm1.ScrMouseDown(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
DrawState:=true;
StatusBar1.Panels[4].Text:='Changed';
Reserve.Picture:=Screen.Picture;
case DrawStyle of
dsPen: Screen.Canvas.MoveTo(X,Y);
dsLine: begin
        //Reserve.Picture:=Screen.Picture;
        DrawBegin.X:=X;
        DrawBegin.Y:=Y;
        end;
dsRect: begin
        //Reserve.Picture:=Screen.Picture;
        DrawBegin.X:=X;
        DrawBegin.Y:=Y;
        end;
dsEl:   begin
        //Reserve.Picture:=Screen.Picture;
        DrawBegin.X:=X;
        DrawBegin.Y:=Y;
        end;
dsFill: begin
        Screen.Canvas.Brush.Style:=bsSolid;
        Screen.Canvas.Brush.Color:=DrawColor;
        Screen.Canvas.FloodFill(X,Y,Screen.Canvas.Pixels[X,Y],fsSurface);
        end;
//dsEraser: Reserve.Picture:=Screen.Picture;
end;
end;

procedure TForm1.ScrMouseMove(Sender: TObject; Shift: TShiftState; X,
  Y: Integer);
begin
if Drawstate then
case DrawStyle of
dsPen: Screen.Canvas.LineTo(X,Y);
dsLine: begin
        Screen.Picture:=Reserve.Picture;
        Screen.Canvas.MoveTo(X,Y);
        Screen.Canvas.LineTo(DrawBegin.X,DrawBegin.Y);
        end;
dsRect: begin
        Screen.Picture:=Reserve.Picture;
        Screen.Canvas.Brush.Style:=bsClear;
        Screen.Canvas.Pen.Color:=DrawColor;
        Screen.Canvas.Pen.Width:=DrawWidth;
        Screen.Canvas.Rectangle(DrawBegin.X,DrawBegin.Y,X,Y);
        end;
dsEl:   begin
        Screen.Picture:=Reserve.Picture;
        Screen.Canvas.Brush.Style:=bsClear;
        Screen.Canvas.Pen.Color:=DrawColor;
        Screen.Canvas.Pen.Width:=DrawWidth;
        Screen.Canvas.Ellipse(DrawBegin.X,DrawBegin.Y,X,Y);
        end;
dsEraser: begin
          DrawWidth:=Screen.Canvas.Pen.Width;
          Screen.Canvas.Pen.Color:=clWhite;
          Screen.Canvas.Pen.Width:=15;
          Screen.Canvas.MoveTo(X,Y);
          Screen.Canvas.LineTo(X,Y);
          Screen.Canvas.Pen.Width:=DrawWidth;
          Screen.Canvas.Pen.Color:=DrawColor;
          end;
end;
end;

procedure TForm1.SetColor1Click(Sender: TObject);
begin
if ColorDialog1.Execute then begin
                             DrawColor:=ColorDialog1.Color;
                             Screen.Canvas.Pen.Color:=DrawColor;
                             end;
StatusBar1.Panels[2].Text:=colortostring(ColorDialog1.Color);
end;

procedure TForm1.ScrMouseUp(Sender: TObject; Button: TMouseButton;
  Shift: TShiftState; X, Y: Integer);
begin
DrawState:=false;
case DrawStyle of
dsLine: begin
        Screen.Canvas.MoveTo(X,Y);
        Screen.Canvas.LineTo(DrawBegin.X,DrawBegin.Y);
        end;
dsRect: Screen.Canvas.Rectangle(DrawBegin.X,DrawBegin.Y,X,Y);
dsEl:   Screen.Canvas.Ellipse(DrawBegin.X,DrawBegin.Y,X,Y);
end;
Screen.Canvas.Brush.Style:=bsSolid;
Undo1.Enabled:=true;
ToolButton15.Enabled:=true;
Redo1.Enabled:=false;
ToolButton16.Enabled:=false;
end;

procedure TForm1.NewClick(Sender: TObject);
var State: byte;
begin
State:=IDNo;
if StatusBar1.Panels[4].Text='Changed' then State:=MessageDlg('Save changes to current file ?',mtConfirmation,[mbYes,mbNo,mbCancel],0);
if State=IDYes then begin
                    Save1.Click;
                    State:=IDNo;
                    end;
if State=IDNo then
       begin
       Screen.Canvas.Brush.Color:=clWhite;
       Screen.Canvas.Brush.Style:=bsSolid;
       Screen.Canvas.FloodFill(1,1,$00050505,fsBorder);
       Screen.Canvas.Pen.Color:=clBlack;
       DrawStyle:=dsPen;
       DrawState:=false;
       DrawColor:=clBlack;
       DrawWidth:=1;
       ToolButton1.Click;
       Undo1.Enabled:=false;
       Redo1.Enabled:=false;
       ToolButton15.Enabled:=false;
       ToolButton16.Enabled:=false;
       Reserve.Picture:=Screen.Picture;
       ReserveF.Picture:=Screen.Picture;
       StatusBar1.Panels[3].Text:='  Untitled.bmp';
       StatusBar1.Panels[4].Text:='';
       end;
end;

procedure TForm1.Save1Click(Sender: TObject);
var name: string;
begin
if SavePictureDialog1.Execute then begin
                                   if pos('.bmp',SavePictureDialog1.FileName)>0 then Screen.Picture.SaveToFile(SavePictureDialog1.FileName)
                                                                                else Screen.Picture.SaveToFile(SavePictureDialog1.FileName+'.bmp');
                                   name:=SavePictureDialog1.FileName;
                                   if pos('.bmp',SavePictureDialog1.FileName)=0 then name:=name+'.bmp';
                                   while pos('\',name)>0 do delete(name,1,pos('\',name));
                                   StatusBar1.Panels[3].Text:=name;
                                   StatusBar1.Panels[4].Text:='';
                                   end;
end;

procedure TForm1.Open1Click(Sender: TObject);
var name: string;
begin
if OpenPictureDialog1.Execute then begin
                                   Screen.Picture.LoadFromFile(OpenPictureDialog1.FileName);
                                   name:=OpenPictureDialog1.FileName;
                                   if pos('.bmp',OpenPictureDialog1.FileName)=0 then name:=name+'.bmp';
                                   while pos('\',name)>0 do delete(name,1,pos('\',name));
                                   StatusBar1.Panels[3].Text:=name;
                                   end;
end;

procedure TForm1.ToolButton1Click(Sender: TObject);
begin
DrawStyle:=dsPen;
StatusBar1.Panels[0].Text:='Pen';
Pencil1.Checked:=true;
ToolButton1.Down:=true;
ToolButton2.Down:=false;
ToolButton3.Down:=false;
ToolButton5.Down:=false;
ToolButton9.Down:=false;
ToolButton14.Down:=false;
end;

procedure TForm1.ToolButton2Click(Sender: TObject);
begin
DrawStyle:=dsLine;
StatusBar1.Panels[0].Text:='Line';
Line1.Checked:=true;
ToolButton2.Down:=true;
ToolButton1.Down:=false;
ToolButton3.Down:=false;
ToolButton5.Down:=false;
ToolButton9.Down:=false;
ToolButton14.Down:=false;
end;

procedure TForm1.ToolButton3Click(Sender: TObject);
begin
DrawStyle:=dsRect;
StatusBar1.Panels[0].Text:='Rectangle';
Rectangle1.Checked:=true;
ToolButton3.Down:=true;
ToolButton1.Down:=false;
ToolButton2.Down:=false;
ToolButton5.Down:=false;
ToolButton9.Down:=false;
ToolButton14.Down:=false;
end;

procedure TForm1.ToolButton5Click(Sender: TObject);
begin
DrawStyle:=dsEl;
StatusBar1.Panels[0].Text:='Ellipse';
Ellipse1.Checked:=true;
ToolButton5.Down:=true;
ToolButton1.Down:=false;
ToolButton2.Down:=false;
ToolButton3.Down:=false;
ToolButton9.Down:=false;
ToolButton14.Down:=false;
end;

procedure TForm1.ToolButton13Click(Sender: TObject);
begin
if ColorDialog1.Execute then begin
                             DrawColor:=ColorDialog1.Color;
                             Screen.Canvas.Pen.Color:=DrawColor;
                             end;
StatusBar1.Panels[2].Text:=colortostring(ColorDialog1.Color);
end;

procedure TForm1.ToolButton14Click(Sender: TObject);
begin
DrawStyle:=dsEraser;
StatusBar1.Panels[0].Text:='Eraser';
Eraser1.Checked:=true;
ToolButton14.Down:=true;
ToolButton1.Down:=false;
ToolButton2.Down:=false;
ToolButton3.Down:=false;
ToolButton5.Down:=false;
ToolButton9.Down:=false;
end;

procedure TForm1.ToolButton15Click(Sender: TObject);
begin
ReserveF.Picture:=Screen.Picture;
Screen.Picture:=Reserve.Picture;
Undo1.Enabled:=false;
Redo1.Enabled:=true;
ToolButton15.Enabled:=false;
ToolButton16.Enabled:=true;
end;

procedure TForm1.ToolButton16Click(Sender: TObject);
begin
Reserve.Picture:=Screen.Picture;
Screen.Picture:=ReserveF.Picture;
Undo1.Enabled:=true;
Redo1.Enabled:=false;
ToolButton15.Enabled:=true;
ToolButton16.Enabled:=false;
end;

procedure TForm1.ToolButton8Click(Sender: TObject);
begin
if DrawWidth>1 then DrawWidth:=DrawWidth-1;
Screen.Canvas.Pen.Width:=DrawWidth;
StatusBar1.Panels[1].Text:=inttostr(DrawWidth)+' px';
end;

procedure TForm1.ToolButton7Click(Sender: TObject);
begin
if DrawWidth<10 then DrawWidth:=DrawWidth+1;
Screen.Canvas.Pen.Width:=DrawWidth;
StatusBar1.Panels[1].Text:=inttostr(DrawWidth)+' px';
end;

procedure TForm1.ToolButton9Click(Sender: TObject);
begin
DrawStyle:=dsFill;
StatusBar1.Panels[0].Text:='Fill';
Fill1.Checked:=true;
ToolButton9.Down:=true;
ToolButton1.Down:=false;
ToolButton2.Down:=false;
ToolButton3.Down:=false;
ToolButton5.Down:=false;
ToolButton14.Down:=false;
end;

end.
