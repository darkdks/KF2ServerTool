object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Translator for KF2ServerTool'
  ClientHeight = 556
  ClientWidth = 849
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 13
  object Panel1: TPanel
    Left = 0
    Top = 0
    Width = 849
    Height = 41
    Align = alTop
    TabOrder = 0
    object Label1: TLabel
      Left = 8
      Top = 14
      Width = 51
      Height = 13
      Caption = 'Language:'
    end
    object cbLanguage: TComboBox
      Left = 65
      Top = 11
      Width = 145
      Height = 21
      Style = csDropDownList
      TabOrder = 0
      OnChange = cbLanguageChange
    end
  end
  object Panel2: TPanel
    Left = 0
    Top = 515
    Width = 849
    Height = 41
    Align = alBottom
    Caption = 'Panel2'
    TabOrder = 1
  end
  object pnlStrings: TScrollBox
    Left = 0
    Top = 41
    Width = 849
    Height = 474
    Align = alClient
    TabOrder = 2
    ExplicitLeft = 216
    ExplicitTop = 240
    ExplicitWidth = 185
    ExplicitHeight = 41
  end
end
