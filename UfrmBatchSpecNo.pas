unit UfrmBatchSpecNo;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DB, ADODB,inifiles, DosMove,StrUtils,
  FR_Class, ComCtrls;

type
  TfrmBatchSpecNo = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    ADOQuery1: TADOQuery;
    DosMove1: TDosMove;
    RadioGroup1: TRadioGroup;
    DateTimePicker1: TDateTimePicker;
    Label1: TLabel;
    Label5: TLabel;
    Label2: TLabel;
    ComboBox1: TComboBox;
    RadioGroup2: TRadioGroup;
    LabeledEdit3: TEdit;
    LabeledEdit1: TEdit;
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormCreate(Sender: TObject);
    procedure LabeledEdit1Exit(Sender: TObject);
    procedure LabeledEdit2Exit(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure RadioGroup2Click(Sender: TObject);
  private
    { Private declarations }
    pPLLX:integer; //0:批审核 1:批打印 2:批量删除
  public
    { Public declarations }
  end;

function  frmBatchSpecNo(const PLLX:integer): TfrmBatchSpecNo;

implementation
uses UDM, SDIMAIN;
var
  ffrmBatchSpecNo: TfrmBatchSpecNo;

{$R *.dfm}

function  frmBatchSpecNo(const PLLX:integer): TfrmBatchSpecNo;
begin
  if ffrmBatchSpecNo=nil then ffrmBatchSpecNo:=tfrmBatchSpecNo.Create(application.mainform);
  result:=ffrmBatchSpecNo;
  frmBatchSpecNo.pPLLX:=PLLX;
end;

procedure TfrmBatchSpecNo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  ifBatchOperater:=false;
  
  action:=cafree;
  if ffrmBatchSpecNo=self then ffrmBatchSpecNo:=nil;
end;

procedure TfrmBatchSpecNo.BitBtn1Click(Sender: TObject);
var
    ssql,sssql:string;
    i,k:integer;
    adotemp2,adotemp3,adotemp4,adotemp11:tadoquery;
    xx,iChecked:integer;
    s0,s1,ss:string;
    sTemp,LshRange,RangeField:string;
    pLshRange:Pchar;
//  ini:tinifile;
  Save_Cursor:TCursor;
begin
  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    { Show hourglass cursor }

  i:=0;
  sTemp:=ifThen(RadioGroup2.ItemIndex=0,LabeledEdit3.Text,LabeledEdit1.Text);
  if not RangeStrToSql(pchar(sTemp),false,'0',4,pLshRange) then
  begin
    application.messagebox('范围输入不正确，请重新输入！', '提示信息',MB_OK);
    exit;
  end;

  //=========将pchar类型的pLshRange转换为string类型的LshRange
  setlength(LshRange,length(pLshRange));
  for k :=1  to length(pLshRange) do LshRange[k]:=pLshRange[k-1];
  //=========================================================

  RangeField:=ifThen(RadioGroup2.ItemIndex=0,'unid','lsh');

  //if trim(LabeledEdit1.Text)<>'' then
  //begin
  //  LshRange:=StringReplace(LshRange,'(''','('''+LabeledEdit1.Text,[rfReplaceAll]);//加入联机字母
  //  LshRange:=StringReplace(LshRange,',''',','''+LabeledEdit1.Text,[rfReplaceAll]);//加入联机字母
  //  ss:=' (checkid in '+LshRange+') and ';
  //end else
  ss:=' ('+RangeField+' in '+LshRange+') and ';

  s0:='select unid from chk_con_his where '+
      ss+
      ' (CONVERT(CHAR(10),report_date,121)='''+FormatDateTime('YYYY-MM-DD',DateTimePicker1.Date)+
      ''') and (isnull(diagnosetype,'''')='''+trim(ComboBox1.Text)+''') and (combin_id='''+SDIAppForm.cbxConnChar.Text+''')'; //只有常规单才能批量操作
  //if trim(LabeledEdit1.Text)<>'' then
  //  s1:=' order by checkid '
  //  else s1:=' order by lsh ';

  ifBatchOperater:=true;
  
  if   pPLLX=0 then  //0:批审核 1:批打印
  begin
        adotemp2:=tadoquery.Create(nil);//需要审核的数据集(病人基本信息)
        adotemp2.Connection:=DM.ADOConnection1;
        adotemp3:=tadoquery.Create(nil);
        adotemp3.Connection:=DM.ADOConnection1;
        ssql:=s0+' AND ((report_doctor IS NULL) OR (report_doctor='''')) ';
        sssql:='select * from chk_valu_HIS where pkunid=:p_pkunid';
        adotemp2.Close;
        adotemp2.SQL.Clear;
        adotemp2.SQL.Text:=ssql;
        adotemp2.Open;
        if adotemp2.RecordCount=0 then begin application.messagebox('所选范围内记录条数为零，请重新输入！', '提示信息',MB_OK); adotemp2.Free;adotemp3.Free; exit; end;
        //adotemp2.first;
        while not adotemp2.Eof do
        begin
           adotemp3.Close;
           adotemp3.SQL.Clear;
           adotemp3.SQL.Text:=sssql;
           adotemp3.Parameters.ParamByName('p_pkunid').Value:=adotemp2.fieldbyname('unid').Value;
           adotemp3.Open;  //需要审核的数据集(病人检验结果)
           if adotemp3.RecordCount=0 then
              begin
                i:=1;//存在没有检验结果的项目
                adotemp2.next;
                continue;//不审核没有检验结果的项目
              end;

        xx:=adotemp2.fieldbyname('unid').AsInteger;
        if SDIAppForm.ADObasic.Locate('唯一编号',xx,[loCaseInsensitive]) then
        begin
          SDIAppForm.ADObasic.Edit;
          SDIAppForm.ADObasic.FieldByName('审核者').AsString:=operator_name;
          SDIAppForm.ADObasic.Post;
        end;
        adotemp2.Next;

        end;
        adotemp2.Free;
        adotemp3.Free;
        if i=0 then application.messagebox('批审核完毕,已被审核过的则无法审核！', '提示信息',MB_OK)
               else application.messagebox('批审核完毕,已被审核过的或者不存在检验结果的则无法审核！', '提示信息',MB_OK);
  end;

  if pPLLX=1 then   //0:批审核 1:批打印
  begin
    adotemp4:=tadoquery.Create(nil);
    adotemp4.Connection:=DM.ADOConnection1;
    adotemp4.Close;
    adotemp4.SQL.Clear;
    adotemp4.SQL.Text:=s0+s1;
    adotemp4.Open;
    if adotemp4.RecordCount=0 then begin application.messagebox('所选范围内记录条数为零，请重新输入！', '提示信息',MB_OK); adotemp4.Free; exit; end;
    adotemp4.First;
    while not adotemp4.Eof do
    begin
        xx:=adotemp4.fieldbyname('unid').AsInteger;
        if SDIAppForm.ADObasic.Locate('唯一编号',xx,[loCaseInsensitive]) then
          begin
             if RadioGroup1.ItemIndex=0 then SDIAppForm.SpeedButton2Click(SDIAppForm.SpeedButton2);
             if RadioGroup1.ItemIndex=1 then SDIAppForm.ToolButton8Click(SDIAppForm.ToolButton8);
             //if RadioGroup1.ItemIndex=2 then SDIAppForm.SpeedButton4Click(SDIAppForm.SpeedButton4);
          end;
        adotemp4.Next;
    end;
    adotemp4.Free;
    SDIAppForm.update_Ado_dtl;

    //ini:=TINIFILE.Create(ExtractFilePath(application.ExeName)+'AppProfile.INI');
    //ini.WriteInteger('Interface','批量打印方式',RadioGroup1.ItemIndex);
    //ini.Free;
  end;

  if pPLLX=2 then   //0:批审核 1:批打印 2:批量删除
  begin
    adotemp4:=tadoquery.Create(nil);
    adotemp4.Connection:=DM.ADOConnection1;
    adotemp4.Close;
    adotemp4.SQL.Clear;
    adotemp4.SQL.Text:=s0;
    adotemp4.Open;
    if adotemp4.RecordCount=0 then begin application.messagebox('所选范围内记录条数为零，请重新输入！', '提示信息',MB_OK); adotemp4.Free; exit; end;
    if (MessageDlg('是否真要批量删除记录？', mtConfirmation, [mbYes, mbNo], 0)<> mrYes) then BEGIN adotemp4.Free; exit;END;

    //adotemp4.First;
    while not adotemp4.Eof do
    begin
        xx:=adotemp4.fieldbyname('unid').AsInteger;

        adotemp11:=tadoquery.Create(nil);
        adotemp11.Connection:=dm.ADOConnection1;
        adotemp11.Close;
        adotemp11.SQL.Clear;
        adotemp11.SQL.Text:='select count(*) as iChecked from view_Chk_Con_All where His_Unid='''+inttostr(xx)+'''';
        adotemp11.Open;
        iChecked:=adotemp11.fieldbyname('iChecked').AsInteger;
        adotemp11.Free;
        
        if (SDIAppForm.ADObasic.Locate('唯一编号',xx,[loCaseInsensitive])) and
           ((SDIAppForm.ADObasic.FieldByName('审核者').AsString=operator_name) OR (TRIM(SDIAppForm.ADObasic.FieldByName('审核者').AsString)='')) and
           (iChecked<=0) then
        begin
          adotemp4.Delete;
          CONTINUE;
        end ;
        adotemp4.Next;
    end;
    adotemp4.Free;

    sdiappform.suiButton8Click(nil);

  end;
  
  Screen.Cursor := Save_Cursor;  { Always restore to normal }

  //ini:=TINIFILE.Create(ExtractFilePath(application.ExeName)+'AppProfile.INI');
  //ini.WriteString('Interface','联机号范围字母',LabeledEdit1.Text);
  //ini.Free;

  close;
end;

procedure TfrmBatchSpecNo.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmBatchSpecNo.FormCreate(Sender: TObject);
begin
  ADOQuery1.Connection:=DM.ADOConnection1;

  //SetWindowLong(LabeledEdit1.Handle, GWL_STYLE, GetWindowLong(LabeledEdit1.Handle, GWL_STYLE) or ES_NUMBER);//只能输入数字
  //SetWindowLong(LabeledEdit2.Handle, GWL_STYLE, GetWindowLong(LabeledEdit2.Handle, GWL_STYLE) or ES_NUMBER);//只能输入数字
end;

procedure TfrmBatchSpecNo.LabeledEdit1Exit(Sender: TObject);
begin
   TLabeledEdit(SENDER).Text:= RightStr('0000'+TRIM(TLabeledEdit(SENDER).Text),4);
end;

procedure TfrmBatchSpecNo.LabeledEdit2Exit(Sender: TObject);
begin
   TLabeledEdit(SENDER).Text:= RightStr('0000'+TRIM(TLabeledEdit(SENDER).Text),4);
end;

procedure TfrmBatchSpecNo.FormShow(Sender: TObject);
var
  ini:tinifile;
begin
//  ini:=TINIFILE.Create(ExtractFilePath(application.ExeName)+'AppProfile.INI');
//  LabeledEdit1.Text:=trim(ini.ReadString('Interface','联机号范围字母',''));
//  ini.Free;

  if pPLLX=1 then
  begin
    RadioGroup1.Visible:=true;
    ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
    RadioGroup1.ItemIndex:=ini.ReadInteger('Interface','批量打印方式',0);
    ini.Free;
  end else
  begin RadioGroup1.Visible:=false;  end;

  DateTimePicker1.DateTime:=SDIAppForm.ADObasic.FieldByName('申请日期').AsDateTime;//date();
end;

procedure TfrmBatchSpecNo.RadioGroup2Click(Sender: TObject);
begin
  if (sender as TRadioGroup).ItemIndex=0 then
  begin
    LabeledEdit3.Enabled:=true;
    LabeledEdit3.SetFocus;
    LabeledEdit1.Enabled:=false;
    LabeledEdit1.Clear;
  end else if (sender as TRadioGroup).ItemIndex=1 then
  begin
    LabeledEdit3.Enabled:=false;
    LabeledEdit3.Clear;
    LabeledEdit1.Enabled:=true;
    LabeledEdit1.SetFocus;
  end
end;

initialization
  ffrmBatchSpecNo:=nil;
  
end.
