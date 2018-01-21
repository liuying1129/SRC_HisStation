object frmStaticCombItem: TfrmStaticCombItem
  Left = 192
  Top = 103
  Width = 700
  Height = 500
  Caption = #25353#32452#21512#39033#30446#32479#35745
  Color = clBtnFace
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  WindowState = wsMaximized
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object DBGrid1: TDBGrid
    Left = 0
    Top = 233
    Width = 692
    Height = 233
    Align = alClient
    DataSource = DataSource1
    ReadOnly = True
    TabOrder = 0
    TitleFont.Charset = ANSI_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -13
    TitleFont.Name = #23435#20307
    TitleFont.Style = []
  end
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 692
    Height = 233
    Align = alTop
    TabOrder = 1
    object Label1: TLabel
      Left = 13
      Top = 8
      Width = 52
      Height = 13
      Caption = #24320#22987#26085#26399
    end
    object Label2: TLabel
      Left = 117
      Top = 8
      Width = 52
      Height = 13
      Caption = #32467#26463#26085#26399
    end
    object DateTimePicker1: TDateTimePicker
      Left = 13
      Top = 24
      Width = 100
      Height = 21
      Date = 38692.361815682870000000
      Time = 38692.361815682870000000
      TabOrder = 0
    end
    object DateTimePicker2: TDateTimePicker
      Left = 116
      Top = 24
      Width = 100
      Height = 21
      Date = 38692.361815682870000000
      Time = 38692.361815682870000000
      TabOrder = 1
    end
    object BitBtn2: TBitBtn
      Left = 230
      Top = 20
      Width = 147
      Height = 25
      Caption = #32479#35745#32467#26524#23548#20837'Excel'
      TabOrder = 2
      OnClick = BitBtn2Click
    end
    object GroupBox1: TGroupBox
      Left = 13
      Top = 56
      Width = 545
      Height = 57
      Caption = #25353#32452#21512#39033#30446#32479#35745
      TabOrder = 3
      object Label3: TLabel
        Left = 12
        Top = 24
        Width = 98
        Height = 13
        Caption = #35831#36873#25321#32479#35745#31867#22411':'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object BitBtn1: TBitBtn
        Left = 258
        Top = 20
        Width = 75
        Height = 25
        Caption = #32479#35745
        TabOrder = 0
        OnClick = BitBtn1Click
      end
      object ComboBox1: TComboBox
        Left = 120
        Top = 21
        Width = 129
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Items.Strings = (
          #20165#25353#32452#21512#39033#30446
          #25353#36865#26816#21307#29983
          #25353#25805#20316#32773)
      end
    end
    object GroupBox2: TGroupBox
      Left = 13
      Top = 120
      Width = 545
      Height = 101
      Caption = #20004#23545#21322#32479#35745
      TabOrder = 4
      object Label4: TLabel
        Left = 16
        Top = 24
        Width = 35
        Height = 13
        Caption = 'HBsAg'
      end
      object Label5: TLabel
        Left = 96
        Top = 24
        Width = 35
        Height = 13
        Caption = 'HBsAb'
      end
      object Label6: TLabel
        Left = 192
        Top = 24
        Width = 35
        Height = 13
        Caption = 'HBeAg'
      end
      object Label7: TLabel
        Left = 280
        Top = 24
        Width = 35
        Height = 13
        Caption = 'HBeAb'
      end
      object Label8: TLabel
        Left = 368
        Top = 24
        Width = 35
        Height = 13
        Caption = 'HBcAb'
      end
      object Label9: TLabel
        Left = 12
        Top = 66
        Width = 360
        Height = 13
        Caption = #27880':1'#12289#20116#39033#30340#33521#25991#21517#24517#39035#20026'HBsAg,HBsAb,HBeAg,HBeAb,HBcAb'
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object Label10: TLabel
        Left = 32
        Top = 82
        Width = 274
        Height = 13
        Caption = '2'#12289#22914#26524#36873#25321#26694#20026#31354','#34920#31034#19981#23558#35813#39033#20316#20026#31579#36873#26465#20214
        Font.Charset = ANSI_CHARSET
        Font.Color = clBlue
        Font.Height = -13
        Font.Name = #23435#20307
        Font.Style = []
        ParentFont = False
      end
      object BitBtn3: TBitBtn
        Left = 456
        Top = 35
        Width = 75
        Height = 25
        Caption = #32479#35745
        TabOrder = 0
        OnClick = BitBtn3Click
      end
      object HBsAg: TComboBox
        Left = 16
        Top = 40
        Width = 81
        Height = 21
        ItemHeight = 13
        TabOrder = 1
        Text = #38452#24615
        Items.Strings = (
          #38452#24615
          #38451#24615)
      end
      object HBsAb: TComboBox
        Left = 104
        Top = 40
        Width = 81
        Height = 21
        ItemHeight = 13
        TabOrder = 2
        Text = #38452#24615
        Items.Strings = (
          #38452#24615
          #38451#24615)
      end
      object HBeAg: TComboBox
        Left = 192
        Top = 40
        Width = 81
        Height = 21
        ItemHeight = 13
        TabOrder = 3
        Text = #38452#24615
        Items.Strings = (
          #38452#24615
          #38451#24615)
      end
      object HBeAb: TComboBox
        Left = 280
        Top = 40
        Width = 81
        Height = 21
        ItemHeight = 13
        TabOrder = 4
        Text = #38452#24615
        Items.Strings = (
          #38452#24615
          #38451#24615)
      end
      object HBcAb: TComboBox
        Left = 368
        Top = 40
        Width = 81
        Height = 21
        ItemHeight = 13
        TabOrder = 5
        Text = #38452#24615
        Items.Strings = (
          #38452#24615
          #38451#24615)
      end
    end
  end
  object ADOQuery1: TADOQuery
    AfterOpen = ADOQuery1AfterOpen
    CommandTimeout = 0
    Parameters = <>
    Left = 88
    Top = 224
  end
  object DataSource1: TDataSource
    DataSet = ADOQuery1
    Left = 128
    Top = 224
  end
  object LYDataToExcel1: TLYDataToExcel
    Left = 168
    Top = 232
  end
end
