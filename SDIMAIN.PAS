unit SDIMAIN;

interface

uses Windows,Messages, Classes,SysUtils, Graphics, Forms, Controls, Menus,
  Dialogs, StdCtrls, Buttons, ExtCtrls,CheckLst, ComCtrls, ImgList, StdActns,
  ActnList, ToolWin, DosMove,ADODB, Grids, DBGrids,
  DB,inifiles,FR_Class, LYAboutBox,Printers,
  StrUtils, shellapi{ShellExecute}, 
  DateUtils, ADOLYGetcode,Math,Jpeg,Variants, UfrmLocateRecord,
  FR_BarC;

//==为了通过发送消息更新主窗体状态栏而增加==//
const
  WM_UPDATETEXTSTATUS=WM_USER+1;
TYPE
  TWMUpdateTextStatus=TWMSetText;
//=========================================//

type
  TSDIAppForm = class(TForm)
    ActionList1: TActionList;
    Action1: TAction;
    Action2: TAction;
    Action4: TAction;
    ImageList1: TImageList;
    ADObasic: TADOQuery;
    DSbasic: TDataSource;
    ADO_dtl: TADOQuery;
    DS_dtl: TDataSource;
    MainMenu1: TMainMenu;
    File1: TMenuItem;
    FileNewItem: TMenuItem;
    N1: TMenuItem;
    FileOpenItem: TMenuItem;
    N2: TMenuItem;
    N3: TMenuItem;
    N10: TMenuItem;
    N13: TMenuItem;
    N15: TMenuItem;
    N5: TMenuItem;
    N6: TMenuItem;
    N7: TMenuItem;
    N8: TMenuItem;
    N9: TMenuItem;
    Edit1: TMenuItem;
    Help1: TMenuItem;
    HelpAboutItem: TMenuItem;
    LYAboutBox1: TLYAboutBox;
    Action6: TAction;
    Action7: TAction;
    Action10: TAction;
    N12: TMenuItem;
    N44: TMenuItem;
    N46: TMenuItem;
    O1: TMenuItem;
    PopupMenu1: TPopupMenu;
    N39: TMenuItem;
    N43: TMenuItem;
    N51: TMenuItem;
    N52: TMenuItem;
    N54: TMenuItem;
    N55: TMenuItem;
    N56: TMenuItem;
    N57: TMenuItem;
    N61: TMenuItem;
    N38: TMenuItem;
    N40: TMenuItem;
    frReport1: TfrReport;
    N31: TMenuItem;
    Excel2: TMenuItem;
    Action9: TAction;
    CoolBar1: TCoolBar;
    ToolBar1: TToolBar;
    ToolButton1: TSpeedButton;
    suiButton8: TSpeedButton;
    ToolButton4: TToolButton;
    suiButton3: TSpeedButton;
    suiButton4: TSpeedButton;
    ToolButton6: TToolButton;
    ToolButton8: TSpeedButton;
    Panel1: TPanel;
    Panel5: TPanel;
    Label1: TLabel;
    LabeledEdit13: TLabeledEdit;
    Panel2: TPanel;
    Panel3: TPanel;
    Splitter2: TSplitter;
    CheckListBox1: TCheckListBox;
    DBGrid2: TDBGrid;
    Panel7: TPanel;
    GroupBox1: TGroupBox;
    DBGrid1: TDBGrid;
    GroupBox2: TGroupBox;
    Label3: TLabel;
    Label4: TLabel;
    suiButton6: TBitBtn;
    LabeledEdit2: TLabeledEdit;
    LabeledEdit3: TLabeledEdit;
    LabeledEdit5: TLabeledEdit;
    LabeledEdit6: TLabeledEdit;
    LabeledEdit7: TLabeledEdit;
    LabeledEdit8: TLabeledEdit;
    LabeledEdit9: TLabeledEdit;
    LabeledEdit10: TLabeledEdit;
    LabeledEdit12: TLabeledEdit;
    DateTimePicker1: TDateTimePicker;
    LabeledEdit14: TLabeledEdit;
    LabeledEdit4: TLabeledEdit;
    LabeledEdit15: TLabeledEdit;
    DateTimePicker2: TDateTimePicker;
    LabeledEdit16: TLabeledEdit;
    DateTimePicker3: TDateTimePicker;
    DateTimePicker4: TDateTimePicker;
    Splitter1: TSplitter;
    StatusBar1: TStatusBar;
    N37: TMenuItem;
    DosMove1: TDosMove;
    N24: TMenuItem;
    N25: TMenuItem;
    N34: TMenuItem;
    N35: TMenuItem;
    SpeedButton1: TSpeedButton;
    ToolButton2: TToolButton;
    TimerIdleTracker: TTimer;
    SpeedButton5: TSpeedButton;
    CheckBox1: TCheckBox;
    Action3: TAction;
    N64: TMenuItem;
    N65: TMenuItem;
    N16: TMenuItem;
    N67: TMenuItem;
    N68: TMenuItem;
    N69: TMenuItem;
    N70: TMenuItem;
    Label5: TLabel;
    Label6: TLabel;
    SpeedButton2: TSpeedButton;
    N11: TMenuItem;
    Panel4: TPanel;
    cbxConnChar: TComboBox;
    Label2: TLabel;
    N17: TMenuItem;
    N18: TMenuItem;
    N19: TMenuItem;
    N21: TMenuItem;
    N14: TMenuItem;
    pmChangeGroup: TPopupMenu;
    N20: TMenuItem;
    N22: TMenuItem;
    LabeledEdit1: TLabeledEdit;
    LabeledEdit11: TLabeledEdit;
    procedure FileExit1Execute(Sender: TObject);
    procedure HelpAbout1Execute(Sender: TObject);
    procedure FormShow(Sender: TObject);
    procedure N8Click(Sender: TObject);
    procedure N9Click(Sender: TObject);
    procedure ToolButton1Click(Sender: TObject);
    procedure N3Click(Sender: TObject);
    procedure UpdateADObasic;//全部检验单事件
    procedure ToolButton8Click(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure FileOpenItemClick(Sender: TObject);
    procedure FileNewItemClick(Sender: TObject);
    procedure suiButton3Click(Sender: TObject);
    procedure suiButton4Click(Sender: TObject);
    procedure N6Click(Sender: TObject);
    procedure FormDestroy(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure CheckListBox1ClickCheck(Sender: TObject);
    procedure DBGrid2DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure LabeledEdit4Exit(Sender: TObject);
    procedure DBGrid1DrawColumnCell(Sender: TObject; const Rect: TRect;
      DataCol: Integer; Column: TColumn; State: TGridDrawState);
    procedure suiButton6Click(Sender: TObject);
    procedure suiButton6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N15Click(Sender: TObject);
    procedure LabeledEdit13KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit5Exit(Sender: TObject);
    procedure ADO_dtlAfterOpen(DataSet: TDataSet);
    procedure ADObasicAfterScroll(DataSet: TDataSet);
    procedure N39Click(Sender: TObject);
    procedure suiButton8Click(Sender: TObject);
    procedure N44Click(Sender: TObject);
    procedure cbxConnCharChange(Sender: TObject);
    procedure N46Click(Sender: TObject);
    procedure O1Click(Sender: TObject);
    procedure LabeledEdit10KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit12KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit6KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit8KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit9KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit14KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure cbxConnCharEnter(Sender: TObject);
    procedure LabeledEdit15KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure LabeledEdit18KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure N43Click(Sender: TObject);
    procedure N51Click(Sender: TObject);
    procedure N52Click(Sender: TObject);
    procedure N54Click(Sender: TObject);
    procedure N55Click(Sender: TObject);
    procedure N56Click(Sender: TObject);
    procedure N57Click(Sender: TObject);
    procedure N61Click(Sender: TObject);
    procedure LabeledEdit2KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure ADObasicAfterOpen(DataSet: TDataSet);
    procedure N31Click(Sender: TObject);
    procedure Excel2Click(Sender: TObject);
    procedure N37Click(Sender: TObject);
    procedure N25Click(Sender: TObject);
    procedure SpeedButton1Click(Sender: TObject);
    procedure LabeledEdit1KeyDown(Sender: TObject; var Key: Word;
      Shift: TShiftState);
    procedure frReport1BeforePrint(Memo: TStringList; View: TfrView);
    procedure LabeledEdit3Change(Sender: TObject);
    procedure TimerIdleTrackerTimer(Sender: TObject);
    procedure SpeedButton5Click(Sender: TObject);
    procedure N64Click(Sender: TObject);
    procedure N69Click(Sender: TObject);
    procedure N70Click(Sender: TObject);
    procedure SpeedButton2Click(Sender: TObject);
    procedure N11Click(Sender: TObject);
    procedure N16Click(Sender: TObject);
    procedure N18Click(Sender: TObject);
    procedure N19Click(Sender: TObject);
    procedure N21Click(Sender: TObject);
    procedure Edit1Click(Sender: TObject);
    procedure N14Click(Sender: TObject);
    procedure pmChangeGroupPopup(Sender: TObject);
  private
    procedure CheckTheListBox;//根据当前病人的结果在checklistbox1中打钩
    procedure WriteProfile;
    procedure ReadConfig;
    procedure ReadIni;
    procedure updateDBGrid2;
    function CheckMan: boolean;
    procedure ClearAll(CONST Clear_TYPE:integer);
    //==为了通过发送消息更新主窗体状态栏而增加==//
    procedure WMUpdateTextStatus(var message:twmupdatetextstatus);  {WM_UPDATETEXTSTATUS消息处理函数}
                                              message WM_UPDATETEXTSTATUS;
    procedure updatestatusBar(const text:string);//Text为该格式#$2+'0:abc'+#$2+'1:def'表示状态栏第0格显示abc,第1格显示def,依此类推
    //==========================================//
    procedure pmChangeGroupItemClick(Sender: TObject);
    procedure LoadToolMenu(const ToolMenuItem:TMenuItem;const ASel:string);                                                   
    procedure miToolItemClick(Sender: TObject);
  public
      { Public declarations }
    ifnewadd:boolean;
    procedure FillBasic;
    procedure combinchecklistbox(CheckListBox:TCheckListBox);
    procedure InsertOrDeleteVaue(const ComboItemID:string;const ifAddorDel:boolean;const checkunid:integer);
    procedure updatedbgrid1;
    procedure update_Ado_dtl;
    procedure NewAddStatus;
    function AddValetudinarianBasicInfo(const PLSH,pcheckid,Ppatientname,Psex,
      Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
      PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,pCombin_id,pGermName:string;
      Pcheck_date,Preport_date,pSJSJ,pJCSJ:TDatetime;
      var ValetudinarianInfoId:integer):boolean;//UfrmCopyInfo要调用该函数,故放在public中
    function UpdateValetudinarianBasicInfo(Punid:integer;const PLSH,pcheckid,Ppatientname,Psex,
      Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
      PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,pGermName,pHis_MzOrZy:string;
      Pcheck_date,Preport_date,pSJSJ,pJCSJ:TDatetime;
      var ValetudinarianInfoId:integer):boolean;//UfrmCopyInfo要调用该函数,故放在public中
  end;

var
  SDIAppForm: TSDIAppForm;

implementation

uses  Unit_dialog_pllr,
   UfrmCommQuery,
   UfrmLogin,
   UfrmBatchSpecNo,
  UfrmCheckDate,
  UfrmExcelQuery,
  UfrmStaticCombItem,
  UDM,
  UfrmFromExcelLoad,
  UfrmCopyInfo;

var
    copyName,copySex,copyage,copyCaseno,copyBedno,copydeptname,copycheck_doctor:string;//复制的病人基本信息，仅粘贴时有用

{$R *.dfm}

procedure TSDIAppForm.NewAddStatus;
begin
  if ifnewadd then exit;

  ClearAll(1);

  LabeledEdit16.Text:=getmaxid(trim(cbxConnChar.Text),GetServerDate(DM.ADOConnection1),trim(LabeledEdit12.Text));
  if LabeledEdit2.CanFocus then LabeledEdit2.SetFocus;

  ifnewadd:=true;
end;

procedure TSDIAppForm.FileExit1Execute(Sender: TObject);
begin
  Close;
end;

procedure TSDIAppForm.HelpAbout1Execute(Sender: TObject);
var
  ini:tinifile;
begin
  LYAboutBox1.ProcuctName:=Caption;
  LYAboutBox1.Version:=GetVersionLY(pchar(APPLICATION.ExeName));//函数返回的Pchar类型还真能直接赋值给string!!!
  LYAboutBox1.Copyright:='版权所有,严禁反编译，反汇编';
  ini:=TINIFILE.Create(ExtractFilePath(application.ExeName)+'AppProfile.INI');
  LYAboutBox1.Comments:=ini.ReadString('Interface','companyname','广东誉凯软件工作室');
  LYAboutBox1.Author:=ini.ReadString('Interface','companytel','13710248644、(020)33053535');
  LYAboutBox1.WebPage:=ini.ReadString('Interface','companywww','http://yklis.ys168.com');//会员帐号:yklis;密码是:liu771129
  ini.Free;
  LYAboutBox1.Execute;
end;

procedure TSDIAppForm.FormShow(Sender: TObject);
begin
  if ifRegister then bRegister:=true else bRegister:=false;
  
  frmLogin.ShowModal;

  ADO_dtl.Connection := DM.ADOConnection1;
  ADObasic.Connection := DM.ADOConnection1;

  combinchecklistbox(CheckListBox1);
  
  LoadGroupName(cbxConnChar);

  ReadConfig;
  UpdateStatusBar(#$2+'6:'+SCSYDW);

  UpdateADObasic;
  update_Ado_dtl;

  if DM.ADOConn_His.Connected then DM.ADOConn_His.Connected:=false;

  if IdleTrackerInit then TimerIdleTracker.Enabled:=true else TimerIdleTracker.Enabled:=false;//要用到ReadConfig中的LoginTime参数

  LoadToolMenu(N65,'select name from CommCode where TypeName=''工具菜单'' order by ID');
end;

procedure TSDIAppForm.ClearAll(CONST Clear_TYPE:integer);
//Clear_TYPE:1---新增清空
//Clear_TYPE:2---换组清空
var
  ServerDate:tdate;
  ini:tinifile;
begin
  ServerDate:=GetServerDate(DM.ADOConnection1);

  labelededit2.Clear;
  labelededit3.Clear;
  labelededit5.Clear;
  labelededit7.Clear;
  if Clear_TYPE=2 then labelededit8.Clear; //样本类型 注：换组后样本类型一般不会相同，故清空
  labelededit14.Clear;
  if Clear_TYPE=2 then labelededit15.Clear; //备注 注：小林要求换组后清空备注20080423
  DateTimePicker1.DateTime := ServerDate;//申请日期
  DateTimePicker2.DateTime := ServerDate;//要求检查日期
  DateTimePicker3.DateTime:=ServerDate;   //申请时间
  DateTimePicker4.DateTime:=ServerDate;   //要求检查时间
  labelededit6.Text:=ifThen(ifDefaultDepartment,department_name,'');//送检科室
  labelededit10.Text:=ifThen(ifDefaultDoctor,operator_name,'');//送检医生

  //获取优先级别
  ini:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  LabeledEdit12.Text:=ini.ReadString('Interface','当前保存的优先级别','');
  ini.Free;
  //==========
end;

procedure tsdiappform.FillBasic;
begin
  if ((not ADObasic.Active) or (ADObasic.RecordCount < 1)) then exit;
  
  LabeledEdit2.Text := trim(ADObasic.FieldByName('病历号').AsString);
  LabeledEdit3.Text := trim(ADObasic.FieldByName('姓名').AsString);
  LabeledEdit4.Text := trim(ADObasic.FieldByName('性别').AsString);
  LabeledEdit5.Text := trim(ADObasic.FieldByName('年龄').AsString);
  LabeledEdit6.Text := trim(ADObasic.FieldByName('送检科室').AsString);
  LabeledEdit7.Text := trim(ADObasic.FieldByName('床号').AsString);
  LabeledEdit8.Text := trim(ADObasic.FieldByName('样本类型').AsString);
  LabeledEdit9.Text := trim(ADObasic.FieldByName('样本情况').AsString);
  LabeledEdit10.Text := trim(ADObasic.FieldByName('送检医生').AsString);
  DateTimePicker1.Date := ADObasic.FieldByName('申请日期').AsDateTime;
  DateTimePicker2.Date := ADObasic.FieldByName('创建日期').AsDateTime;
  LabeledEdit12.Text := trim(ADObasic.FieldByName('优先级别').AsString);
  LabeledEdit14.Text := trim(ADObasic.FieldByName('临床诊断').AsString);
  LabeledEdit15.Text := trim(ADObasic.FieldByName('备注').AsString);
  LabeledEdit16.Text := trim(ADObasic.FieldByName('样本号').AsString);
  DateTimePicker3.Time:=ADObasic.FieldByName('申请日期').AsDateTime;
  DateTimePicker4.Time:=ADObasic.FieldByName('创建日期').AsDateTime;
end;

procedure TSDIAppForm.N8Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  n8.Checked := true;
end;

procedure TSDIAppForm.N9Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  n9.Checked := true;
end;

procedure TSDIAppForm.ToolButton1Click(Sender: TObject);
var
  adotemp11:tadoquery;
  iChecked:integer;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not DBGrid1.DataSource.DataSet.Active then exit;
  if DBGrid1.DataSource.DataSet.RecordCount=0 then exit;
  if not checkman then
  begin
    MESSAGEDLG('非您审核，无权修改!',MTINFORMATION,[MBOK],0);
    exit;
  end;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=dm.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='select count(*) as iChecked from Chk_Valu_His where PkUnid='+adobasic.fieldbyname('唯一编号').AsString+' and itemvalue=''1'' ';
  adotemp11.Open;
  iChecked:=adotemp11.fieldbyname('iChecked').AsInteger;
  adotemp11.Free;
      
  if iChecked>0 then
  begin
    MESSAGEDLG('该申请已被科室处理,不能删除!',mtError,[MBOK],0);
    exit;
  end;      
  
  if (MessageDlg('是否真要删除当前记录？', mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then exit;
    DBGrid1.DataSource.DataSet.Delete;
end;

procedure TSDIAppForm.N3Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  Form_pllr.ShowModal;
end;

procedure TSDIAppForm.UpdateADObasic;  //全部检验单事件
var
  strsql22,strsql,strsql44,STRSQL45,STRSQL46,STRSQL47,STRSQL48,STRSQL49: string;
begin
  if bRegister then strsql22:='select ' else strsql22:='select top 2 ';//未注册版本只能显示前两条记录
  strsql:=' cch.unid as 唯一编号,cch.lsh as 样本号,cch.patientname as 姓名,cch.report_doctor as 审核者,'+
        ' cch.caseno as 病历号,cch.sex as 性别,'+
        ' cch.age as 年龄,cch.bedno as 床号,cch.deptname as 送检科室,'+
        ' cch.check_date as 创建日期,cch.check_doctor as 送检医生,'+
        ' cch.report_date as 申请日期,'+
        ' cch.operator as 操作者,cch.printtimes as 打印时间,cch.diagnosetype as 优先级别,'+
        ' cch.flagetype as 样本类型,cch.diagnose as 临床诊断,cch.typeflagcase as 样本情况,'+
        ' cch.issure as 备注,cch.combin_id as 组别,cch.germname as 细菌,cch.checkid as 联机号, '+
        ' cch.His_Unid as His唯一编号,cch.His_MzOrZy as His门诊或住院, '+
        ' cch.WorkDepartment as 所属部门,cch.WorkCategory as 工种,cch.WorkID as 工号,cch.ifMarry as 婚否,cch.OldAddress as 籍贯,cch.Address as 住址,cch.Telephone as 电话,cch.WorkCompany as 所属公司, '+
        ' cch.PushPress as 舒张压,cch.PullPress as 收缩压,cch.LeftEyesight as 左眼视力,cch.RightEyesight as 右眼视力,cch.Stature as 身高,cch.Weight as 体重, '+
        ' cch.TjJiWangShi as 既往史,cch.TjJiaZuShi as 家族史,cch.TjNeiKe as 内科,cch.TjWaiKe as 外科,cch.TjWuGuanKe as 五官科,cch.TjFuKe as 妇科,cch.TjLengQiangGuang as 冷强光,cch.TjXGuang as X光,cch.TjBChao as B超,'+
        ' cch.TjXinDianTu as 心电图,cch.TjJianYan as 检验,cch.TjDescription as 结论,cch.TJAdvice as 建议, '+
        ' cch.Audit_Date as 审核时间 '+
        //' vcca.unid as 检验单唯一编号 '+
        ' from chk_con_his cch '+
        //' left join view_Chk_Con_All vcca on vcca.His_unid=cch.Unid '+
        ' where ';
  if trim(cbxConnChar.Text)='' then   //所有申请单
    strsql44:=''
  else strsql44:=' cch.combin_id='''+trim(cbxConnChar.Text)+''' and ';
  STRSQL46:='';
  if trim(LabeledEdit1.Text)<>'' then   //门诊/住院号筛选
  begin
    STRSQL46:=' cch.caseno like ''%'+trim(leftstr(LabeledEdit1.Text,CaseNoMatchingNum))+'%'' and ';
  end;
  if trim(LabeledEdit11.Text)='' then   //姓名筛选
    STRSQL49:=''
  else STRSQL49:=' cch.patientname like ''%'+trim(LabeledEdit11.Text)+'%'' and ';
  if ShowSelfDJ then STRSQL48:=' cch.operator='''+operator_name+''' and '
  else STRSQL48:='';
  STRSQL47:=' 1=1 ';
  STRSQL45:=' order by CONVERT(CHAR(10),cch.report_date,121),优先级别,'+OrderType;
  ADObasic.Close;
  ADObasic.SQL.Clear;
  ADObasic.SQL.Add(strsql22);
  ADObasic.SQL.Add(strsql);
  ADObasic.SQL.Add(strsql44);
  ADObasic.SQL.Add(strsql46);
  ADObasic.SQL.Add(strsql49);
  ADObasic.SQL.Add(strsql48);
  ADObasic.SQL.Add(strsql47);
  ADObasic.SQL.Add(strsql45);
  ADObasic.Open;
end;

procedure TSDIAppForm.suiButton8Click(Sender: TObject); //刷新按钮事件
var ff:integer;
begin
   if not adobasic.Active then exit;
   ff:=adobasic.fieldbyname('唯一编号').AsInteger;
   UpdateADObasic;
   adobasic.Locate('唯一编号',ff,[loCaseInsensitive]);
end;

procedure TSDIAppForm.ToolButton8Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

   if not ADObasic.Active then exit;
   if ADObasic.RecordCount=0 then exit;

  g_Printtime:=ADObasic.fieldbyname('打印时间').AsString;

   if not ifAutoCheck then  //打印前要检查是否已被审核
   begin
     if trim(ADObasic.FieldByName('审核者').AsString)='' then
     begin
      MessageBox(Handle, '请先审核！', '系统提示', MB_ICONASTERISK);
      exit;
     end;
   end;

    if not frReport1.LoadFromFile('report_SampleNo.frf') then
    begin
      showmessage('加载默认样本标签打印模板report_SampleNo.frf失败');
      exit;
    end;


    //frReport1.Pages.Pages[0].pgsize:=255;//.pgHeight:=70;
    //frReport1.Pages.Pages[0].pgHeight:=70;
    //frReport1.Pages[0].ChangePaper($100,2100,1500,-1,poPortrait);  //1 inch=2.54 cm

    if n9.Checked then  //预览模式
      frReport1.ShowReport;
    if n8.Checked then  //直接打印模式
    begin
      if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
    end;
end;

procedure TSDIAppForm.FormCreate(Sender: TObject);
Begin
  ChangeYouFormAllControlIme(Self);//设置中文输入法

  SetWindowLong(LabeledEdit16.Handle, GWL_STYLE, GetWindowLong(LabeledEdit16.Handle, GWL_STYLE) or ES_NUMBER);//只能输入数字
end;

procedure TSDIAppForm.FileOpenItemClick(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  close;
end;

procedure TSDIAppForm.FileNewItemClick(Sender: TObject);
begin
  frmLogin.ShowModal;
end;

procedure TSDIAppForm.suiButton3Click(Sender: TObject);
var
  adotemp11:tadoquery;
  unid:integer;
begin
  //实际操作中,审核者可能是收费者、标本采集者
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADObasic.Active then exit;
  if ADObasic.RecordCount=0 then exit;
  if not ado_dtl.Active then exit;//20080130
  if ado_dtl.RecordCount=0 then exit;

   unid:=ADObasic.fieldbyname('唯一编号').AsInteger;

   if (trim(adobasic.FieldByName('审核者').AsString)<>operator_name) and (trim(adobasic.FieldByName('审核者').AsString)<>'') then
   begin
      if MessageDlg('已被审核过，想修改审核者？', mtWarning	, [mbNo,mbYes], 0 ) = mrNo then  exit;
   end;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='update chk_con_his set report_doctor='''+operator_name+''',Audit_Date=getdate() where unid='+inttostr(unid);
  adotemp11.ExecSQL;
  adotemp11.Free;

  ADObasic.Refresh; //刷新界面
end;

procedure TSDIAppForm.suiButton4Click(Sender: TObject);
var
  adotemp11:tadoquery;
  unid:integer;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not ADObasic.Active then exit;
  if not ADObasic.RecordCount=0 then exit;
  if trim(DBGrid1.DataSource.DataSet.FieldByName('审核者').AsString)='' then exit;//20080130

  unid:=ADObasic.fieldbyname('唯一编号').AsInteger;

  if not checkman then
  begin
          MESSAGEDLG('非您审核，无权修改!',MTINFORMATION,[MBOK],0);
          exit;
  end;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='update chk_con_his set report_doctor='''',Audit_Date=null where unid='+inttostr(unid);
  adotemp11.ExecSQL;
  adotemp11.Free;

  ADObasic.Refresh; //刷新界面
end;

procedure TSDIAppForm.ReadConfig;
var
  configini:tinifile;
begin
  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  IF CONFIGINI.ReadBool('Interface','ifPreview',TRUE) THEN
  begin
    n9.Checked:=TRUE;   //打印预览
    n8.Checked:=false;  //直接打印
  end ELSE
  begin
    n9.Checked:=false;
    n8.Checked:=TRUE;
  end;

  N25.Checked:=configini.ReadBool('Interface','ifPagination',false);{记录是否按组分页}
  N64.Checked:=configini.ReadBool('Interface','ifCaseNoMerger',false);{记录是否按姓别性别年龄合并打印}
  cbxConnChar.Text:=trim(CONFIGINI.ReadString('Interface','ShowReportType',cbxConnChar.Items[0]));
  CheckListBox1.Height:=configini.ReadInteger('Interface','clbCombItemHeight',101);{记录组合项目选择框高度}
  Panel7.Width:=configini.ReadInteger('Interface','gridBaseInfoWidth',477);{记录基本信息框宽度}
  CheckBox1.Checked:=configini.ReadBool('Interface','ifContinuousEdit',false);{记录是否连续录入基本信息}

  LabeledEdit16.Enabled:=configini.ReadBool('EditEnabled','LSH',true);
  LabeledEdit2.Enabled:=configini.ReadBool('EditEnabled','Caseno',true);
  LabeledEdit6.Enabled:=configini.ReadBool('EditEnabled','deptname',true);
  LabeledEdit7.Enabled:=configini.ReadBool('EditEnabled','bedno',true);
  LabeledEdit10.Enabled:=configini.ReadBool('EditEnabled','check_doctor',true);
  LabeledEdit8.Enabled:=configini.ReadBool('EditEnabled','flagetype',true);
  LabeledEdit9.Enabled:=configini.ReadBool('EditEnabled','typeflagcase',true);
  LabeledEdit14.Enabled:=configini.ReadBool('EditEnabled','diagnose',true);
  DateTimePicker1.Enabled:=configini.ReadBool('EditEnabled','report_date',true);
  DateTimePicker3.Enabled:=configini.ReadBool('EditEnabled','SJSJ',true);
  LabeledEdit15.Enabled:=configini.ReadBool('EditEnabled','issure',true);

  ReadIni();

  configini.Free;
end;

procedure TSDIAppForm.WriteProfile;
var
  ConfigIni:tinifile;
begin
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));

  configini.WriteBool('Interface','ifPreview',n9.Checked);{记录是否打印预览模式}
  configini.WriteBool('Interface','ifPagination',N25.Checked);{记录是否按组分页}
  configini.WriteBool('Interface','ifCaseNoMerger',N64.Checked);{记录是否按姓别性别年龄合并打印}
  ConfigIni.WriteString('Interface','ShowReportType',trim(cbxConnChar.Text)); {记录主界面中要显示的检验单类型}
  if CheckListBox1.Height<10 then CheckListBox1.Height:=10;
  configini.WriteInteger('Interface','clbCombItemHeight',CheckListBox1.Height);{记录组合项目选择框高度}
  configini.WriteInteger('Interface','gridBaseInfoWidth',Panel7.Width);{记录基本信息框宽度}
  configini.WriteBool('Interface','ifContinuousEdit',CheckBox1.Checked);{记录是否连续录入基本信息}

  configini.WriteBool('EditEnabled','LSH',LabeledEdit16.Enabled);
  configini.WriteBool('EditEnabled','Caseno',LabeledEdit2.Enabled);
  configini.WriteBool('EditEnabled','deptname',LabeledEdit6.Enabled);
  configini.WriteBool('EditEnabled','bedno',LabeledEdit7.Enabled);
  configini.WriteBool('EditEnabled','check_doctor',LabeledEdit10.Enabled);
  configini.WriteBool('EditEnabled','flagetype',LabeledEdit8.Enabled);
  configini.WriteBool('EditEnabled','typeflagcase',LabeledEdit9.Enabled);
  configini.WriteBool('EditEnabled','diagnose',LabeledEdit14.Enabled);
  configini.WriteBool('EditEnabled','report_date',DateTimePicker1.Enabled);
  configini.WriteBool('EditEnabled','SJSJ',DateTimePicker3.Enabled);
  configini.WriteBool('EditEnabled','issure',LabeledEdit15.Enabled);

  configini.Free;
end;

procedure TSDIAppForm.FormDestroy(Sender: TObject);
begin
  WriteProfile;

  IdleTrackerTerm;
end;

procedure TSDIAppForm.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
var
  adotemp11:Tadoquery;
begin
    if parname='SCSYDW' then ParValue:=SCSYDW;

    if parname='样本条码号' then ParValue:=trim(ADObasic.fieldbyname('唯一编号').AsString);//设计器中设置BarCode的Memo为[样本条码号]
    if parname='组合项目' then
    begin
      adotemp11:=Tadoquery.Create(nil);
      adotemp11.Connection:=dm.ADOConnection1;
      adotemp11.Close;
      adotemp11.SQL.Clear;
      adotemp11.SQL.Add('declare @ret varchar(500)');
      adotemp11.SQL.Add('set @ret='''' ');
      adotemp11.SQL.Add('select @ret=@ret+'',''+combin_Name from chk_valu_his WHERE PkUnid='+ADObasic.fieldbyname('唯一编号').AsString+' group by combin_Name');
      adotemp11.SQL.Add('set @ret=stuff(@ret,1,1,'''')');
      adotemp11.SQL.Add('select @ret as cn');
      adotemp11.Open;
      ParValue:=trim(adotemp11.fieldbyname('cn').AsString);
      adotemp11.Free;
    end;
    if parname='样本类型' then ParValue:=trim(ADObasic.fieldbyname('样本类型').AsString);
    if parname='姓名' then ParValue:=trim(ADObasic.fieldbyname('姓名').AsString);
    if parname='性别' then ParValue:=trim(ADObasic.fieldbyname('性别').AsString);
    if parname='年龄' then ParValue:=trim(ADObasic.fieldbyname('年龄').AsString);
    if parname='申请医生' then ParValue:=trim(ADObasic.fieldbyname('送检医生').AsString);
    if parname='申请科室' then ParValue:=trim(ADObasic.fieldbyname('送检科室').AsString);
    if parname='申请日期' then ParValue:=trim(ADObasic.fieldbyname('申请日期').AsString);
    if parname='门诊住院号' then ParValue:=trim(ADObasic.fieldbyname('病历号').AsString);
    if parname='优先级别' then ParValue:=trim(ADObasic.fieldbyname('优先级别').AsString);
    if parname='床号' then ParValue:=trim(ADObasic.fieldbyname('床号').AsString);
    if parname='临床诊断' then ParValue:=trim(ADObasic.fieldbyname('临床诊断').AsString);
    if parname='补打标志' then ParValue:=ifThen(g_Printtime<>'','补打');
end;

procedure TSDIAppForm.updateDBGrid2;
begin
  if not dbgrid2.DataSource.DataSet.Active then exit;
  dbgrid2.Columns[1].Width:=80;
  dbgrid2.Columns[2].Width:=50;

  dbgrid2.Columns[3].Width:=70;
  dbgrid2.Columns[4].Width:=50;
  dbgrid2.Columns[5].Width:=50;
  dbgrid2.Columns[6].Width:=50;
  dbgrid2.Columns[7].Width:=50;
  dbgrid2.Columns[8].Width:=50;
  dbgrid2.Columns[9].Width:=50;
end;

procedure TSDIAppForm.updatedbgrid1;
begin
  if not dbgrid1.DataSource.DataSet.Active then exit;
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

  VisibleColumn(dbgrid1,'唯一编号',OrderType='唯一编号');//按唯一编号排序时显示唯一编号,否则(样本号)不显示唯一编号
end;

procedure TSDIAppForm.combinchecklistbox(CheckListBox:TCheckListBox);//将组合项目号及名称导入CheckListBox中
const sqll='select id,name from combinitem order by id';
    var adotemp3:tadoquery;
begin
     adotemp3:=tadoquery.Create(nil);
     adotemp3.Connection:=DM.ADOConnection1;
     adotemp3.Close;
     adotemp3.SQL.Clear;
     adotemp3.SQL.Text:=sqll;
     adotemp3.Open;
     adotemp3.First;
     CheckListBox.Items.Clear;

     while not adotemp3.Eof do
     begin
      CheckListBox.Items.Add(trim(adotemp3.fieldbyname('id').AsString)+'   '+adotemp3.fieldbyname('name').AsString);
      adotemp3.Next;
     end;
     adotemp3.Free;
end;

procedure TSDIAppForm.CheckListBox1ClickCheck(Sender: TObject);
var
      i,b,checkunid:integer;
      s2:string;
begin
      i:=CheckListBox1.ItemIndex;

        if (not dsbasic.DataSet.Active) or (dsbasic.DataSet.RecordCount < 1) then
        begin
          Application.MessageBox('请先录入基本信息', '提示信息', MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);
          CheckListBox1.Checked[i]:=false;
          exit;
        end;

      if not checkman then
      begin
          CheckListBox1.Checked[i]:=not CheckListBox1.Checked[i];
          MESSAGEDLG('非您审核，无权修改!',MTINFORMATION,[MBOK],0);
          exit;
      end;

      checkunid:=dsbasic.DataSet.fieldbyname('唯一编号').AsInteger;

      s2:=checklistbox1.Items.Strings[i];
      b:=pos('   ',s2);
      s2:=copy(s2,1,b-1);

      InsertOrDeleteVaue(s2,checklistbox1.Checked[i],checkunid);
end;

procedure TSDIAppForm.DBGrid2DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  sItemValue:string;
begin
  //======================检验科未处理的组合项目==============================//
  if (datacol=1) then
  begin
    sItemValue:=ADO_dtl.fieldbyname('ItemValue').AsString;
    if (sItemValue<>'1')and(ADO_dtl.RecordCount>0) then
    begin
      tdbgrid(sender).Canvas.Brush.color:=clYellow;
      if ((State = [gdSelected]) or (State=[gdSelected,gdFocused])) then
      begin
        tdbgrid(sender).Canvas.Brush.color:=clhighlight;
        tdbgrid(sender).Canvas.Font.Color:=clwindow;
      end;
      tdbgrid(sender).DefaultDrawColumnCell(rect,datacol,column,state);
    end;
  end;
  //==========================================================================//}
end;

procedure TSDIAppForm.CheckTheListBox;//根据当前病人的结果在checklistbox1中打钩
var
  i:integer;
  b:integer;
  ss,sss:string;
  adotemp2:tadoquery;
begin
    adotemp2:=tadoquery.Create(nil);
    adotemp2.Connection:=DM.ADOConnection1;
    ADOtemp2.Close;
    ADOtemp2.SQL.Clear;
    ADOtemp2.SQL.Text:=ado_dtl.SQL.Text;
    ADOtemp2.Parameters.ParamByName('pkunid').Value :=
          ADObasic.FieldByName('唯一编号').AsInteger;
    ADOtemp2.Open;

    for i:=0 to checklistbox1.Items.Count-1 do checklistbox1.Checked[i]:=false;

    while not ADOtemp2.Eof do
    begin
      for i:=0 to checklistbox1.Items.Count-1 do
      begin
        ss:=checklistbox1.Items.Strings[i];
        b:=pos('   ',ss);
        sss:=copy(ss,1,b-1);
        if trim(ADOtemp2.FieldByName('组合项目号').AsString)=trim(sss) then
        begin
          checklistbox1.Checked[i]:=true;
          break;
        end;
      end;
      ADOtemp2.Next;
    end;

    ADOtemp2.Free;
end;

procedure TSDIAppForm.DBGrid1DrawColumnCell(Sender: TObject;
  const Rect: TRect; DataCol: Integer; Column: TColumn;
  State: TGridDrawState);
var
  iOne,iNoOne:integer;
  Diagnosetype,sUnid,strPrintTimes:string;
  adotemp11,adotemp22:tadoquery;
begin
   //======================打印过变化颜色======================//
    if datacol=2 then //姓名列
    begin
      strPrintTimes:=ADObasic.fieldbyname('打印时间').AsString;
      IF strPrintTimes<>'' then
      begin
        tdbgrid(sender).Canvas.Font.Color:=clred;
        tdbgrid(sender).DefaultDrawColumnCell(rect,datacol,column,state);
      end;
    end;
   //==========================================================================//

   //=====================常规与急诊用颜色区分=======================//
    if datacol=1 then //样本号列
    begin
      Diagnosetype:=ADObasic.fieldbyname('优先级别').AsString;
      IF Diagnosetype<>CGYXJB then
      begin
        tdbgrid(sender).Canvas.Font.Color:=clblue;
        tdbgrid(sender).DefaultDrawColumnCell(rect,datacol,column,state);
      end;
    end;
   //==========================================================================//
      
   //=====================已检验的申请单变化颜色=======================//
    if datacol=3 then 
    begin
      sUnid:=ADObasic.fieldbyname('唯一编号').AsString;

      adotemp11:=tadoquery.Create(nil);
      adotemp11.Connection:=dm.ADOConnection1;
      adotemp11.Close;
      adotemp11.SQL.Clear;
      adotemp11.SQL.Text:='select count(*) as iNoOne from Chk_Valu_His cvh where cast(cvh.PkUnid as varchar)='''+sUnid+''' and isnull(cvh.itemvalue,'''')<>''1'' ';
      adotemp11.Open;
      iNoOne:=adotemp11.fieldbyname('iNoOne').AsInteger;
      adotemp11.Free;

      adotemp22:=tadoquery.Create(nil);
      adotemp22.Connection:=dm.ADOConnection1;
      adotemp22.Close;
      adotemp22.SQL.Clear;
      adotemp22.SQL.Text:='select count(*) as iOne from Chk_Valu_His cvh where cast(cvh.PkUnid as varchar)='''+sUnid+''' and cvh.itemvalue=''1'' ';
      adotemp22.Open;
      iOne:=adotemp22.fieldbyname('iOne').AsInteger;
      adotemp22.Free;

      IF iOne<=0 then
      begin
        tdbgrid(sender).Canvas.Brush.color:=clYellow;
        if ((State = [gdSelected]) or (State=[gdSelected,gdFocused])) then
        begin
            tdbgrid(sender).Canvas.Brush.color:=clhighlight;
            tdbgrid(sender).Canvas.Font.Color:=clwindow;
        end;
        tdbgrid(sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
      end;
      
      IF (iOne>0) and (iNoOne>0) then
      begin
        tdbgrid(sender).Canvas.Brush.color:=$F0FFFF;
        if ((State = [gdSelected]) or (State=[gdSelected,gdFocused])) then
        begin
            tdbgrid(sender).Canvas.Brush.color:=clhighlight;
            tdbgrid(sender).Canvas.Font.Color:=clwindow;
        end;
        tdbgrid(sender).DefaultDrawColumnCell(Rect,DataCol,Column,State);
      end;
    end;
   //==========================================================================//   
end;

procedure TSDIAppForm.LabeledEdit4Exit(Sender: TObject);
begin
  //国家标准性别代码
  if trim(TLabeledEdit(Sender).Text)='0' then TLabeledEdit(Sender).Text:='未知的性别' else
  if trim(TLabeledEdit(Sender).Text)='1' then TLabeledEdit(Sender).Text:='男' else
  if trim(TLabeledEdit(Sender).Text)='2' then TLabeledEdit(Sender).Text:='女' else
  if trim(TLabeledEdit(Sender).Text)='5' then TLabeledEdit(Sender).Text:='女变男' else
  if trim(TLabeledEdit(Sender).Text)='6' then TLabeledEdit(Sender).Text:='男变女' else
  if trim(TLabeledEdit(Sender).Text)='9' then TLabeledEdit(Sender).Text:='未说明的性别';
end;

function TSDIAppForm.CheckMan: boolean;//20080130
var
  adotemp12:tadoquery;
  ifSuperUser:boolean;
begin
  result:=false;
  if trim(DBGrid1.DataSource.DataSet.FieldByName('审核者').AsString)='' then begin result:=true;exit; end;
  adotemp12:=tadoquery.Create(nil);
  adotemp12.Connection:=DM.ADOConnection1;
  adotemp12.Close;
  adotemp12.SQL.Clear;
  adotemp12.SQL.Text:='select * from worker where ifSuperUser=''1'' ';
  adotemp12.Open;
  ifSuperUser:=adotemp12.Locate('id',trim(operator_id),[loCaseInsensitive]);
  adotemp12.Free;
  if ifSuperUser then begin result:=true;exit; end;
  if uppercase(trim(DBGrid1.DataSource.DataSet.FieldByName('审核者').AsString))=uppercase(trim(operator_name)) then result:=true;
end;

function TSDIAppForm.AddValetudinarianBasicInfo(const PLSH,pcheckid,Ppatientname,Psex,
  Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
  PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,pCombin_id,pGermName:string;
  Pcheck_date,Preport_date,pSJSJ,pJCSJ:TDatetime;
  var ValetudinarianInfoId:integer): boolean;
var
  adotemp2:tadoquery;
  stringTemp:string;
begin
  stringTemp:='Insert into chk_con_his ('+
      ' checkid,lsh,patientname,sex,age,Caseno,bedno,deptname,check_doctor,report_date,report_doctor,operator,Diagnosetype,flagetype,diagnose,typeflagcase,issure,Combin_id,GermName) values ('+//check_date,
      ':P_checkid,:P_lsh,:P_patientname,:P_sex,:P_age,:P_Caseno,:P_bedno,:P_deptname,:P_check_doctor,:P_report_date,:P_report_doctor,:P_operator, '+//:P_check_date,
      ':P_Diagnosetype,:P_flagetype,:P_diagnose,:P_typeflagcase,:P_issure,:Combin_id,:GermName) ';
  adotemp2:=tadoquery.Create(nil);
  adotemp2.Connection:=DM.ADOConnection1;
  adotemp2.Close;
  adotemp2.SQL.Clear;
  adotemp2.SQL.Add(stringTemp);
  adotemp2.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
  adotemp2.Parameters.ParamByName('P_checkid').Value:=pcheckid ;
  adotemp2.Parameters.ParamByName('P_lsh').Value:=Copy(Plsh,1,8) ;
  adotemp2.Parameters.ParamByName('P_patientname').Value:=Copy(Ppatientname,1,14) ;
  adotemp2.Parameters.ParamByName('P_sex').Value:=Copy(Psex,1,8) ;
  adotemp2.Parameters.ParamByName('P_age').Value:=Copy(Page,1,14) ;
  adotemp2.Parameters.ParamByName('P_Caseno').Value:=Copy(PCaseno,1,10) ;
  adotemp2.Parameters.ParamByName('P_bedno').Value:=Copy(Pbedno,1,10) ;
  adotemp2.Parameters.ParamByName('P_deptname').Value:=Copy(Pdeptname,1,40) ;
  adotemp2.Parameters.ParamByName('P_check_doctor').Value:=Copy(Pcheck_doctor,1,14) ;
  adotemp2.Parameters.ParamByName('P_report_date').Value:=strtodatetime(datetostr(Preport_date)+' '+timetostr(pSJSJ)) ;//申请时间
  adotemp2.Parameters.ParamByName('P_report_doctor').Value:=Copy(Preport_doctor,1,14) ;
  adotemp2.Parameters.ParamByName('P_operator').Value:=Copy(Poperator,1,14) ;
  adotemp2.Parameters.ParamByName('P_Diagnosetype').Value:=Copy(PDiagnosetype,1,4) ;
  adotemp2.Parameters.ParamByName('P_flagetype').Value:=Copy(Pflagetype,1,60) ;
  adotemp2.Parameters.ParamByName('P_diagnose').Value:=Copy(Pdiagnose,1,50) ;
  adotemp2.Parameters.ParamByName('P_typeflagcase').Value:=Copy(Ptypeflagcase,1,30) ; //
  adotemp2.Parameters.ParamByName('P_issure').Value:=Pissure ;
  adotemp2.Parameters.ParamByName('Combin_id').Value:=pCombin_id ; //
  adotemp2.Parameters.ParamByName('GermName').Value:=pGermName ; //
  Try
    adotemp2.Open ;
    ValetudinarianInfoId:=adotemp2.fieldbyname('Insert_Identity').AsInteger;
  except
    Application.MessageBox('增加新记录失败!','系统提示',MB_ICONWARNING);
    adotemp2.Free;
    result:=false;
    exit;
  End;

  adotemp2.Free;
  result:=true;
end;

function TSDIAppForm.UpdateValetudinarianBasicInfo(Punid:integer;const PLSH,pcheckid,Ppatientname,Psex,
  Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
  PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,pGermName,pHis_MzOrZy:string;
  Pcheck_date,Preport_date,pSJSJ,pJCSJ:TDatetime;
  var ValetudinarianInfoId:integer): boolean;
var
  adotemp2:tadoquery;
  stringTemp:string;
begin
  if pHis_MzOrZy<>'' then//表示从HIS中取得的信息，不能修改
  begin
    MESSAGEDLG('该病人信息从HIS中取得，不能修改!',MTINFORMATION,[MBOK],0);
    result:=false;
    exit;
  end;
        
  if not checkman then
  begin
    MESSAGEDLG('非您审核，无权修改!',MTINFORMATION,[MBOK],0);
    result:=false;
    exit;
  end;

  stringTemp:=' Update chk_con_his set '+
        ' checkid=:P_checkid,lsh=:P_lsh,patientname=:P_patientname,sex=:P_sex,age=:P_age,Caseno=:P_Caseno,bedno=:P_bedno,deptname=:P_deptname,'+
        'check_doctor=:P_check_doctor,report_date=:P_report_date,operator=:P_operator,'+  //report_doctor=:P_report_doctor,//审核者不需要在此更新//check_date=:P_check_date,
        'Diagnosetype=:P_Diagnosetype,flagetype=:P_flagetype,diagnose=:P_diagnose,typeflagcase=:P_typeflagcase,issure=:P_issure, ' +//age_real=:P_age_real,
        ' GermName=:GermName '+
        ' Where unid=:P_unid';
  adotemp2:=tadoquery.Create(nil);
  adotemp2.Connection:=DM.ADOConnection1;
  adotemp2.Close;
  adotemp2.SQL.Clear;
  adotemp2.SQL.text:=stringTemp ;
  adotemp2.Parameters.ParamByName('P_checkid').Value:=Pcheckid;
  adotemp2.Parameters.ParamByName('P_lsh').Value:=plsh ;
  adotemp2.Parameters.ParamByName('P_patientname').Value:=Copy(Ppatientname,1,14) ;
  adotemp2.Parameters.ParamByName('P_sex').Value:=Copy(Psex,1,8) ;
  adotemp2.Parameters.ParamByName('P_age').Value:=Copy(Page,1,14) ;
  adotemp2.Parameters.ParamByName('P_Caseno').Value:=Copy(PCaseno,1,10) ;
  adotemp2.Parameters.ParamByName('P_bedno').Value:=Copy(Pbedno,1,10) ;
  adotemp2.Parameters.ParamByName('P_deptname').Value:=Copy(Pdeptname,1,40) ;
  adotemp2.Parameters.ParamByName('P_check_doctor').Value:=Copy(Pcheck_doctor,1,14) ;
  adotemp2.Parameters.ParamByName('P_report_date').Value:=strtodatetime(datetostr(preport_date)+' '+timetostr(pSJSJ)) ;
  adotemp2.Parameters.ParamByName('P_operator').Value:=Copy(Poperator,1,14) ;
  adotemp2.Parameters.ParamByName('P_Diagnosetype').Value:=Copy(PDiagnosetype,1,4) ;
  adotemp2.Parameters.ParamByName('P_flagetype').Value:=Copy(Pflagetype,1,60) ;
  adotemp2.Parameters.ParamByName('P_diagnose').Value:=Copy(Pdiagnose,1,50) ;
  adotemp2.Parameters.ParamByName('P_typeflagcase').Value:=Copy(Ptypeflagcase,1,30) ;//
  adotemp2.Parameters.ParamByName('P_issure').Value:=Pissure ; //
  adotemp2.Parameters.ParamByName('GermName').Value:=pGermName ; //
  adotemp2.Parameters.ParamByName('P_unid').Value:=Punid ;
  Try
    adotemp2.EXECSql ;
  except
    on E:Exception do
    begin
      MESSAGEDLG('修改记录失败:'+E.Message,mtError,[mbOK],0);
      adotemp2.Free;
      result:=false;
      exit;
    end;
  end;

  adotemp2.Free;
  ValetudinarianInfoId:=PUNID;
  result:=true;
end;

procedure TSDIAppForm.suiButton6Click(Sender: TObject);
var
  valetudinarianInfoId:integer;

  Punid : integer;
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
  Preport_doctor : string;
  Poperator : string;
  PDiagnosetype : string;
  Pflagetype : string;
  Pdiagnose : string;
  Ptypeflagcase : string;
  pissure:string;
  pSJSJ,pJCSJ:TDATETIME;
  pCombin_id:string;//组别
  pHis_MzOrZy:string;

  AddorUpdateResult:boolean;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit; //权限检查

  PDiagnosetype := trim(LabeledEdit12.text); //string 优先级别
  if PDiagnosetype='' then PDiagnosetype:=CGYXJB;
  if(PDiagnosetype<>CGYXJB)and(PDiagnosetype<>'急诊')and(PDiagnosetype<>'加急')then
  begin
    MessageBox(Handle, '请选择正确的优先级别！', '信息提示', MB_ICONHAND);
    LabeledEdit12.SetFocus;
    exit;
  end;
  Punid := DBGrid1.DataSource.DataSet.fieldbyname('唯一编号').AsInteger;//integer
  PLSH:=TRIM(LABELEDEDIT16.Text);
  Ppatientname := trim(LabeledEdit3.text); //string
  Psex := trim(LabeledEdit4.text); //string
  Page := trim(LabeledEdit5.text); //string
  PCaseno := trim(LabeledEdit2.text); //string
  Pbedno := trim(LabeledEdit7.text); //string
  Pdeptname := trim(LabeledEdit6.text); //string
  Pcheck_date := DateTimePicker2.Date; //TDatetime //检查日期
  Pcheck_doctor := trim(LabeledEdit10.Text); //string  //送检医生
  Preport_date := DateTimePicker1.Date; //TDatetime //申请日期
  Preport_doctor := '';//审核者; //string
  Poperator := operator_name; //string
  Pflagetype := trim(LabeledEdit8.text); //string
  Pdiagnose := trim(LabeledEdit14.text); //string
  Ptypeflagcase := trim(LabeledEdit9.text); //string
  pissure:=trim(labelededit15.Text);
  pSJSJ:=DateTimePicker3.Time;
  pJCSJ:=DateTimePicker4.Time;
  pCombin_id:=trim(cbxConnChar.Text); //组别
  pHis_MzOrZy:=trim(ADObasic.fieldbyname('His门诊或住院').AsString);

  if ADObasic.RecordCount=0 then//当前无记录的情况,则肯定是新增
  begin
      AddorUpdateResult:=AddValetudinarianBasicInfo(PLSH,'',Ppatientname,Psex,
        Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
        PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,pCombin_id,'',
        Pcheck_date,Preport_date,pSJSJ,pJCSJ,
        ValetudinarianInfoId);
  end else//当前有记录的情况
  begin
      if ifnewadd then//新增
      begin
        AddorUpdateResult:=AddValetudinarianBasicInfo(PLSH,'',Ppatientname,Psex,
          Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
          PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,pCombin_id,'',
          Pcheck_date,Preport_date,pSJSJ,pJCSJ,
          ValetudinarianInfoId);
      end else//修改
      begin
        AddorUpdateResult:=UpdateValetudinarianBasicInfo(Punid,PLSH,'',Ppatientname,Psex,
          Page,PCaseno,Pbedno,Pdeptname,Pcheck_doctor,Preport_doctor,Poperator,
          PDiagnosetype,Pflagetype,Pdiagnose,Ptypeflagcase,pissure,'',pHis_MzOrZy,
          Pcheck_date,Preport_date,pSJSJ,pJCSJ,
          ValetudinarianInfoId);
      end;
  end;

  if AddorUpdateResult then
  begin
    UpdateADObasic;
    adobasic.Locate('唯一编号',ValetudinarianInfoId,[loCaseInsensitive]) ;
    update_Ado_dtl;

    LabeledEdit13.SetFocus;
  end;

  if CheckBox1.Checked then NewAddStatus();
end;

procedure TSDIAppForm.suiButton6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
begin
  if key=13 then suiButton6Click(nil);
end;

procedure TSDIAppForm.N15Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

   if not ADObasic.Active then exit;
   if ADObasic.RecordCount=0 then exit;

  frmBatchSpecNo(0).ShowModal; //批审核
end;

procedure TSDIAppForm.N6Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

   if not ADObasic.Active then exit;
   if ADObasic.RecordCount=0 then exit;

  frmBatchSpecNo(1).ShowModal; //批打印
end;

procedure TSDIAppForm.N46Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

   if not ADObasic.Active then exit;
   if ADObasic.RecordCount=0 then exit;

  frmBatchSpecNo(2).ShowModal;
end;

procedure TSDIAppForm.LabeledEdit13KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var b,i,checkunid:integer;
    ss,sss:string;
begin
  if key<>13 then EXIT;

        if (not dsbasic.DataSet.Active) or (dsbasic.DataSet.RecordCount < 1) then
        begin
          Application.MessageBox('请先录入基本信息', '提示信息',
            MB_OK + MB_ICONEXCLAMATION + MB_DEFBUTTON1 + MB_APPLMODAL);
          exit;
        end;

      checkunid:=dsbasic.DataSet.fieldbyname('唯一编号').AsInteger;


  //===================输入'+',是最后条则新增，否则移到下一条============//
  if trim(LabeledEdit13.Text)='+' then
  begin
      ADObasic.Next;
      if LabeledEdit2.CanFocus then  LabeledEdit2.SetFocus else LabeledEdit3.SetFocus;
      exit;
  end;
  //==================================================//

  if not checkman then
  begin
    MESSAGEDLG('非您审核，无权修改!',MTINFORMATION,[MBOK],0);
    LabeledEdit13.Clear;
    LabeledEdit13.SetFocus;
    exit;
  end;

  for i:=0 to CheckListBox1.Count-1 do
  begin
    ss:=checklistbox1.Items.Strings[i];
    b:=pos('   ',ss);
    sss:=copy(ss,1,b);
    if trim(sss)=trim(LabeledEdit13.Text) then
    begin
        checklistbox1.Checked[i]:=not CheckListBox1.Checked[i];

        InsertOrDeleteVaue(sss,checklistbox1.Checked[i],checkunid);

        break;
    end;  //if
  end;
  if trim(LabeledEdit13.Text)<>'+' then
  begin
    tlabelededit(sender).Clear;
    tlabelededit(sender).SetFocus;
  end;
end;

procedure TSDIAppForm.LabeledEdit5Exit(Sender: TObject);
begin
  tlabelededit(sender).Text:=ageConvertChinese(trim(tlabelededit(sender).Text));
end;

procedure TSDIAppForm.update_Ado_dtl;
var
  strsql11:string;
begin
  if not ADObasic.Active then exit;

  strsql11:='select cvh.pkcombin_id as 组合项目号,cvh.combin_name as 组合项目名称,cvh.* from chk_valu_his cvh '+
                        'where '+
                        'pkunid=:pkunid';
  ADO_dtl.Close;
  ADO_dtl.SQL.Clear;
  ADO_dtl.SQL.Text:=strsql11;
  ADO_dtl.Parameters.ParamByName('pkunid').Value :=
      dsbasic.DataSet.FieldByName('唯一编号').AsInteger;
  try
    ADO_dtl.Open;
  except
  end;
end;

procedure TSDIAppForm.ADO_dtlAfterOpen(DataSet: TDataSet);
begin
  checkthelistbox;
  updateDBGrid2;
end;

procedure TSDIAppForm.InsertOrDeleteVaue(const ComboItemID:string;const ifAddorDel:boolean;const checkunid:integer);
var
      adotemp3,adotemp5,adotemp11: tadoquery;
      sName:string;
      iNum,RecNum:integer;
begin
      if ifAddorDel then
      //==========================增加插入=================================//
      begin
          adotemp5:=tadoquery.Create(nil);
          adotemp5.Connection:=DM.ADOConnection1;
          adotemp5.Close;
          adotemp5.SQL.Clear;
          adotemp5.SQL.Text:='select Name from combinitem where id='''+trim(ComboItemID)+''' ';
          adotemp5.Open;
          sName:=adotemp5.fieldbyname('Name').AsString;
          adotemp5.Free;

        adotemp3:=tadoquery.Create(nil);
        adotemp3.Connection:=DM.ADOConnection1;
        adotemp3.Close;
        adotemp3.SQL.Clear;
        adotemp3.SQL.Text:='select count(*) as iNum from chk_valu_his where pkunid='+inttostr(checkunid)+' and pkcombin_id='''+trim(ComboItemID)+''' ';
        adotemp3.Open;
        iNum:=adotemp3.fieldbyname('iNum').AsInteger;
        adotemp3.Free;
        if iNum<=0 then
        begin
          adotemp5:=tadoquery.Create(nil);
          adotemp5.Connection:=DM.ADOConnection1;
          adotemp5.Close;
          adotemp5.SQL.Clear;
          adotemp5.SQL.Text:='insert into chk_valu_his (pkunid,pkcombin_id,combin_Name) values ('+inttostr(checkunid)+','''+trim(ComboItemID)+''','''+sName+''') ';
          adotemp5.ExecSQL;
          adotemp5.Free;
        end;
      end  //if ifAddorDel
        //===============================================================================//
      else
      begin
      //======================减少删除==================================================//
        adotemp11:=tadoquery.Create(nil);
        adotemp11.Connection:=DM.ADOConnection1;
        adotemp11.Close;
        adotemp11.SQL.Clear;
        adotemp11.SQL.Text:='select count(*) as RecNum from chk_valu_his where pkunid='+inttostr(checkunid)+' and pkcombin_id='''+trim(ComboItemID)+''' and itemvalue=''1'' ';
        adotemp11.Open;
        RecNum:=adotemp11.fieldbyname('RecNum').AsInteger;
        adotemp11.Free;

        if RecNum<=0 then
        begin
          adotemp5:=tadoquery.Create(nil);
          adotemp5.Connection:=DM.ADOConnection1;
          adotemp5.Close;
          adotemp5.SQL.Clear;
          adotemp5.SQL.Text:='delete from chk_valu_his where pkunid='+inttostr(checkunid)+' and pkcombin_id='''+trim(ComboItemID)+''' ';
          adotemp5.ExecSQL;
          adotemp5.Free;
        end else MESSAGEDLG('该申请已被科室处理,不能删除!',mtError,[MBOK],0);
      end;

      ADO_dtl.Close;
      ADO_dtl.Parameters.ParamByName('pkunid').Value := checkunid;
      ADO_dtl.Open;
end;

procedure TSDIAppForm.ADObasicAfterScroll(DataSet: TDataSet);
begin
      FillBasic;
      
      if not ifBatchOperater then update_Ado_dtl;

    ifnewadd:=false;
end;

procedure TSDIAppForm.N44Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmCheckDate.ShowModal;
end;

procedure TSDIAppForm.cbxConnCharChange(Sender: TObject);
begin
  ClearAll(2);
  UpdateADObasic;
  update_Ado_dtl;
end;

procedure TSDIAppForm.O1Click(Sender: TObject);
var                                                                           
  ss:string;
  sWorkGroup:string;
  adotemp3:tadoquery;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  adotemp3:=tadoquery.Create(nil);
  adotemp3.Connection:=DM.ADOConnection1;
  adotemp3.Close;
  adotemp3.SQL.Clear;
  adotemp3.SQL.Text:='select name from CommCode where TypeName=''检验组别'' group by name';
  adotemp3.Open;
  while not adotemp3.Eof do
  begin
    sWorkGroup:=sWorkGroup+#13+trim(adotemp3.fieldbyname('name').AsString);
    adotemp3.Next;
  end;
  adotemp3.Free;
  sWorkGroup:=trim(sWorkGroup);

  ss:='报表标题'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+        
      '打印时自动审核申请单'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
      '根据"门诊/住院号"提取备注'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
      '填写病人基本信息时,直接回车弹出取码框'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
      '送检科室取码的匹配方式'+#2+'Combobox'+#2+'模糊匹配'+#13+'左匹配'+#13+'右匹配'+#13+'全匹配'+#2+'1'+#2+#2+#3+
      '送检医生取码的匹配方式'+#2+'Combobox'+#2+'模糊匹配'+#13+'左匹配'+#13+'右匹配'+#13+'全匹配'+#2+'1'+#2+#2+#3+
      '送检医生默认为登录者'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
      '送检科室默认为登录者科室'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
      '仅显示登录者所开申请单'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
      '病人基本信息排序方式'+#2+'Combobox'+#2+'唯一编号'+#13+'流水号'+#2+'1'+#2+#2+#3+
      '弹出登录窗口的时间'+#2+'Edit'+#2+#2+'1'+#2+'注:表示多长时间内无操作,则自动弹出登录窗口(单位:秒)'+#2+#3+
      '筛选时用病历号的前几位匹配'+#2+'Edit'+#2+#2+'1'+#2+#2+#3+
      '病历号回车打印标签'+#2+'CheckListBox'+#2+#2+'1'+#2+#2+#3+
      '通用模板文件'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '分组模板文件'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '体检模板文件'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '直方图模板工作组'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '直方图模板文件'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '血型模板工作组'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '血型模板文件'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '特殊模板1工作组'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '特殊模板1文件'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '特殊模板2工作组'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '特殊模板2文件'+#2+'File'+#2+#2+'2'+#2+#2+#3+
      '特殊模板3工作组'+#2+'Combobox'+#2+sWorkGroup+#2+'2'+#2+#2+#3+
      '特殊模板3文件'+#2+'File'+#2+#2+'2'+#2+#2+#3;
  if ShowOptionForm('选项','报表'+#2+'选项'+#2+'打印模板',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
	  ReadIni;
end;

procedure TSDIAppForm.LabeledEdit2KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=dm.ADOConnection1;
  tmpADOLYGetcode.GetCodePos:=gcAll;
  tmpADOLYGetcode.IfShowDialogZeroRecord:=false;
  tmpADOLYGetcode.OpenStr:='select caseno as 病历号,patientname as 姓名,sex as 性别,age as 年龄,deptname as 送检科室,check_doctor as 送检医生,issure as 备注 from view_Chk_Con_All where isnull(caseno,'''')<>'''' order by unid desc';//最近输入的显示在最前(一般希望选择最近的病历) 
  tmpADOLYGetcode.InField:='caseno';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
    LabeledEdit3.Text:=tmpADOLYGetcode.OutValue[1];
    LabeledEdit4.Text:=tmpADOLYGetcode.OutValue[2];
    LabeledEdit5.Text:=tmpADOLYGetcode.OutValue[3];
    LabeledEdit6.Text:=tmpADOLYGetcode.OutValue[4];
    LabeledEdit10.Text:=tmpADOLYGetcode.OutValue[5];
    if ifGetMemoFromCaseNo then LabeledEdit15.Text:=tmpADOLYGetcode.OutValue[6];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit12KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.IfNullGetCode:=ifEnterGetCode;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from CommCode where TypeName=''优先级别'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit6KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  if deptname_match='全匹配' then tmpADOLYGetcode.GetCodePos:=gcAll
    else if deptname_match='左匹配' then tmpADOLYGetcode.GetCodePos:=gcLeft
      else if deptname_match='右匹配' then tmpADOLYGetcode.GetCodePos:=gcRight
        else tmpADOLYGetcode.GetCodePos:=gcNone;
  tmpADOLYGetcode.IfNullGetCode:=ifEnterGetCode;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from CommCode where TypeName=''部门'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit10KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  if check_doctor_match='全匹配' then tmpADOLYGetcode.GetCodePos:=gcAll
    else if check_doctor_match='左匹配' then tmpADOLYGetcode.GetCodePos:=gcLeft
      else if check_doctor_match='右匹配' then tmpADOLYGetcode.GetCodePos:=gcRight
        else tmpADOLYGetcode.GetCodePos:=gcNone;
  tmpADOLYGetcode.IfNullGetCode:=ifEnterGetCode;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from worker';
  tmpADOLYGetcode.InField:='id,wbm,pinyin';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit8KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.IfNullGetCode:=ifEnterGetCode;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from CommCode where TypeName=''样本类型'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit9KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.IfNullGetCode:=ifEnterGetCode;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from CommCode where TypeName=''样本状态'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit14KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.GetCodePos:=gcLeft;
  tmpADOLYGetcode.IfNullGetCode:=ifEnterGetCode;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from CommCode where TypeName=''临床诊断'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit15KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.IfNullGetCode:=ifEnterGetCode;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from CommCode where TypeName=''备注'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.LabeledEdit18KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  tmpADOLYGetcode:TADOLYGetcode;
begin
  if key<>13 then exit;
  tmpADOLYGetcode:=TADOLYGetcode.create(nil);
  tmpADOLYGetcode.Connection:=DM.ADOConnection1;
  tmpADOLYGetcode.IfNullGetCode:=ifEnterGetCode;
  tmpADOLYGetcode.OpenStr:='select name as 名称 from CommCode where TypeName=''细菌'' ';
  tmpADOLYGetcode.InField:='id,wbm,pym';
  tmpADOLYGetcode.InValue:=tLabeledEdit(sender).Text;
  tmpADOLYGetcode.ShowX:=left+tLabeledEdit(SENDER).Parent.Left+tLabeledEdit(SENDER).Left;
  tmpADOLYGetcode.ShowY:=top+22{当前窗体标题栏高度}+21{当前窗体菜单高度}+tLabeledEdit(SENDER).Parent.Top+tLabeledEdit(SENDER).Parent.Parent.Top{Panel7}+tLabeledEdit(SENDER).Top+tLabeledEdit(SENDER).Height;

  if tmpADOLYGetcode.Execute then
  begin
    tLabeledEdit(SENDER).Text:=tmpADOLYGetcode.OutValue[0];
  end;
  tmpADOLYGetcode.Free;
end;

procedure TSDIAppForm.FormClose(Sender: TObject; var Action: TCloseAction);
begin
  if MessageDlg('确实要退出系统吗?', mtInformation, [mbNo,mbYes], 0 ) = mrYes then
  begin
    //if ifAutoCompletionJob then CompletionJob;
    action:=cafree;
  end else action:=caNone;
end;

procedure TSDIAppForm.UpdateStatusBar(const text: string);
//Text为该格式#$2+'0:abc'+#$2+'1:def'表示状态栏第0格显示abc,第1格显示def,依此类推
var
  i,J2Pos,J2Len,TextLen,j:integer;
  tmpText:string;
begin
  TextLen:=length(text);
  for i :=0 to StatusBar1.Panels.Count-1 do
  begin
    J2Pos:=pos(#$2+inttostr(i)+':',text);
    J2Len:=length(#$2+inttostr(i)+':');
    if J2Pos<>0 then
    begin
      tmpText:=text;
      tmpText:=copy(tmpText,J2Pos+J2Len,TextLen-J2Pos-J2Len+1);
      j:=pos(#$2,tmpText);
      if j<>0 then tmpText:=leftstr(tmpText,j-1);
      StatusBar1.Panels[i].Text:=tmpText;
    end;
  end;
end;

procedure TSDIAppForm.WMUpdateTextStatus(var message: twmupdatetextstatus);
begin
  UpdateStatusBar(pchar(message.Text));
  message.Result:=-1;
end;

procedure TSDIAppForm.cbxConnCharEnter(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then LabeledEdit2.SetFocus;//无权限则cbxConnChar失去焦点
end;

procedure TSDIAppForm.N31Click(Sender: TObject);
begin
  LabeledEdit16.Enabled:=not LabeledEdit16.Enabled;
end;

procedure TSDIAppForm.N39Click(Sender: TObject);
begin
  LabeledEdit2.Enabled:=not LabeledEdit2.Enabled;
end;

procedure TSDIAppForm.N43Click(Sender: TObject);
begin
  LabeledEdit6.Enabled:=not LabeledEdit6.Enabled;
end;

procedure TSDIAppForm.N51Click(Sender: TObject);
begin
  LabeledEdit7.Enabled:=not LabeledEdit7.Enabled;
end;

procedure TSDIAppForm.N52Click(Sender: TObject);
begin
  LabeledEdit10.Enabled:=not LabeledEdit10.Enabled;
end;

procedure TSDIAppForm.N19Click(Sender: TObject);
begin
  LabeledEdit8.Enabled:=not LabeledEdit8.Enabled;
end;

procedure TSDIAppForm.N54Click(Sender: TObject);
begin
  LabeledEdit9.Enabled:=not LabeledEdit9.Enabled;
end;

procedure TSDIAppForm.N55Click(Sender: TObject);
begin
  LabeledEdit14.Enabled:=not LabeledEdit14.Enabled;
end;

procedure TSDIAppForm.N56Click(Sender: TObject);
begin
  DateTimePicker1.Enabled:=not DateTimePicker1.Enabled;
end;

procedure TSDIAppForm.N57Click(Sender: TObject);
begin
  DateTimePicker3.Enabled:=not DateTimePicker3.Enabled;
end;

procedure TSDIAppForm.N61Click(Sender: TObject);
begin
  LabeledEdit15.Enabled:=not LabeledEdit15.Enabled;
end;

procedure TSDIAppForm.ADObasicAfterOpen(DataSet: TDataSet);
begin
  updatedbgrid1;
end;

procedure TSDIAppForm.Excel2Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmFromExcelLoad.ShowModal;
end;

procedure TSDIAppForm.ReadIni;
var
  configini:tinifile;

  pInStr,pDeStr:Pchar;
  i:integer;
  adotemp22:tadoquery;
begin
  //读系统代码
  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=dm.ADOConnection1;
  adotemp22.Close;
  adotemp22.SQL.Clear;
  adotemp22.SQL.Text:='select Name from CommCode where TypeName=''系统代码'' and ReMark=''授权使用单位'' ';
  adotemp22.Open;
  SCSYDW:=adotemp22.fieldbyname('Name').AsString;
  adotemp22.Free;
  if SCSYDW='' then SCSYDW:='2F3A054F64394BBBE3D81033FDE12313';//'未授权单位'加密后的字符串
  //======解密SCSYDW
  pInStr:=pchar(SCSYDW);
  pDeStr:=DeCryptStr(pInStr,CryptStr);
  setlength(SCSYDW,length(pDeStr));
  for i :=1  to length(pDeStr) do SCSYDW[i]:=pDeStr[i-1];
  //==========

  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));

  BBBT:=TRIM(configini.ReadString('报表','报表标题',''));
  ifAutoCheck:=configini.ReadBool('选项','打印时自动审核申请单',false);
  ifEnterGetCode:=configini.ReadBool('选项','填写病人基本信息时,直接回车弹出取码框',false);
  deptname_match:=configini.ReadString('选项','送检科室取码的匹配方式','');
  check_doctor_match:=configini.ReadString('选项','送检医生取码的匹配方式','');
  ifDefaultDoctor:=configini.ReadBool('选项','送检医生默认为登录者',false);
  ifDefaultDepartment:=configini.ReadBool('选项','送检科室默认为登录者科室',false);
  ShowSelfDJ:=configini.ReadBool('选项','仅显示登录者所开申请单',false);
  ifGetMemoFromCaseNo:=configini.ReadBool('选项','根据"门诊/住院号"提取备注',false);
  OrderType:=configini.ReadString('选项','病人基本信息排序方式','');
  OrderType:=ifThen(OrderType='流水号','right(''0000''+cch.lsh,4)','唯一编号');
  LoginTime:=configini.ReadInteger('选项','弹出登录窗口的时间',30);
  CaseNoMatchingNum:=configini.ReadInteger('选项','筛选时用病历号的前几位匹配',MaxInt);
  CaseNoCrPrintLabel:=configini.ReadBool('选项','病历号回车打印标签',false);

  TempFile_Common:=configini.ReadString('打印模板','通用模板文件','');
  TempFile_Group:=configini.ReadString('打印模板','分组模板文件','');
  TempFile_TJ:=configini.ReadString('打印模板','体检模板文件','');
  WorkGroup_ZFT:=configini.ReadString('打印模板','直方图模板工作组','');
  TempFile_ZFT:=configini.ReadString('打印模板','直方图模板文件','');
  WorkGroup_XX:=configini.ReadString('打印模板','血型模板工作组','');
  TempFile_XX:=configini.ReadString('打印模板','血型模板文件','');
  WorkGroup_T1:=configini.ReadString('打印模板','特殊模板1工作组','');
  TempFile_T1:=configini.ReadString('打印模板','特殊模板1文件','');
  WorkGroup_T2:=configini.ReadString('打印模板','特殊模板2工作组','');
  TempFile_T2:=configini.ReadString('打印模板','特殊模板2文件','');
  WorkGroup_T3:=configini.ReadString('打印模板','特殊模板3工作组','');
  TempFile_T3:=configini.ReadString('打印模板','特殊模板3文件','');  

  configini.Free;
end;

procedure TSDIAppForm.N37Click(Sender: TObject);
var
  ss:string;
begin
  ss:='RegisterNum'+#2+'Edit'+#2+#2+'0'+#2+'将该窗体标题栏上的字符串发给开发者,以获取注册码'+#2;
  if bRegister then exit;
  //函数返回的Pchar类型还真能直接赋值给string!!!
  if ShowOptionForm(Pchar('注册:'+GetHDSn('C:\')+'-'+GetHDSn('D:\')),'Register',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini')))then
    if ifRegister then bRegister:=true else bRegister:=false;
end;

procedure TSDIAppForm.N25Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

    tmenuitem(sender).Checked:= not tmenuitem(sender).Checked;
end;

procedure TSDIAppForm.SpeedButton1Click(Sender: TObject);
var
  LYLocateRecord:TLYLocateRecord;
begin
  LYLocateRecord:=TLYLocateRecord.create(nil);
  LYLocateRecord.DataSource:=DSbasic;
  LYLocateRecord.Execute;
  LYLocateRecord.free;
end;

procedure TSDIAppForm.LabeledEdit1KeyDown(Sender: TObject; var Key: Word;
  Shift: TShiftState);
var
  adotemp11:tadoquery;
  i:integer;
  sName:string;
begin
  if key<>13 then exit;

  if TLabeledEdit(Sender).CanFocus then TLabeledEdit(Sender).SetFocus;
  TLabeledEdit(Sender).SelectAll;

  if not CaseNoCrPrintLabel then exit;

  if not ADObasic.Active then exit;

  if ADObasic.RecordCount>30 then exit;

  i:=0;
  adotemp11:=tadoquery.Create(nil);
  adotemp11.clone(ADObasic);
  sName:=adotemp11.fieldbyname('姓名').AsString;
  while not adotemp11.Eof do
  begin
    if sName<>adotemp11.fieldbyname('姓名').AsString then
    begin
      i:=1;
      break;
    end;
    adotemp11.Next;
  end;
  adotemp11.Free;

  if i=1 then exit;
  
  ADObasic.First;
  while not ADObasic.Eof do
  begin
    ToolButton8Click(nil);
    ADObasic.Next;
  end;
end;

procedure TSDIAppForm.frReport1BeforePrint(Memo: TStringList;
  View: TfrView);
var
  adotemp11:tadoquery;
  unid:integer;
  report_doctor,sql,sPrinttimes,sReport_doctor:string;
begin
  //可能要打印审核者，故只能在BeforePrint事件中处理.(其实在PrintReport中处理更合理)
  if not ADObasic.Active then exit;
  if not ADObasic.RecordCount=0 then exit;

  unid:=ADObasic.fieldbyname('唯一编号').AsInteger;
  sPrinttimes:=ADObasic.fieldbyname('打印时间').AsString;
  report_doctor:=trim(ADObasic.fieldbyname('审核者').AsString);

  //if printtimes=0 then sPrinttimes:=' printtimes='+inttostr(printtimes+1) else sPrinttimes:='';//修改打印次数
  //sPrinttimes:=' printtimes=getdate ';//修改打印次数
  if(ifAutoCheck)and(report_doctor='') then sReport_doctor:=' ,report_doctor='''+operator_name+''',Audit_Date=getdate() ' else sReport_doctor:='';//修改审核者
   
  //if(sPrinttimes='')and(sReport_doctor='')then exit;
  //if(sPrinttimes<>'')and(sReport_doctor<>'')then ss:=',' else ss:='';

  sql:='update chk_con_his set printtimes=getdate() '+sReport_doctor+' where unid='+inttostr(unid);
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:=sql;
  adotemp11.ExecSQL;
  adotemp11.Free;

  if (sPrinttimes='') or (sReport_doctor<>'') then
  adobasic.Refresh;//打印后要显示红色、更新显示审核者
end;

procedure TSDIAppForm.LabeledEdit3Change(Sender: TObject);
var
  ini:tinifile;
  XrfMc:string;//以前设置的输入法名称
  CurImeName:string;
begin
  //保存当前输入法
  CurImeName:=GetSysCurImeName;//函数返回的Pchar类型还真能直接赋值给string!!!
  ini:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  XrfMc:=ini.ReadString('输入法选择','默认中文输入法','');
  if (XrfMc<>CurImeName)and(CurImeName<>'') then
  begin
    ini.WriteString('输入法选择','默认中文输入法',CurImeName);
    ChangeYouFormAllControlIme(Self);//设置中文输入法
  end;
  ini.Free;
  //==============
end;

procedure TSDIAppForm.TimerIdleTrackerTimer(Sender: TObject);
begin
//自动弹出登录窗口
  if(GetTickCount-IdleTrackerGetLastTickCount>LoginTime*1000)and(FindWindow(PCHAR('TfrmLogin'),PCHAR('登录'))=0) then
    frmLogin.ShowModal;
end;

procedure TSDIAppForm.SpeedButton5Click(Sender: TObject);
begin
  NewAddStatus();
end;

procedure TSDIAppForm.N64Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

    tmenuitem(sender).Checked:= not tmenuitem(sender).Checked;
end;

procedure TSDIAppForm.N69Click(Sender: TObject);
begin
  copyName:=trim(LabeledEdit3.text);
  copySex:=trim(LabeledEdit4.text);
  copyage:=trim(LabeledEdit5.text);
  copyCaseno:=trim(LabeledEdit2.text);
  copyBedno:=trim(LabeledEdit7.text);
  copydeptname:=trim(LabeledEdit6.text);
  copycheck_doctor:=trim(LabeledEdit10.text);
end;

procedure TSDIAppForm.N70Click(Sender: TObject);
begin
  LabeledEdit3.text:=copyName;
  LabeledEdit4.text:=copySex;
  LabeledEdit5.text:=copyage;
  LabeledEdit2.text:=copyCaseno;
  LabeledEdit7.text:=copyBedno;
  LabeledEdit6.text:=copydeptname;
  LabeledEdit10.text:=copycheck_doctor;
end;

procedure TSDIAppForm.SpeedButton2Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

   if not ADObasic.Active then exit;
   if ADObasic.RecordCount=0 then exit;

  g_Printtime:=ADObasic.fieldbyname('打印时间').AsString;

   if not ifAutoCheck then  //打印前要检查是否已被审核
   begin
     if trim(ADObasic.FieldByName('审核者').AsString)='' then
     begin
      MessageBox(Handle, '请先审核！', '系统提示', MB_ICONASTERISK);
      exit;
     end;
   end;

    if not frReport1.LoadFromFile('report_Application_Form.frf') then
    begin
      showmessage('加载默认申请单打印模板report_Application_Form.frf失败');
      exit;
    end;


    //frReport1.Pages.Pages[0].pgsize:=255;//.pgHeight:=70;
    //frReport1.Pages.Pages[0].pgHeight:=70;
    //frReport1.Pages[0].ChangePaper($100,2100,1500,-1,poPortrait);  //1 inch=2.54 cm

    if n9.Checked then  //预览模式
      frReport1.ShowReport;
    if n8.Checked then  //直接打印模式
    begin
      if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
    end;
end;

procedure TSDIAppForm.N11Click(Sender: TObject);
VAR
  Save_Cursor:TCursor;
  adotemp11:tadoquery;
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  if (MessageDlg('是否归档已完成的申请?', mtConfirmation, [mbYes, mbNo], 0) <> mrYes) then exit;

  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=dm.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:='PRO_Completion_Chk_His';

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    { Show hourglass cursor }
  try
    adotemp11.ExecSQL;
  finally
    adotemp11.Free;
    Screen.Cursor := Save_Cursor;  { Always restore to normal }
  end;

  UpdateADObasic;
  update_Ado_dtl;
end;

procedure TSDIAppForm.N16Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmCopyInfo.ShowModal;
end;

procedure TSDIAppForm.N18Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmCommQuery.ShowModal;
end;

procedure TSDIAppForm.N21Click(Sender: TObject);
//var
//  adotemp11,adotemp22:tadoquery;
//  RecNum_Con,RecNum:integer;
begin
{  if not ifhaspower(sender,powerstr_js_main) then exit;

  if not (Sender as TMenuItem).Checked then
  begin
    adotemp11:=Tadoquery.Create(nil);
    adotemp11.Connection:=dm.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=
    'select count(*) as RecNum_Con from dbo.sysobjects where id = object_id(N''[dbo].[TRIGGER_Lsh_Verify_Con]'') and OBJECTPROPERTY(id, N''IsTrigger'') = 1';
    adotemp11.Open;
    RecNum_Con:=adotemp11.fieldbyname('RecNum_Con').AsInteger;
    adotemp11.Free;
    if RecNum_Con<=0 then
    begin
      adotemp11:=Tadoquery.Create(nil);
      adotemp11.Connection:=dm.ADOConnection1;
      adotemp11.Close;
      adotemp11.SQL.Clear;
      adotemp11.SQL.Text:=
      ' CREATE TRIGGER TRIGGER_Lsh_Verify_Con ON chk_con_his '+
      ' FOR UPDATE '+
      ' AS '+
      '  declare @unid int,@RecNum int,@flagetype varchar(60) '+
      '  select @flagetype=flagetype,@unid=unid  from inserted '+
      '  if (@unid is null) return '+
      '  if isnull(@flagetype,'''')='''' return '+
      '  select @RecNum=count(*) from chk_valu_his i,combinitem c where i.pkcombin_id=c.id and isnull(specimentype_DfValue,'''')<>isnull(@flagetype,'''') and i.pkunid=@unid '+
      '  if @RecNum>0 '+
      '  begin '+
      '    raiserror (''已启用样本的组合项目校验,样本类型校验错误!'',16,1) '+
      '    ROLLBACK TRANSACTION'+
      '  end ';
      adotemp11.ExecSQL;
      adotemp11.Free;
    end;

    adotemp11:=Tadoquery.Create(nil);
    adotemp11.Connection:=dm.ADOConnection1;
    adotemp11.Close;
    adotemp11.SQL.Clear;
    adotemp11.SQL.Text:=
    'select count(*) as RecNum from dbo.sysobjects where id = object_id(N''[dbo].[TRIGGER_Lsh_Verify]'') and OBJECTPROPERTY(id, N''IsTrigger'') = 1';
    adotemp11.Open;
    RecNum:=adotemp11.fieldbyname('RecNum').AsInteger;
    adotemp11.Free;
    if RecNum<=0 then
    begin
      adotemp11:=Tadoquery.Create(nil);
      adotemp11.Connection:=dm.ADOConnection1;
      adotemp11.Close;
      adotemp11.SQL.Clear;
      adotemp11.SQL.Text:=
      'CREATE TRIGGER TRIGGER_Lsh_Verify ON chk_valu_his '+
      'FOR INSERT, UPDATE '+
      'AS '+
      '  declare @pkunid int,@pkcombin_id varchar(10),@specimentype_DfValue varchar(60),@RecNum int,@itemtype varchar(50) '+
      '  select @itemtype=itemtype,@specimentype_DfValue=specimentype_DfValue,@pkunid=pkunid  from inserted i,combinitem c where i.pkcombin_id=c.id '+
      '  if (@pkunid is null) return '+
      '  select @RecNum=count(*)  from chk_valu_his i,combinitem c where i.pkcombin_id=c.id and isnull(specimentype_DfValue,'''')<>isnull(@specimentype_DfValue,'''') and i.pkunid=@pkunid '+
      '  if @RecNum>0 '+
      '  begin '+
      '    raiserror (''已启用样本的组合项目校验,样本类型校验错误!'',16,1) '+
      '    ROLLBACK TRANSACTION '+
      '  end '+
      '  declare @RecNum2 int '+
      '  select @RecNum2=count(*)  from chk_valu_his i,combinitem c where i.pkcombin_id=c.id and isnull(itemtype,'''')<>isnull(@itemtype,'''') and i.pkunid=@pkunid '+
      '  if @RecNum2>0 '+
      '  begin '+
      '    raiserror (''已启用样本的组合项目校验,样本分隔符校验错误!'',16,1) '+
      '    ROLLBACK TRANSACTION '+
      '  end '+
      '  declare @flagetype varchar(60) '+
      '  select @flagetype=flagetype from chk_con_his cch where unid=@pkunid '+
      '  if isnull(@flagetype,'''')='''' return '+
      '  if isnull(@flagetype,'''')<>isnull(@specimentype_DfValue,'''') '+
      '  begin '+
      '    raiserror (''已启用样本的组合项目校验,样本类型校验错误!'',16,1) '+
      '    ROLLBACK TRANSACTION '+
      '  end ';
      adotemp11.ExecSQL;
      adotemp11.Free;
    end;
  end ELSE
  begin
    adotemp22:=Tadoquery.Create(nil);
    adotemp22.Connection:=dm.ADOConnection1;
    adotemp22.Close;
    adotemp22.SQL.Clear;
    adotemp22.SQL.Text:=
    ' if exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[TRIGGER_Lsh_Verify_Con]'') and OBJECTPROPERTY(id, N''IsTrigger'') = 1) '+
    ' drop trigger [dbo].[TRIGGER_Lsh_Verify_Con]';
    adotemp22.ExecSQL;
    adotemp22.Free;

    adotemp22:=Tadoquery.Create(nil);
    adotemp22.Connection:=dm.ADOConnection1;
    adotemp22.Close;
    adotemp22.SQL.Clear;
    adotemp22.SQL.Text:=
    ' if exists (select * from dbo.sysobjects where id = object_id(N''[dbo].[TRIGGER_Lsh_Verify]'') and OBJECTPROPERTY(id, N''IsTrigger'') = 1) '+
    ' drop trigger [dbo].[TRIGGER_Lsh_Verify]';
    adotemp22.ExecSQL;
    adotemp22.Free;
  end;//}
end;

procedure TSDIAppForm.Edit1Click(Sender: TObject);
var
  adotemp11:tadoquery;
  RecNum_Con,RecNum:integer;
begin
  RecNum_Con:=0;
  RecNum:=0;
  
  adotemp11:=Tadoquery.Create(nil);
  adotemp11.Connection:=dm.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:=
  'select count(*) as RecNum_Con from dbo.sysobjects where id = object_id(N''[dbo].[TRIGGER_Lsh_Verify_Con]'') and OBJECTPROPERTY(id, N''IsTrigger'') = 1';
  try
    adotemp11.Open;
    RecNum_Con:=adotemp11.fieldbyname('RecNum_Con').AsInteger;
  except
  end;
  adotemp11.Free;

  adotemp11:=Tadoquery.Create(nil);
  adotemp11.Connection:=dm.ADOConnection1;
  adotemp11.Close;
  adotemp11.SQL.Clear;
  adotemp11.SQL.Text:=
  'select count(*) as RecNum from dbo.sysobjects where id = object_id(N''[dbo].[TRIGGER_Lsh_Verify]'') and OBJECTPROPERTY(id, N''IsTrigger'') = 1';
  try
    adotemp11.Open;
    RecNum:=adotemp11.fieldbyname('RecNum').AsInteger;
  except
  end;
  adotemp11.Free;

  N21.Checked:=(RecNum_Con>0) and (RecNum>0);
end;

procedure TSDIAppForm.N14Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

  frmstaticcombitem.ShowModal;
end;

procedure TSDIAppForm.pmChangeGroupPopup(Sender: TObject);
const
  sqll='select name from CommCode where TypeName=''申请单工作组'' group by name';
var
  adotemp3:tadoquery;
  delMenuItem,TempMenuItem:TMenuItem;
  tempstr:string;
  i,j:integer;
begin
     adotemp3:=tadoquery.Create(nil);
     adotemp3.Connection:=DM.ADOConnection1;
     adotemp3.Close;
     adotemp3.SQL.Clear;
     adotemp3.SQL.Text:=sqll;
     adotemp3.Open;
     adotemp3.First;
     
     //加载前先清除pmChangeGroup项
     for j := pmChangeGroup.Items.Count-1 downto 0 do
     begin
          if (pmChangeGroup.Items.Items[j] is TMenuItem)then
          begin
            delMenuItem := pmChangeGroup.Items.Items[j];
            if(delMenuItem.Caption<>'更换组别')and(delMenuItem.Caption<>'-') then
            //这就要求组别设置时，不能设置"更换组别"及"-"
              if (delMenuItem <> nil) then FreeandNIl(delMenuItem);
          end;
     end;

     i:=0;
     while not adotemp3.Eof do
     begin
      inc(i);
      tempstr:=trim(adotemp3.fieldbyname('name').AsString);

      //加载到pmChangeGroup
      TempMenuItem := TMenuItem.Create(self);
      TempMenuItem.Name := 'Temp' + inttostr(i);
      TempMenuItem.Caption := tempstr;
      TempMenuItem.OnClick:=pmChangeGroupItemClick;
      pmChangeGroup.Items.Add(TempMenuItem);

      adotemp3.Next;
     end;
     adotemp3.Free;
end;

procedure TSDIAppForm.pmChangeGroupItemClick(Sender: TObject);
var
  ADOTEMP22:TADOQUERY;
  Insert_Identity:INTEGER;
begin
  if not adobasic.Active then exit;
  if adobasic.RecordCount=0 then exit;
  if trim(adobasic.FieldByName('组别').AsString)=trim(tmenuitem(sender).Caption) then exit;

  if not checkman then
  begin
    MESSAGEDLG('非您审核，无权修改!',MTINFORMATION,[MBOK],0);
    exit;
  end;
  if application.MessageBox(Pchar('您确实要将该病人更换为'+trim(tmenuitem(sender).Caption)+'吗?'),'系统提示', MB_OKCANCEL+MB_ICONINFORMATION)<>IDOK then exit;

  Insert_Identity:=adobasic.fieldbyname('唯一编号').AsInteger;

  ADOTEMP22:=TADOQUERY.Create(NIL);
  ADOTEMP22.Connection:=DM.ADOConnection1;
  ADOTEMP22.Close;
  ADOTEMP22.SQL.Clear;
  ADOTEMP22.SQL.Add('update chk_con_his set combin_id='''+tmenuitem(sender).Caption+''' where unid='+inttostr(Insert_Identity));
  ADOTEMP22.ExecSQL;
  ADOTEMP22.Free;

  UpdateADObasic;//换组后刷新当前组的显示
end;

procedure TSDIAppForm.LoadToolMenu(const ToolMenuItem: TMenuItem;
  const ASel: string);
var
  adotemp3:tadoquery;
  delMenuItem,TempMenuItem:TMenuItem;
  tempstr:string;
  i,j:integer;
begin
  adotemp3:=tadoquery.Create(nil);
  adotemp3.Connection:=DM.ADOConnection1;
  adotemp3.Close;
  adotemp3.SQL.Clear;
  adotemp3.SQL.Text:=ASel;
  adotemp3.Open;

  //加载前先清除工具菜单项
  for j := ToolMenuItem.Count-1 downto 0 do
  begin
      if (ToolMenuItem.Items[j] is TMenuItem)then
      begin
        delMenuItem := ToolMenuItem.Items[j];
        if (delMenuItem <> nil) then FreeandNIl(delMenuItem);
      end;
  end;

  i:=0;
  while not adotemp3.Eof do
  begin
    inc(i);
    tempstr:=trim(adotemp3.fieldbyname('name').AsString);

    //加载到工具菜单
    TempMenuItem := TMenuItem.Create(self);
    TempMenuItem.Name := 'TmpTool' + inttostr(i);
    TempMenuItem.Caption := tempstr;
    TempMenuItem.OnClick:=miToolItemClick;
    ToolMenuItem.Add(TempMenuItem);

    adotemp3.Next;
  end;
  adotemp3.Free;
end;

procedure TSDIAppForm.miToolItemClick(Sender: TObject);
var
  adotemp3:tadoquery;
  Reserve,Reserve2:string;
begin
  adotemp3:=tadoquery.Create(nil);
  adotemp3.Connection:=DM.ADOConnection1;
  adotemp3.Close;
  adotemp3.SQL.Clear;
  adotemp3.SQL.Text:='select Reserve,Reserve2 from CommCode where TypeName=''工具菜单'' and name='''+(Sender as TMenuItem).Caption+''' ';
  adotemp3.Open;
  Reserve:=adotemp3.fieldbyname('Reserve').AsString;
  Reserve2:=adotemp3.fieldbyname('Reserve2').AsString;
  adotemp3.Free;

  if Reserve2='1' then if not ifhaspower(sender,powerstr_js_main) then exit;

  if ShellExecute(Handle, 'Open', Pchar(ExtractFilePath(application.ExeName)+Reserve), '', '', SW_ShowNormal)<=32 then
    MessageDlg((Sender as TMenuItem).Caption+'('+Reserve+')打开失败!',mtError,[mbOK],0);
end;

end.
