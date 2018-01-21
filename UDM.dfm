object DM: TDM
  OldCreateOrder = False
  OnCreate = DataModuleCreate
  Left = 244
  Top = 182
  Height = 202
  Width = 267
  object ADOConnection1: TADOConnection
    LoginPrompt = False
    Provider = 'SQLOLEDB.1'
    Left = 43
    Top = 16
  end
  object ADOConn_His: TADOConnection
    LoginPrompt = False
    Left = 134
    Top = 14
  end
end
