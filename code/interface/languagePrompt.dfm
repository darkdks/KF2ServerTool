object FormSetLanguage: TFormSetLanguage
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMaximize]
  BorderStyle = bsToolWindow
  Caption = 'Select Language'
  ClientHeight = 105
  ClientWidth = 268
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  PixelsPerInch = 96
  TextHeight = 13
  object lblSelectLanguage: TLabel
    Left = 16
    Top = 16
    Width = 60
    Height = 16
    Caption = 'Language:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -13
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object cbbLanguageSet: TComboBox
    Left = 16
    Top = 38
    Width = 169
    Height = 21
    Style = csDropDownList
    TabOrder = 0
  end
  object btnOk: TButton
    Left = 185
    Top = 72
    Width = 75
    Height = 25
    Caption = 'Ok'
    TabOrder = 1
    OnClick = btnOkClick
  end
end
