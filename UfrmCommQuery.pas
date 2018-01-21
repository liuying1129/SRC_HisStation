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

function frmCommQuery:TfrmCommQuery;    {��̬�������庯��}

implementation
uses  UDM,SDIMAIN;

const
  //��ϸsql��䣬��ѯ��������EXCEL�о�Ҫ�õ����ʶ���Ϊ��Ԫ��ȫ�ֱ���
  MXSqlstr1='select cvh.pkcombin_id as �����Ŀ��,cvh.combin_name as �����Ŀ����,cvh.* from chk_valu_his_bak cvh ';
  MXSqlstr2=' order by pkunid,�����Ŀ�� ';

var
  ffrmCommQuery:TfrmCommQuery;           {���صĴ������,���رմ����ͷ��ڴ�ʱ����}

{$R *.dfm}

////////////////////////////////////////////////////////////////////////////////
function frmCommQuery:TfrmCommQuery;    {��̬�������庯��}
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
  sqlstr1:=' select unid as Ψһ���,lsh as ������,patientname as ����,report_doctor as �����,Audit_Date as ���ʱ��,'+
        ' caseno as ������,sex as �Ա�,'+
        ' age as ����,bedno as ����,deptname as �ͼ����, '+
        ' check_date as ��������,check_doctor as �ͼ�ҽ��,'+
        ' report_date as ��������,'+
        ' operator as ������,printtimes as ��ӡʱ��,diagnosetype as ���ȼ���,'+
        ' flagetype as ��������,diagnose as �ٴ����,typeflagcase as �������,'+
        ' issure as ��ע,combin_id as ���,germname as ϸ��,checkid as ������, '+
        ' His_Unid as HisΨһ���,His_MzOrZy as His�����סԺ, '+
        ' WorkDepartment as ��������,WorkCategory as ����,WorkID as ����,ifMarry as ���,OldAddress as ����,Address as סַ,Telephone as �绰,WorkCompany as ������˾, '+
        ' PushPress as ����ѹ,PullPress as ����ѹ,LeftEyesight as ��������,RightEyesight as ��������,Stature as ����,Weight as ����, '+
        ' TjJiWangShi as ����ʷ,TjJiaZuShi as ����ʷ,TjNeiKe as �ڿ�,TjWaiKe as ���,TjWuGuanKe as ��ٿ�,TjFuKe as ����,TjLengQiangGuang as ��ǿ��,TjXGuang as X��,TjBChao as B��,'+
        ' TjXinDianTu as �ĵ�ͼ,TjJianYan as ����,TjDescription as ����,TJAdvice as ���� '+
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

    if parname='���������' then ParValue:=trim(ADObasic.fieldbyname('������').AsString);//�����������BarCode��MemoΪ[���������]
    if parname='�����Ŀ' then
    begin
      adotemp11:=Tadoquery.Create(nil);
      adotemp11.Connection:=dm.ADOConnection1;
      adotemp11.Close;
      adotemp11.SQL.Clear;
      adotemp11.SQL.Add('declare @ret varchar(500)');
      adotemp11.SQL.Add('set @ret='''' ');
      adotemp11.SQL.Add('select @ret=@ret+'',''+combin_Name from chk_valu_his_bak WHERE PkUnid='+ADObasic.fieldbyname('Ψһ���').AsString+' group by combin_Name');
      adotemp11.SQL.Add('set @ret=stuff(@ret,1,1,'''')');
      adotemp11.SQL.Add('select @ret as cn');
      adotemp11.Open;
      ParValue:=trim(adotemp11.fieldbyname('cn').AsString);
      adotemp11.Free;
    end;
    if parname='��������' then ParValue:=trim(ADObasic.fieldbyname('��������').AsString);
    if parname='����' then ParValue:=trim(ADObasic.fieldbyname('����').AsString);
    if parname='�Ա�' then ParValue:=trim(ADObasic.fieldbyname('�Ա�').AsString);
    if parname='����' then ParValue:=trim(ADObasic.fieldbyname('����').AsString);
    if parname='����ҽ��' then ParValue:=trim(ADObasic.fieldbyname('�ͼ�ҽ��').AsString);//
    if parname='�������' then ParValue:=trim(ADObasic.fieldbyname('�ͼ����').AsString);
    if parname='��������' then ParValue:=trim(ADObasic.fieldbyname('��������').AsString);//
    if parname='����סԺ��' then ParValue:=trim(ADObasic.fieldbyname('������').AsString);
    if parname='���ȼ���' then ParValue:=trim(ADObasic.fieldbyname('���ȼ���').AsString);
    if parname='����' then ParValue:=trim(ADObasic.fieldbyname('����').AsString);//
    if parname='�ٴ����' then ParValue:=trim(ADObasic.fieldbyname('�ٴ����').AsString);//
    if parname='�����־' then ParValue:=ifThen(g_Printtime<>'','����');
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
    masterDataSource.DataSet.fieldbyname('Ψһ���').AsInteger;
  ADOQuery1.Open;
end;

procedure TfrmCommQuery.ADObasicAfterOpen(DataSet: TDataSet);
var
  i:integer;
begin
//    VisibleColumn(dbgridresult,'Ψһ���',false);
    for i :=0  to dbgridresult.Columns.Count-1 do
    begin
       dbgridresult.Columns[i].Width:=55;
       if (i=3)or(i=12)or(i=2) then dbgridresult.Columns[i].Width:=70;//������ڣ���������,������
    end;

    label2.Caption:=inttostr(DataSet.RecordCount);//��ʾ�˴�
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

  g_Printtime:=ADObasic.fieldbyname('��ӡʱ��').AsString;

    if not frReport1.LoadFromFile('report_Application_Form.frf') then
    begin
      showmessage('����Ĭ�����뵥��ӡģ��report_Application_Form.frfʧ��');
      exit;
    end;


    //frReport1.Pages.Pages[0].pgsize:=255;//.pgHeight:=70;
    //frReport1.Pages.Pages[0].pgHeight:=70;
    //frReport1.Pages[0].ChangePaper($100,2100,1500,-1,poPortrait);  //1 inch=2.54 cm

    if sdiappform.n9.Checked then  //Ԥ��ģʽ
      frReport1.ShowReport;
    if sdiappform.n8.Checked then  //ֱ�Ӵ�ӡģʽ
    begin
      if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
    end;
end;

procedure TfrmCommQuery.BitBtn3Click(Sender: TObject);
begin
  if not ifhaspower(sender,powerstr_js_main) then exit;

   if not ADObasic.Active then exit;
   if ADObasic.RecordCount=0 then exit;

  g_Printtime:=ADObasic.fieldbyname('��ӡʱ��').AsString;

    if not frReport1.LoadFromFile('report_SampleNo.frf') then
    begin
      showmessage('����Ĭ��������ǩ��ӡģ��report_SampleNo.frfʧ��');
      exit;
    end;


    //frReport1.Pages.Pages[0].pgsize:=255;//.pgHeight:=70;
    //frReport1.Pages.Pages[0].pgHeight:=70;
    //frReport1.Pages[0].ChangePaper($100,2100,1500,-1,poPortrait);  //1 inch=2.54 cm

    if sdiappform.n9.Checked then  //Ԥ��ģʽ
      frReport1.ShowReport;
    if sdiappform.n8.Checked then  //ֱ�Ӵ�ӡģʽ
    begin
      if frReport1.PrepareReport then frReport1.PrintPreparedReport('', 1, True, frAll);
    end;
end;

initialization
  ffrmCommQuery:=nil;
end.