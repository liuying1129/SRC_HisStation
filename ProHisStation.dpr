program ProHisStation;

uses
  Forms,
  SDIMAIN in 'SDIMAIN.PAS' {SDIAppForm},
  Unit_dialog_pllr in 'Unit_dialog_pllr.pas' {Form_pllr},
  UfrmCommQuery in 'UfrmCommQuery.pas' {frmCommQuery},
  UfrmLogin in 'UfrmLogin.pas' {frmLogin},
  UfrmBatchSpecNo in 'UfrmBatchSpecNo.pas' {frmBatchSpecNo},
  UfrmCheckDate in 'UfrmCheckDate.pas' {frmCheckDate},
  UfrmExcelQuery in 'UfrmExcelQuery.pas' {frmExcelQuery},
  UfrmStaticCombItem in 'UfrmStaticCombItem.pas' {frmStaticCombItem},
  UDM in 'UDM.pas' {DM: TDataModule},
  UfrmFromExcelLoad in 'UfrmFromExcelLoad.pas' {frmFromExcelLoad},
  UfrmCopyInfo in 'UfrmCopyInfo.pas' {frmCopyInfo};

{$R *.RES}

begin
  Application.Initialize;
  Application.CreateForm(TDM, DM);
  Application.CreateForm(TSDIAppForm, SDIAppForm);
  Application.Run;
end.

