object FormAdd: TFormAdd
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'Add map'
  ClientHeight = 362
  ClientWidth = 318
  Color = clWhite
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clBlack
  Font.Height = -10
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poMainFormCenter
  OnCreate = FormCreate
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 12
  object pnlWorkshopID: TPanel
    Left = 0
    Top = 0
    Width = 318
    Height = 65
    Align = alTop
    TabOrder = 0
    object jvlbl1: TLabel
      Left = 17
      Top = 8
      Width = 80
      Height = 14
      Margins.Left = 6
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Workshop ID'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtID: TJvEdit
      Left = 17
      Top = 26
      Width = 128
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ''
      OnChange = edtIDChange
      OnExit = edtIDExit
    end
  end
  object pnlClient: TPanel
    Left = 0
    Top = 209
    Width = 318
    Height = 125
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alClient
    TabOrder = 1
    ExplicitTop = 208
    ExplicitHeight = 134
    object jvlbl2: TLabel
      AlignWithMargins = True
      Left = 17
      Top = 5
      Width = 298
      Height = 14
      Margins.Left = 16
      Margins.Top = 4
      Margins.Right = 2
      Margins.Bottom = 4
      Align = alTop
      Caption = 'Options'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      ExplicitWidth = 48
    end
    object chkDoForAll: TCheckBox
      AlignWithMargins = True
      Left = 31
      Top = 102
      Width = 284
      Height = 12
      Margins.Left = 30
      Margins.Top = 12
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alTop
      Caption = 'Do this for the next x items'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
      TabOrder = 0
      Visible = False
    end
    object chkAddMapEntry: TCheckBox
      AlignWithMargins = True
      Left = 17
      Top = 77
      Width = 298
      Height = 13
      Margins.Left = 16
      Margins.Top = 4
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Add map entry'
      TabOrder = 1
    end
    object chkAddMapCycle: TCheckBox
      AlignWithMargins = True
      Left = 17
      Top = 44
      Width = 298
      Height = 12
      Margins.Left = 16
      Margins.Top = 4
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Add map in map cycle'
      TabOrder = 2
    end
    object chkDownloadItem: TCheckBox
      AlignWithMargins = True
      Left = 17
      Top = 60
      Width = 298
      Height = 13
      Margins.Left = 16
      Margins.Top = 4
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Download the item now'
      TabOrder = 3
      OnClick = chkDownloadItemClick
    end
    object chkAddWorkshopRedirect: TCheckBox
      AlignWithMargins = True
      Left = 17
      Top = 27
      Width = 298
      Height = 13
      Margins.Left = 16
      Margins.Top = 4
      Margins.Right = 2
      Margins.Bottom = 0
      Align = alTop
      Caption = 'Subcribe the server '
      TabOrder = 4
    end
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 334
    Width = 318
    Height = 28
    Align = alBottom
    TabOrder = 2
    ExplicitTop = 343
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 198
      Top = 3
      Width = 56
      Height = 22
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      Caption = 'Cancel'
      TabOrder = 0
      OnClick = btnCancelClick
    end
    object btnOk: TButton
      AlignWithMargins = True
      Left = 258
      Top = 3
      Width = 57
      Height = 22
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      Caption = 'OK'
      Default = True
      TabOrder = 1
      OnClick = btnOkClick
    end
  end
  object pnl3: TPanel
    Left = 0
    Top = 128
    Width = 318
    Height = 81
    Align = alTop
    TabOrder = 3
    object lblPn3: TLabel
      Left = 18
      Top = 8
      Width = 82
      Height = 14
      Margins.Left = 6
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Item(s) name'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object lblItemNameNote: TLabel
      Left = 18
      Top = 54
      Width = 283
      Height = 24
      Caption = 
        'Note: If the map requires an upk(package) file you should add'#13#10' ' +
        'this file as mod file in mod tab'
    end
    object edtItemName: TJvEdit
      Left = 17
      Top = 26
      Width = 248
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      ReadOnly = True
      TabOrder = 0
      Text = ''
      OnExit = edtIDExit
    end
    object btnFindMapRedirectNames: TButton
      Left = 270
      Top = 24
      Width = 35
      Height = 25
      Caption = '...'
      TabOrder = 1
      OnClick = btnFindMapRedirectNamesClick
    end
  end
  object pnlRedirectURL: TPanel
    Left = 0
    Top = 65
    Width = 318
    Height = 63
    Align = alTop
    TabOrder = 4
    ExplicitTop = 68
    object jvlbl4: TLabel
      Left = 18
      Top = 8
      Width = 79
      Height = 14
      Margins.Left = 6
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Redirect URL'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -12
      Font.Name = 'Tahoma'
      Font.Style = [fsBold]
      ParentFont = False
    end
    object edtRedirectURL: TJvEdit
      Left = 17
      Top = 26
      Width = 288
      Height = 24
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -13
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      Text = ''
      OnExit = edtIDExit
    end
  end
end
