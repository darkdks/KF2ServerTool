object formNewConfig: TformNewConfig
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'New Server config'
  ClientHeight = 357
  ClientWidth = 513
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblPCGAMEPATH: TLabel
    Left = 17
    Top = 77
    Width = 132
    Height = 13
    Caption = 'PCServer-KFGame path'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblPCENGINEPATH: TLabel
    Left = 17
    Top = 133
    Width = 136
    Height = 13
    Caption = 'PCServer-KFEngine path'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label1: TLabel
    Left = 24
    Top = 256
    Width = 401
    Height = 25
    Caption = 
      'To create a new server, specify a new KFGame and KF Engine confi' +
      'guration file.'
    WordWrap = True
  end
  object Label2: TLabel
    Left = 24
    Top = 276
    Width = 347
    Height = 13
    Caption = 
      'If you don'#39't already have it, you can create a copy of the exist' +
      'ing ones.'
    WordWrap = True
  end
  object Label3: TLabel
    Left = 24
    Top = 237
    Width = 20
    Height = 13
    Caption = 'Tip:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label4: TLabel
    Left = 17
    Top = 23
    Width = 147
    Height = 13
    Caption = 'KFServerTool config name'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object Label5: TLabel
    Left = 24
    Top = 47
    Width = 84
    Height = 16
    Caption = 'KFServerTool_'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label6: TLabel
    Left = 250
    Top = 47
    Width = 17
    Height = 16
    Caption = '.ini'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object Label7: TLabel
    Left = 387
    Top = 118
    Width = 54
    Height = 13
    Caption = 'Must exists'
  end
  object Label8: TLabel
    Left = 387
    Top = 172
    Width = 54
    Height = 13
    Caption = 'Must exists'
  end
  object chkOnlyItemsFromConfig: TCheckBox
    Left = 24
    Top = 191
    Width = 429
    Height = 28
    Hint = 
      'Enable this option to only see items that are in PCServer-KFGame' +
      ' and PCServer-KFEngine.\nCache and local maps folder will be ign' +
      'ored.\nThis is useful when you have multiple servers with multip' +
      'le settings\n and you dont want to see maps from another server ' +
      'in the tool.'
    Align = alCustom
    Caption = 'Only display items that are in the current configuration file'
    ParentShowHint = False
    ShowHint = True
    TabOrder = 0
  end
  object inputKFEnginePath: TJvFilenameEdit
    Left = 24
    Top = 152
    Width = 417
    Height = 21
    Filter = 'PCServer-KFEngine Config File (*.ini)|*.ini'
    DialogOptions = [ofHideReadOnly, ofFileMustExist]
    DialogTitle = 'PCServer-KFEngine Config File'
    TabOrder = 1
    Text = ''
    OnChange = checkForEnableOK
  end
  object inputKFGamePath: TJvFilenameEdit
    Left = 24
    Top = 96
    Width = 417
    Height = 21
    Filter = 'PCServer-KFGame Config File (*.ini)|*.ini'
    DialogOptions = [ofHideReadOnly, ofFileMustExist]
    DialogTitle = 'PCServer-KFGame Config File'
    TabOrder = 2
    Text = ''
    OnChange = checkForEnableOK
  end
  object btnCancel: TButton
    Left = 350
    Top = 324
    Width = 75
    Height = 25
    Caption = 'Cancel'
    ModalResult = 2
    TabOrder = 3
  end
  object btnOk: TButton
    Left = 431
    Top = 325
    Width = 75
    Height = 25
    Caption = 'Ok'
    ModalResult = 1
    TabOrder = 4
    OnClick = btnOkClick
  end
  object edtConfigName: TEdit
    Left = 109
    Top = 42
    Width = 137
    Height = 21
    TabOrder = 5
    OnChange = checkForEnableOK
  end
end
