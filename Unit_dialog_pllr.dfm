object Form_pllr: TForm_pllr
  Left = 272
  Top = 111
  BorderStyle = bsDialog
  Caption = #30149#20154#20449#24687#25209#37327#24405#20837
  ClientHeight = 433
  ClientWidth = 292
  Color = clSkyBlue
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -13
  Font.Name = #23435#20307
  Font.Style = []
  KeyPreview = True
  OldCreateOrder = False
  Position = poScreenCenter
  OnClose = FormClose
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object CheckListBox1: TCheckListBox
    Left = 0
    Top = 175
    Width = 292
    Height = 203
    Align = alClient
    Color = 16767438
    Columns = 2
    Ctl3D = False
    ItemHeight = 13
    ParentCtl3D = False
    TabOrder = 0
  end
  object Panel1: TPanel
    Left = 0
    Top = 378
    Width = 292
    Height = 55
    Align = alBottom
    Color = clSkyBlue
    TabOrder = 1
    object Label2: TLabel
      Left = 34
      Top = 36
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
    object BitBtn1: TBitBtn
      Left = 13
      Top = 7
      Width = 62
      Height = 25
      Caption = #30830#23450'(F2)'
      TabOrder = 0
      OnClick = BitBtn1Click
      NumGlyphs = 2
    end
    object BitBtn2: TBitBtn
      Left = 75
      Top = 7
      Width = 62
      Height = 25
      Caption = #20851#38381'(Esc)'
      TabOrder = 1
      OnClick = BitBtn2Click
      NumGlyphs = 2
    end
    object BitBtn3: TBitBtn
      Left = 147
      Top = 7
      Width = 60
      Height = 25
      Caption = #20840#36873
      TabOrder = 2
      OnClick = BitBtn3Click
    end
    object BitBtn4: TBitBtn
      Left = 208
      Top = 7
      Width = 60
      Height = 25
      Caption = #21453#36873
      TabOrder = 3
      OnClick = BitBtn4Click
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 0
    Width = 292
    Height = 175
    Align = alTop
    Color = clSkyBlue
    TabOrder = 2
    object Label1: TLabel
      Left = 62
      Top = 28
      Width = 52
      Height = 13
      Caption = #20248#20808#32423#21035
    end
    object Label3: TLabel
      Left = 62
      Top = 8
      Width = 52
      Height = 13
      Caption = #30003#35831#26085#26399
    end
    object Label4: TLabel
      Left = 52
      Top = 152
      Width = 65
      Height = 13
      Caption = #26679#26412#21495#33539#22260
    end
    object DateTimePicker1: TDateTimePicker
      Left = 120
      Top = 4
      Width = 87
      Height = 21
      Date = 37833.628041087960000000
      Time = 37833.628041087960000000
      TabOrder = 0
      OnChange = DateTimePicker1Change
    end
    object LabeledEdit1: TLabeledEdit
      Left = 120
      Top = 88
      Width = 87
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #26679#26412#31867#22411
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 4
      OnKeyDown = LabeledEdit1KeyDown
    end
    object LabeledEdit5: TLabeledEdit
      Left = 120
      Top = 108
      Width = 87
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #26679#26412#29366#24577
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 5
      OnKeyDown = LabeledEdit5KeyDown
    end
    object LabeledEdit6: TLabeledEdit
      Left = 120
      Top = 48
      Width = 87
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #36865#26816#31185#23460
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 2
      OnKeyDown = LabeledEdit6KeyDown
    end
    object LabeledEdit10: TLabeledEdit
      Left = 120
      Top = 68
      Width = 87
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 52
      EditLabel.Height = 13
      EditLabel.Caption = #36865#26816#21307#29983
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 3
      OnKeyDown = LabeledEdit10KeyDown
    end
    object LabeledEdit15: TLabeledEdit
      Left = 120
      Top = 128
      Width = 87
      Height = 19
      Color = 16767438
      Ctl3D = False
      EditLabel.Width = 26
      EditLabel.Height = 13
      EditLabel.Caption = #22791#27880
      LabelPosition = lpLeft
      ParentCtl3D = False
      TabOrder = 6
      OnKeyDown = LabeledEdit15KeyDown
    end
    object ComboBox1: TComboBox
      Left = 120
      Top = 25
      Width = 87
      Height = 21
      ItemHeight = 13
      TabOrder = 1
      Text = #24120#35268
      OnChange = ComboBox1Change
      Items.Strings = (
        #24120#35268
        #24613#35786)
    end
    object Edit1: TEdit
      Left = 120
      Top = 148
      Width = 87
      Height = 21
      TabOrder = 7
    end
  end
  object DosMove1: TDosMove
    Active = True
    Left = 16
    Top = 8
  end
  object ActionList1: TActionList
    Left = 16
    Top = 80
    object Action1: TAction
      Caption = 'Action1'
      ShortCut = 113
      OnExecute = BitBtn1Click
    end
    object Action2: TAction
      Caption = 'Action2'
      ShortCut = 27
      OnExecute = BitBtn2Click
    end
  end
end
