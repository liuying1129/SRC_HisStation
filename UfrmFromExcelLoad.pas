unit UfrmFromExcelLoad;

interface

uses
  Windows, Messages, SysUtils, Variants, Classes, Graphics, Controls, Forms,
  Dialogs, StdCtrls, Buttons, ExtCtrls,ComObj,ADODB;

type
  TfrmFromExcelLoad = class(TForm)
    BitBtn1: TBitBtn;
    BitBtn2: TBitBtn;
    LabeledEdit1: TLabeledEdit;
    OpenDialog1: TOpenDialog;
    SpeedButton1: TSpeedButton;
    Label1: TLabel;
    Label13: TLabel;
    Label2: TLabel;
    Label3: TLabel;
    Label4: TLabel;
    Label5: TLabel;
    Label6: TLabel;
    Label7: TLabel;
    Label8: TLabel;
    Label10: TLabel;
    Label11: TLabel;
    Label9: TLabel;
    Label12: TLabel;
    Label14: TLabel;
    Label15: TLabel;
    Label16: TLabel;
    procedure SpeedButton1Click(Sender: TObject);
    procedure FormClose(Sender: TObject; var Action: TCloseAction);
    procedure BitBtn1Click(Sender: TObject);
    procedure BitBtn2Click(Sender: TObject);
  private
    { Private declarations }
  public
    { Public declarations }
  end;

//var
function frmFromExcelLoad: TfrmFromExcelLoad;

implementation

uses UDM, SDIMAIN;
var
  ffrmFromExcelLoad: TfrmFromExcelLoad;
  
{$R *.dfm}
function frmFromExcelLoad: TfrmFromExcelLoad;
begin
  if ffrmFromExcelLoad=nil then ffrmFromExcelLoad:=TfrmFromExcelLoad.Create(application.mainform);
  result:=ffrmFromExcelLoad;
end;

procedure TfrmFromExcelLoad.FormClose(Sender: TObject;
  var Action: TCloseAction);
begin
  action:=cafree;
  if ffrmFromExcelLoad=self then ffrmFromExcelLoad:=nil;
end;

procedure TfrmFromExcelLoad.SpeedButton1Click(Sender: TObject);
begin
  if not OpenDialog1.Execute then exit;
  LabeledEdit1.Text:=OpenDialog1.FileName;
end;

procedure TfrmFromExcelLoad.BitBtn1Click(Sender: TObject);
var
  excelv,sheetv:variant;
  //(1)占位列,(2)流水号,(3)联机号,(4)病历号,(5)检查日期,(6)姓名,
  LSH,LJH,BLH,JCRQ,XM:string;
  //(7)性别,(8)年龄,(9)床号,(10)送检科室,(11)送检医生, (12)操作员,
  XB,LL,CH,SJKS,SJYS,CZY:STRING;
  //(13)审核者,(14)申请日期,(15)优先级别,(16)工作组别,(17)样本类型,
  SHZ,SQRQ,YXJB,ZB,YBLX:STRING;
  //(18)样本情况,(19)临床诊断,(20)备注,(21)细菌,(22)所属公司,
  YBQK,LCZD,BZ,XJ,SSGS:STRING;
  //(23)所属部门,(24)工种，(25)工号,(26)婚否,(27)籍贯,(28)住址,
  SSBM,GZ,GH,HF,JG,ZZ:STRING;
  //(29)电话，(30)舒张压,(31)收缩压,(32)左眼视力,
  DH,SZY,SSY,ZYSL:STRING;
  //(33)右眼视力,(34)身高,(35)体重,(36)既往史,(37)家族史,
  YYSL,SG,TZ,JWS,JZS:STRING;
  //(38)内科，(39)外科，(40)五官科，(41)妇科，(42)冷强光，
  NK,WK,WGK,FK,LQG:STRING;
  //(43)X光，(44)B超，(45)心电图，(46)检验，(47)结论，(48)建议
  XG,BC,XDT,JY,JL,YSJY:STRING;
  //(49)项目名称,(50)项目英文名,(51)检验结果,(52)单位
  XMMC,XMYWM,JYJG,DW:STRING;
  //(53)最小值,(54)最大值,(55)组合项目号,(56)打印编号,(57)项目代码
  ZXZ,ZDZ,ZHXMH,DYBH,XMDM:STRING;

  i,RecNum,ValetudinarianInfoId,RecNum_Valu:integer;
  adotemp11,adotemp22,adotemp33,adotemp44:tadoquery;
  Save_Cursor:TCursor;
begin
  //if trim(sdiappform.cbxConnChar.Text)='' then
  //begin
  //  showmessage('组别不能为空!');
  //  exit;
  //end;

  //{IF TRIM(ZB)='' THEN //}ZB:=sdiappform.cbxConnChar.Text;//如无组别,则导入当前组别

  try
    excelv:=CreateOleObject('excel.application');
  except
    showmessage('您的计算机上可能没安装Excel!');
    exit;
  end;
  try
    excelv.workbooks.open(LabeledEdit1.Text);
  except
    showmessage('此文件不存在!');
    exit;
  end;

  Save_Cursor := Screen.Cursor;
  Screen.Cursor := crHourGlass;    { Show hourglass cursor }
  try  
    sheetv:=excelv.workbooks[1].worksheets[1];

    i:=2;
    //基本信息
    {TJH:=sheetv.cells[i,1];}LSH:=sheetv.cells[i,2];LJH:=sheetv.cells[i,3];BLH:=sheetv.cells[i,4];JCRQ:=sheetv.cells[i,5];XM:=sheetv.cells[i,6];
    XB:=sheetv.cells[i,7];LL:=sheetv.cells[i,8];CH:=sheetv.cells[i,9];SJKS:=sheetv.cells[i,10];SJYS:=sheetv.cells[i,11];CZY:=sheetv.cells[i,12];
    SHZ:=sheetv.cells[i,13];SQRQ:=sheetv.cells[i,14];YXJB:=sheetv.cells[i,15];{ZB:=sheetv.cells[i,16];}YBLX:=sheetv.cells[i,17];
    YBQK:=sheetv.cells[i,18];LCZD:=sheetv.cells[i,19];BZ:=sheetv.cells[i,20];XJ:=sheetv.cells[i,21];SSGS:=sheetv.cells[i,22];
    SSBM:=sheetv.cells[i,23];GZ:=sheetv.cells[i,24];GH:=sheetv.cells[i,25];HF:=sheetv.cells[i,26];JG:=sheetv.cells[i,27];ZZ:=sheetv.cells[i,28];
    DH:=sheetv.cells[i,29];SZY:=sheetv.cells[i,30];SSY:=sheetv.cells[i,31];ZYSL:=sheetv.cells[i,32];
    YYSL:=sheetv.cells[i,33];SG:=sheetv.cells[i,34];TZ:=sheetv.cells[i,35];JWS:=sheetv.cells[i,36];JZS:=sheetv.cells[i,37];
    NK:=sheetv.cells[i,38];WK:=sheetv.cells[i,39];WGK:=sheetv.cells[i,40];FK:=sheetv.cells[i,41];LQG:=sheetv.cells[i,42];
    XG:=sheetv.cells[i,43];BC:=sheetv.cells[i,44];XDT:=sheetv.cells[i,45];JY:=sheetv.cells[i,46];JL:=sheetv.cells[i,47];YSJY:=sheetv.cells[i,48];
    //检验结果
    XMMC:=sheetv.cells[i,49];XMYWM:=sheetv.cells[i,50];JYJG:=sheetv.cells[i,51];DW:=sheetv.cells[i,52];
    ZXZ:=sheetv.cells[i,53];ZDZ:=sheetv.cells[i,54];ZHXMH:=sheetv.cells[i,55];DYBH:=sheetv.cells[i,56];XMDM:=sheetv.cells[i,57];

    while (XM<>'') do //AND (TJH<>'')
    begin
      adotemp22:=tadoquery.create(nil);
      adotemp22.Connection:=dm.ADOConnection1;
      adotemp22.Close;
      adotemp22.SQL.Clear;
      adotemp22.SQL.Text:='select unid from chk_con where patientname='''+XM+''' AND sex='''+XB+''' AND age='''+LL+''' AND combin_id='''+ZB+'''';// dnh='+TJH;
      adotemp22.Open;
      RecNum:=adotemp22.RecordCount;
      IF RecNum>=1 then ValetudinarianInfoId:=adotemp22.FIELDBYNAME('UNID').AsInteger;
      adotemp22.Free;
      IF RecNum>=1 then//该病人已存在
      begin
        if (trim(JYJG)<>'')and(trim(XMDM)<>'') then//插入检验结果
        begin
          adotemp44:=tadoquery.create(nil);
          adotemp44.Connection:=dm.ADOConnection1;
          adotemp44.Close;
          adotemp44.SQL.Clear;
          adotemp44.SQL.Text:='select COUNT(*) AS RecNum_Valu from chk_valu where PkUnid='+inttostr(ValetudinarianInfoId)+' and name='''+XMMC+''' and itemvalue='''+JYJG+''' ';
          adotemp44.Open;
          RecNum_Valu:=adotemp44.fieldbyname('RecNum_Valu').AsInteger;
          adotemp44.Free;

          IF RecNum_Valu<=0 THEN//该病人没有该检验项目的结果(通过每个病人的项目中文名及结果来判断)
          BEGIN
            adotemp33:=tadoquery.create(nil);
            adotemp33.Connection:=dm.ADOConnection1;
            adotemp33.Close;
            adotemp33.SQL.Clear;
            adotemp33.SQL.Add('insert into chk_valu ([pkunid],[pkcombin_id],[itemid],[name],[english_name],[itemvalue],[Unit],'+
           '[Min_value],[Max_value],[printorder],[issure]) values ('+
                inttostr(ValetudinarianInfoId)+','''+ZHXMH+''','''+XMDM+''','''+XMMC+''','''+XMYWM+''','''+JYJG+''','''+DW+''','''+
                ZXZ+''','''+ZDZ+''','+inttostr(strtointdef(DYBH,0))+',''1'')');
            adotemp33.ExecSQL;
            adotemp33.Free;
          END;
        end;

        inc(i);
        //基本信息
        {TJH:=sheetv.cells[i,1];}LSH:=sheetv.cells[i,2];LJH:=sheetv.cells[i,3];BLH:=sheetv.cells[i,4];JCRQ:=sheetv.cells[i,5];XM:=sheetv.cells[i,6];
        XB:=sheetv.cells[i,7];LL:=sheetv.cells[i,8];CH:=sheetv.cells[i,9];SJKS:=sheetv.cells[i,10];SJYS:=sheetv.cells[i,11];CZY:=sheetv.cells[i,12];
        SHZ:=sheetv.cells[i,13];SQRQ:=sheetv.cells[i,14];YXJB:=sheetv.cells[i,15];{ZB:=sheetv.cells[i,16];}YBLX:=sheetv.cells[i,17];
        YBQK:=sheetv.cells[i,18];LCZD:=sheetv.cells[i,19];BZ:=sheetv.cells[i,20];XJ:=sheetv.cells[i,21];SSGS:=sheetv.cells[i,22];
        SSBM:=sheetv.cells[i,23];GZ:=sheetv.cells[i,24];GH:=sheetv.cells[i,25];HF:=sheetv.cells[i,26];JG:=sheetv.cells[i,27];ZZ:=sheetv.cells[i,28];
        DH:=sheetv.cells[i,29];SZY:=sheetv.cells[i,30];SSY:=sheetv.cells[i,31];ZYSL:=sheetv.cells[i,32];
        YYSL:=sheetv.cells[i,33];SG:=sheetv.cells[i,34];TZ:=sheetv.cells[i,35];JWS:=sheetv.cells[i,36];JZS:=sheetv.cells[i,37];
        NK:=sheetv.cells[i,38];WK:=sheetv.cells[i,39];WGK:=sheetv.cells[i,40];FK:=sheetv.cells[i,41];LQG:=sheetv.cells[i,42];
        XG:=sheetv.cells[i,43];BC:=sheetv.cells[i,44];XDT:=sheetv.cells[i,45];JY:=sheetv.cells[i,46];JL:=sheetv.cells[i,47];YSJY:=sheetv.cells[i,48];
        //检验结果
        XMMC:=sheetv.cells[i,49];XMYWM:=sheetv.cells[i,50];JYJG:=sheetv.cells[i,51];DW:=sheetv.cells[i,52];
        ZXZ:=sheetv.cells[i,53];ZDZ:=sheetv.cells[i,54];ZHXMH:=sheetv.cells[i,55];DYBH:=sheetv.cells[i,56];XMDM:=sheetv.cells[i,57];
        continue;
      end;

      IF TRIM(YXJB)='' THEN YXJB:=CGYXJB;//如无优先级别,则导入'常规'
      adotemp11:=tadoquery.create(nil);
      adotemp11.Connection:=dm.ADOConnection1;
      adotemp11.Close;
      adotemp11.SQL.Clear;
      adotemp11.SQL.Add('insert into chk_con ([checkid],[patientname],[sex],[age],[Caseno],[bedno],[deptname],[check_date],[check_doctor],'+
     '[report_date],[report_doctor],[operator],[Diagnosetype],[flagetype],[diagnose],[typeflagcase],'+
     '[issure],[combin_id],[LSH],[GermName],[WorkDepartment],[WorkCategory],[WorkID],[ifMarry],'+
     '[OldAddress],[Address],[Telephone],[TjDescription],[WorkCompany],[PushPress],[PullPress],'+
     '[LeftEyesight],[RightEyesight],[Stature],[Weight],[TjJiWangShi],[TjJiaZuShi],[TjNeiKe],'+
     '[TjWaiKe],[TjWuGuanKe],[TjFuKe],[TjLengQiangGuang],[TjXGuang],[TjBChao],'+
     '[TjXinDianTu],[TJAdvice],[TjJianYan]) values ('''+//,[DNH]
          LJH+''','''+XM+''','''+XB+''','''+LL+''','''+BLH+''','''+CH+''','''+SJKS+''','''+JCRQ+''','''+SJYS+''','''+
          SQRQ+''','''+SHZ+''','''+CZY+''','''+YXJB+''','''+YBLX+''','''+LCZD+''','''+YBQK+''','''+
          BZ+''','''+ZB+''','''+LSH+''','''+XJ+''','''+SSBM+''','''+GZ+''','''+GH+''','''+HF+''','''+
          JG+''','''+ZZ+''','''+DH+''','''+JL+''','''+SSGS+''','''+SZY+''','''+SSY+''','''+
          ZYSL+''','''+YYSL+''','''+SG+''','''+TZ+''','''+JWS+''','''+JZS+''','''+NK+''','''+
          WK+''','''+WGK+''','''+FK+''','''+LQG+''','''+XG+''','''+BC+''','''+
          XDT+''','''+YSJY+''','''+JY+''')');//''','''+TJH+
      adotemp11.SQL.Add(' SELECT SCOPE_IDENTITY() AS Insert_Identity ');
      adotemp11.Open;
      ValetudinarianInfoId:=adotemp11.fieldbyname('Insert_Identity').AsInteger;
      adotemp11.Free;
      if (trim(JYJG)<>'')and(trim(XMDM)<>'') then//插入检验结果
      begin
        adotemp44:=tadoquery.create(nil);
        adotemp44.Connection:=dm.ADOConnection1;
        adotemp44.Close;
        adotemp44.SQL.Clear;
        adotemp44.SQL.Text:='select COUNT(*) AS RecNum_Valu from chk_valu where PkUnid='+inttostr(ValetudinarianInfoId)+' and name='''+XMMC+''' and itemvalue='''+JYJG+''' ';
        adotemp44.Open;
        RecNum_Valu:=adotemp44.fieldbyname('RecNum_Valu').AsInteger;
        adotemp44.Free;

        IF RecNum_Valu<=0 THEN//该病人没有该检验项目的结果(通过每个病人的项目中文名及结果来判断)
        BEGIN
          adotemp33:=tadoquery.create(nil);
          adotemp33.Connection:=dm.ADOConnection1;
          adotemp33.Close;
          adotemp33.SQL.Clear;
          adotemp33.SQL.Add('insert into chk_valu ([pkunid],[pkcombin_id],[itemid],[name],[english_name],[itemvalue],[Unit],'+
         '[Min_value],[Max_value],[printorder],[issure]) values ('+
              inttostr(ValetudinarianInfoId)+','''+ZHXMH+''','''+XMDM+''','''+XMMC+''','''+XMYWM+''','''+JYJG+''','''+DW+''','''+
              ZXZ+''','''+ZDZ+''','+inttostr(strtointdef(DYBH,0))+',''1'')');
          adotemp33.ExecSQL;
          adotemp33.Free;
        END;
      end;

      inc(i);
      //基本信息
      {TJH:=sheetv.cells[i,1];}LSH:=sheetv.cells[i,2];LJH:=sheetv.cells[i,3];BLH:=sheetv.cells[i,4];JCRQ:=sheetv.cells[i,5];XM:=sheetv.cells[i,6];
      XB:=sheetv.cells[i,7];LL:=sheetv.cells[i,8];CH:=sheetv.cells[i,9];SJKS:=sheetv.cells[i,10];SJYS:=sheetv.cells[i,11];CZY:=sheetv.cells[i,12];
      SHZ:=sheetv.cells[i,13];SQRQ:=sheetv.cells[i,14];YXJB:=sheetv.cells[i,15];{ZB:=sheetv.cells[i,16];}YBLX:=sheetv.cells[i,17];
      YBQK:=sheetv.cells[i,18];LCZD:=sheetv.cells[i,19];BZ:=sheetv.cells[i,20];XJ:=sheetv.cells[i,21];SSGS:=sheetv.cells[i,22];
      SSBM:=sheetv.cells[i,23];GZ:=sheetv.cells[i,24];GH:=sheetv.cells[i,25];HF:=sheetv.cells[i,26];JG:=sheetv.cells[i,27];ZZ:=sheetv.cells[i,28];
      DH:=sheetv.cells[i,29];SZY:=sheetv.cells[i,30];SSY:=sheetv.cells[i,31];ZYSL:=sheetv.cells[i,32];
      YYSL:=sheetv.cells[i,33];SG:=sheetv.cells[i,34];TZ:=sheetv.cells[i,35];JWS:=sheetv.cells[i,36];JZS:=sheetv.cells[i,37];
      NK:=sheetv.cells[i,38];WK:=sheetv.cells[i,39];WGK:=sheetv.cells[i,40];FK:=sheetv.cells[i,41];LQG:=sheetv.cells[i,42];
      XG:=sheetv.cells[i,43];BC:=sheetv.cells[i,44];XDT:=sheetv.cells[i,45];JY:=sheetv.cells[i,46];JL:=sheetv.cells[i,47];YSJY:=sheetv.cells[i,48];
      //检验结果
      XMMC:=sheetv.cells[i,49];XMYWM:=sheetv.cells[i,50];JYJG:=sheetv.cells[i,51];DW:=sheetv.cells[i,52];
      ZXZ:=sheetv.cells[i,53];ZDZ:=sheetv.cells[i,54];ZHXMH:=sheetv.cells[i,55];DYBH:=sheetv.cells[i,56];XMDM:=sheetv.cells[i,57];
    end;

    //======清除内存
    if not VarIsEmpty(sheetv) then VarClear(sheetv);
    if not VarIsEmpty(excelv) then
    begin
      excelv.DisplayAlerts := False;
      excelv.Quit;
      VarClear(excelv);
    end;
    //=============

  finally
    Screen.Cursor := Save_Cursor;  { Always restore to normal }
  end;

  sdiappform.UpdateADObasic;//刷新主界面
  MESSAGEDLG('导入成功!',MTINFORMATION,[MBOK],0);
  close;
end;

procedure TfrmFromExcelLoad.BitBtn2Click(Sender: TObject);
begin
  CLOSE;
end;

initialization
  ffrmFromExcelLoad:=nil;

end.
