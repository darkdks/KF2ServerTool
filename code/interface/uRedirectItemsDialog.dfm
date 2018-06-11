object frmRedirectItemsDialog: TfrmRedirectItemsDialog
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu]
  BorderStyle = bsSingle
  Caption = 'Redirect Items'
  ClientHeight = 384
  ClientWidth = 315
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poOwnerFormCenter
  OnShow = FormShow
  PixelsPerInch = 96
  TextHeight = 13
  object lvRedirectItems: TListView
    Left = 0
    Top = 0
    Width = 315
    Height = 356
    Align = alClient
    Columns = <
      item
        AutoSize = True
        Caption = 'Nome'
      end>
    MultiSelect = True
    TabOrder = 0
    ViewStyle = vsReport
    OnDblClick = btnOkClick
  end
  object pnlBottom: TPanel
    Left = 0
    Top = 356
    Width = 315
    Height = 28
    Align = alBottom
    TabOrder = 1
    object btnCancel: TButton
      AlignWithMargins = True
      Left = 195
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
      Left = 255
      Top = 3
      Width = 57
      Height = 22
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Align = alRight
      Caption = 'Ok'
      Default = True
      TabOrder = 1
      OnClick = btnOkClick
    end
  end
end
