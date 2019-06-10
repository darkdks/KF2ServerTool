object FormWorkshop: TFormWorkshop
  Left = 0
  Top = 0
  Caption = 'Workshop explorer'
  ClientHeight = 589
  ClientWidth = 880
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  PixelsPerInch = 96
  TextHeight = 12
  object wbWorkshop: TWebBrowser
    Left = 0
    Top = 31
    Width = 880
    Height = 558
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 0
    OnBeforeNavigate2 = wbWorkshopBeforeNavigate2
    OnDocumentComplete = wbWorkshopDocumentComplete
    ExplicitWidth = 938
    ExplicitHeight = 595
    ControlData = {
      4C000000F35A0000AC3900000000000000000000000000000000000000000000
      000000004C000000000000000000000001000000E0D057007335CF11AE690800
      2B2E12620A000000000000004C0000000114020000000000C000000000000046
      8000000000000000000000000000000000000000000000000000000000000000
      00000000000000000100000000000000000000000000000000000000}
  end
  object pnlTop: TPanel
    Left = 0
    Top = 0
    Width = 880
    Height = 31
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Color = clCaptionText
    ParentBackground = False
    TabOrder = 1
    object lblTip: TLabel
      Left = 66
      Top = 14
      Width = 329
      Height = 13
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 
        'Tip: Search the map, enter in the workshop item page and press a' +
        'dd'
      Color = clWhite
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWhite
      Font.Height = -11
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object lblId: TLabel
      AlignWithMargins = True
      Left = 798
      Top = 3
      Width = 15
      Height = 12
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      Caption = 'ID:'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      Visible = False
    end
    object btnForward: TButton
      AlignWithMargins = True
      Left = 28
      Top = 5
      Width = 22
      Height = 21
      Margins.Left = 1
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alLeft
      Caption = '>'
      TabOrder = 0
      OnClick = btnForwardClick
    end
    object btnBack: TButton
      AlignWithMargins = True
      Left = 5
      Top = 5
      Width = 21
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 1
      Margins.Bottom = 4
      Align = alLeft
      Caption = '<'
      TabOrder = 1
      OnClick = btnBackClick
    end
    object btnAdd: TButton
      AlignWithMargins = True
      Left = 819
      Top = 5
      Width = 56
      Height = 21
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 4
      Margins.Bottom = 4
      Align = alRight
      Caption = 'Add'
      Enabled = False
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -10
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 2
      OnClick = btnAddClick
    end
  end
end
