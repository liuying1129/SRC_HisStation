object frmBatchSpecNo: TfrmBatchSpecNo
  Left = 194
  Top = 231
  BorderStyle = bsDialog
  Caption = #33539#22260#36873#25321
  ClientHeight = 198
  ClientWidth = 308
  Color = clSkyBlue
  Font.Charset = ANSI_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object Label1: TLabel
    Left = 98
    Top = 10
    Width = 52
    Height = 13
    Caption = #30003#35831#26085#26399
  end
  object Label5: TLabel
    Left = 45
    Top = 165
    Width = 167
    Height = 13
    Caption = #27880#65306'1'#12289#33539#22260#26684#24335#22914'5,7-9,12'
    Font.Charset = ANSI_CHARSET
    Font.Color = clRed
    Font.Height = -13
    Font.Name = #23435#20307
    Font.Style = []
    ParentFont = False
  end
  object Label2: TLabel
    Left = 97
    Top = 30
    Width = 52
    Height = 13
    Caption = #20248#20808#32423#21035
  end
  object BitBtn1: TBitBtn
    Left = 72
    Top = 136
    Width = 75
    Height = 25
    Caption = #30830#23450
    TabOrder = 0
    OnClick = BitBtn1Click
  end
  object BitBtn2: TBitBtn
    Left = 168
    Top = 136
    Width = 75
    Height = 25
    Caption = #20851#38381
    TabOrder = 1
    OnClick = BitBtn2Click
  end
  object RadioGroup1: TRadioGroup
    Left = 33
    Top = 97
    Width = 248
    Height = 36
    Caption = #25171#21360#31867#22411#36873#25321
    Columns = 2
    ItemIndex = 0
    Items.Strings = (
      #30003#35831#21333
      #26631#31614)
    TabOrder = 2
  end
  object DateTimePicker1: TDateTimePicker
    Left = 156
    Top = 5
    Width = 95
    Height = 21
    Date = 37942.591355486110000000
    Time = 37942.591355486110000000
    TabOrder = 3
  end
  object ComboBox1: TComboBox
    Left = 156
    Top = 27
    Width = 95
    Height = 21
    ItemHeight = 13
    TabOrder = 4
    Text = #24120#35268
    Items.Strings = (
      #24120#35268
      #24613#35786)
  end
  object RadioGroup2: TRadioGroup
    Left = 41
    Top = 42
    Width = 112
    Height = 50
    ItemIndex = 0
    Items.Strings = (
      #21807#19968#32534#21495#33539#22260
      #26679#26412#21495#33539#22260)
    TabOrder = 5
    OnClick = RadioGroup2Click
  end
  object LabeledEdit3: TEdit
    Left = 156
    Top = 49
    Width = 95
    Height = 21
    TabOrder = 6
  end
  object LabeledEdit1: TEdit
    Left = 156
    Top = 71
    Width = 95
    Height = 21
    Enabled = False
    TabOrder = 7
  end
  object ADOQuery1: TADOQuery
    Parameters = <>
    Left = 24
    Top = 8
  end
  object DosMove1: TDosMove
    Active = True
    Left = 264
    Top = 8
  end
end
