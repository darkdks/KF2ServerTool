object formPB: TformPB
  Left = 0
  Top = 0
  BorderIcons = []
  BorderStyle = bsNone
  Caption = 'Working'
  ClientHeight = 69
  ClientWidth = 270
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnClose = FormClose
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object lblStatus: TLabel
    Left = 7
    Top = 49
    Width = 40
    Height = 12
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Working'
  end
  object lblTitle: TLabel
    Left = 7
    Top = 2
    Width = 29
    Height = 12
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '<title>'
  end
  object btncancel: TButton
    Left = 207
    Top = 49
    Width = 56
    Height = 19
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Cancel'
    TabOrder = 0
    Visible = False
    OnClick = btncancelClick
  end
  object pb1: TProgressBar
    Left = 8
    Top = 19
    Width = 254
    Height = 25
    TabOrder = 1
  end
  object tmrUndeterminedPB: TTimer
    Enabled = False
    Interval = 300
    OnTimer = tmrUndeterminedPBTimer
    Left = 224
    Top = 65528
  end
end
