unit UfrmStaticCombItem;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, ADODB,inifiles, ComCtrls, StdCtrls, Buttons, Grids, DBGrids,
  ExtCtrls, ULYDataToExcel;

type
  TfrmStaticCombItem = class(TForm)
    DBGrid1: TDBGrid;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    Panel1: TPanel;
    DateTimePicker1: TDateTimePicker;
    DateTimePicker2: TDateTimePicker;
    BitBtn2: TBitBtn;
    LYDataToExcel1: TLYDataToExcel;
    Label1: TLabel;
    Label2: TLabel;
    GroupBox1: TGroupBox;
    Label3: TLabel;
    BitBtn1: TBitBtn;
    ComboBox1: TComboBox;
    GroupBox2: TGroupBox;
    BitBtn3: TBitBtn;
    HBsAg: TComboBox;
    HBsAb: TComboBox;
    HBeAg: TComboBox;
    HBeAb: TComboBox;
    HBcAb: TComboBox;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label9: TLabel;
    Label10: TLabel;
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
function  frmStaticCombItem: TfrmStaticCombItem;

implementation

uses UDM;
var
  ffrmStaticCombItem: TfrmStaticCombItem;

{$R *.dfm}

function  frmStaticCombItem: TfrmStaticCombItem;
begin
  if ffrmStaticCombItem=nil then ffrmStaticCombItem:=tfrmStaticCombItem.Create(application.mainform);
  result:=ffrmStaticCombItem;
end;

procedure TfrmStaticCombItem.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmStaticCombItem=self then ffrmStaticCombItem:=nil;
end;

procedure TfrmStaticCombItem.FormCreate(Sender: TObject);
Begin
  adoquery1.Connection:=DM.ADOConnection1;
end;

procedure TfrmStaticCombItem.BitBtn1Click(Sender: TObject);
VAR
  Save_Cursor:TCursor;
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Text:='dbo.pro_StaticCombItem '''+datetostr(DateTimePicker1.Date)+''','''+datetostr(DateTimePicker2.Date)+''','''+ComboBox1.Text+''' ';

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    { Show hourglass cursor }
  try
    adoquery1.Open;
  finally
    Screen.Cursor := Save_Cursor;  { Always restore to normal }
  end;
end;

procedure TfrmStaticCombItem.BitBtn2Click(Sender: TObject);
begin
  LYDataToExcel1.DataSet:= adoQuery1;
  LYDataToExcel1.ExcelTitel:='БъЬт';
  LYDataToExcel1.Execute;
end;

procedure TfrmStaticCombItem.FormShow(Sender: TObject);
begin
  DateTimePicker2.Date := date;
  DateTimePicker1.Date := date-30;
end;

procedure TfrmStaticCombItem.ADOQuery1AfterOpen(DataSet: TDataSet);
begin
  dbgrid1.Columns[0].Width:=100;
  dbgrid1.Columns[1].Width:=100;
  dbgrid1.Columns[2].Width:=100;
  //dbgrid1.Columns[3].Width:=100;
end;

procedure TfrmStaticCombItem.BitBtn3Click(Sender: TObject);
VAR
  Save_Cursor:TCursor;
begin
  adoquery1.Close;
  adoquery1.SQL.Clear;
  adoquery1.SQL.Text:='dbo.pro_StaticHBV '''+datetostr(DateTimePicker1.Date)+''','''+datetostr(DateTimePicker2.Date)+''','''+HBsAg.Text+''','''+HBsAb.Text+''','''+HBeAg.Text+''','''+HBeAb.Text+''','''+HBcAb.Text+''' ';

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    { Show hourglass cursor }
  try
    adoquery1.Open;
  finally
    Screen.Cursor := Save_Cursor;  { Always restore to normal }
  end;
end;

initialization
  ffrmStaticCombItem:=nil;

end.
