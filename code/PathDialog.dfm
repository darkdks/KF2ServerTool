object kfPathDialog: TkfPathDialog
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Killing Floor Server'
  ClientHeight = 105
  ClientWidth = 282
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 12
  object lbl1: TLabel
    Left = 6
    Top = 18
    Width = 233
    Height = 36
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 
      'To use this tool you need to select the path of your existing se' +
      'rver or install a new one. '#13#10'What do you want to do?'
    WordWrap = True
  end
  object btn1: TButton
    Left = 77
    Top = 78
    Width = 99
    Height = 19
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Configure the path'
    TabOrder = 0
    OnClick = btn1Click
  end
  object btn2: TButton
    Left = 180
    Top = 78
    Width = 93
    Height = 19
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Install a new server'
    TabOrder = 1
    OnClick = btn2Click
  end
  object dlgServerBrowser: TJvBrowseForFolderDialog
    RootDirectory = fdMyComputer
    Left = 56
    Top = 72
  end
end
