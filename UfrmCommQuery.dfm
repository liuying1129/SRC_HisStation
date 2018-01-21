object frmCommQuery: TfrmCommQuery
  Left = 5
  Top = 108
  Width = 794
  Height = 450
  Caption = #26597#35810
  Color = clSkyBlue
  Font.Charset = GB2312_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Splitter1: TSplitter
    Left = 0
    Top = 273
    Width = 778
    Height = 5
    Cursor = crVSplit
    Align = alTop
  end
  object pnlCommQryTop: TPanel
    Left = 0
    Top = 0
    Width = 778
    Height = 35
    Align = alTop
    Color = 16767438
    TabOrder = 0
    object Label1: TLabel
      Left = 486
      Top = 16
      Width = 33
      Height = 13
      Caption = #20154#27425':'
    end
    object Label2: TLabel
      Left = 520
      Top = 16
      Width = 7
      Height = 13
      Caption = '0'
    end
    object BitBtnCommQry: TBitBtn
      Left = 11
      Top = 5
      Width = 110
      Height = 25
      Caption = #36873#21462#26597#35810#26465#20214'(&Q)'
      TabOrder = 0
      OnClick = BitBtnCommQryClick
    end
    object BitBtnCommQryClose: TBitBtn
      Left = 302
      Top = 5
      Width = 90
      Height = 25
      Cancel = True
      Caption = #20851#38381'(&R)'
      TabOrder = 1
      OnClick = BitBtnCommQryCloseClick
    end
    object BitBtn1: TBitBtn
      Left = 121
      Top = 5
      Width = 90
      Height = 25
      Caption = #25171#21360#30003#35831#21333'(&P)'
      TabOrder = 2
      OnClick = BitBtn1Click
    end
    object BitBtn3: TBitBtn
      Left = 212
      Top = 5
      Width = 90
      Height = 25
      Caption = #25171#21360#26631#31614
      TabOrder = 3
      OnClick = BitBtn3Click
    end
  end
  object DBGridResult: TDBGrid
    Left = 0
    Top = 35
    Width = 778
    Height = 238
    Align = alTop
    Color = 16767438
    Ctl3D = False
    DataSource = MasterDataSource
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 1
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
  end
  object pnlCommQryBotton: TPanel
    Left = 0
    Top = 386
    Width = 778
    Height = 26
    Align = alBottom
    Color = 16767438
    TabOrder = 2
    object BitBtn4: TBitBtn
      Left = 160
      Top = 1
      Width = 87
      Height = 25
      Caption = #20462#25913#26816#39564#32467#26524
      TabOrder = 0
      OnClick = BitBtn4Click
    end
    object BitBtn2: TBitBtn
      Left = 72
      Top = 1
      Width = 87
      Height = 25
      Caption = #20462#25913#22522#26412#20449#24687
      TabOrder = 1
      OnClick = BitBtn2Click
    end
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 278
    Width = 778
    Height = 108
    Align = alClient
    Color = 16767438
    Ctl3D = False
    DataSource = DataSource1
    ParentCtl3D = False
    ReadOnly = True
    TabOrder = 3
    TitleFont.Charset = GB2312_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
  end
  object ADOQuery1: TADOQuery
    CursorType = ctStatic
    AfterOpen = ADOQuery1AfterOpen
    Parameters = <>
    Left = 304
    Top = 280
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 336
    Top = 280
  end
  object frReport1: TfrReport
    InitialZoom = pzDefault
    ModifyPrepared = False
    PreviewButtons = [pbZoom, pbLoad, pbSave, pbPrint, pbFind, pbHelp, pbExit]
    ShowPrintDialog = False
    RebuildPrinter = False
    OnGetValue = frReport1GetValue
    Left = 304
    Top = 80
    ReportForm = {19000000}
  end
  object ADObasic: TADOQuery
    CursorType = ctStatic
    AfterOpen = ADObasicAfterOpen
    AfterScroll = ADObasicAfterScroll
    Parameters = <>
    Left = 304
    Top = 136
  end
  object LYQuery1: TADOLYQuery
    DataBaseType = dbtMSSQL
    Left = 536
    Top = 104
  end
  object MasterDataSource: TDataSource
    DataSet = ADObasic
    Left = 336
    Top = 136
  end
end
