object formNewServerFirstConfig: TformNewServerFirstConfig
  Left = 0
  Top = 0
  BorderStyle = bsToolWindow
  Caption = 'New server'
  ClientHeight = 326
  ClientWidth = 542
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lblTipText1: TLabel
    Left = 24
    Top = 40
    Width = 505
    Height = 49
    AutoSize = False
    Caption = 
      'You have created a new server. The configuration files for this ' +
      'new server are copies from the original. made by KF2Server. Plea' +
      'se modify the options below.'
    WordWrap = True
  end
  object lblTipTextTitle: TLabel
    Left = 17
    Top = 13
    Width = 111
    Height = 13
    Caption = 'New server first run'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
  end
  object gbServer: TGroupBox
    AlignWithMargins = True
    Left = 13
    Top = 88
    Width = 516
    Height = 185
    Margins.Left = 8
    Margins.Top = 8
    Margins.Right = 28
    Margins.Bottom = 2
    Caption = 'Server '
    Color = clWhite
    ParentBackground = False
    ParentColor = False
    TabOrder = 0
    object lblServerName: TLabel
      Left = 17
      Top = 28
      Width = 65
      Height = 13
      Margins.Left = 13
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 2
      Caption = 'Server name:'
    end
    object lblServerPort: TLabel
      Left = 17
      Top = 63
      Width = 59
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Server port:'
    end
    object lblWebPort: TLabel
      Left = 204
      Top = 63
      Width = 49
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Web Port:'
    end
    object lblTipText2: TLabel
      Left = 25
      Top = 100
      Width = 346
      Height = 26
      AutoSize = False
      Caption = 
        '* The Server port and Web port needs to be different from other ' +
        'servers if you want to run multiple server at the same time.'
      WordWrap = True
    end
    object edtNCServerName: TJvEdit
      Left = 87
      Top = 26
      Width = 328
      Height = 21
      Hint = 'Name of the server that is displayed to other players.'
      Margins.Top = 10
      Margins.Bottom = 10
      CustomHint = FormMain.blhintHelp
      Constraints.MaxWidth = 700
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      Text = ''
    end
    object edtNCServerPort: TJvEdit
      Left = 81
      Top = 60
      Width = 71
      Height = 21
      Hint = 'The port to run the server. (Default is 7777)'
      CustomHint = FormMain.blhintHelp
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = ''
      OnKeyPress = filterEdit
    end
    object edtNCWebPort: TJvEdit
      Left = 258
      Top = 60
      Width = 89
      Height = 21
      Hint = 'The port to access the web admin, by default the port is 8080'
      CustomHint = FormMain.blhintHelp
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      Text = ''
      OnKeyPress = filterEdit
    end
    object cbClearMapEntries: TCheckBox
      Left = 17
      Top = 149
      Width = 216
      Height = 17
      CustomHint = FormMain.blhintHelp
      Caption = 'Clear map and mod entries'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 285
    Width = 542
    Height = 41
    Align = alBottom
    TabOrder = 1
    ExplicitLeft = 462
    ExplicitTop = 0
    ExplicitWidth = 371
    object btnOk: TButton
      AlignWithMargins = True
      Left = 461
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
      TabOrder = 0
      OnClick = btnOkClick
      ExplicitLeft = 472
    end
  end
end
