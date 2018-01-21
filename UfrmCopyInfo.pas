unit UfrmCopyInfo;
//20080423 creat

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, ExtCtrls, Buttons, DB, ADODB,StrUtils{rightstr},
  Grids, DBGrids, CheckLst;

type
  TfrmCopyInfo = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LabeledEdit2: TLabeledEdit;
    ComboBox2: TComboBox;
    Label2: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    DataSource1: TDataSource;
    Label3: TLabel;
    Label6: TLabel;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    Panel1: TPanel;
    CheckBox1: TCheckBox;
    CheckListBox1: TCheckListBox;
    ComboBox1: TComboBox;
    Label1: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure FormShow(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure CheckBox1Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
function  frmCopyInfo: TfrmCopyInfo;

implementation

uses UDM, SDIMAIN;
var
  ffrmCopyInfo: TfrmCopyInfo;
  GAdotemp11:tadoquery;

{$R *.dfm}

function  frmCopyInfo: TfrmCopyInfo;
begin
  if ffrmCopyInfo=nil then ffrmCopyInfo:=TfrmCopyInfo.Create(application.mainform);
  result:=ffrmCopyInfo;
end;

procedure TfrmCopyInfo.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  Gadotemp11.Free;
  if ffrmCopyInfo=self then ffrmCopyInfo:=nil;
end;

procedure TfrmCopyInfo.FormShow(Sender: TObject);
const
  sqll='select name from CommCode where TypeName=''样本类型'' group by name';
var
  adotemp3:tadoquery;
  tempstr:string;
begin
  LoadGroupName(ComboBox1);
  
  //加载样本类型 start
  adotemp3:=tadoquery.Create(nil);
  adotemp3.Connection:=DM.ADOConnection1;
  adotemp3.Close;
  adotemp3.SQL.Clear;
  adotemp3.SQL.Text:=sqll;
  adotemp3.Open;
     
  ComboBox2.Items.Clear;//加载前先清除comboBox项

  while not adotemp3.Eof do
  begin
    tempstr:=trim(adotemp3.fieldbyname('name').AsString);

    ComboBox2.Items.Add(tempstr); //加载到comboBox

    adotemp3.Next;
  end;
  adotemp3.Free;
  //加载样本类型 stop

  SDIAppForm.combinchecklistbox(CheckListBox1);  
end;

procedure TfrmCopyInfo.BitBtn2Click(Sender: TObject);
begin
  close;
end;

procedure TfrmCopyInfo.BitBtn1Click(Sender: TObject);
var
  valetudinarianInfoId:integer;
  adotemp22:tadoquery;
  
  tmpPatientname : string;
//  tmpLSH:STRING;

  sMinLsh:STRING;//开始样本号

  Punid : integer;
//  pcheckid : string; //联机号
  iLsh : integer;
  PLSH:STRING;
  Ppatientname : string;
  Psex : string;
  Page : string;
  PCaseno : string;
  Pbedno : string;
  Pdeptname : string;
  Pcheck_date : TDatetime;
  Pcheck_doctor : string;
  Preport_date : TDatetime;
//  Preport_doctor : string;
  Poperator : string;
  PDiagnosetype : string;//优先级别
  Pflagetype : string;
  Pdiagnose : string;
  Ptypeflagcase : string;
  pissure:string;
  pSJSJ,pJCSJ:TDATETIME;
  pCombin_id:string;//组别
//  pGermName:string;
  
  AddorUpdateResult:boolean;
  
  Save_Cursor:TCursor;
  i,j,b:integer;
  s2:string;
begin
  pCombin_id:=trim(combobox1.Items[combobox1.ItemIndex]);

  if pCombin_id='' then//如果combobox1.ItemIndex<0，pCombin_id肯定为空
  begin
    MessageBox(Handle, '请选择目标申请单工作组！', '提示', MB_ICONERROR);
    exit;
  end;

  {//如此取样本号不是非常严谨.因待复制记录的检查日期可能非今天.先用着吧,反正也没什么大问题:)
  //为降低程序复杂性，按今天日期、常规来取流水号
  sMaxLSH:=getmaxid(pCombin_id,datetostr(GetServerDate(DM.ADOConnection1)),CGYXJB);
  IF NOT TRYSTRTOINT(sMaxLSH,iMaxLSH) THEN
  BEGIN
    MessageBox(Handle, PCHAR('无效的最大流水号'+sMaxLSH), '提示', MB_ICONERROR);//该情况应该不可能出现
    EXIT;
  END;
  PLSH:=sMaxLSH;//}

  sMinLsh:=trim(LabeledEdit2.Text);
  //IF sMinLsh<>'' then//表示允许不填联机号
    if NOT TRYSTRTOINT(sMinLsh,iLsh) THEN
    BEGIN
      MessageBox(Handle, PCHAR('无效的开始样本号'+sMinLsh), '提示', MB_ICONERROR);
      EXIT;
    END;

  if GAdotemp11.RecordCount<=0 then exit;

  AddorUpdateResult:=false;

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;

  for i :=0  to dbgrid1.SelectedRows.Count-1 do
  begin
    GAdotemp11.GotoBookmark(pointer(DBGrid1.SelectedRows.Items[i]));

    //PLSH:=GAdotemp11.fieldbyname('样本号').AsString;
    PDiagnosetype := GAdotemp11.fieldbyname('优先级别').AsString; //优先级别
    Ppatientname := GAdotemp11.fieldbyname('姓名').AsString;
    Psex := GAdotemp11.fieldbyname('性别').AsString;
    Page := GAdotemp11.fieldbyname('年龄').AsString;
    PCaseno := GAdotemp11.fieldbyname('病历号').AsString;
    Pbedno := GAdotemp11.fieldbyname('床号').AsString;
    Pdeptname := GAdotemp11.fieldbyname('送检科室').AsString;
    Pcheck_date := GAdotemp11.fieldbyname('创建日期').AsDateTime; //TDatetime //检查日期
    Pcheck_doctor := GAdotemp11.fieldbyname('送检医生').AsString; //送检医生
    Preport_date := GAdotemp11.fieldbyname('申请日期').AsDateTime; //TDatetime //申请日期
//    Preport_doctor := '';//审核者; //string
    Poperator := operator_name; //string
    Pflagetype := trim(combobox2.text); //样本类型
    Pdiagnose := GAdotemp11.fieldbyname('临床诊断').AsString;
    Ptypeflagcase := GAdotemp11.fieldbyname('样本情况').AsString;
    pissure:=GAdotemp11.fieldbyname('备注').AsString;//备注
    pSJSJ:=GAdotemp11.fieldbyname('申请日期').AsDateTime;
    pJCSJ:=GAdotemp11.fieldbyname('创建日期').AsDateTime;
    //pGermName:=GAdotemp11.fieldbyname('细菌').AsString;//细菌

    PLSH := inttostr(iLsh);
    //判断是否已存在该样本号
    adotemp22:=tadoquery.Create(nil);
    adotemp22.Connection:=dm.ADOConnection1;
    adotemp22.Close;
    adotemp22.SQL.Clear;
    adotemp22.SQL.Text:='select unid,lsh,patientname from chk_con_his where isnull(lsh,'''')<>'''' and lsh='''+PLSH+''' and '+
                            ' CONVERT(CHAR(10),report_date,121)=:P_report_date and Diagnosetype=:Diagnosetype and '+
                            ' combin_id=:P_combin_id ';
    adotemp22.Parameters.ParamByName('P_report_date').Value:=FormatDateTime('YYYY-MM-DD',Preport_date);
    adotemp22.Parameters.ParamByName('Diagnosetype').Value:=PDiagnosetype;
    adotemp22.Parameters.ParamByName('P_combin_id').Value:=pCombin_id;
    adotemp22.Open;
    Punid:=adotemp22.fieldbyname('unid').AsInteger;
    //tmpLSH:=adotemp22.fieldbyname('lsh').AsString;//修改时流水号就不用修改了
    tmpPatientname := adotemp22.fieldbyname('patientname').AsString;
    if adotemp22.RecordCount>0 then//已存在该样本号
    begin
      if tmpPatientname='' then
      begin
        AddorUpdateResult:=SDIAppForm.UpdateValetudinarianBasicInfo(Punid,PLSH,'',Ppatientname,Psex,
          Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,'',Poperator,
          PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,'','',
          Pcheck_date,Preport_date,pSJSJ,pJCSJ,
          ValetudinarianInfoId);
      end else//如果该病人已填写了基本资料(填写了姓名就代表已填写了基本资料)则不做处理了
      begin
        inc(iLsh);
        adotemp22.Free;
        continue;
      end;
    end else
    begin
      AddorUpdateResult:=SDIAppForm.AddValetudinarianBasicInfo(PLSH,'',Ppatientname,Psex,
        Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,'',Poperator,
        PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,pCombin_id,'',
        Pcheck_date,Preport_date,pSJSJ,pJCSJ,
        ValetudinarianInfoId);
    end;
    adotemp22.Free;
    //======================
    inc(iLsh);

    if not AddorUpdateResult then
    begin
      //MessageBox(Handle, PCHAR('无效的开始联机号'+trim(LabeledEdit2.Text)), '提示', MB_ICONERROR);//AddValetudinarianBasicInfo方法本身会报错
      break;
    end;

    for j:=0 to checklistbox1.Items.Count-1 do
    begin
     if checklistbox1.Checked[j] then
     begin
       s2:=checklistbox1.Items.Strings[j];
       b:=pos('   ',s2);
       s2:=copy(s2,1,b-1);

       sdiappform.InsertOrDeleteVaue(s2,true,ValetudinarianInfoId);
     end;
    end;
  end;

  if pCombin_id=trim(sdiappform.cbxConnChar.Text) then sdiappform.suiButton8Click(nil);//如果复制到当前组，则需马上更新显示
  
  Screen.Cursor := Save_Cursor;  { Always restore to normal }
  close;
end;

procedure TfrmCopyInfo.FormCreate(Sender: TObject);
begin
  SetWindowLong(LabeledEdit2.Handle, GWL_STYLE, GetWindowLong(LabeledEdit2.Handle, GWL_STYLE) or ES_NUMBER);//只能输入数字

  Gadotemp11:=tadoquery.Create(nil);
  Gadotemp11.clone(SDIAppForm.ADObasic);//clone的dataset,指针指在第1条记录,故无需Gadotemp11.First(呵呵,程序中也无需指到第一条,当做一个知识点吧)
  DataSource1.DataSet:=Gadotemp11;

  if dbgrid1.DataSource.DataSet.Active then
  begin
    dbgrid1.Columns[0].Width:=55;//唯一编号
    dbgrid1.Columns[1].Width:=40;//样本号
    dbgrid1.Columns[2].Width:=42;//姓名
    dbgrid1.Columns[3].Width:=42;//审核者
    dbgrid1.Columns[4].Width:=65;
    dbgrid1.Columns[5].Width:=30;
    dbgrid1.Columns[6].Width:=30;
    dbgrid1.Columns[7].Width:=30;
    dbgrid1.Columns[8].Width:=60;//送检科室
    dbgrid1.Columns[9].Width:=72;//检查日期
    dbgrid1.Columns[10].Width:=55;//送检医生
    dbgrid1.Columns[11].Width:=72;//申请日期
  end;
end;

procedure TfrmCopyInfo.CheckBox1Click(Sender: TObject);
begin
  Gadotemp11.First;
  while not Gadotemp11.Eof do
  begin
    DBGrid1.SelectedRows.CurrentRowSelected:=(sender as TCheckBox).Checked;
    Gadotemp11.Next;  
  end;
end;

initialization
  ffrmCopyInfo:=nil;

end.
