object frmCheckDate: TfrmCheckDate
  Left = 223
  Top = 174
  BorderStyle = bsDialog
  ClientHeight = 142
  ClientWidth = 290
  Color = clSkyBlue
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 72
    Top = 24
    Width = 52
    Height = 13
    Caption = #26816#26597#26085#26399
  end
  object BitBtn1: TBitBtn
    Left = 56
    Top = 88
    Width = 75
    Height = 25
    Caption = #30830#23450
    Default = True
    TabOrder = 0
    OnClick = BitBtn1Click
    Glyph.Data = {
      DE010000424DDE01000000000000760000002800000024000000120000000100
      0400000000006801000000000000000000001000000000000000000000000000
      80000080000000808000800000008000800080800000C0C0C000808080000000
      FF0000FF000000FFFF00FF000000FF00FF00FFFF0000FFFFFF00333333333333
      3333333333333333333333330000333333333333333333333333F33333333333
      00003333344333333333333333388F3333333333000033334224333333333333
      338338F3333333330000333422224333333333333833338F3333333300003342
      222224333333333383333338F3333333000034222A22224333333338F338F333
      8F33333300003222A3A2224333333338F3838F338F33333300003A2A333A2224
      33333338F83338F338F33333000033A33333A222433333338333338F338F3333
      0000333333333A222433333333333338F338F33300003333333333A222433333
      333333338F338F33000033333333333A222433333333333338F338F300003333
      33333333A222433333333333338F338F00003333333333333A22433333333333
      3338F38F000033333333333333A223333333333333338F830000333333333333
      333A333333333333333338330000333333333333333333333333333333333333
      0000}
    NumGlyphs = 2
  end
  object BitBtn2: TBitBtn
    Left = 152
    Top = 88
    Width = 75
    Height = 25
    Caption = #21462#28040
    TabOrder = 1
    OnClick = BitBtn2Click
    Kind = bkCancel
  end
  object DateTimePicker1: TDateTimePicker
    Left = 72
    Top = 40
    Width = 142
    Height = 21
    Date = 38148.352326921300000000
    Time = 38148.352326921300000000
    TabOrder = 2
  end
  object ADObasic: TADOQuery
    AfterScroll = ADObasicAfterScroll
    Parameters = <>
    Left = 224
    Top = 8
  end
  object ADOdtl: TADOQuery
    Parameters = <>
    Left = 256
    Top = 8
  end
  object frDB_adobasic: TfrDBDataSet
    DataSet = ADObasic
    Left = 224
    Top = 40
  end
  object frDB_adodtl: TfrDBDataSet
    DataSet = ADOdtl
    Left = 256
    Top = 40
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    ModifyPrepared = False
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    RebuildPrinter = False
    Left = 152
    Top = 8
    ReportForm = {19000000}
  end
end
