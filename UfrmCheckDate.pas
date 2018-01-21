unit UfrmCheckDate;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Mask, Buttons,DB, Grids, DBGrids, ADODB, FR_DSet,
  FR_DBSet, FR_Class, ExtCtrls, ComCtrls;

type
  TfrmCheckDate = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ADObasic: TADOQuery;
    ADOdtl: TADOQuery;
    frDB_adobasic: TfrDBDataSet;
    frDB_adodtl: TfrDBDataSet;
    frReport1: TfrReport;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure ADObasicAfterScroll(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
function  frmCheckDate: TfrmCheckDate;

implementation

uses  UDM, SDIMAIN;
var
ffrmCheckDate: TfrmCheckDate;
  ifPrintSumm:boolean;

{$R *.dfm}
function  frmCheckDate: TfrmCheckDate;
begin
  if ffrmCheckDate=nil then ffrmCheckDate:=tfrmCheckDate.Create(application.mainform);
  result:=ffrmCheckDate;
end;

procedure TfrmCheckDate.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmCheckDate=self then ffrmCheckDate:=nil;
end;

procedure TfrmCheckDate.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmCheckDate.BitBtn1Click(Sender: TObject);
var
 t6: TfrMemoView;
begin
  ifPrintSumm:=true;
  
  ADObasic.Close;
  ADObasic.SQL.Clear;
  ADObasic.SQL.Text:='select * from chk_con where CONVERT(CHAR(10),check_date,121)=:P_check_date '+
                               ' union select * from chk_con_bak where CONVERT(CHAR(10),check_date,121)=:P_check_date_2 order by checkid';//+
  ADObasic.Parameters.ParamByName('P_check_date').Value:=FormatDateTime('YYYY-MM-DD',DateTimePicker1.Date);
  ADObasic.Parameters.ParamByName('P_check_date_2').Value:=FormatDateTime('YYYY-MM-DD',DateTimePicker1.Date);
  ADObasic.Open;
  if adobasic.RecordCount=0 then begin
    ifprintsumm:=false;
    showmessage('没有该日期的记录！');
    exit;
  end;

  if not frReport1.LoadFromFile(ExtractFilePath(application.ExeName)+'report_summarize.frf') then
  begin
    showmessage('加载打印模板report_summarize.frf失败，请与开发商联系');
    ifPrintSumm:=false;
    exit;
  end;
  t6 := TfrMemoView(frReport1.FindObject('Memo6'));
  if(t6=nil) then
  begin
    showmessage('统计报表中没有发现MEMO6');
    ifPrintSumm:=false;
    exit;
  end;
   T6.Memo.Text :=datetostr(DateTimePicker1.Date) ;

    if sdiappform.N9.Checked then  //预览模式
      frReport1.ShowReport;
    if sdiappform.N8.Checked then  //直接打印模式
    begin
      if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
    end;
  
  ifPrintSumm:=false;
  close;
end;

procedure TfrmCheckDate.FormShow(Sender: TObject);
begin
  DateTimePicker1.Date:=date;
  adobasic.Connection:=DM.ADOConnection1;
  adodtl.Connection:=DM.ADOConnection1;
end;

procedure TfrmCheckDate.ADObasicAfterScroll(DataSet: TDataSet);
begin
  if not ifprintsumm then exit;
  ADOdtl.Close;
  ADOdtl.SQL.Clear;
  ADOdtl.SQL.Text:='select * from view_chk_valu_All where pkunid=:P_pkunid and issure=1 ';
  //                                ' union select * from chk_valu_bak where pkunid=:P_pkunid_2 and issure=1 ';
  //ADOdtl.SQL.Text:='select * from chk_valu where pkunid=:P_pkunid and issure=1 '+
  //                                ' union select * from chk_valu_bak where pkunid=:P_pkunid_2 and issure=1 ';
  ADOdtl.Parameters.ParamByName('P_pkunid').Value:=ADObasic.fieldbyname('unid').AsInteger;
  //ADOdtl.Parameters.ParamByName('P_pkunid_2').Value:=ADObasic.fieldbyname('unid').AsInteger;
  ADOdtl.Open;
end;

initialization
  ffrmCheckDate:=nil;

end.
