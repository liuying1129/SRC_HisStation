unit UfrmExcelQuery;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, DB, Grids, DBGrids, StdCtrls, Buttons, ExtCtrls,ADODB,StrUtils,
  FR_DSet, FR_DBSet, FR_Class, TeEngine, Series, TeeProcs, Chart,fr_chart,
  UADOLYQuery, ULYDataToExcel;

type
  TfrmExcelQuery = class(TForm)
    pnlCommQryTop: TPanel;
    DBGridResult: TDBGrid;
    BitBtnCommQry: TBitBtn;
    BitBtnCommQryClose: TBitBtn;
    BitBtn1: TBitBtn;
    Masterquery: TADOQuery;
    LYQuery1: TADOLYQuery;
    MasterDataSource: TDataSource;
    LYDataToExcel1: TLYDataToExcel;
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtnCommQryClick(Sender: TObject);
    procedure BitBtnCommQryCloseClick(Sender: TObject);
    procedure FormCreate(Sender: TObject);
    procedure BitBtn1Click(Sender: TObject);
    procedure MasterqueryAfterOpen(DataSet: TDataSet);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
//  frmCommQuery: TfrmCommQuery;

function frmExcelQuery:TfrmExcelQuery;    {动态创建窗体函数}

implementation
uses   UDM;

var
  ffrmExcelQuery:TfrmExcelQuery;           {本地的窗体变量,供关闭窗体释放内存时调用}

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmExcelQuery:TfrmExcelQuery;    {动态创建窗体函数}
begin
  if ffrmExcelQuery=nil then ffrmExcelQuery:=TfrmExcelQuery.Create(application.mainform);
  result:=ffrmExcelQuery;
end;

procedure TfrmExcelQuery.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmExcelQuery=self then ffrmExcelQuery:=nil;
end;
////////////////////////////////////////////////////////////////////////////////

procedure TfrmExcelQuery.BitBtnCommQryClick(Sender: TObject);
const
  sqlstr1='select Z.lsh as 流水号,Z.checkid as 联机号,Z.caseno as 病历号,Z.check_date as 检查日期,Z.patientname as 姓名,'+
    'Z.sex as 性别,'+
    'Z.age as 年龄,Z.bedno as 床号,Z.deptname as 送检科室,'+
    'Z.check_doctor as 送检医生,Z.operator as 操作者,Z.report_doctor as 审核者,Z.report_date as 申请日期,'+
    'Z.diagnosetype as 优先级别,Z.combin_id as 工作组别,'+
    'Z.flagetype as 样本类型,Z.typeflagcase as 样本情况,Z.diagnose as 临床诊断,'+
    'Z.issure as 备注,Z.germname as 细菌, '+
    'Z.WorkCompany as 所属公司,Z.WorkDepartment as 所属部门,Z.WorkCategory as 工种,Z.WorkID as 工号,Z.ifMarry as 婚否,Z.OldAddress as 籍贯,'+
    'Z.Address as 住址,Z.Telephone as 电话,Z.PushPress as 舒张压,Z.PullPress as 收缩压,'+
    'Z.LeftEyesight as 左眼视力,Z.RightEyesight as 右眼视力,Z.Stature as 身高,Z.Weight as 体重,'+
    'Z.TjJiWangShi as 既往史,Z.TjJiaZuShi as 家族史,Z.TjNeiKe as 内科,Z.TjWaiKe as 外科,Z.TjWuGuanKe as 五官科,'+
    'Z.TjFuKe as 妇科,Z.TjLengQiangGuang as 冷强光,Z.TjXGuang as X光,Z.TjBChao as B超,Z.TjXinDianTu as 心电图,TjJianYan as 检验,'+
    'Z.TjDescription as 结论,Z.TJAdvice as 建议, '+
    ' C.name as 项目名称,C.english_name as 项目英文名,C.itemvalue as 检验结果,C.unit as 单位,'+
    ' C.min_value as 最小值,C.max_value as 最大值,C.pkcombin_id as 组合项目号,C.printorder as 打印编号,C.itemid AS 项目代码 '+
    ' from chk_con_BAK Z,chk_valu_bak C '+
    ' WHERE Z.UNID=C.PKUNID '+
    ' order by 检查日期,流水号,组合项目号,打印编号 ';
VAR
  Save_Cursor:TCursor;
begin
  lyquery1.Connection:=DM.ADOConnection1;
  lyquery1.SelectString:=sqlstr1;
  if lyquery1.Execute then
  begin
    MasterQuery.SQL.Text:=lyquery1.ResultSelect;
    Save_Cursor := Screen.Cursor;
    Screen.Cursor := crHourGlass;    { Show hourglass cursor }
    try
      MasterQuery.Open;
    finally
      Screen.Cursor := Save_Cursor;  { Always restore to normal }
    end;
  end;
end;

procedure TfrmExcelQuery.BitBtnCommQryCloseClick(Sender: TObject);
begin
  close;
end;

procedure TfrmExcelQuery.FormCreate(Sender: TObject);
begin
  Masterquery.Connection:=DM.ADOConnection1;
end;

procedure TfrmExcelQuery.BitBtn1Click(Sender: TObject);
begin
  LYDataToExcel1.DataSet:= Masterquery;                     
  LYDataToExcel1.ExcelTitel:=BBBT;                      
  LYDataToExcel1.Execute;
end;

procedure TfrmExcelQuery.MasterqueryAfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
    for i :=0  to DBGridResult.Columns.Count-1 do
    begin
       DBGridResult.Columns[i].Width:=55;
       if (i=3)or(i=18)or(i=2) then dbgridresult.Columns[i].Width:=70;//检查日期，申请日期,病历号
    end;
end;

initialization
  ffrmExcelQuery:=nil;
end.
