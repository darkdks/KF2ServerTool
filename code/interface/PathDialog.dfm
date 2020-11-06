object kfPathDialog: TkfPathDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Killing Floor Server'
  ClientHeight = 114
  ClientWidth = 509
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poScreenCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object lblDescriptionHelp: TLabel
    Left = 7
    Top = 17
    Width = 490
    Height = 28
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 
      'To use this tool you need to select the path of your existing se' +
      'rver or install a new one. '#13#10'What do you want to do?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -12
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    WordWrap = True
  end
  object btnConfigurePath: TButton
    Left = 184
    Top = 76
    Width = 156
    Height = 28
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Configure the path'
    TabOrder = 0
    OnClick = btnConfigurePathClick
  end
  object btnInstallServer: TButton
    Left = 344
    Top = 76
    Width = 153
    Height = 28
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Install a new server'
    TabOrder = 1
    OnClick = btnInstallServerClick
  end
  object dlgServerBrowser: TJvBrowseForFolderDialog
    RootDirectory = fdMyComputer
    Left = 56
    Top = 72
  end
end
