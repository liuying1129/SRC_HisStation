unit UfrmCommQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,ADODB,StrUtils,
  FR_DSet, FR_DBSet, FR_Class, TeEngine, Series, TeeProcs, Chart,fr_chart,
  UADOLYQuery,ComObj,Jpeg, Menus,inifiles;

type
  TfieldList=array of string;
  
type
  TfrmCommQuery = class(TForm)
    pnlCommQryTop: TPanel;
    DBGridResult: TDBGrid;
    pnlCommQryBotton: TPanel;
    BitBtnCommQry: TBitBtn;
    BitBtnCommQryClose: TBitBtn;
    DBGrid1: TDBGrid;
    Splitter1: TSplitter;
    ADOQuery1: TADOQuery;
    DataSource1: TDataSource;
    BitBtn1: TBitBtn;
    frReport1: TfrReport;
    ADObasic: TADOQuery;
    BitBtn3: TBitBtn;
    BitBtn4: TBitBtn;
    BitBtn2: TBitBtn;
    LYQuery1: TADOLYQuery;
    MasterDataSource: TDataSource;
    Label1: TLabel;
    Label2: TLabel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnCommQryClick(Sender: TObject);
    procedure BitBtnCommQryCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure frReport1GetValue(const ParName: String;
      var ParValue: Variant);
    procedure BitBtn2Click(Sender: TObject);
    procedure BitBtn4Click(Sender: TObject);
    procedure ADObasicAfterScroll(DataSet: TDataSet);
    procedure ADObasicAfterOpen(DataSet: TDataSet);
    procedure ADOQuery1AfterOpen(DataSet: TDataSet);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn3Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmCommQuery: TfrmCommQuery;

function frmCommQuery:TfrmCommQuery;    {动态创建窗体函数}

implementation
uses  UDM,SDIMAIN;

const
  //明细sql语句，查询、导出到EXCEL中均要用到，故定义为单元的全局变量
  MXSqlstr1='select cvh.pkcombin_id as 组合项目号,cvh.combin_name as 组合项目名称,cvh.* from chk_valu_his_bak cvh ';
  MXSqlstr2=' order by pkunid,组合项目号 ';

var
  ffrmCommQuery:TfrmCommQuery;           {本地的窗体变量,供关闭窗体释放内存时调用}

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmCommQuery:TfrmCommQuery;    {动态创建窗体函数}
begin
  if ffrmCommQuery=nil then ffrmCommQuery:=TfrmCommQuery.Create(application.mainform);
  result:=ffrmCommQuery;
end;

procedure TfrmCommQuery.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmCommQuery=self then ffrmCommQuery:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmCommQuery.BitBtnCommQryClick(Sender: TObject);
var
  sqlstr1:string;
  Save_Cursor:TCursor;
begin
  sqlstr1:=' select unid as 唯一编号,lsh as 样本号,patientname as 姓名,report_doctor as 审核者,Audit_Date as 审核时间,'+
        ' caseno as 病历号,sex as 性别,'+
        ' age as 年龄,bedno as 床号,deptname as 送检科室, '+
        ' check_date as 创建日期,check_doctor as 送检医生,'+
        ' report_date as 申请日期,'+
        ' operator as 操作者,printtimes as 打印时间,diagnosetype as 优先级别,'+
        ' flagetype as 样本类型,diagnose as 临床诊断,typeflagcase as 样本情况,'+
        ' issure as 备注,combin_id as 组别,germname as 细菌,checkid as 联机号, '+
        ' His_Unid as His唯一编号,His_MzOrZy as His门诊或住院, '+
        ' WorkDepartment as 所属部门,WorkCategory as 工种,WorkID as 工号,ifMarry as 婚否,OldAddress as 籍贯,Address as 住址,Telephone as 电话,WorkCompany as 所属公司, '+
        ' PushPress as 舒张压,PullPress as 收缩压,LeftEyesight as 左眼视力,RightEyesight as 右眼视力,Stature as 身高,Weight as 体重, '+
        ' TjJiWangShi as 既往史,TjJiaZuShi as 家族史,TjNeiKe as 内科,TjWaiKe as 外科,TjWuGuanKe as 五官科,TjFuKe as 妇科,TjLengQiangGuang as 冷强光,TjXGuang as X光,TjBChao as B超,'+
        ' TjXinDianTu as 心电图,TjJianYan as 检验,TjDescription as 结论,TJAdvice as 建议 '+
        ' from chk_con_his_bak ';
  
  lyquery1.Connection:=DM.ADOConnection1;
  lyquery1.SelectString:=sqlstr1;
  if lyquery1.Execute then
  begin
    ADObasic.SQL.Text:=lyquery1.ResultSelect;
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;    { Show hourglass cursor }
    try
      ADObasic.Open;
    finally
      Screen.Cursor := Save_Cursor;  { Always restore to normal }
    end;
  end;
end;

procedure TfrmCommQuery.BitBtnCommQryCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmCommQuery.FormCreate(Sender: TObject);
begin
  ADObasic.Connection:=DM.ADOConnection1;
  ADOQuery1.Connection:=DM.ADOConnection1;
  //ADO_PRINT.Connection:=DM.ADOConnection1;
end;

procedure TfrmCommQuery.frReport1GetValue(const ParName: String;
  var ParValue: Variant);
var
//  ItemChnName:string;
//  cur_value:string;
//  min_value:string;
//  max_value:string;
//  i:integer;
  adotemp11:Tadoquery;
begin
    if parname='SCSYDW' then ParValue:=SCSYDW;

    if parname='样本条码号' then ParValue:=trim(ADObasic.fieldbyname('样本号').AsString);//设计器中设置BarCode的Memo为[样本条码号]
    if parname='组合项目' then
    begin
      adotemp11:=Tadoquery.Create(nil);
      adotemp11.Connection:=dm.ADOConnection1;
      adotemp11.Close;
      adotemp11.SQL.Clear;
      adotemp11.SQL.Add('declare @ret varchar(500)');
      adotemp11.SQL.Add('set @ret='''' ');
      adotemp11.SQL.Add('select @ret=@ret+'',''+combin_Name from chk_valu_his_bak WHERE PkUnid='+ADObasic.fieldbyname('唯一编号').AsString+' group by combin_Name');
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
    if parname='申请医生' then ParValue:=trim(ADObasic.fieldbyname('送检医生').AsString);//
    if parname='申请科室' then ParValue:=trim(ADObasic.fieldbyname('送检科室').AsString);
    if parname='申请日期' then ParValue:=trim(ADObasic.fieldbyname('申请日期').AsString);//
    if parname='门诊住院号' then ParValue:=trim(ADObasic.fieldbyname('病历号').AsString);
    if parname='优先级别' then ParValue:=trim(ADObasic.fieldbyname('优先级别').AsString);
    if parname='床号' then ParValue:=trim(ADObasic.fieldbyname('床号').AsString);//
    if parname='临床诊断' then ParValue:=trim(ADObasic.fieldbyname('临床诊断').AsString);//
    if parname='补打标志' then ParValue:=ifThen(g_Printtime<>'','补打');
end;

procedure TfrmCommQuery.BitBtn2Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;
  dbgridresult.ReadOnly:=false;
end;

procedure TfrmCommQuery.BitBtn4Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;
  dbgrid1.ReadOnly:=false;

end;

procedure TfrmCommQuery.ADObasicAfterScroll(DataSet: TDataSet);
const
  sqlstr1=' where pkunid=:pkunid ';
begin
  ADOQuery1.Close;
  ADOQuery1.SQL.Clear;
  ADOQuery1.SQL.Text:=MXSqlstr1+sqlstr1+MXSqlstr2;
  ADOQuery1.Parameters.ParamByName('pkunid').Value:=
    masterDataSource.DataSet.fieldbyname('唯一编号').AsInteger;
  ADOQuery1.Open;
end;

procedure TfrmCommQuery.ADObasicAfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
//    VisibleColumn(dbgridresult,'唯一编号',false);
    for i :=0  to dbgridresult.Columns.Count-1 do
    begin
       dbgridresult.Columns[i].Width:=55;
       if (i=3)or(i=12)or(i=2) then dbgridresult.Columns[i].Width:=70;//检查日期，申请日期,病历号
    end;

    label2.Caption:=inttostr(DataSet.RecordCount);//显示人次
end;

procedure TfrmCommQuery.ADOQuery1AfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
    for i :=0  to dbgrid1.Columns.Count-1 do
    begin
       dbgrid1.Columns[i].Width:=65;
    end;
end;

procedure TfrmCommQuery.BitBtn1Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

   if not ADObasic.Active then exit;
   if ADObasic.RecordCount=0 then exit;

  g_Printtime:=ADObasic.fieldbyname('打印时间').AsString;

    if not frReport1.LoadFromFile('report_Application_Form.frf') then
    begin
      showmessage('加载默认申请单打印模板report_Application_Form.frf失败');
      exit;
    end;


    //frReport1.Pages.Pages[0].pgsize:=255;//.pgHeight:=70;
    //frReport1.Pages.Pages[0].pgHeight:=70;
    //frReport1.Pages[0].ChangePaper($100,2100,1500,-1,poPortrait);  //1 inch=2.54 cm

    if sdiappform.n9.Checked then  //预览模式
      frReport1.ShowReport;
    if sdiappform.n8.Checked then  //直接打印模式
    begin
      if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
    end;
end;

procedure TfrmCommQuery.BitBtn3Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

   if not ADObasic.Active then exit;
   if ADObasic.RecordCount=0 then exit;

  g_Printtime:=ADObasic.fieldbyname('打印时间').AsString;

    if not frReport1.LoadFromFile('report_SampleNo.frf') then
    begin
      showmessage('加载默认样本标签打印模板report_SampleNo.frf失败');
      exit;
    end;


    //frReport1.Pages.Pages[0].pgsize:=255;//.pgHeight:=70;
    //frReport1.Pages.Pages[0].pgHeight:=70;
    //frReport1.Pages[0].ChangePaper($100,2100,1500,-1,poPortrait);  //1 inch=2.54 cm

    if sdiappform.n9.Checked then  //预览模式
      frReport1.ShowReport;
    if sdiappform.n8.Checked then  //直接打印模式
    begin
      if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
    end;
end;

initialization
  ffrmCommQuery:=nil;
end.
