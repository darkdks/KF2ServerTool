object FormMain: TFormMain
  Left = 0
  Top = 0
  Caption = 'Killing Floor 2 Server Tool'
  ClientHeight = 562
  ClientWidth = 684
  Color = clGray
  Constraints.MinHeight = 600
  Constraints.MinWidth = 700
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
  object lblCredits: TLabel
    AlignWithMargins = True
    Left = 2
    Top = 2
    Width = 680
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
    ExplicitLeft = 592
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
  object pnl1: TPanel
    Left = 0
    Top = 529
    Width = 684
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
    object lblDonate: TLabel
      AlignWithMargins = True
      Left = 630
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
      Left = 574
      Top = 2
      Width = 46
      Height = 21
      Cursor = crHandPoint
      Margins.Left = 10
      Margins.Top = 2
      Margins.Right = 0
      Margins.Bottom = 10
      Align = alRight
      Alignment = taRightJustify
      Caption = 'Update'
      Font.Charset = ANSI_CHARSET
      Font.Color = clTeal
      Font.Height = -11
      Font.Name = 'Verdana'
      Font.Style = [fsBold, fsUnderline]
      ParentFont = False
      OnClick = checkForUpdates
      ExplicitHeight = 13
    end
    object btnReinstall: TBitBtn
      Left = 272
      Top = 2
      Width = 130
      Height = 29
      Hint = 'Reinstall an item, helpfull fix broken item or add some entrys'
      Margins.Left = 2
      Margins.Top = 4
      Margins.Right = 2
      Margins.Bottom = 4
      Align = alCustom
      Caption = 'Reinstall item'
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C006000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB25A19B9641AB85F19B65E
        17B76016AA5316FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEED9CAFFFFFFFFFFFFFFFFFFBF6B1D
        E6A626E2A123E19F22E5A220BA6317FFFFFFFFFFFFFFFFFFEAD6C8FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF9569D2872CC07135FF
        FFFFFAF5F0BE6A20E4A62DE0A029E09D25E2A025B9621AFAF4F0FFFFFFB4652E
        C57118C38963FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD0986CDD9A
        36EAB542E3A639B75F1ECB7D27DC9930E4A733E3A42FE1A22CE1A129D88F24C5
        701DAD551ADC931FE39E1DD0811AC58B65FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        D49B6CE0A03AEBB849E9B447E8B343E9B643E9B13EE6AE3CE5AB39E4A836E4A8
        33E4A531E3A52EE4A42AE3A427E09D24DE9A22E19D20D2811CC68B65FFFFFFFF
        FFFFFFFFFFF2DECBDB9839EDC355E9B94EE9B74BE8B548E8B346E8B244E7B343
        E3A53ADA9432D99431DE9B32E6AC35E5A731E3A42DE1A32AE09F27DF9E25E2A0
        22CA791DECD8C8FFFFFFFFFFFFFFFFFFCF863DE9B74FECBE55EABB50E9B94DEA
        BA4DE3A63ED79032D89133DD9935D99534CB7C29BA6320D08528E7AD36E4A532
        E2A32EE2A42ADE9926BC6E32FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC87825EEC6
        5AECBD57ECBE55E3A73EE0A13AE9B94BEAB94BE6AE41E4A93EEBB643E8B040C1
        6D23BC671FE9B139E3A733E6A832B55E1FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FCF7F1DA983AEFC660EEC25BE9B44AE5AA41EDC258E5AB42D89032D99C58DDAC
        7BBC6621D1862CEFC14AC16F21C87922E8AF3CE6AD38CB7D26FBF5F1FFFFFFFF
        FFFFD2872CDA9636D89133E9BB57EFC965EEC360E6A93DEDC45CE7B448DE9D37
        F3DCBBFFFFFFFFFFFFEFD9C7B45D1DC87924EFBD49A64B11E6A93BE8B03EDE9B
        35C57324C57423BB6721E6BC6AF5D887F1CD68F1C967EFC767ECBC53E9B84FEE
        C45FE6AB3EFBF0DEFFFFFFFFFFFFFFFFFFFFFFFFF3E4D9AA5014E8B043CB7B26
        CB7C25EAB645E7AF40E9B13EEBB53EC77626ECCF95F7E7C0F7E4B8F4DC9BF2D5
        88ECBF55ECC158ECBC51E9B556FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFB4
        6934D0872CE3A83EB96319EBBA48E8B243E6AF3FE8B23BC6741FECCF94F8E8BC
        F7E5B9F6E5BAF6E5BBF3DCA3F6E3B6F3D994F0D18DFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFB76B3AD0872AE7B654BE6C1FEFC75FEDCA72EFC973F1D488E4
        BF82EDD297FAE9C3F8E8BEF8E7BAF7E6BAF4DCA1F4DEABF6E1ADEFD292FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD4A768ECD398ECD197E3BF84F5E1ACF3DE
        A6F2DDA5F4DEA2E3BF83EDCE8FEDD398EDD096F6E1B1F8E7BDF5E1AEF1D79CF7
        E6BBEFD18FF2E0B9FFFFFFFFFFFFFFFFFFFFFFFFE7CBA6D3A263F7E6B2DBAE72
        E8CB8DF4E0A9F0D69DE5C285E6C286E1BB7EFFFFFFFFFFFFFEFCF8EFD79FF9E8
        BFF9E7BFF0D493F6E3B4F6E2B0EBCB88EBCD96F2E4CAF1E2C7DCB377D8A86BF0
        D7A1F1DAA6D4A364F7E5B4F4E0ABEACC8FFEFBF7FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFEECE8CF9EBC4F8E9BFF7E4B6ECCD8AF6E5B9F8E7BCEDD399E9C98AE5C3
        86E7C68DF7E6B5F4E1AFD2A064EFD8A2F6E0B0F6E1B0E4BF82FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFF0D89DF8E9BEF9E9C2F9E9C1F8EAC2F6E3B2E9C887EFD69E
        F6E4B7FAEDC5FBECC2F6E4B4E8CA91D6A76BEFD8A2F7E5B6F5E1B1F5E1B1F3DE
        AAE9C991FFFFFFFFFFFFFFFFFFFCF5E6F5DFACFAEEC8F9EAC2F9E9C2F9E9C1FA
        EAC3F9EAC2F0D9A4E7C789E0B875DDB472E0BA7FEBCE97F7E8BAF7E5BAF6E3B5
        F6E3B4F6E4B4F6E4B5EFD49CF9F1E3FFFFFFFFFFFFFFFFFFF5E2B7F6E5B6F9EC
        C8F9EBC3F9EBC3FAEAC5FAEAC4FAEBC4F9ECC4FAEBC4FAEBC3FAEAC1F9E9BFF8
        E8BEF8E8BCF8E6B9F6E4B8F7E4B8F2DCA6EFD8ADFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFF6E3B7F7E6B7FBEFCAF9E9C0EFD292F3DDA6F6E6B9F9EAC3F9E9C1F8E9
        C0F8E9BFF5E3B4F1D79FEBCC8BF6E4B7F8E9BDF3DDA8F0DAB0FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFF6E3B9F7E2B0F3DAA3FFFFFFFEFCF8F1DA9E
        FAEBC6F9E9C2F9E9C2FAEBC4EFD599FEFCF8FFFFFFEED39BF2DBA6F2DDB1FFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCF6E7FFFFFFFF
        FFFFFFFFFFF3DDA2FAEECBFAECC8FAEBC6FAEDC8F0D99FFFFFFFFFFFFFFFFFFF
        FBF4E5FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFF3DB9FF3DDA2F2DCA1F2DBA0F2DBA1F1D598FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnClick = btnReinstallClick
    end
    object btnUpdate: TBitBtn
      Left = 406
      Top = 2
      Width = 130
      Height = 29
      Hint = 
        'Update an item, just download and update the file, without touch' +
        'ing the server settings (map cycle, map entry, subscribe)'
      Margins.Left = 2
      Margins.Top = 4
      Margins.Right = 2
      Margins.Bottom = 4
      Align = alCustom
      Caption = 'Update item'
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C006000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCC7B19CC801DCC801DC97413C36C11BE65
        0AB95D00AC5800A25300954400FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE6B752FDFFFFFFF9C5
        FFE893F9DC7BF9CB58F1BB37EDA812E09900B45909FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEF
        B030E9A424E49C23E19622E19622D68A1FD2831DCE7D1CCD7919CA7415FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC6751BD69334D69334D18420CC7C15CA76
        06C26A00AE6000A96100904000FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDFA442FBFFFFF9E8A6
        F8D772F5C75BF1BD41EDAE25E99E04D59000B05005FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE7
        AF47F5F3E3F6E093F5D172F2C965EEBF54E9B342E6A630E59D14C1690FFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFEDAB2AEDAB2AE9A62AE59E29E29B25DE9323DA8F22D68922D4
        841CD3831CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDD982CDEA13ADEA13A
        DA9228D48924D08322CC7B1BC77515C0680EB05503FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFE0
        9E36FBFFFFFCEDB1FBE18AF8DE81F6D270F5C95FF5C54CE5A630AE5202FFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFDE9C34F9FFFFF7E4A5F9D77EF5D071F4C85FF2C04EEFBA3FE1
        9B23AC5003FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDC9A32FAFFFFF7E19BF6D575F3CB68F2C2
        57F1BB43EEB336E0951BAE5001FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFF1B538EBAD31E7A125E2941FDD8E1CD9962FF9FFFFF7DB95
        F5CD6AF3C35FF1C04CEEB43AECAD2ADC9212AB4C00A54C009845008D3E008E43
        008F4400FFFFFFFFFFFFFFFFFFFFFFFFF0B134E9AD36EEE2C4F6F0D4F7D875F4
        D678F9E39EF6D57AF4CB64F1C155EEB943EBB033EBA41EE49A08D08100C17700
        CA7D00D69F4BA246008E4300FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFEAA82BE69B
        22F2ECDEF9F5E3FADB7FF6D777F4CB68F2C659F1BD46EFB237EAAA26E6A012E3
        9500CC8600C68200E6C265A246008C4200FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFE39C26E19D2FF1EDECF8EECFF5CD68F4CB5EF2C04FEEB83FE9AF
        2EE8A41AE69B03D38A00C48100E3B13FA94E018B4100FFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFDD8E21DB9528EEECE1F5E6BEF2C24F
        F0BC45EDB135EAA622E79D0DDF9200C88200ECB93EAB5607944200FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD7891BD6
        8D24EDE3D7F2D17DEEB334EAAB2BE7A116E59A00CC8500E8B830C0680E9C4400
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFD38017D0831FEADFC8F1C35EE9A119E79907D78C00E5A81BC0
        680EA34A00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFCE7811D08C30F0E6CBE9B939E290
        00E8AD18C0680EA94C00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFC56D0C
        CE8836EFDFB3EBB52CC0680EAD4D00FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFBF6005CE8836C0680EB05200FFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFBA5F07B65904FFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      OnClick = btnUpdateClick
    end
    object btnAddNew: TBitBtn
      Left = 4
      Top = 2
      Width = 130
      Height = 29
      Hint = 
        'Update an item, just download and update the file, without touch' +
        'ing the server settings (map cycle, map entry, subscribe)'
      Margins.Left = 2
      Margins.Top = 4
      Margins.Right = 2
      Margins.Bottom = 4
      Align = alCustom
      Caption = 'Add'
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C006000000000000000000000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1A751C1A751C0B6F0F0B6F0F0B6F
        0D0B6F0D086B0B086B0BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1A751C72D288
        22C34D22C34D22C24B22C24B1DAC3B086B0BFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF1A751C6ED08421C04D21BE4C21BE4A21BE4A1CA839086B0BFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF1A751C6ED18421C04F21C04F21C04D21BE4C1CAA3B08
        6B0BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1A751C6ED08621C25021C24F21C0
        4F21C04F1CAB3C086B0BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1A751C6ED287
        1EC3531EC25221C25021C24F1CAD3E086B0BFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF1A751C6FD58C21C55521C3531EC3531EC2521CAF3F086B0BFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF1A751C5CCB7C1FC6581FC65721C55521C3551BAE4208
        6B0BFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF2083291A751C
        1A751C1A751C1A751C1A751C1A751C1A751C086B0B5CCB7C1FC85B1FC65A1FC6
        581FC6581BAE42086B0B086B0B086B0B086B0B086B0B086B0B086B0B086B0B08
        6B0B278D3446CE781BB44D1BB44D1BB44D1BB44D1BB44D1BB44D1BB44D5CCB7C
        1FC95E1FC95D1FC85B1FC65A1BAE421BAE421BB44D1BB44D1BB44D1BB44D1BB4
        4D1BB44D1BAE4210801C28903555ED9F18D16D1ED36E1ED16D1ED16B1ED0691E
        D0681ECE661FCD631FCD621FCB601FC95E1FC95D1FC85B1FC65A1FC6581FC658
        1FC55721C55521C3531EC35321C04F12831D28933855F0A218D4711CD5731CD5
        711CD36E1ED16D1ED16B1ED0691ED0681ECE661FCD651FCD621FCB601FC95E1F
        C95D1FC85B1FC85B1FC6571FC6581FC55721C55521C04F12872029963B53F2A5
        17D8751CD8761CD6741CD5731CD5711CD36E1ED36D1ED16B1ED0691ED0681ECE
        661FCE651FCD631FCB601FCB5E1FC95D1FC85D1FC85B1FC65A1FC65821C04F12
        8B23299B3E4FF4A714DA7717DA7917D87718D77618D47118D57019D46F1BD370
        1ED36E1ED16B1ED0691ED0681ECE661DCD641CCC611BC95F1BC95D1BC75B1BC6
        5A1BC6581FC65A128E262B9E416CFFBD4CEFA34EF0A24FEE9F4FEE9E4FED9C51
        EB9B53E89A18D5701CD5711CD3701ED36E1ED16D1DCF681CCC6154E38F52E38D
        52E28B52E08952E08852DD8655E28A1E9832249E3C249E3C249E3C249E3C249E
        3C249E3C249E3C249E3C249E3C6EE5A01CD8761CD6731CD5711CD37019C35E12
        8C23128C23128C23128C23128C23128C23128C23128C23128C23FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1E98326EE5A01BD9791CD9781CD8
        761CD67419C35E1E9832FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1E98326DEAA6
        1BDC7E1BDB7C1BDB7B1BD9781BC8641E9832FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF1E983270ECA619E08319DE8119DC7E1BDB7C1BCB681E9832FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF1E983270ECA819E08419E08419E08319DE8119CF6D1E
        9832FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1E98326FEEAA19E08419E08419E0
        8419E08419D2731E9832FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1E98326EF0AA
        12DE7F12DE7F12DE7F12DE7F14D3701E9832FFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFF249E3C6EF0AC8AFFCE8AFFCE8AFFCE8AFFCE72F2AF249E3CFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFF249E3C2CBB5331C15731C15731C15731C1572CBB5324
        9E3CFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnAddNewClick
    end
    object btnRemove: TBitBtn
      Left = 138
      Top = 2
      Width = 130
      Height = 29
      Hint = 
        'Update an item, just download and update the file, without touch' +
        'ing the server settings (map cycle, map entry, subscribe)'
      Margins.Left = 2
      Margins.Top = 4
      Margins.Right = 2
      Margins.Bottom = 4
      Align = alCustom
      Caption = 'Remove'
      Glyph.Data = {
        F6060000424DF606000000000000360000002800000018000000180000000100
        180000000000C0060000C40E0000C40E00000000000000000000FFFFFFFFFFFF
        FFFFFFFFFFFFF1F1FAD4D4F0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFD5D5EFF1F1FAFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFF1F1FA4949C02424B57070CCFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7373C93B3BC95555C7F1F1
        FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF1F1FA4B4BC13636C43333C52F2FBE71
        71CCFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF7373CA4545D5
        5C5CF36161F35757C8F1F1FAFFFFFFFFFFFFFFFFFFF1F1FA4A4AC13535C31919
        BC0B0BBA3232C63030BF7171CBFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF72
        72CA4343D25555EE3C3CF14E4EF76565F75757C8F1F1FAFFFFFFFFFFFF5353C5
        7777DB1717BA0606B70808B90D0DBC3434C83131C07171CBFFFFFFFFFFFFFFFF
        FFFFFFFF7272CA3F3FCF5050E83535E93838EE3C3CF34D4DF65F5FF15050C2FF
        FFFFFFFFFF3333BA8888E25454D10606B60808B90A0ABB0F0FBE3535CA3232C2
        7171CBFFFFFFFFFFFF7272CB3C3CCC4A4AE12E2EE13030E53434EA3737ED4040
        F05D5DF12E2EBBFFFFFFFFFFFFA8A8E13F3FC08989E25454D20707B80909BA0B
        0BBD1111C03737CC3434C37171CB7171CB3939C84545DC2828DA2929DD2D2DE2
        3030E53A3AE85959ED3535C3AAAADFFFFFFFFFFFFFFFFFFFA8A8E13F3FBF8989
        E35555D30909BA0B0BBC0D0DBE1212C23838CE3535C43737C64141D72222D322
        22D62626DA2929DD3333E15454E73333C2AAAADFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFA8A8E13F3FC08989E35656D40A0ABB0C0CBD0E0EC01414C43A3ACF3C3C
        D21C1CCD1C1CD01F1FD32222D62D2DDA4F4FE23232C0AAAADFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFA9A9E14040C08A8AE35656D50B0BBC0D0DBF
        0F0FC11515C51717C71717CA1A1ACC1C1CD02727D44A4ADD3030BEAAAADFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA9A9E14040C08A
        8AE35757D50C0CBD0E0EBF1010C21212C41515C71717CA2222CE4646D72D2DBD
        AAAADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFA9A9E14040C07B7BDE1414BE0C0CBE0E0EC01010C21212C41D1DC942
        42D32C2CBBAAAADFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFA9A9E12D2DBD3030C40C0CBB0B0BBC0C0CBE0E0E
        C01010C21515C43A3ACF3535C3AAAAE0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8E14343C34F4FCD1D1DBE0A0ABA
        0909BA0B0BBC0C0CBE0E0EBF0F0FC11414C33838CE3333C3A9A9E0FFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8E14545C45656CE37
        37C53333C53232C52424C22323C22727C50C0CBD0D0DBE0E0EC01212C23737CC
        3232C1A9A9E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8E14646
        C45959CE3A3AC53636C43535C53333C53A3AC75D5DD29797E75858D42B2BC626
        26C52626C62929C74949D03F3FC5A9A9E0FFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        A8A8E14949C55D5DCF3E3EC63A3AC43838C43636C43C3CC65B5BD04646C15151
        C69C9CE85858D33030C62F2FC72F2FC73232C85050D04141C4A9A9E0FFFFFFFF
        FFFFFFFFFFA8A8E25050C76060CF4242C73E3EC53B3BC53A3AC43F3FC65B5BCF
        3E3EBFA9A9E1A9A9E15252C69C9CE85959D33030C63030C63030C63232C75151
        CF4242C4A9A9E0FFFFFFFFFFFF5454C9A2A2E95151CB4141C64040C63E3EC543
        43C75E5ECF3F3FC0A8A8E1FFFFFFFFFFFFA9A9E15252C69C9CE85A5AD33232C5
        3232C53131C53636C75A5AD13434BCFFFFFFFFFFFF5555C69A9AE69B9BE74F4F
        CA4141C64747C86161D04141C1A8A8E1FFFFFFFFFFFFFFFFFFFFFFFFA8A8E152
        52C69D9DE85B5BD23333C53333C54C4CCC5454CC4E4EC1FFFFFFFFFFFFF0F0FA
        5555C69A9AE69B9BE75656CD6464D14444C2A8A8E1FFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFA8A8E15353C79E9EE85C5CD24E4ECC5555CC4E4EC1F1F1FAFF
        FFFFFFFFFFFFFFFFF0F0FA5555C69A9AE6A2A2E94E4EC6A8A8E1FFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8E16565CF9F9FE87E7EDB4E4E
        C2F1F1FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF0F0FA5050C53D3DC0A8A8E2FF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFA8A8E1
        4B4BC45353C4F1F1FAFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF
        FFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFFF}
      ParentShowHint = False
      ShowHint = True
      TabOrder = 3
      OnClick = btnRemoveClick
    end
  end
  object jvpgcntrl1: TJvPageControl
    Left = 0
    Top = 17
    Width = 684
    Height = 512
    Margins.Left = 2
    Margins.Top = 2
    Margins.Right = 2
    Margins.Bottom = 2
    ActivePage = tsExtra
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
        Width = 640
        Height = 470
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
          Width = 636
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
            ExplicitHeight = 17
          end
          object btnNewProfile: TButton
            Left = 49
            Top = 31
            Width = 61
            Height = 25
            Hint = 'Create a new server profile'
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'New'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 0
            OnClick = btnNewProfileClick
          end
          object btnRenameProfile: TButton
            Left = 114
            Top = 31
            Width = 74
            Height = 25
            Hint = 'Rename current profile'
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Rename'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = btnRenameProfileClick
          end
          object btnDeleteProfile: TButton
            Left = 192
            Top = 31
            Width = 69
            Height = 25
            Hint = 'Delete current profile'
            Margins.Left = 2
            Margins.Top = 2
            Margins.Right = 2
            Margins.Bottom = 2
            Caption = 'Delete'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            OnClick = btnDeleteProfileClick
          end
          object cbbProfile: TComboBox
            AlignWithMargins = True
            Left = 51
            Top = 2
            Width = 423
            Height = 25
            Hint = 'Choose a profile with different options'
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
          Width = 636
          Height = 202
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
            Height = 28
            Caption = 
              'Example: ?Mutator=KFMutator.KFMutator_MaxPlayersV2?MaxPlayers=15' +
              '?MaxMonsters=64'#13#10'Example: ?Game=MyCustoGameMode.GameMode?Mutator' +
              '=MyMutator.Mutator'
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
            AlignWithMargins = True
            Left = 20
            Top = 138
            Width = 596
            Height = 44
            Margins.Left = 20
            Margins.Top = 2
            Margins.Right = 20
            Margins.Bottom = 20
            Align = alBottom
            Caption = 'Start server'
            TabOrder = 0
            OnClick = btnStartServerClick
          end
          object chkAutoConnectWeb: TCheckBox
            Left = 12
            Top = 45
            Width = 493
            Height = 17
            Hint = 
              'Activating this option will make the webadmin open inside the to' +
              'ol itself '#13#10'as soon as the server goes online. '#13#10'Note that for t' +
              'his option to work correctly you must enable WebAdmin in options' +
              ' tab.'
            Caption = 'Auto connect to web admin'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            OnClick = chkAutoConnectWebClick
          end
        end
        object pnl5: TPanel
          Left = 2
          Top = 92
          Width = 636
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
            Width = 278
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
              Width = 270
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
              Width = 270
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
            Left = 461
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
            Left = 278
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
          Width = 636
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
            Width = 628
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
            Width = 628
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
          Width = 636
          Height = 71
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Align = alTop
          BevelOuter = bvNone
          TabOrder = 4
          object lblGamePass: TLabel
            Left = 208
            Top = 9
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
            Left = 208
            Top = 30
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
            Top = 30
            Width = 193
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
              'Weekly'
              'Custom')
          end
        end
      end
    end
    object tsMaps: TTabSheet
      Caption = 'Maps'
      ImageIndex = 8
      object pnl2: TPanel
        Left = 0
        Top = 0
        Width = 676
        Height = 28
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alTop
        BevelOuter = bvNone
        TabOrder = 0
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
      object lvMaps: TListView
        Left = 0
        Top = 28
        Width = 676
        Height = 452
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
          end
          item
            Header = 'Official'
            GroupID = 1
            State = [lgsNormal, lgsCollapsible]
            HeaderAlign = taLeftJustify
            FooterAlign = taLeftJustify
            TitleImage = -1
          end
          item
            Header = 'Redirect or local'
            GroupID = 2
            State = [lgsNormal, lgsCollapsible]
            HeaderAlign = taLeftJustify
            FooterAlign = taLeftJustify
            TitleImage = -1
          end
          item
            Header = 'Incomplete / Broken'
            GroupID = 3
            State = [lgsNormal, lgsCollapsible]
            HeaderAlign = taLeftJustify
            FooterAlign = taLeftJustify
            TitleImage = -1
          end>
        IconOptions.Arrangement = iaLeft
        LargeImages = il1
        MultiSelect = True
        GroupView = True
        ReadOnly = True
        RowSelect = True
        PopupMenu = pmLV
        SmallImages = il1
        TabOrder = 1
        ViewStyle = vsReport
        OnClick = lvClick
        OnColumnClick = lvMapsColumnClick
        OnCompare = lvCompare
        OnCustomDrawItem = lvMapsCustomDrawItem
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
        Width = 676
        Height = 480
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
      object lvUnknowed: TListView
        Left = 0
        Top = 0
        Width = 676
        Height = 480
        Margins.Left = 2
        Margins.Top = 2
        Margins.Right = 2
        Margins.Bottom = 2
        Align = alClient
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
        Groups = <
          item
            Header = 'Workshop'
            GroupID = 0
            State = [lgsNormal]
            HeaderAlign = taLeftJustify
            FooterAlign = taLeftJustify
            TitleImage = -1
          end
          item
            Header = 'Official'
            GroupID = 1
            State = [lgsNormal]
            HeaderAlign = taLeftJustify
            FooterAlign = taLeftJustify
            TitleImage = -1
          end
          item
            Header = 'Redirect or local'
            GroupID = 2
            State = [lgsNormal]
            HeaderAlign = taLeftJustify
            FooterAlign = taLeftJustify
            TitleImage = -1
          end>
        IconOptions.Arrangement = iaLeft
        LargeImages = il1
        MultiSelect = True
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
        Width = 640
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
            Text = ''
            OnExit = edtPortExit
          end
          object cbStatusWeb: TJvComboBox
            Left = 105
            Top = 36
            Width = 101
            Height = 25
            Style = csDropDownList
            TabOrder = 1
            Text = ''
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
            Hint = 
              'This will enable redirect clients to download items from Worksho' +
              'p. You must enable this option if you install maps and mods from' +
              ' steam workshop.'
            Style = csDropDownList
            ParentShowHint = False
            ShowHint = True
            TabOrder = 2
            Text = ''
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
            Text = ''
            OnExit = edtWebPassExit
          end
          object chkAutoLoginAdmin: TCheckBox
            Left = 24
            Top = 129
            Width = 429
            Height = 28
            Hint = 
              'Enabling this option will cause WebAdmin to automatically log in' +
              ' using the Admin'#39's username and the specified password. '#13#10'This o' +
              'ption only takes effect if the * Auto connect to webadmin * is e' +
              'nabled on the server profile tab.'
            Align = alCustom
            Caption = 'Auto web admin login using specified pass'
            ParentShowHint = False
            ShowHint = True
            TabOrder = 4
            OnClick = chkAutoLoginAdminClick
          end
        end
        object Panel1: TPanel
          Left = 345
          Top = 19
          Width = 293
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
            Text = ''
            OnExit = edtRedirectURLExit
          end
          object cbbRedirectEnabled: TJvComboBox
            Left = 113
            Top = 7
            Width = 88
            Height = 25
            Hint = 
              'Enable this option to setup a custom URL for redirect clients to' +
              ' download items from the specified Redirect URL '
            Style = csDropDownList
            ParentShowHint = False
            ShowHint = True
            TabOrder = 1
            Text = ''
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
        Width = 640
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
        object lblTheme: TLabel
          Left = 320
          Top = 26
          Width = 47
          Height = 17
          Margins.Left = 2
          Margins.Top = 2
          Margins.Right = 2
          Margins.Bottom = 2
          Caption = 'Theme:'
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
        object cbbLanguage: TJvComboBox
          Left = 96
          Top = 53
          Width = 125
          Height = 25
          Style = csDropDownList
          TabOrder = 1
          Text = ''
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
          Hint = 
            'Enable this option to only see items that are in PCServer-KFGame' +
            ' and PCServer-KFEngine.'#13#10'Cache and local maps folder will be ign' +
            'ored.'#13#10'This is useful when you have multiple servers with multip' +
            'le settings'#13#10' and you dont wanna see maps from another server in' +
            'to the tool.'
          Align = alCustom
          Caption = 'Only display items that are into the current configuration file'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = chkOnlyFromConfigItemsClick
        end
        object cbbTheme: TJvComboBox
          Left = 372
          Top = 24
          Width = 173
          Height = 25
          Style = csDropDownList
          TabOrder = 3
          Text = ''
          OnChange = cbbThemeChange
        end
        object chkAutoCheckForUpdates: TCheckBox
          Left = 320
          Top = 55
          Width = 317
          Height = 28
          Hint = 
            'Automatically check if updates are available for'#13#10'the tool in th' +
            'e official KF2ServerTool repository.'
          Align = alCustom
          Caption = 'Automatically check for updates'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 4
          OnClick = chkAutoCheckForUpdatesClick
        end
      end
      object grpmaintenance: TGroupBox
        AlignWithMargins = True
        Left = 8
        Top = 196
        Width = 640
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
          Hint = 
            'This will update the server to Current Version [no beta or previ' +
            'ew version]'
          Caption = 'Current version'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 0
          OnClick = btnCheckForUpdateClick
        end
        object btnCleanDownloadCache: TButton
          Left = 246
          Top = 47
          Width = 179
          Height = 25
          Hint = 'This will clean all downloaded items cache (KFGame/cache)'
          Caption = 'Clean download cache'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 1
          OnClick = btnCleanDownloadCacheClick
        end
        object btnCheckForPreview: TButton
          Left = 19
          Top = 77
          Width = 190
          Height = 25
          Hint = 'This will update the server to Beta Preview version'
          Caption = 'Beta/Preview'
          ParentShowHint = False
          ShowHint = True
          TabOrder = 2
          OnClick = btnCheckForPreviewClick
        end
        object btnCleanWorkshopData: TButton
          Left = 246
          Top = 78
          Width = 179
          Height = 25
          Hint = 
            'This will clean workshop data (Binaries\Win64\steamapps\workshop' +
            '\content\232090)'#13#10'This is helpfull to force update in all maps a' +
            'nd auto repair some broken items.'
          Caption = 'Clean workshop data '
          ParentShowHint = False
          ShowHint = True
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
        Width = 676
        Height = 480
        Align = alClient
        TabOrder = 0
        OnDocumentComplete = wb1DocumentComplete
        ExplicitWidth = 661
        ExplicitHeight = 439
        ControlData = {
          4C000000DE4500009C3100000000000000000000000000000000000000000000
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
        Width = 666
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
        Top = 463
        Width = 664
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
        ExplicitLeft = 430
        ExplicitWidth = 237
      end
      object mmoNotepad: TMemo
        AlignWithMargins = True
        Left = 8
        Top = 33
        Width = 660
        Height = 427
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
    Left = 480
    Top = 16
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
    Left = 584
    Top = 16
    Bitmap = {
      494C010106002000180210001000FFFFFFFFFF10FFFFFFFFFFFFFFFF424D3600
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
    Left = 512
    Top = 16
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
        Enabled = False
      end
      object ManualEntry1: TMenuItem
        Caption = 'Manual entry'
        Enabled = False
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
    Left = 632
    Top = 16
  end
  object pmAdd: TPopupMenu
    Left = 544
    Top = 16
    object AddWorkshopMap: TMenuItem
      Caption = 'From Workshop Browser'
      Hint = 
        'Will open a workshop webbrowser that you can search a map or mod' +
        ' to add'
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
end
