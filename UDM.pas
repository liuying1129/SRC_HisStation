unit UDM;

interface

uses
  WINDOWS,SysUtils, Classes, DB, ADODB,INIFILES,Dialogs{ShowMessage函数},Controls,
  ComCtrls, Buttons,StdCtrls, ExtCtrls,MENUS,DBGrids,StrUtils, FR_Class,
  FR_DSet, FR_DBSet,Forms{Application变量},DBCtrls{DBEdit},Mask{TMaskEdit},Imm{ImmGetIMEFileName};

type
  PDescriptType=^TDescriptType;
  TDescriptType=record
    ID:string;
    UpID:String;
  end;
  
type
  TDM = class(TDataModule)
    ADOConnection1: TADOConnection;
    ADOConn_His: TADOConnection;
    procedure DataModuleCreate(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

const
  CryptStr='lc';//加解密种子,从市政版本开始改为'lc'，以前版本为'YIDA'
  SYSNAME='HIS_STATION';
  sDBALIAS='ALIAS_SHHJ';
  CGYXJB='常规';//常规优先级别字符串
  sUnRegister='您使用的是未注册版本';

var
  DM: TDM;

  powerstr_js_main:string;
  operator_name:string;
  operator_id:string;
  department_name:string;//登录者部门名称
  BBBT:STRING;//报表标题
  ifGetMemoFromCaseNo:boolean;//是否根据"门诊/住院号"提取备注
  ifSaveSuccess:boolean;//记录"保存检验单F3"事件是否成功,批量录入时要用到
  ifAutoCheck:boolean;//记录是否打印时自动审核申请单
  ifEnterGetCode:boolean;//记录是否 填写病人基本信息时,直接回车弹出取码框
  deptname_match:string;//记录送检科室的取码匹配方式
  check_doctor_match:string;////记录送检医生的取码匹配方式
  ifDefaultDoctor:boolean;
  ifDefaultDepartment:boolean;
  ShowSelfDJ:boolean;//仅显示登录者所开申请单
  SCSYDW:STRING;//授权使用单位
  LisConn:string;//Lis连接字符串,MakeDBConn过程中被赋值,然后传入QC.DLL、CalcItemPro.dll
  OrderType:string;//基本信息排序方式
  ifBatchOperater:boolean;//是否批量操作,批量操作时结果不跟随基本信息滚动.滚动太耗时,使批打慢
  LoginTime:integer;//弹出登录窗口的时间
  g_initialcatalog:string;
  g_Printtime:string;
  CaseNoMatchingNum:integer;//筛选时用病历号的前几位匹配
  CaseNoCrPrintLabel:boolean;

  TempFile_Common:string;
  TempFile_Group:string;
  TempFile_TJ:string;
  WorkGroup_ZFT:string;
  TempFile_ZFT:string;
  WorkGroup_XX:string;
  TempFile_XX:string;
  WorkGroup_T1:string;
  TempFile_T1:string;
  WorkGroup_T2:string;
  TempFile_T2:string;
  WorkGroup_T3:string;
  TempFile_T3:string;  


//**********************Dll接口函数部分***************************************//
//该函数计算pSourStr中有多少个pSS
function ManyStr(const pSS, pSourStr: Pchar): integer;stdcall;external 'LYFunction.dll';
//范围字符串pRangeStr类似5,7-9,11 转换为('0005','0007','0008','0009','0011')
function RangeStrToSql(const pRangeStr:Pchar;const ifLPad:boolean;const LPad:Char;const sWidth:integer;var pSqlStr:Pchar):boolean;stdcall;external 'LYFunction.dll';
//加强型的Pos函数,取得psubStr在pAllstr中第Times次出现的位置
function PosExt(const psubStr,pAllstr:Pchar;const Times:Byte):integer;stdcall;external 'LYFunction.dll';
//找到表达式中小数点位数的最大值.如56.5*100+23.01的值为2
function MaxDotLen(const ACalaExp:PChar):integer;stdcall;external 'LYFunction.dll';
function GetHDSn(const RootPath:pchar):pchar;stdcall;external 'LYFunction.dll';
function GetSysCurImeName: pchar;stdcall;external 'LYFunction.dll';//取得系统当前的中文输入法名称
function GetVersionLY(const AFileName:pchar):pchar;stdcall;external 'LYFunction.dll';
function DeCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'DESCrypt.dll';//解密
function EnCryptStr(aStr: Pchar; aKey: Pchar): Pchar;stdcall;external 'DESCrypt.dll';//加密
function CalParserValue(const CalExpress:Pchar;var ReturnValue:single):boolean;stdcall;external 'CalParser.dll';
function ShowOptionForm(const pCaption,pTabSheetCaption,pItemInfo,pInifile:Pchar):boolean;stdcall;external 'OptionSetForm.dll';
//****************************************************************************//

procedure SendKeyToControl(const VK:byte;control:Twincontrol);
function ageConvertChinese(agestr: string): string;
function GetServerDate(adoConn:TADOConnection):TDate;
procedure AddPickList(dbgrid: tdbgrid; const FieldIndex: integer;const JoinStr: string);//JoinStr是这样的样式：aa,bb,cc,dd
//控制指定列的显示与否
procedure VisibleColumn(dbgrid:tdbgrid;const DisplayName:string;const ifVisible:boolean);
function ifhaspower(sender: tobject;const powerstr_js:string): boolean;
function GetMaxId(const combin_id:string;CurDate:tdate;Diagnosetype:string): string;//取得最大流水号,参数:组别名及日期
function HasSubInDbf(Node:TTreeNode):Boolean;
Procedure ChangeYouFormAllControlIme(YFormName:TWinControl);//需要更改输入法的窗体名称
function SmoothLine(const strHistogram:string;const SmoothNum:byte;var Strings:TStrings):integer;
function GetNextValue(CurValue: string): string;
function GetFirstValue(CurValue: string): string;
function MakeDBConn:boolean;
procedure LoadGroupName(const comboBox:TcomboBox);
procedure MakeDBGridColumnsAutoFixItsWidth(objDBGrid:TDBGrid);
function StopTime: integer; //返回没有键盘和鼠标事件的时间

implementation

{$R *.dfm}

procedure TDM.DataModuleCreate(Sender: TObject);
begin
  //AppPath:=ExtractFilePath(application.ExeName);

  MakeDBConn;
end;

procedure VisibleColumn(dbgrid:tdbgrid;const DisplayName:string;const ifVisible:boolean);
var
  i:integer;
begin
  if not dbgrid.DataSource.DataSet.Active then exit;
  for i :=0  to dbgrid.Columns.Count-1 do
    if uppercase(dbgrid.Fields[i].DisplayName)=uppercase(DisplayName) then
      dbgrid.Columns[i].Visible:=ifVisible;
end;

procedure AddPickList(dbgrid: tdbgrid; const FieldIndex: integer;
  const JoinStr: string);//JoinStr是这样的样式：aa,bb,cc,dd 注：用英文或中文状态的逗号分隔均可
var
  CommaPos:integer;
  s1,s2:string;
begin
  s1:=JoinStr;
  if not dbgrid.DataSource.DataSet.Active then exit;
  if dbgrid.DataSource.DataSet.RecordCount=0 then exit;
  dbgrid.Columns[FieldIndex].PickList.Clear;
  if trim(JoinStr)='' then exit;
  CommaPos:=pos(',',s1);
  while CommaPos<>0 do
  begin
    s2:=trim(copy(s1,1,CommaPos-1));
    if trim(s2)<>'' then dbgrid.Columns[FieldIndex].PickList.add(s2);
    delete(s1,1,CommaPos);
    CommaPos:=pos(',',s1);
  end;
  if trim(s1)<>'' then dbgrid.Columns[FieldIndex].PickList.add(s1);
end;

function GetServerDate(adoConn:TADOConnection):TDate;
//返回值中包括了日期部分及时间部分
//datetimetostr(返回值)-->2005-8-28 10:05:36
//datetostr(返回值)-->2005-8-28
//timetostr(返回值)-->10:05:36
var
  adotempDate:tadoquery;
begin
  adotempDate:=tadoquery.Create(NIL);
  ADOTEMPDATE.Connection:=adoConn;
  ADOTEMPDATE.Close;
  ADOTEMPDATE.SQL.Clear;
  ADOTEMPDATE.SQL.Text:='SELECT GETDATE() as ServerDate ';
  ADOTEMPDATE.Open;
  result:=ADOTEMPDATE.fieldbyname('ServerDate').AsDateTime;
  ADOTEMPDATE.Free;  //}
end;

procedure SendKeyToControl(const VK:byte;control:Twincontrol);
BEGIN
  control.SetFocus;
  keybd_event(VK,MapVirtualKey(VK,0),0,0); //指定键被按下
END;

function ageConvertChinese(agestr: string): string;
var
  fagestr:single;
begin
    agestr:=uppercase(agestr);
    result:='';
    if (agestr='') then begin result:=''; exit;end;
    if UpperCase(agestr)='C' then begin result:='成'; exit;end;
    if trystrtofloat(agestr,fagestr) then begin result:=agestr+'岁';exit;end;
    result:=StringReplace(agestr,'N','分钟',[rfReplaceAll,rfIgnoreCase]);
    result:=StringReplace(result,'Y','岁',[rfReplaceAll,rfIgnoreCase]);
    result:=StringReplace(result,'M','月',[rfReplaceAll,rfIgnoreCase]);
    result:=StringReplace(result,'D','天',[rfReplaceAll,rfIgnoreCase]);
    result:=StringReplace(result,'H','小时',[rfReplaceAll,rfIgnoreCase]);
end;

function haspower(powerstr_cur, menuname,sDatabaseName: string): boolean;
var
  jsmc:string;
  plusPos:integer;
  aa,bb:string;
  menuname_js:string;
  ADOquery_ryjs,ADOquery_menuitem:tADOquery;
  user_powerstr:string;
  ado_super:tadoquery;
begin
  result:=false;
  //===============超级用户例外=================//
  ado_super:=tadoquery.Create(nil);
  ado_super.Connection:=DM.ADOConnection1;
  ado_super.SQL.Clear;
  ado_super.SQL.Text:='select * from worker where ifSuperUser=''1'' ';
  ado_super.Open;
  ado_super.First;
  if ado_super.Locate('id',operator_id,[loCaseInsensitive]) then
  begin
    result:=true;
    ado_super.Free;
    exit;
  end;
  //=======================================================//
  aa:='';bb:='';
  user_powerstr:=powerstr_cur;

  ADOquery_ryjs:=tADOquery.Create(nil);
  ADOquery_ryjs.Connection:=DM.ADOConnection1;
  ADOquery_ryjs.SQL.Clear;
  ADOquery_ryjs.SQL.Text:='select * from ryjs';
  ADOquery_ryjs.Open;

  ADOquery_menuitem:=tADOquery.Create(nil);
  ADOquery_menuitem.Connection:=DM.ADOConnection1;
  ADOquery_menuitem.SQL.Clear;
  ADOquery_menuitem.SQL.Text:='select * from menuitem WHERE SYSNAME='''+SYSNAME+''' ';
  ADOquery_menuitem.Open;

  while length(user_powerstr)>=3 do
  begin
    plusPos:=posExt('+',Pchar(user_powerstr),2);
    jsmc:=copy(user_powerstr,2,pluspos-2);
    try
      aa:=aa+ADOquery_ryjs.Lookup('jsmc',jsmc,'jsqx');
    except
      aa:=aa+'';
    end;
    delete(user_powerstr,1,pluspos);
  end;

  while length(aa)>=3 do
  begin
    bb:=copy(aa,1,3);
    if ADOquery_menuitem.Locate('bm',bb,[loCaseInsensitive]) then
        menuname_js:=trim(ADOquery_menuitem.fieldbyname('menuname').AsString)
    else  menuname_js:='';

    if  UpperCase(menuname_js)= UpperCase(Trim(menuname)) then
    begin
      result:=true;
      ADOquery_ryjs.Free;
      ADOquery_menuitem.Free;
      exit;
    end;
    delete(aa,1,3);
  end;

  if ADOquery_ryjs<>nil then ADOquery_ryjs.Free;
  if ADOquery_menuitem<>nil then ADOquery_menuitem.Free;
  if ado_super<>nil then ado_super.Free;
end;

function ifhaspower(sender: tobject;const powerstr_js:string): boolean;
begin
  result:=true;

  if sender is tmenuitem then
  begin
    if not haspower(powerstr_js,tmenuitem(sender).Caption,sDBALIAS) then result:=false;
  end;

  if sender is ttoolbutton then
  begin
    if not haspower(powerstr_js,ttoolbutton(sender).Caption,sDBALIAS) then result:=false;
  end;

  if sender is tbutton then
  begin
    if not haspower(powerstr_js,tbutton(sender).Caption,sDBALIAS) then result:=false;
  end;

  if sender is tpanel then
  begin
    if not haspower(powerstr_js,tpanel(sender).Caption,sDBALIAS) then result:=false;
  end;

  if sender is tspeedbutton then
  begin
    if not haspower(powerstr_js,tspeedbutton(sender).Caption,sDBALIAS) then result:=false;
  end;//}

  if sender is tcombobox then  
  begin
    if not haspower(powerstr_js,inttostr(tcombobox(sender).tag),sDBALIAS) then result:=false;
  end;

  if sender is tedit then
  begin
    if not haspower(powerstr_js,inttostr(tedit(sender).tag),sDBALIAS) then result:=false;
  end;

  if sender is tLabeledEdit then
  begin
    if not haspower(powerstr_js,tLabeledEdit(sender).EditLabel.Caption,sDBALIAS) then result:=false;
  end;

  if not result then
      messagedlg('对不起，您没有该权限！',mtinformation,[mbok],0);
end;

function GetMaxId(const combin_id:string;CurDate:tdate;Diagnosetype:string): string;  //取得最大样本号
var
  maxid: string;
  adotemp11:tadoquery;
  iMaxId:integer;
  s1,s2,s3:string;
begin
  if(Diagnosetype<>CGYXJB)and(Diagnosetype<>'急诊')and(Diagnosetype<>'加急')then Diagnosetype:=CGYXJB;

          s1:='select LSH from chk_con_his '+
                            ' WHERE (CONVERT(CHAR(10),report_date,121)=:p_CHECK_DATE1 ) '+
                            ' and (Diagnosetype='''+Diagnosetype+''') ';
          s2:=ifThen(trim(combin_id)='','',' AND (flagetype='''+combin_id+''') ');
          s3:=' order by right(''0000''+lsh,4) desc';     //按降序排序
  adotemp11:=tadoquery.Create(nil);
  adotemp11.Connection:=DM.ADOConnection1;
          ADOtemp11.Close;
          ADOtemp11.SQL.Clear;
          ADOtemp11.SQL.Text:=s1+s2+s3;

          ADOtemp11.Parameters.ParamByName('p_CHECK_DATE1').Value:=FormatDateTime('YYYY-MM-DD',CurDate);
          ADOtemp11.open;
          //ADOtemp11.First;
      maxid := trim(ADOtemp11.FieldByName('LSH').AsString);
      ADOtemp11.Free;

      if not trystrtoint(maxid,iMaxId) then begin result:='1';exit;end;
      //if Length(maxid) = 0 then
      //  maxid := '0001';
      //if Length(maxid) = 1 then
      //  maxid := '000' + maxid;
      //if Length(maxid) = 2 then
      //  maxid := '00' + maxid;
      //if Length(maxid) = 3 then
      //  maxid := '0' + maxid;
      result := inttostr(iMaxId+1);
end;//}

function HasSubInDbf(Node:TTreeNode):Boolean;
//检查节点Node有无子节点,有则返回True,反之返回False
var
  adotemp22:tadoquery;
begin
  result:=false;
  adotemp22:=tadoquery.Create(nil);
  adotemp22.Connection:=dm.ADOConnection1;
  adotemp22.Close;
  adotemp22.SQL.Clear;
  adotemp22.SQL.Text:='select * from RisDescriptType where UpID='''+PDescriptType(Node.Data)^.ID+'''';
  adotemp22.Open;
  if adotemp22.RecordCount<>0 then result:= True;
  adotemp22.Free;
end;

function ifRegister:boolean;
var
  HDSn,RegisterNum,EnHDSn:string;
  configini:tinifile;
  pEnHDSn:Pchar;
begin
  result:=false;
  
  HDSn:=GetHDSn('C:\')+'-'+GetHDSn('D:\');//函数返回的Pchar类型还真能直接赋值给string!!!

  CONFIGINI:=TINIFILE.Create(ChangeFileExt(Application.ExeName,'.ini'));
  RegisterNum:=CONFIGINI.ReadString('Register','RegisterNum','');
  CONFIGINI.Free;
  pEnHDSn:=EnCryptStr(Pchar(HDSn),CryptStr);
  EnHDSn:=StrPas(pEnHDSn);

  if Uppercase(EnHDSn)=Uppercase(RegisterNum) then result:=true;

  if not result then messagedlg('对不起,您没有注册或注册码错误,请注册!',mtinformation,[mbok],0);
end;

Procedure ChangeYouFormAllControlIme(YFormName:TWinControl);//需要更改输入法的窗体名称
//输入法自动切换过程
//20051104 by 刘鹰
//解决思路:
//程序员只需要将窗体中该输入中文的控件的imemode=imOpen,然后在每个窗体里
//create(或active)事件里调用本人编写的方法ChangeYouFormAllControlIme(Self)即可.
//在程序中提供一个用户输入法选项供用户选择自己喜欢的输入法,
//调用显示FrmImeNameList窗体即可!
//注意：在"选择输入法后"要再次调用ChangeYouFormAllControlIme(Self)方法哦:)
var
  StrImeName:string;
  procedure JugeClassType(PClass:Tcontrol);
  //虽然麻烦,但必须具体判断,下面将 dephi可更改的控件几乎都包含了,没有包含的是使用价值不大.
  begin
    if pclass is TEdit then//更改Tedit类控件,以下同理
    begin
      if TEdit(pclass).ImeMode=imOpen then
        TEdit(pclass).ImeName:=StrImeName
      else
        TEdit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TLabeledEdit then
    begin
      if TLabeledEdit(pclass).ImeMode=imOpen then
        TLabeledEdit(pclass).ImeName:=StrImeName
      else
        TLabeledEdit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TMemo then
    begin
      if TMemo(pclass).ImeMode=imOpen then
       TMemo(pclass).ImeName:=StrImeName
      else
       TMemo(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TComboBox then
    begin
      if TComboBox(pclass).ImeMode=imOpen then
       TComboBox(pclass).ImeName:=StrImeName
      else
       TComboBox(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TRichEdit then
    begin
      if TRichEdit(pclass).ImeMode=imOpen then
       TRichEdit(pclass).ImeName:=StrImeName
      else
       TRichEdit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TDBGrid then
    begin
      if TDBGrid(pclass).ImeMode=imOpen then
       TDBGrid(pclass).ImeName:=StrImeName
      else
       TDBGrid(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TDBEdit then
    begin
      if TDBEdit(pclass).ImeMode=imOpen then
       TDBEdit(pclass).ImeName:=StrImeName
      else
       TDBEdit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TDbMemo then
    begin
      if TDbMemo(pclass).ImeMode=imOpen then
       TDbMemo(pclass).ImeName:=StrImeName
      else
       TDbMemo(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TDbcombobox then
    begin
      if TDbcombobox(pclass).ImeMode=imOpen then
       TDbcombobox(pclass).ImeName:=StrImeName
      else
       TDbcombobox(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is Tdblookupcombobox then
    begin
      if Tdblookupcombobox(pclass).ImeMode=imOpen then
       Tdblookupcombobox(pclass).ImeName:=StrImeName
      else
       Tdblookupcombobox(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is Tdbrichedit then
    begin
      if Tdbrichedit(pclass).ImeMode=imOpen then
       Tdbrichedit(pclass).ImeName:=StrImeName
      else
       Tdbrichedit(pclass).ImeMode:=imClose;
      exit;
    end;

    if pclass is TMaskEdit then
    begin
      if TMaskEdit(pclass).ImeMode=imOpen then
        TMaskEdit(pclass).ImeName:=StrImeName
      else
        TMaskEdit(pclass).ImeMode:=imClose;
      exit;
    end;
  end;
const
  DefaultImeName='中文 (简体) - 智能 ABC';
var
  i:integer;
  ChildControl:TControl;
  ConfigIni:tinifile;
  YouFormOrOTher:Twincontrol;
begin
  YouFormOrOTher:=YFormName;

  //读取保存的用户选择的输入法,用单元全局变量 StrImeName 保存
  //主窗体Create时调用该过程,此时UDM没被创建,故用"ExtractFilePath(application.ExeName)"代替AppPath变量
  ConfigIni:=tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  try
    StrImeName:=ConfigIni.ReadString('输入法选择','默认中文输入法',DefaultImeName);
  finally
    ConfigIni.Free;
  end;

  //调用方法 JugeClassType(ChildControl) 更改窗体中控件的 ImeMode
  for i:=0 to YouFormOrOTher.ControlCount-1 do
  begin
   ChildControl:=YouFormOrOTher.Controls[i];
   JugeClassType(ChildControl);

   //如果控件包含控件,更改被包含的控件
   if ChildControl is TWinControl then ChangeYouFormAllControlIme(ChildControl as TWinControl);
  end;
end;

function SmoothLine(const strHistogram:string;const SmoothNum:byte;var Strings:TStrings):integer;
//strHistogram格式:'2 3 5.5 2.3'
//返回值:Strings的元素个数.调用时先判断返回值,大于零才有效
//SmoothNum:平滑处理的次数.次数越多曲线越光滑,但曲线偏离越多
//Strings:返回的点
var
  ls:TStrings;
  t,i,j:integer;
  cc:array of single;
  fdotData:single;
begin
  result:=0;

  if Strings = nil then Exit;
  ls:=TStringList.Create;
  t:=ExtractStrings([' '],[],Pchar(trim(strHistogram)),ls);
  if t=0 then begin ls.Free;exit;end;

  for i :=0  to t-1 do//如有无效点，则返回false
    if not trystrtofloat(ls[i],fdotData) then begin ls.Free;exit;end;

  setlength(cc,t);

  for i :=1  to SmoothNum do//平滑处理的次数
  begin
    for j:=2 to t-1 do
    begin
      cc[j-1]:=(strtofloat(ls[j-2])+strtofloat(ls[j-1])+strtofloat(ls[j]))/3;
    end;
    cc[0]:=strtofloat(ls[0]);
    cc[t-1]:=strtofloat(ls[t-1]);
    
    for j:=0 to t-1 do ls[j]:=floattostr(cc[j]);
  end;

  for j:=0 to t-1 do Strings.Add(ls[j]);
  ls.Free;

  result:=t;
end;

function GetNextValue(CurValue: string): string;
VAR
  iCurValue,i:INTEGER;
  rCurValue,sCurValue:STRING;
begin
    RESULT:='';
    for i :=length(CurValue) downto 1 do
    begin
      if not(CurValue[i] in ['0'..'9']) then
      begin
        if i=length(CurValue) then //最后一个字符为非数字
        begin
          exit;
        end;
        iCurValue:=strtoint(copy(CurValue,i+1,length(CurValue)-i));
        inc(iCurValue);
        rCurValue:=Format('%.'+inttostr(length(CurValue)-i)+'d', [iCurValue]);//iMaxFieldValue
        sCurValue:=copy(CurValue,1,i);
        result:=sCurValue + rCurValue;
        exit;
      end else
      begin
        if i=1 then //全部为数字的情况
        begin
          iCurValue:=strtoint(CurValue);
          inc(iCurValue);
          rCurValue:=Format('%.'+inttostr(length(CurValue))+'d', [iCurValue]);//iMaxFieldValue
          result:= rCurValue;
          exit;
        end;
      end;
    end;
end;

function GetFirstValue(CurValue: string): string;
VAR
  rCurValue,sCurValue:STRING;
  i:integer;
begin
    RESULT:='';
    for i :=length(CurValue) downto 1 do
    begin
      if not(CurValue[i] in ['0'..'9']) then
      begin
        if i=length(CurValue) then //最后一个字符为非数字
        begin
          exit;
        end;
        rCurValue:=Format('%.'+inttostr(length(CurValue)-i)+'d', [1]);//iMaxFieldValue
        sCurValue:=copy(CurValue,1,i);
        result:=sCurValue + rCurValue;
        exit;
      end else
      begin
        if i=1 then //全部为数字的情况
        begin
          rCurValue:=Format('%.'+inttostr(length(CurValue))+'d', [1]);//iMaxFieldValue
          result:= rCurValue;
          exit;
        end;
      end;
    end;
end;

function MakeDBConn:boolean;
var
  newconnstr,ss: string;
  Ini: tinifile;
  userid, password, datasource, initialcatalog: string;{, provider}
  ifIntegrated:boolean;//是否集成登录模式

  pInStr,pDeStr:Pchar;
  i:integer;
  Label labReadIni;
begin
  result:=false;

  labReadIni:
  Ini := tinifile.Create(ChangeFileExt(Application.ExeName,'.ini'));
  datasource := Ini.ReadString('连接数据库', '服务器', '');
  initialcatalog := Ini.ReadString('连接数据库', '数据库', '');
  ifIntegrated:=ini.ReadBool('连接数据库','集成登录模式',false);
  userid := Ini.ReadString('连接数据库', '用户', '');
  password := Ini.ReadString('连接数据库', '口令', '107DFC967CDCFAAF');
  Ini.Free;
  //======解密password
  pInStr:=pchar(password);
  pDeStr:=DeCryptStr(pInStr,CryptStr);
  setlength(password,length(pDeStr));
  for i :=1  to length(pDeStr) do password[i]:=pDeStr[i-1];
  //==========

  newconnstr := '';
  newconnstr := newconnstr + 'user id=' + UserID + ';';
  newconnstr := newconnstr + 'password=' + Password + ';';
  newconnstr := newconnstr + 'data source=' + datasource + ';';
  newconnstr := newconnstr + 'Initial Catalog=' + initialcatalog + ';';
  newconnstr := newconnstr + 'provider=' + 'SQLOLEDB.1' + ';';
  //Persist Security Info,表示ADO在数据库连接成功后是否保存密码信息
  //ADO缺省为True,ADO.net缺省为False
  //程序中会传ADOConnection信息给TADOLYQuery,故设置为True
  newconnstr := newconnstr + 'Persist Security Info=True;';
  if ifIntegrated then
    newconnstr := newconnstr + 'Integrated Security=SSPI;';
  try
    dm.ADOConnection1.Connected := false;
    dm.ADOConnection1.ConnectionString := newconnstr;
    dm.ADOConnection1.Connected := true;
    result:=true;
    LisConn:=newconnstr;
    g_initialcatalog:=initialcatalog;
  except
  end;
  if not result then
  begin
    ss:='服务器'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '数据库'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '集成登录模式'+#2+'CheckListBox'+#2+#2+'0'+#2+'启用该模式,则用户及口令无需填写'+#2+#3+
        '用户'+#2+'Edit'+#2+#2+'0'+#2+#2+#3+
        '口令'+#2+'Edit'+#2+#2+'0'+#2+#2+'1';
    if ShowOptionForm('连接数据库','连接数据库',Pchar(ss),Pchar(ChangeFileExt(Application.ExeName,'.ini'))) then
      goto labReadIni else application.Terminate;
  end;
end;

procedure LoadGroupName(const comboBox:TcomboBox);
const
  sqll='select name from CommCode where TypeName=''申请单工作组'' group by name';
var
  adotemp3:tadoquery;
  tempstr:string;
begin
     adotemp3:=tadoquery.Create(nil);
     adotemp3.Connection:=DM.ADOConnection1;
     adotemp3.Close;
     adotemp3.SQL.Clear;
     adotemp3.SQL.Text:=sqll;
     adotemp3.Open;
     
     comboBox.Items.Clear;//加载前先清除comboBox项

     while not adotemp3.Eof do
     begin
      tempstr:=trim(adotemp3.fieldbyname('name').AsString);

      comboBox.Items.Add(tempstr); //加载到comboBox

      adotemp3.Next;
     end;
     adotemp3.Free;
end;

procedure MakeDBGridColumnsAutoFixItsWidth(objDBGrid:TDBGrid);
//使dbGrid的内容自动适应他的宽度{如为DBGridEh则将改为：(objDBGrid:TDBGridEh);}
var
  cc:integer;
  i,tmpLength:integer;
  objDataSet:TAdoquery;
  aDgCLength:array of integer;
begin
  cc:=objDbGrid.Columns.Count-1;

  objDataSet:=TAdoquery.Create(nil);
  //objDataSet.Clone(objDBGrid.DataSource.DataSet);

  setlength(aDgCLength,cc+1);
  //取标题字段的长度
  for i:=0 to  cc do
  begin
    aDgCLength[i]:= length(objDbGrid.Columns[i].Title.Caption);
  end; 

  objDataSet.First;
  while not objDataSet.Eof do
  begin
    //取列中每个字段的长度
    for i:=0 to  cc do
    begin
      tmpLength:=length(objDataSet.Fields.Fields[i].AsString);
      if tmpLength>aDgCLength[i] then aDgCLength[i]:=tmpLength;
    end;
    objDataSet.Next;
  end; 

  for i:=0 to  cc do
  begin
    objDbGrid.Columns[i].Width:=aDgCLength[i]*8;
  end;
end;

function StopTime: integer;
//返回没有键盘和鼠标事件的时间
var
  LInput: TLastInputInfo;
begin
  LInput.cbSize := SizeOf(TLastInputInfo);
  GetLastInputInfo(LInput);
  Result := (GetTickCount() - LInput.dwTime) div 1000;//微秒换成秒
end;

end.
