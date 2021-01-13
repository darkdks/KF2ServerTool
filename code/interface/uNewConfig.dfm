object formNewConfig: TformNewConfig
  Left = 0
  Top = 0
  BorderStyle = bsSizeToolWin
  Caption = 'New Server config'
  ClientHeight = 319
  ClientWidth = 553
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblNewServerCopy: TLabel
    Left = 17
    Top = 13
    Width = 93
    Height = 13
    Caption = 'New server copy'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object lblTip1: TLabel
    Left = 24
    Top = 32
    Width = 521
    Height = 54
    AutoSize = False
    Caption = 
      'The KF2 server will create new configuration files for this serv' +
      'er in the destination of the Config folder subpath. These files ' +
      'will be copies of the current ones. You must remove maps and cha' +
      'nge settings for this new server. This will not affect the origi' +
      'nal server.'
    WordWrap = True
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 278
    Width = 553
    Height = 41
    Align = alBottom
    TabOrder = 0
    ExplicitLeft = 462
    ExplicitTop = 0
    ExplicitWidth = 371
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 387
      Top = 6
      Width = 75
      Height = 29
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alRight
      Caption = 'Cancel'
      ModalResult = 2
      TabOrder = 0
      ExplicitLeft = 333
      ExplicitTop = 8
      ExplicitHeight = 25
    end
    object btnOk: TButton
      AlignWithMargins = True
      Left = 472
      Top = 6
      Width = 75
      Height = 29
      Margins.Left = 5
      Margins.Top = 5
      Margins.Right = 5
      Margins.Bottom = 5
      Align = alRight
      Caption = 'Ok'
      ModalResult = 1
      TabOrder = 1
      OnClick = btnOkClick
      ExplicitLeft = 414
      ExplicitTop = 8
      ExplicitHeight = 25
    end
  end
  object GroupBox1: TGroupBox
    Left = 8
    Top = 80
    Width = 537
    Height = 192
    Caption = 'Settings'
    TabOrder = 1
    object lblConfigName: TLabel
      Left = 17
      Top = 20
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
    object lblKF2ServerTool: TLabel
      Left = 24
      Top = 42
      Width = 79
      Height = 14
      Caption = 'KFServerTool_'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object lblIni: TLabel
      Left = 246
      Top = 42
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
    object lblConfigFolferSubPath: TLabel
      Left = 17
      Top = 79
      Width = 120
      Height = 13
      Caption = 'Config folder subpath'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblKFGameConfig: TLabel
      Left = 24
      Top = 109
      Width = 88
      Height = 14
      Caption = 'KFGame\Config\'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
    end
    object edtConfigName: TEdit
      Left = 107
      Top = 39
      Width = 137
      Height = 21
      TabOrder = 0
      Text = 'new'
      OnChange = checkForEnableOK
      OnKeyPress = filterEdit
    end
    object edtConfigFolder: TEdit
      Left = 118
      Top = 105
      Width = 140
      Height = 21
      TabOrder = 1
      Text = 'new'
      OnKeyPress = filterEdit
    end
    object chkGenerateNewConfig: TCheckBox
      Left = 24
      Top = 132
      Width = 481
      Height = 28
      Hint = 
        'Enable this option to run the server to generate new configurati' +
        'on files (required if the configuration folder is new). Leave un' +
        'checked if you already have configuration files for the specifie' +
        'd subpath.'
      Align = alCustom
      Caption = 'Generate new setting files '
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
    end
    object chkOnlyItemsFromConfig: TCheckBox
      Left = 24
      Top = 156
      Width = 489
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
      TabOrder = 3
    end
  end
end
