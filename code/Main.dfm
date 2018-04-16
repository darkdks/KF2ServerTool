object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Killing Floor 2 Server Tool 1.2.0 Beta'
  ClientHeight = 561
  ClientWidth = 664
  Color = clGray
  Constraints.MinHeight = 600
  Constraints.MinWidth = 680
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -14
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCanResize = FormCanResize
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 17
  object lbl2: TLabel
    AlignWithMargins = True
    Left = 2
    Top = 2
    Width = 660
    Height = 13
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alTop
    Alignment = taRightJustify
    Caption = 'darkdks @ 2018'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWhite
    Font.Height = -11
    Font.Name = 'Tahoma'
    Font.Style = [fsBold]
    ParentFont = False
    OnClick = lblDonateClick
    ExplicitLeft = 572
    ExplicitWidth = 90
  end
  object JvgBitmapImage1: TJvgBitmapImage
    Left = 26
    Top = 201
    Width = 85
    Height = 85
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
  end
  object lbl3: TLabel
    Left = 19
    Top = 48
    Width = 76
    Height = 17
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = 'Web Admin:'
  end
  object lbl5: TLabel
    Left = 97
    Top = 48
    Width = 63
    Height = 18
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Caption = '<Status>'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -15
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object pnl1: TPanel
    Left = 0
    Top = 528
    Width = 664
    Height = 33
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    Align = alBottom
    BevelOuter = bvNone
    Color = clCream
    ParentBackground = False
    TabOrder = 0
    object btnRemove: TJvSpeedButton
      Left = 121
      Top = 2
      Width = 113
      Height = 25
      Margins.Left = 2
      Margins.Top = 4
      Margins.Right = 2
      Margins.Bottom = 4
      Align = alCustom
      Caption = 'Remove'
      DropDownMenu = pmRemove
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FCFCF8C6C6DFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC9C9
        E3F9F9F3FFFFFFFFFFFFFFFFFFFFFFFF3E3EB50000ABDADAD9FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFD1D1D70E0EEE6060C6FFFFFFFFFFFFFBFBF73D3DB3
        0000B10404B70000B38989C5FFFFFFFFFFFFFFFFFFFFFFFF8B8BD20A0AE43B3B
        EF2828FF5F5FC6F9F9F3D6D6E90000AE0000AF0707B80707BB0000B9DCDCD5FF
        FFFFFFFFFFD3D3D90000DA2D2DE23535EB3939F00F0FE7D6D6E4FFFFFFFFFFF3
        0000B30000B40909BB0B0BBC0000BBAAAAD0A1A1D70000CB2525D82828DC2A2A
        E40A0ADDEAEADFFFFFFFFFFFFFFFFFFFB8B8DC0000B40000B60B0BBC0A0AC216
        16C01515C81818CF2222D42424D80202D5ABABD6FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFF20000B40000B60D0DBE0D0DC11111C61717C81414CF0000C8EEEE
        E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0D0E92B2BC00404BA0D
        0DBF1111C31111C62020C7BEBEE1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF9999D00303B10202B80A0ABA0E0EBF0E0EC11313BFA4A4CDFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0D0DC0D0DBB2C2CC31616BC05
        05B90000B70303BB0303C00000B8D7D7D4FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        8E8ECC1515BC3838C33434C33232C43C3CC35151CC2626C32424C32323C40000
        BD9191C6FFFFFFFFFFFFFFFFFFCECEDC1C1CBD3A3AC33737C23636C30F0FBABA
        BADBCBCBE52323C22727C23030C72D2DC60808BED8D8D7FFFFFFCECEE52323C1
        3F3FC34040C53838C41717BBEAEAE7FFFFFFFFFFFFF5F5ED2323C12828C13131
        C43131C30303BACECEE0FEFEFB8E8ED22B2BC63D3DC21D1DBCAEAED7FFFFFFFF
        FFFFFFFFFFFFFFFFB7B7DD2525C12929C00D0DC57575C0FFFFFDFFFFFFFFFFFF
        8F8FD22525BFE6E6E7FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF5F5ED2020
        BE7676C0FFFFFFFFFFFFFFFFFFFFFFFFFDFDFBDBDBE9FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFDCDCE9FFFFFCFFFFFFFFFFFF}
      Layout = blGlyphLeft
      ParentShowHint = True
    end
    object btnAddNew: TJvSpeedButton
      Left = 6
      Top = 2
      Width = 111
      Height = 25
      Margins.Left = 4
      Margins.Top = 4
      Margins.Right = 2
      Margins.Bottom = 4
      Align = alCustom
      Caption = 'Add'
      DropDownMenu = pmAdd
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFDEDEDE
        CFCFCFC9C9C9C4C4C4C3C3C3D0C4CBCCC6CACDC6CACDC3CAC2C2C2C4C4C4C8C8
        C8CECECEDADADAFEFEFEFFFFFFF8F8F8F2F2F2EDEDEDECECECF7EBF24DB2731B
        AC5219AB506ABB89F3EAEFEBEBEBEDEDEDF1F1F1F7F7F7FFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF1EAE5930B3662DB26434B76AFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1FB3622C
        B86B2AB76936BB72FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF1CB8672ABC7027BB6E33BF77FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1BBD6C27
        C07525BF7334C37CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF87DFB6
        81DEB282DEB282DEB38DE1B91FC37625C57924C47929C67C8DE1B982DEB282DE
        B280DDB193E2BDFFFFFF95E5C108C36E18C67718C67718C67718C67723CA7E23
        CA7E23CA7E22C97D17C67718C67718C67718C67703C16BBEEED989E4BC12C979
        20CC8120CC8120CC8120CC8121CC8221CC8221CC8221CC8220CC8120CC8120CC
        8120CC810DC876B6EED6B3EFD61ED2841CD0831DD1841DD1841FD1851FCF8620
        CF851FCF8520D0851FD1841DD1841DD1841BD0831DD383D2F5E7FFFFFFD7F7EA
        DAF8EBDBF8EBDBF8EBEEFCF614D0831DD2881BD28728D58EEEFCF6DBF8EBDBF8
        EBDAF8EBDEF8EEFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0DD2841B
        D58B18D48A26D790FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF0BD4871AD78E17D68C24D893FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF09D78819
        D99016D88E23DA95FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFF05D7880FD88D0CD88C1FDC95FFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFAEF4D750
        E4AB51E5ABC4F6E2FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      Layout = blGlyphLeft
      ParentShowHint = True
    end
    object lblDonate: TLabel
      AlignWithMargins = True
      Left = 610
      Top = 2
      Width = 46
      Height = 29
      Cursor = crHandPoint
      Margins.Left = 10
      Margins.Top = 2
      Margins.Right = 8
      Margins.Bottom = 2
      Align = alRight
      Alignment = taRightJustify
      Caption = 'Donate'
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      OnClick = lblDonateClick
      ExplicitHeight = 13
    end
    object lbl9: TLabel
      AlignWithMargins = True
      Left = 539
      Top = 2
      Width = 53
      Height = 21
      Cursor = crHandPoint
      Margins.Left = 10
      Margins.Top = 2
      Margins.Right = 8
      Margins.Bottom = 10
      Align = alRight
      Alignment = taRightJustify
      Caption = 'Updates'
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      OnClick = lbl9Click
      ExplicitHeight = 13
    end
    object btnReinstall: TBitBtn
      Left = 238
      Top = 2
      Width = 129
      Height = 25
      Margins.Left = 2
      Margins.Top = 4
      Margins.Right = 2
      Margins.Bottom = 4
      Align = alCustom
      Caption = 'Reinstall item'
      DoubleBuffered = True
      Glyph.Data = {
        36040000424D3604000000000000360000002800000010000000100000000100
        2000000000000004000000000000000000000000000000000000000000000000
        0000000000000000000000000000000000000000003300000033000000330000
        00000000000000000000000000000000000000000000FFFFFF00000000000000
        000000000024000000230000000000000000757371FF73716FFF757371FF0000
        0000000000000000002F000000230000000000000000FFFFFF00000000000000
        00236D6B69C16C6A69BF0000002F00000033716F6DFFEEECEBFF716F6DFF0000
        003300000033747270F16C6A69C00000002400000000FFFFFF00000000006F6D
        6BBFA19F9DFF9E9C9AFF706E6CEF716F6DFF898785FFE1DFDEFF898785FF716F
        6DFF72706EFE9F9D9BFFA19F9DFF716F6DBD00000000FFFFFF00000000007A78
        76ED9F9D9BFFDFDDDBFFB8B6B4FFDBD9D7FFD8D6D4FFD6D4D2FFD8D6D4FFDBD9
        D7FFB8B6B4FFDFDDDBFF9F9D9BFF7A7876AF00000000FFFFFF00000000000000
        0000767572FEB7B3B3FFD2D0CFFFD1CFCFFFD3D1D0FFD3D1D0FFD3D1D0FFD1CF
        CFFFD2D0CFFFB7B3B3FF757371EF0000000000000000FFFFFF00000000330000
        0033787674FFD2D0CEFFCECCCAFFBEBCBAFF92908EFF8D8B89FF92908EFFBEBC
        BAFFCECCCAFFD2D0CEFF787674FF0000003300000033FFFFFF00817F7DFF7C7A
        78FF9D9B99FFCCC9C8FFCCC9C8FF93918FFF7A78769C7E7C7A227A78769C9391
        8FFFCCC9C8FFCCC9C8FF9D9B99FF7C7A78FF817F7DFFFFFFFF00817F7DFFE3E1
        DFFFDCDAD8FFC6C5C2FFC8C6C4FF8F8D8BFF4847463D000000074847463D8F8D
        8BFFC8C6C4FFC6C5C2FFDCDAD8FFE3E1DFFF817F7DFFFFFFFF00848280FF807E
        7CFF949492FFD0CECCFFC3C0BFFF93918FFF72716FAD3A39384E72716FAD9392
        90FFC3C0BFFFD0CECCFF949492FF807E7CFF848280FFFFFFFF00000000000000
        0000807E7CFFDAD9D8FFBEBBB9FFBCB9B7FF94918EFF928F8DFF94918FFFB3B2
        B0FFBEBBB9FFDBD9D8FF807E7CFF0000000000000000FFFFFF00000000000000
        0023827F7DEFACAAA8FFC7C5C3FFBBB8B7FFBAB7B6FFBBB8B7FFBBB8B7FFBBB8
        B7FFC7C5C3FFACAAA8FF817F7DEF0000002300000000FFFFFF00000000008280
        7EBAA4A2A0FFDAD8D7FFC6C4C2FFE4E3E1FFDBD9D7FFC2BFBEFFD7D5D4FFE4E3
        E1FFC5C4C2FFDAD8D7FFA4A2A0FF82807EBA00000000FFFFFF00000000008B89
        87B2B2B1AFFFAFAEACFF858381EB868482FF9A9897FFBCBAB7FF9A9897FF8684
        82FF858381FEAFAEACFFB2B1AFFF8B8987B200000000FFFFFF00000000000000
        00008D8B89B28D8B89AF00000000000000008B8987FFE9E7E7FF8B8987FF0000
        0000000000008C8A88ED8D8B89B00000000000000000FFFFFF00000000000000
        000000000000000000000000000000000000908E8CFF8F8D8BFF908E8CFF0000
        00000000000000000000000000000000000000000000FFFFFF00}
      ParentDoubleBuffered = False
      TabOrder = 0
      OnClick = btnReinstallClick
    end
    object btnUpdate: TBitBtn
      Left = 371
      Top = 2
      Width = 130
      Height = 25
      Margins.Left = 2
      Margins.Top = 4
      Margins.Right = 2
      Margins.Bottom = 4
      Align = alCustom
      Caption = 'Update item'
      DoubleBuffered = True
      Glyph.Data = {
        36030000424D3603000000000000360000002800000010000000100000000100
        18000000000000030000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFF9F9F9FCF1F5F9E9F0BCDCCFA9D9C5B8DCCEF3E7ECFBEEF3F6F5
        F6FCFCFCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEBE7E8FFEFF688D4B702BA7112
        BD7B18BE7C11BE7901BC735EC9A0FFF1F5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFC0AFB648C5960FBC793CC68C49CE9647D19970D7AE54B08823BB7A04BB
        72CCC6C8DED8DAFFFFFFFFFFFFFFFFFFFFFFFF44AF8616C17E4DCB956DDCB165
        A589BAA2A8CDB2BBEADADFE2C4CFB7ADAC81B29DDCD2D7FFFFFFFFFFFFFFFFFF
        E9F5F105BB7348C89083D5B6708071D0A995E3D6C0EEE6D1ECEAE3F4F9FDF3F6
        F7D0BFBCB1825CFFFFFFFFFFFFFFFFFF90DEC019C07D76CAA6699A80ECDCE3EF
        F4FAECF0F5E6E8E8E5DACACAB18CF8FFFFB38754823700FFFFFFFFFFFFFFFFFF
        5DD0A42DC18484D2B5858078D1BDB3D1BFA8DED1B7E7E7E4E5EAEFF6FAFEFBFF
        FF9D5400833100FDFFFFCEEEE2D5F0E64CC89736C58A8BD3B6ACA19FDFEDEBDB
        EAE9F2F3F8EFE7D7DCCFB6EEECE5E3DBCFA75C00883500F7FAFFE3F4ED00B267
        1BC08039C88E89CCB1AEE9D4BAF5E29E8B83F1EAD9F2F0EDF4F7FAFCFFFFD7BA
        88A157007B2E00FFFFFFFFFFFFC0E8D904B97036C78D75D5ADA1D6C492ACA2E3
        CCC1F2F7FAEAEAECF6EDDAFFFFFFC08E43964A00A06F48FFFFFFFFFFFFFFFFFF
        81D5B420C1845DD0A082E8C19C807CF7FBFDF0E8DDFAF7EEF5F0E3FFFFFFA25E
        09792600F0EDEEFFFFFFFFFFFFFFFFFFFFFFFF56CA9E3CCB9453C193E4CCD6E4
        DECCF2EDDCF7F4F0F8FCFFFFFFFF6D0E00CBB7ABFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFF38CD9353614DD2B4B0FAFFFFF3F6F9EFEBE2E8E5DBE3DDD3D0BC
        B6FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1FDF8D9CFD1EAE2E3D4
        CBC6E7E6E2F2F3F4F3F4F5DBD6D1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEFFFFE6E5E1E1E1DFDAD4D3FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFCFCFBEBEAE8FFFFFFFFFFFFFFFFFFFFFFFF}
      ParentDoubleBuffered = False
      TabOrder = 1
      OnClick = btnUpdateClick
    end
  end
  object jvpgcntrl1: TJvPageControl
    Left = 0
    Top = 17
    Width = 664
    Height = 511
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ActivePage = tswebadmin
    Align = alClient
    TabOrder = 1
    OnChange = jvpgcntrl1Change
    ParentColor = False
    Color = clWhite
    object tsServer: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Server'
      ImageIndex = 2
      object grpStartServer: TGroupBox
        AlignWithMargins = True
        Left = 8
        Top = 8
        Width = 620
        Height = 469
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 28
        Margins.Bottom = 2
        Align = alClient
        Caption = 'Start server'
        Color = clWhite
        ParentColor = False
        TabOrder = 0
        object pnl3: TPanel
          Left = 2
          Top = 19
          Width = 616
          Height = 73
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 0
          object lblProfile: TLabel
            AlignWithMargins = True
            Left = 6
            Top = 2
            Width = 41
            Height = 69
            Margins.Left = 6
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alLeft
            Caption = 'Profile:'
            Color = clBlack
            ParentColor = False
            ExplicitHeight = 17
          end
          object btnNewProfile: TButton
            Left = 49
            Top = 31
            Width = 61
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'New'
            TabOrder = 0
            OnClick = btnNewProfileClick
          end
          object btnRenameProfile: TButton
            Left = 114
            Top = 31
            Width = 74
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Rename'
            TabOrder = 1
            OnClick = btnRenameProfileClick
          end
          object btnDeleteProfile: TButton
            Left = 192
            Top = 31
            Width = 69
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Delete'
            TabOrder = 2
            OnClick = btnDeleteProfileClick
          end
          object cbbProfile: TComboBox
            AlignWithMargins = True
            Left = 51
            Top = 2
            Width = 403
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 162
            Margins.Bottom = 2
            Align = alClient
            Style = csDropDownList
            Color = clWhite
            Constraints.MaxWidth = 486
            DropDownCount = 20
            TabOrder = 3
            OnChange = cbbProfileChange
          end
        end
        object pnl4: TPanel
          Left = 2
          Top = 266
          Width = 616
          Height = 201
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object lblHelpAdditionParam: TLabel
            Left = 12
            Top = 3
            Width = 493
            Height = 14
            Caption = 
              'Example: ?Mutator=KFMutator.KFMutator_MaxPlayersV2?MaxPlayers=15' +
              '?MaxMonsters=64'
            Color = clBtnFace
            Font.Charset = DEFAULT_CHARSET
            Font.Color = clWindowFrame
            Font.Height = -12
            Font.Name = 'Tahoma'
            Font.Style = []
            ParentColor = False
            ParentFont = False
            ParentShowHint = False
            ShowHint = False
          end
          object btnStartServer: TButton
            Left = 0
            Top = 157
            Width = 616
            Height = 44
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alBottom
            Caption = 'Start server'
            TabOrder = 0
            OnClick = btnStartServerClick
          end
          object chkAutoConnectWeb: TCheckBox
            Left = 12
            Top = 32
            Width = 196
            Height = 17
            Caption = 'Auto connect to web admin'
            TabOrder = 1
            OnClick = chkAutoConnectWebClick
          end
        end
        object pnl5: TPanel
          Left = 2
          Top = 92
          Width = 616
          Height = 51
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 2
          object pnlmap: TPanel
            Left = 0
            Top = 0
            Width = 258
            Height = 51
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alClient
            BevelOuter = bvNone
            TabOrder = 0
            object lblMap: TLabel
              AlignWithMargins = True
              Left = 6
              Top = 2
              Width = 250
              Height = 17
              Margins.Left = 6
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              Caption = 'Map'
              Color = clBlack
              ParentColor = False
              ExplicitWidth = 25
            end
            object cbbMap: TComboBox
              AlignWithMargins = True
              Left = 6
              Top = 24
              Width = 250
              Height = 25
              Margins.Left = 6
              Margins.Top = 0
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alBottom
              Style = csDropDownList
              Color = clWhite
              Constraints.MaxWidth = 486
              DropDownCount = 20
              TabOrder = 0
              OnChange = cbbMapChange
              OnExit = lostFocusSave
            end
          end
          object pnldifficulty: TPanel
            Left = 441
            Top = 0
            Width = 175
            Height = 51
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 1
            object lblDifficulty: TLabel
              AlignWithMargins = True
              Left = 6
              Top = 2
              Width = 167
              Height = 17
              Margins.Left = 6
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              Caption = 'Difficulty'
              Color = clBlack
              ParentColor = False
              ExplicitWidth = 52
            end
            object cbbDifficulty: TComboBox
              AlignWithMargins = True
              Left = 6
              Top = 24
              Width = 161
              Height = 25
              Margins.Left = 6
              Margins.Top = 0
              Margins.Right = 8
              Margins.Bottom = 2
              Align = alBottom
              Style = csDropDownList
              Color = clWhite
              TabOrder = 0
              OnChange = cbbDifficultyChange
              OnExit = lostFocusSave
              Items.Strings = (
                'Normal'
                'Hard'
                'Suicidal'
                'Hell on earth')
            end
          end
          object pnlgamelenght: TPanel
            Left = 258
            Top = 0
            Width = 183
            Height = 51
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alRight
            BevelOuter = bvNone
            TabOrder = 2
            object lblGameLength: TLabel
              AlignWithMargins = True
              Left = 6
              Top = 2
              Width = 175
              Height = 17
              Margins.Left = 6
              Margins.Top = 2
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alTop
              Caption = 'Game Length'
              Color = clBlack
              ParentColor = False
              ExplicitWidth = 82
            end
            object cbbLength: TComboBox
              AlignWithMargins = True
              Left = 6
              Top = 24
              Width = 175
              Height = 25
              Margins.Left = 6
              Margins.Top = 0
              Margins.Right = 2
              Margins.Bottom = 2
              Align = alBottom
              Style = csDropDownList
              Color = clWhite
              TabOrder = 0
              OnChange = cbbLengthChange
              OnExit = lostFocusSave
              Items.Strings = (
                'Short'
                'Medium'
                'Long')
            end
          end
        end
        object pnl6: TPanel
          Left = 2
          Top = 214
          Width = 616
          Height = 52
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 3
          object lblAddParam: TLabel
            AlignWithMargins = True
            Left = 6
            Top = 2
            Width = 608
            Height = 17
            Margins.Left = 6
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alTop
            Caption = 'Additional parameters'
            Color = clBlack
            ParentColor = False
            ExplicitWidth = 131
          end
          object edtExtra: TEdit
            AlignWithMargins = True
            Left = 6
            Top = 25
            Width = 608
            Height = 25
            Margins.Left = 6
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alBottom
            ParentShowHint = False
            ShowHint = False
            TabOrder = 0
            OnChange = edtExtraChange
            OnEnter = edtExtraEnter
            OnExit = lostFocusSave
          end
        end
        object pnl10: TPanel
          Left = 2
          Top = 143
          Width = 616
          Height = 71
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 4
          object lblGamePass: TLabel
            Left = 176
            Top = 11
            Width = 97
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Game password'
            Color = clBlack
            ParentColor = False
          end
          object lblGameMode: TLabel
            Left = 6
            Top = 11
            Width = 74
            Height = 17
            Margins.Left = 6
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Align = alCustom
            Caption = 'Game mode'
            Color = clBlack
            ParentColor = False
          end
          object edtGmPass: TEdit
            Left = 176
            Top = 33
            Width = 180
            Height = 25
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Color = clWhite
            TabOrder = 0
            OnChange = edtGmPassChange
            OnExit = lostFocusSave
          end
          object cbbGameMode: TComboBox
            Left = 5
            Top = 33
            Width = 161
            Height = 25
            Margins.Left = 6
            Margins.Top = 0
            Margins.Right = 8
            Margins.Bottom = 2
            Align = alCustom
            Style = csDropDownList
            Color = clWhite
            TabOrder = 1
            OnChange = cbbGameModeChange
            OnExit = lostFocusSave
            Items.Strings = (
              'Endless'
              'Survival'
              'VersusSurvival'
              'Weekly')
          end
        end
      end
    end
    object tsMaps: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Maps'
      object lvMaps: TListView
        Left = 0
        Top = 28
        Width = 656
        Height = 451
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        Columns = <
          item
            AutoSize = True
            Caption = 'Map File'
          end
          item
            Alignment = taCenter
            Caption = 'Workshop ID'
            Width = 89
          end
          item
            Alignment = taCenter
            Caption = 'Subscrited'
            Width = 85
          end
          item
            Alignment = taCenter
            Caption = 'Map Entry'
            Width = 73
          end
          item
            Alignment = taCenter
            Caption = 'Cycle Entry'
            Width = 73
          end
          item
            Alignment = taCenter
            Caption = 'Map Cache'
            Width = 85
          end>
        GridLines = True
        Groups = <
          item
            Header = 'Workshop'
            GroupID = 0
            State = [lgsNormal, lgsCollapsible]
            HeaderAlign = taLeftJustify
            FooterAlign = taLeftJustify
            TitleImage = -1
            ExtendedImage = -1
          end
          item
            Header = 'Official'
            GroupID = 1
            State = [lgsNormal, lgsCollapsible]
            HeaderAlign = taLeftJustify
            FooterAlign = taLeftJustify
            TitleImage = -1
            ExtendedImage = -1
          end
          item
            Header = 'Redirect or local'
            GroupID = 2
            State = [lgsNormal, lgsCollapsible]
            HeaderAlign = taLeftJustify
            FooterAlign = taLeftJustify
            TitleImage = -1
            ExtendedImage = -1
          end>
        IconOptions.Arrangement = iaLeft
        LargeImages = il1
        MultiSelect = True
        GroupView = True
        ReadOnly = True
        RowSelect = True
        PopupMenu = pmLV
        SmallImages = il1
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = lvClick
        OnColumnClick = lvMapsColumnClick
        OnCompare = lvCompare
        OnCustomDrawItem = lvMapsCustomDrawItem
      end
      object pnl2: TPanel
        Left = 0
        Top = 0
        Width = 656
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 1
        object lblSearch: TLabel
          AlignWithMargins = True
          Left = 2
          Top = 6
          Width = 28
          Height = 20
          Margins.Left = 2
          Margins.Top = 6
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alLeft
          Alignment = taRightJustify
          Caption = 'Filter'
          ExplicitHeight = 17
        end
        object edtSearch: TEdit
          AlignWithMargins = True
          Left = 34
          Top = 2
          Width = 193
          Height = 24
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alLeft
          TabOrder = 0
          OnChange = edtSearchChange
          ExplicitHeight = 25
        end
      end
    end
    object tsMods: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Mods'
      ImageIndex = 1
      object lvMods: TListView
        Left = 0
        Top = 0
        Width = 656
        Height = 479
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        Columns = <
          item
            AutoSize = True
            Caption = 'Mod File'
          end
          item
            Caption = 'Workshop ID'
            Width = 97
          end
          item
            Caption = 'Subscrited'
            Width = 73
          end
          item
            Caption = 'In Cache'
            Width = 73
          end>
        GridLines = True
        MultiSelect = True
        ReadOnly = True
        RowSelect = True
        PopupMenu = pmLV
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = lvClick
      end
    end
    object tsUnknowed: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Unknown'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clBlack
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      object lvUnknowed: TListView
        Left = 0
        Top = 0
        Width = 656
        Height = 479
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
        Checkboxes = True
        Columns = <
          item
            AutoSize = True
            Caption = 'Item File'
          end
          item
            Alignment = taCenter
            Caption = 'Workshop ID'
            Width = 89
          end
          item
            Alignment = taCenter
            Caption = 'Subscription'
            Width = 85
          end
          item
            Alignment = taCenter
            Caption = 'Map Entry'
            Width = 73
          end
          item
            Alignment = taCenter
            Caption = 'Cycle Entry'
            Width = 73
          end
          item
            Alignment = taCenter
            Caption = 'In Cache'
            Width = 85
          end>
        GridLines = True
        IconOptions.Arrangement = iaLeft
        LargeImages = il1
        ReadOnly = True
        RowSelect = True
        PopupMenu = pmLV
        SmallImages = il1
        TabOrder = 0
        ViewStyle = vsReport
        OnClick = lvClick
        OnColumnClick = lvMapsColumnClick
        OnCompare = lvCompare
      end
    end
    object tsExtra: TTabSheet
      Margins.Left = 2
      Margins.Top = 2
      Margins.Right = 2
      Margins.Bottom = 2
      Caption = 'Options'
      ImageIndex = 3
      object grpEnableDisable: TGroupBox
        AlignWithMargins = True
        Left = 8
        Top = 8
        Width = 620
        Height = 178
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 28
        Margins.Bottom = 2
        Align = alTop
        Caption = 'Enable / Disable'
        Color = clWhite
        ParentColor = False
        TabOrder = 0
        object pnl7: TPanel
          Left = 2
          Top = 19
          Width = 343
          Height = 157
          Align = alLeft
          BevelOuter = bvNone
          TabOrder = 0
          object lblDescWebPort: TLabel
            Left = 24
            Top = 70
            Width = 64
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Web Port:'
          end
          object lblDescWebAdmin: TLabel
            Left = 24
            Top = 40
            Width = 76
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Web Admin:'
          end
          object lblWkspDownMan: TLabel
            Left = 24
            Top = 10
            Width = 190
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Workshop Download Manager:'
          end
          object lblWebPass: TLabel
            Left = 24
            Top = 100
            Width = 106
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Web admin pass:'
          end
          object edtPort: TJvEdit
            Left = 93
            Top = 67
            Width = 89
            Height = 25
            TabOrder = 0
            OnExit = edtPortExit
          end
          object cbStatusWeb: TJvComboBox
            Left = 105
            Top = 36
            Width = 101
            Height = 25
            Style = csDropDownList
            TabOrder = 1
            OnChange = cbStatusWebChange
            Items.Strings = (
              'Disabled'
              'Enabled')
          end
          object cbWorkshopDMStatus: TJvComboBox
            Left = 219
            Top = 7
            Width = 89
            Height = 25
            Style = csDropDownList
            TabOrder = 2
            OnChange = cbWorkshopDMStatusChange
            Items.Strings = (
              'Disabled'
              'Enabled')
          end
          object edtWebPass: TJvEdit
            Left = 135
            Top = 98
            Width = 138
            Height = 25
            TabOrder = 3
            OnExit = edtWebPassExit
          end
          object chkAutoLoginAdmin: TCheckBox
            Left = 24
            Top = 129
            Width = 429
            Height = 28
            Align = alCustom
            Caption = 'Auto web admin  login using Admin pass'
            TabOrder = 4
            OnClick = chkAutoLoginAdminClick
          end
        end
        object Panel1: TPanel
          Left = 345
          Top = 19
          Width = 273
          Height = 157
          Align = alClient
          BevelOuter = bvNone
          TabOrder = 1
          object lblRedirectURL: TLabel
            Left = 5
            Top = 39
            Width = 79
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Redirect URL'
          end
          object lblCustomRedirect: TLabel
            Left = 5
            Top = 10
            Width = 103
            Height = 17
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Custom redirect:'
          end
          object edtRedirectURL: TJvEdit
            Left = 5
            Top = 61
            Width = 260
            Height = 25
            Margins.Left = 5
            Margins.Right = 10
            Margins.Bottom = 20
            Align = alCustom
            Constraints.MaxWidth = 700
            TabOrder = 0
            OnExit = edtRedirectURLExit
          end
          object cbbRedirectEnabled: TJvComboBox
            Left = 113
            Top = 7
            Width = 88
            Height = 25
            Style = csDropDownList
            TabOrder = 1
            OnCloseUp = cbbRedirectEnabledCloseUp
            Items.Strings = (
              'Disabled'
              'Enabled')
          end
        end
      end
      object grpapplication: TGroupBox
        AlignWithMargins = True
        Left = 8
        Top = 335
        Width = 620
        Height = 134
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 28
        Margins.Bottom = 2
        Align = alTop
        Caption = 'Application'
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 1
        object lblFontSize: TLabel
          Left = 26
          Top = 26
          Width = 60
          Height = 17
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Font Size:'
        end
        object lblFontColor: TLabel
          Left = 318
          Top = 26
          Width = 69
          Height = 17
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Font Color:'
        end
        object lblLanguage: TLabel
          Left = 26
          Top = 56
          Width = 65
          Height = 17
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Language:'
        end
        object trckbrFontSize: TTrackBar
          Left = 85
          Top = 20
          Width = 175
          Height = 24
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Max = 12
          Min = 7
          Position = 7
          SelEnd = 7
          SelStart = 14
          TabOrder = 0
          OnChange = trckbrFontSizeChange
        end
        object btnfontcolor: TJvColorButton
          Left = 389
          Top = 26
          Width = 59
          Height = 17
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          OtherCaption = '&Other...'
          Options = []
          Color = clWhite
          OnChange = btnfontcolorChange
          TabOrder = 1
        end
        object cbbLanguage: TJvComboBox
          Left = 96
          Top = 53
          Width = 125
          Height = 25
          Style = csDropDownList
          TabOrder = 2
          OnChange = cbbLanguageChange
          Items.Strings = (
            'English'
            'Portuguese')
        end
        object chkOnlyFromConfigItems: TCheckBox
          Left = 26
          Top = 89
          Width = 429
          Height = 28
          Align = alCustom
          Caption = 'Only display items from the current configuration file'
          TabOrder = 3
          OnClick = chkOnlyFromConfigItemsClick
        end
      end
      object grpmaintenance: TGroupBox
        AlignWithMargins = True
        Left = 8
        Top = 196
        Width = 620
        Height = 129
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 28
        Margins.Bottom = 2
        Align = alTop
        Caption = 'Maintenance'
        Color = clWhite
        ParentBackground = False
        ParentColor = False
        TabOrder = 2
        object lbl6: TLabel
          Left = 17
          Top = 24
          Width = 88
          Height = 17
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Server Update'
        end
        object lbl7: TLabel
          Left = 246
          Top = 25
          Width = 64
          Height = 17
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Workshop'
        end
        object btnCheckForUpdate: TButton
          Left = 19
          Top = 46
          Width = 190
          Height = 25
          Caption = 'Current version'
          TabOrder = 0
          OnClick = btnCheckForUpdateClick
        end
        object btnCleanDownloadCache: TButton
          Left = 246
          Top = 47
          Width = 179
          Height = 25
          Caption = 'Clean download cache'
          TabOrder = 1
          OnClick = btnCleanDownloadCacheClick
        end
        object btnCheckForPreview: TButton
          Left = 19
          Top = 77
          Width = 190
          Height = 25
          Caption = 'Beta/Preview'
          TabOrder = 2
          OnClick = btnCheckForPreviewClick
        end
        object btnCleanWorkshopData: TButton
          Left = 246
          Top = 78
          Width = 179
          Height = 25
          Caption = 'Clean workshop data '
          TabOrder = 3
          OnClick = btnCleanWorkshopDataClick
        end
      end
    end
    object tswebadmin: TTabSheet
      Caption = 'WebAdmin'
      ImageIndex = 6
      object wb1: TWebBrowser
        Left = 0
        Top = 0
        Width = 656
        Height = 479
        Align = alClient
        TabOrder = 0
        OnDocumentComplete = wb1DocumentComplete
        ExplicitWidth = 661
        ExplicitHeight = 439
        ControlData = {
          4C000000CD430000823100000000000000000000000000000000000000000000
          000000004C000000000000000000000001000000E0D057007335CF11AE690800
          2B2E126208000000000000004C0000000114020000000000C000000000000046
          8000000000000000000000000000000000000000000000000000000000000000
          00000000000000000100000000000000000000000000000000000000}
      end
    end
    object tsNotes: TTabSheet
      Caption = 'Notes'
      ImageIndex = 5
      object lbl1: TLabel
        AlignWithMargins = True
        Left = 8
        Top = 8
        Width = 646
        Height = 17
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 2
        Margins.Bottom = 0
        Align = alTop
        Caption = 'Notepad'
        ExplicitWidth = 52
      end
      object lblAllChangesWillbe: TLabel
        AlignWithMargins = True
        Left = 3
        Top = 462
        Width = 644
        Height = 14
        Margins.Right = 9
        Align = alBottom
        Alignment = taRightJustify
        Caption = 'All changes will be saved automatically'
        Enabled = False
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clBlack
        Font.Height = -12
        Font.Name = 'Tahoma'
        Font.Style = [fsBold]
        ParentFont = False
        ExplicitLeft = 410
        ExplicitWidth = 237
      end
      object mmoNotepad: TMemo
        AlignWithMargins = True
        Left = 8
        Top = 33
        Width = 640
        Height = 426
        Margins.Left = 8
        Margins.Top = 8
        Margins.Right = 8
        Margins.Bottom = 0
        Align = alClient
        MaxLength = -1
        ParentColor = True
        TabOrder = 0
      end
    end
    object tsDebug: TTabSheet
      Caption = 'Debug'
      ImageIndex = 7
      object lbl4: TLabel
        Left = 22
        Top = 27
        Width = 14
        Height = 17
        Caption = 'ID'
      end
      object lbl8: TLabel
        Left = 15
        Top = 167
        Width = 66
        Height = 17
        Caption = 'Item name'
      end
      object btn1: TButton
        Left = 22
        Top = 81
        Width = 225
        Height = 25
        Caption = 'AddWorkshopSubcribe'
        TabOrder = 0
        OnClick = btn1Click
      end
      object btn2: TButton
        Left = 22
        Top = 112
        Width = 225
        Height = 25
        Caption = 'DownloadWorkshopItem'
        TabOrder = 1
        OnClick = btn2Click
      end
      object edtDebugID: TEdit
        Left = 22
        Top = 50
        Width = 121
        Height = 25
        TabOrder = 2
        Text = '123456789'
      end
      object edtDebugItemName: TEdit
        Left = 15
        Top = 190
        Width = 215
        Height = 25
        TabOrder = 3
        Text = 'KF-DebugItem'
      end
      object btn3: TButton
        Left = 15
        Top = 221
        Width = 225
        Height = 25
        Caption = 'AddMapCycle'
        TabOrder = 4
        OnClick = btn3Click
      end
      object btn4: TButton
        Left = 15
        Top = 252
        Width = 225
        Height = 25
        Caption = 'AddMapEntry'
        TabOrder = 5
        OnClick = btn4Click
      end
      object btn5: TButton
        Left = 15
        Top = 283
        Width = 225
        Height = 25
        Caption = 'Get Redirect Items'
        TabOrder = 6
        OnClick = btn5Click
      end
    end
  end
  object pmRemove: TPopupMenu
    OnPopup = pmRemovePopup
    Left = 432
    Top = 8
    object Removeall1: TMenuItem
      Caption = 'Remove full item'
      OnClick = Removeall1Click
    end
    object RemoveGameSteamCache1: TMenuItem
      Caption = 'Cache'
      OnClick = RemoveGameSteamCache1Click
    end
    object RemoveMapEntry1: TMenuItem
      Caption = 'Map Entry'
      OnClick = RemoveMapEntry1Click
    end
    object RemovefromCycle1: TMenuItem
      Caption = 'Map cycle'
      OnClick = RemovefromCycle1Click
    end
    object RemoveServerSubcribe1: TMenuItem
      Caption = 'Workshop Subcription'
      OnClick = RemoveServerSubcribe1Click
    end
  end
  object il1: TImageList
    Left = 544
    Top = 8
    Bitmap = {
      494C0101060020007C0110001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
      0000000000003600000028000000400000002000000001002000000000000020
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D1A89900B94C0000BA4D000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000C6683200FDC93E00DF7B0000DE790000CD600000E5CEC6000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000D88B4500FBC94200EB840000E8810000D76A0000D4AFA0000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000E6C4B500EBA64200F7B92C00F4AB1B00BA501900000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E9CABC00E79E3B00DA7F230000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000D8741800DE730C00DD6E0C00C7622A00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E9A64200F8AC1E00F8AD1E00D67D3B00000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000DE863100F8B12300F7B12700F29C1A00DFAC93000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      00000000000000000000E7B29000FCCB5100F9B92A00FCBB2F00DD740F000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F4CE8400FFF3D800FCCF5600FDC94400D46B
      1400000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000F4DBB900F8DFAB00FDDA7F00FCD98200FCD7
      7500EBC295000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000F8E1B600000000000000000000000000FAEFE000FFE18700FFE08800FFDF
      8800F1BB5A000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000F8DC
      A400FCE6B000F9D06C00F3CA7C00F9E8CF00EDBC5F00FFE39100FFE39000FFE3
      8D00F2C25C000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FAD7
      8300FFF2CE00FFE7A400FFE8A400FFE9A500FFE8A200FFE69B00FFE69A00FFE9
      A000F0C379000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000000000000000000000000000000000000000000000000000FCEB
      C200FFF5E300FFEEBB00FFE8A400FFE7A300FFE7A300FFE89E00FFE89E00F4CB
      6E00F5DBB6000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000FAE6B700F9E1A300FFE0A100FCDF9E00F7DB9B00F7DAA5000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000000000000000000000000000000000000000000000000000000000
      0000000000002D7B2E002C80340025C2830025BF80002D7B2E00307D31000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000191E7800191E80001D25DA001D24D700191E78001C217A000000
      0000000000000000000000000000000000000000000000000000231DB400241C
      B100000000000000000000000000000000000000000000000000000000000000
      00002C1BA1001A1E7E000000000000000000504F4B00504F4B00504F4B00504F
      4B00504F4B00504F4B00504F4B00504F4B00504F4B00504F4B004F4E4A00504F
      4B004D4C48004F4F4900504F4B004F4E4A000000000000000000000000002D7B
      2E0025C28400299F5A002C8F46002C8F46002C8F46002C8E450027B1700025C2
      840039833A00000000000000000000000000000000000000000000000000191E
      78001D25DA001C23B0001C239B001C239B001C239B001C239B001C24C7001D25
      DA00272C8000000000000000000000000000000000005451CA003739DE00383A
      E100241CB3000000000000000000000000000000000000000000000000002C1B
      A100383DE900383DE9001A1E7E0000000000504F4B00504F4B00504F4B00504F
      4B00504F4B00504F4B00504F4B00504F4B0033434A00334147003D4E57007E9B
      A900A2D7F2002A2C2D002D2E2C002D2E2C0000000000000000002D7B2E0028AA
      67002C934B002C944C002C954E002C954E002C954E002C944D002C934B002C91
      490025C283002D7B2E0000000000000000000000000000000000191E78001C24
      BC001C239B001C239B001C239B001C239B001C239B001C239B001C239B001C23
      9B001D25DA00191E780000000000000000006262D4006E6EE3006566E3003739
      DE00383AE100231DB40000000000000000000000000000000000291BA800383D
      E900383DE900383DE900383DE9001A1E7E00504F4B004D4D4700504F4B00504F
      4B00504F4B00504F4B00504F4B00444A510049484400A2D8F600B0DAED00AED8
      EB009ED6EF009ED9F3002D2E2C002D2E2C00000000002D7B2E002C944C002C97
      50002C9852002C9A54002C9C56002D7B2E002C9C56002C9B55002C9953002C97
      50002C944D0029A5610039833A000000000000000000191E78001C239B001C23
      9C001C239D001C239E001C23A0001C23A0001C23A0001C239F001C239E001C23
      9C001C239B001C23B400272C8000000000006D6DDF007574E2006C6CE2006363
      E3003739DE00383AE100221DB6000000000000000000271CB100383DE900383D
      E900383DE900383DE900383DE9002C1BA100504F4B0049484400504F4B00504F
      4B00504F4B00504F4B00504F4B004D4ABD00504F4B004D4A4500A2D8F600262B
      29002D2E2C002D2E2C002D2E2C002D2E2C000000000025C081002C9953002C9C
      57002B9F5A002BA05C002D7B2E00E0E1E1002BA25E002BA15D002BA05B002C9D
      58002C9A54002C97500025C2840000000000000000001D25D7001C239E001C23
      A0001A219200E0E0E0001C23A5001C23A5001C23A5001B22A300E0E0E0001C23
      A1001C239E001C239C001D25DA000000000000000000696BE0007271E1006969
      E2005E5EE1003739DE00383AE100221DB800241DB900383DE900383DE900383D
      E900383DE900383DE9002A1BA50000000000504F4B00464142004F4E4A00504F
      4B00504F4B00504F4B00504F4B003C3CE200504F4B00504F4B004F4C4800A2D8
      F6002D2A2C002D2E2C002D2E2C002D2E2C002D7B2E002C9C56002B9F5A002BA2
      5E002BA460002D7B2E00E4E4E400E4E4E400CED8CE002BA764002BA562002BA3
      5F002BA05B002C9C57002C985200307D3100191E78001C23A0001C23A2001B21
      9700E4E4E400E4E4E400E4E4E4001C23AB001B22A800E4E4E400E4E4E400E4E4
      E4001C23A3001C23A0001C239D001C217A0000000000000000006667E1006F6F
      E1006666E1003738DB003739DE00383AE100383BE400383CE700383DE900383D
      E900383DE900281CAE000000000000000000504F4B00414240004A494500504F
      4B00504F4B00504F4B004D4C48003F3BE800504F4B00504F4B00504F4B007191
      9E00A1D9F6002D2E2C002D2E2C002D2E2C0025BD7E002BA05C002BA460002BA8
      65002D7B2E00E8E8E800E8E8E800E8E8E800E8E8E8002BA763002BAC69002BA8
      65002BA562002BA15D002C9D58002D7B2E001C24D3001C23A4001C23A7001C23
      AA00191F8300E8E8E800E8E8E800E8E8E800E8E8E800E8E8E800E8E8E8001B22
      A8001C23A8001C23A5001C23A100191E78000000000000000000000000006365
      E1006C6CE0006363E1003738DB003739DE00383AE100383BE400383CE700383D
      E900251CB600000000000000000000000000504F4B004242420013174A004E4D
      4900504F4B0040423C00464541003B3EE70097D4F6004E4A4900504F4B0088AB
      B900A0D8F5002D2D2D002D2E2C002D2E2C0036A5640033A968002BA967002D7B
      2E00EBECEC00EBECEC00C8D7C900EBECEC00EBECEC00EBECEC002AB170002BAE
      6C002BAB68002BA6630036A7660031B67800272EA900252BAC001C23AB001C23
      AF001C23B200191F8500ECECEC00ECECEC00ECECEC00ECECEC001B22AF001C23
      B0001C23AD001C23A900272EAA00262DC5000000000000000000000000000000
      00005F62E2006A69E0006161E0003738DB003739DE00383AE100383BE400221D
      BE0000000000000000000000000000000000504F4B003F403C003C3CE8004B4A
      4600454B46004340AD0021282B003C3DE5004B49480096CCED00A1D9F600A1D9
      F600A9D8F4002D2E2C002D2E2C002D2E2C0045AF730045B57A0045B87E0044BB
      8100EFF0F0005292530029B4740029B47200EFF0F000EFF0F0002D7B2E002AB2
      710044BA800045B57A0045B1760044AB6E00373DB200373DB600373DBA00373D
      BD001C23B7001B22B600F0F0F000F0F0F000F0F0F000F0F0F0001C23B7001C23
      B400373DBB00373DB700373DB400363DAF000000000000000000000000000000
      00006569E7006D6EDF006766DF003E3ED9003738DB003739DE00383AE1001F1D
      BF0000000000000000000000000000000000504F4B0040413F003C3CE8004C4A
      49003A3BE9003A3EEB004644A4003C3DE5004F4E4A00504F4B004E504A004F4E
      4A00504F4B00504F4B00504F4B00504F4B005EBD8A0053BD870052C08B0052C2
      8D002D7B2E0051C4900051C5910050C591008BB48C00F3F3F300F3F3F30052C2
      8C0052C18C0053BE890053B98400308134005358C000474CBE00474CC200474C
      C600444AC400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400F4F4F400474C
      C600474CC200474CBF00474CBB001C217E00000000000000000000000000757A
      EE006C79E0006B72E0006B6BDE006464DE003737D8003738DB003739DE00383A
      E1001F1DC000000000000000000000000000504F4B0040413D003C3CE6004B47
      B8003A3DE5004D4B4A002A2B67003D3BE8003C3BE9003939E900373430004E4D
      4900504F4B00504F4B00504F4B00504F4B002D7B2E0060C5950060C796005FC8
      98005FC999005FCA9B005FCB9C005FCB9C005FCB9C00F7F7F700F7F7F700F7F7
      F70060C7970060C5950061C291002D7B2E00191E7800565BC600565BCA005258
      C800F8F8F800F8F8F800F8F8F8005258D100262B8C00F8F8F800F8F8F800F8F8
      F800565BCA00565BC700565BC300191E78000000000000000000868CF5007085
      E2006B7EE1006976E000686FDF006868DE006161DE003737D8003738DB003739
      DE00383AE1001E1DC2000000000000000000504F4B003D413C003C3CE8003B39
      E60041413B004F4E4A001F2550003C3CE60048484200423F4100464142004E4D
      4900504F4B00504F4B00504F4B00504F4B00000000007CD0A8006FCDA1006FCE
      A3006ECFA4006ED1A5006DD1A7006DD2A7006DD1A7006BCEA100FBFBFB00FBFB
      FB006FCDA1006FCB9F008FD6B20000000000000000007378D100666BD000666B
      D3001A1F7900FCFCFC006267D700666BDD00666BDC00292E8D00FCFCFC00484E
      B200666BD100666BCE00878AD6000000000000000000969DFA008496E600788C
      E4006D83E200687AE0006673DF005A60E9005055E5005F5EDD003737D8003738
      DB003739DE00383AE1001E1EC30000000000504F4B0040413F003C3CE800393B
      E700353EE6003331300026284A003C3CE8003B3BE5003C3CE8004543D900282A
      32003D3B3A00464443004E4D4900504F4B00000000002D7B2E007DD2AB007CD4
      AD007CD5AE007CD6B0007CD7B1007BD8B2007CD8B1007CD7B0002D7B2E007CD4
      AD007DD2AB007ED1A9002D7B2E000000000000000000191E7800757AD600757A
      DA00757ADD007075DB00757AE300757AE400757AE300757AE000585DBE00757A
      DA00757AD7007579D400191E780000000000A8AFFE0097A6EA008C9DE8008093
      E6007589E300697FE1006B72F00000000000000000004D53E6003736D5003737
      D8003738DB003739DE00383AE1001D1EC500504F4B00424341003C3CE8003B3C
      3A003B39E9003A3AEA0023201C003D3DE5004C484700423D3F0044413D004742
      3F0045483F004C4B41004F4E4A004F4E4A00000000000000000042904B008BD8
      B6008BDAB7008ADBB9008ADCBB008ADEBC008ADDBB008ADCB9008BDAB8008BD9
      B60096DBBC002D7B2E000000000000000000000000000000000030348E008489
      DE008489E1008489E4008489E7008489EA008489E8008489E5008489E2008489
      DF009093DF00191E78000000000000000000AFB6FF009FADEC0094A4E900889A
      E7007D90E5007B83F70000000000000000000000000000000000494FE7003736
      D5003737D8003738DB003739DE001C1ECA00504F4B00504E4D003C3CE8003D3B
      3A00524F4A00444462004745C70044484200504F4B00504F4B00504F4B004F4E
      4A00504F4B00504F4B00504F4B00504F4B000000000000000000000000002D7B
      2E00C6EDDC0099E0C20098E1C30098E1C30098E1C30099E0C20099DFC100C6EC
      DB002D7B2E00000000000000000000000000000000000000000000000000191E
      7800C3C4F1009397E7009397EA009397EB009397EA009397E8009397E500C3C4
      EF00191E780000000000000000000000000000000000ACB3FF009CABEB0090A1
      E9008C95FC00000000000000000000000000000000000000000000000000464D
      E8003736D5003737D800191FD20000000000504F4B00504F4B00504BC4003D3B
      3A00504F4B00504F4B00504F4B00534D4E00504F4B00504F4B00504F4B00504F
      4B00504F4B00504F4B00504F4B004F4E4A000000000000000000000000000000
      0000000000002D7B2E00D5F3E600D5F3E600D5F3E600C7ECDB002D7B2E000000
      0000000000000000000000000000000000000000000000000000000000000000
      000000000000191E7800D2D4F600D2D4F600D2D4F600C4C6EF00191E78000000
      0000000000000000000000000000000000000000000000000000A9B0FF009DA5
      FF00000000000000000000000000000000000000000000000000000000000000
      00002F37E600161FDA000000000000000000504F4B00504F4B00524F4B004B4A
      4600504F4B00504F4B004F4E4A00504F4B00504F4B00504F4B00504F4B00504F
      4B00504F4B00504F4B00504F4B00504F4B00424D3E000000000000003E000000
      2800000040000000200000000100010000000000000100000000000000000000
      000000000000000000000000FFFFFF00FC7FFFFF00000000F81FFFFF00000000
      F81FFFFF00000000F83FFFFF00000000FC7FFFFF00000000FC3FFFFF00000000
      FC3FFFFF00000000FC1FFFFF00000000FC1FFFFF00000000FE0FFFFF00000000
      FE07FFFF00000000F707FFFF00000000E007FFFF00000000E007FFFF00000000
      E007FFFF00000000F81FFFFF00000000F81FF81FCFF30000E007E00787E10000
      C003C00303C000008001800101800000800180018001000000000000C0030000
      00000000E007000000000000F00F000000000000F00F000000000000E0070000
      00000000C003000080018001800100008001800101800000C003C00303C00000
      E007E00787E10000F81FF81FCFF3000000000000000000000000000000000000
      000000000000}
  end
  object pmLV: TPopupMenu
    OnPopup = pmLVPopup
    Left = 472
    Top = 8
    object add1: TMenuItem
      Caption = 'Add'
      object Browserworkshop1: TMenuItem
        Caption = 'From workshop browser'
        OnClick = AddWorkshopClick
      end
      object AddbyID1: TMenuItem
        Caption = 'From workshop by ID or URL'
        OnClick = AddWorkshopClick
      end
      object Redirect1: TMenuItem
        Caption = 'From redirect'
      end
      object Manual1: TMenuItem
        Caption = 'From local file'
      end
      object ManualEntry1: TMenuItem
        Caption = 'Manual entry'
      end
    end
    object Remove1: TMenuItem
      Caption = 'Remove'
      object allfilesandentry1: TMenuItem
        Caption = 'Full item'
        OnClick = Removeall1Click
      end
      object cache1: TMenuItem
        Caption = 'Cache'
        OnClick = RemoveGameSteamCache1Click
      end
      object Mapentry1: TMenuItem
        Caption = 'Map entry'
        OnClick = RemoveMapEntry1Click
      end
      object MapCycle1: TMenuItem
        Caption = 'Map Cycle'
        OnClick = RemovefromCycle1Click
      end
      object Subcribe1: TMenuItem
        Caption = 'Workshop Subcription'
        OnClick = RemoveServerSubcribe1Click
      end
    end
    object N1: TMenuItem
      Caption = '-'
      Enabled = False
    end
    object Forceupdate1: TMenuItem
      Caption = 'Force update'
      OnClick = btnUpdateClick
    end
    object Reinstall1: TMenuItem
      Caption = 'Reinstall'
      OnClick = btnReinstallClick
    end
    object mniN2: TMenuItem
      Caption = '-'
    end
    object mniShowitempage1: TMenuItem
      Caption = 'Browser item page'
      OnClick = mniShowitempage1Click
    end
    object Explorerlocalfolder1: TMenuItem
      Caption = 'Browser item folder'
      OnClick = Explorerlocalfolder1Click
    end
    object mniCopyID1: TMenuItem
      Caption = 'Copy ID'
      OnClick = mniCopyID1Click
    end
    object Export1: TMenuItem
      Caption = 'Export to list'
      OnClick = Export1Click
    end
  end
  object tmrWebAdmin: TTimer
    Enabled = False
    Interval = 2000
    OnTimer = tmrWebAdminTimer
    Left = 496
    Top = 152
  end
  object pmAdd: TPopupMenu
    Left = 504
    Top = 8
    object AddWorkshopMap: TMenuItem
      Caption = 'From Workshop Browser'
      OnClick = AddWorkshopClick
    end
    object AddWorkshopIDorURL: TMenuItem
      Caption = 'From Workshop ID or URL'
      OnClick = AddWorkshopIDorURLClick
    end
    object FromRedirect1: TMenuItem
      Caption = 'From Redirect'
      OnClick = FromRedirect1Click
    end
    object FromList1: TMenuItem
      Caption = 'From Backup List'
      OnClick = FromList1Click
    end
    object N2: TMenuItem
      Caption = '-'
      Enabled = False
    end
    object Multipleitems1: TMenuItem
      Caption = 'Multiple items'
      OnClick = Multipleitems1Click
    end
    object AddManualEntry: TMenuItem
      Caption = 'Manual'
      Enabled = False
    end
  end
  object idhtp1: TIdHTTP
    AllowCookies = True
    ProxyParams.BasicAuthentication = False
    ProxyParams.ProxyPort = 0
    Request.ContentLength = -1
    Request.Accept = 'text/html, */*'
    Request.BasicAuthentication = False
    Request.UserAgent = 'Mozilla/3.0 (compatible; Indy Library)'
    HTTPOptions = [hoForceEncodeParams]
    Left = 416
    Top = 136
  end
end
