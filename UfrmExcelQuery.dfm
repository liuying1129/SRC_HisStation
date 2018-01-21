object frmExcelQuery: TfrmExcelQuery
  Left = 4
  Top = 106
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
  object pnlCommQryTop: TPanel
    Left = 0
    Top = 0
    Width = 778
    Height = 35
    Align = alTop
    Color = clSkyBlue
    TabOrder = 0
    object BitBtnCommQry: TBitBtn
      Left = 16
      Top = 5
      Width = 107
      Height = 25
      Caption = #36873#21462#26597#35810#26465#20214'(&Q)'
      TabOrder = 0
      OnClick = BitBtnCommQryClick
    end
    object BitBtnCommQryClose: TBitBtn
      Left = 264
      Top = 5
      Width = 68
      Height = 25
      Cancel = True
      Caption = #20851#38381'(&R)'
      TabOrder = 1
      OnClick = BitBtnCommQryCloseClick
    end
    object BitBtn1: TBitBtn
      Left = 123
      Top = 5
      Width = 140
      Height = 25
      Caption = #23548#20837'Excel(&P)'
      TabOrder = 2
      OnClick = BitBtn1Click
    end
  end
  object DBGridResult: TDBGrid
    Left = 0
    Top = 35
    Width = 778
    Height = 377
    Align = alClient
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
  object Masterquery: TADOQuery
    CursorType = ctStatic
    AfterOpen = MasterqueryAfterOpen
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
    DataSet = Masterquery
    Left = 336
    Top = 136
  end
  object LYDataToExcel1: TLYDataToExcel
    Left = 568
    Top = 104
  end
end
