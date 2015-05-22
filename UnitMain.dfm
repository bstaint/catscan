object frmMain: TfrmMain
  Left = 0
  Top = 0
  BorderIcons = [biSystemMenu, biMinimize]
  BorderStyle = bsSingle
  Caption = 'frmMain'
  ClientHeight = 429
  ClientWidth = 752
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  Position = poDesktopCenter
  OnCreate = FormCreate
  OnDestroy = FormDestroy
  PixelsPerInch = 96
  TextHeight = 13
  object pgcMain: TPageControl
    Left = 0
    Top = 0
    Width = 752
    Height = 429
    ActivePage = TabSheet1
    Align = alClient
    TabOrder = 0
    object TabSheet1: TTabSheet
      Caption = #30446#24405#25195#25551
      object lblATCountInfo: TLabel
        Left = 551
        Top = 109
        Width = 60
        Height = 13
        Caption = #25195#25551#32447#31243#65306
      end
      object lblScanInfo: TLabel
        Left = 3
        Top = 109
        Width = 60
        Height = 13
        Caption = #25195#25551#20449#24687#65306
      end
      object lblSpeedInfo: TLabel
        Left = 629
        Top = 109
        Width = 60
        Height = 13
        Caption = #25195#25551#36895#24230#65306
      end
      object lblSpeed: TLabel
        Left = 689
        Top = 109
        Width = 22
        Height = 13
        Caption = '0/'#31186
      end
      object lblATCount: TLabel
        Left = 610
        Top = 109
        Width = 6
        Height = 13
        Caption = '0'
      end
      object lblScan: TLabel
        Left = 61
        Top = 109
        Width = 435
        Height = 13
        AutoSize = False
        Caption = #20934#22791#23601#32490'...'
      end
      object grpOption: TGroupBox
        Left = 0
        Top = 0
        Width = 744
        Height = 107
        Align = alTop
        Caption = #35774#32622
        TabOrder = 0
        object lblDomain: TLabel
          Left = 11
          Top = 21
          Width = 36
          Height = 13
          Caption = #22495#21517#65306
        end
        object lblTCount: TLabel
          Left = 11
          Top = 54
          Width = 36
          Height = 13
          Caption = #32447#31243#65306
        end
        object lblTimeout: TLabel
          Left = 11
          Top = 80
          Width = 36
          Height = 13
          Caption = #36229#26102#65306
        end
        object lblUA: TLabel
          Left = 209
          Top = 54
          Width = 67
          Height = 13
          Caption = 'User-Agent'#65306
        end
        object lblTCountInfo: TLabel
          Left = 132
          Top = 55
          Width = 72
          Height = 13
          Caption = #24314#35758#20540#65288'20'#65289
        end
        object lblTimeoutinfo: TLabel
          Left = 132
          Top = 81
          Width = 60
          Height = 13
          Caption = #21333#20301#65288#31186#65289
        end
        object edtDomain: TEdit
          Left = 48
          Top = 18
          Width = 512
          Height = 21
          TabOrder = 0
        end
        object btnBegin: TButton
          Left = 570
          Top = 16
          Width = 75
          Height = 25
          Caption = #24320#22987
          Default = True
          TabOrder = 1
          OnClick = btnBeginClick
        end
        object btnEnd: TButton
          Left = 649
          Top = 16
          Width = 75
          Height = 25
          Caption = #20572#27490
          TabOrder = 2
          OnClick = btnEndClick
        end
        object seTCount: TSpinEdit
          Left = 48
          Top = 51
          Width = 81
          Height = 22
          MaxValue = 100
          MinValue = 1
          TabOrder = 3
          Value = 20
        end
        object seTimeout: TSpinEdit
          Left = 48
          Top = 77
          Width = 81
          Height = 22
          MaxValue = 60
          MinValue = 1
          TabOrder = 4
          Value = 3
        end
        object chk200: TCheckBox
          Left = 312
          Top = 78
          Width = 65
          Height = 16
          Caption = #25506#27979'200'
          Checked = True
          State = cbChecked
          TabOrder = 5
        end
        object chk403: TCheckBox
          Left = 378
          Top = 78
          Width = 65
          Height = 16
          Caption = #25506#27979'403'
          TabOrder = 6
        end
        object chk3xx: TCheckBox
          Left = 443
          Top = 78
          Width = 65
          Height = 16
          Caption = #25506#27979'3xx'
          TabOrder = 7
        end
        object edtUA: TEdit
          Left = 278
          Top = 51
          Width = 273
          Height = 21
          TabOrder = 8
          Text = 
            'Mozilla/5.0 (compatible; Baiduspider/2.0; +http://www.baidu.com/' +
            'search/spider.html)'
        end
        object chkCus404: TCheckBox
          Left = 210
          Top = 78
          Width = 74
          Height = 16
          Caption = #33258#23450#20041'404'
          TabOrder = 9
        end
      end
      object lvReport: TListView
        Left = 0
        Top = 126
        Width = 744
        Height = 258
        Align = alBottom
        Columns = <
          item
            Caption = 'ID'
          end
          item
            Caption = #22320#22336
            Width = 590
          end
          item
            Alignment = taCenter
            Caption = 'HTTP'#21709#24212
            Width = 80
          end>
        GridLines = True
        ReadOnly = True
        RowSelect = True
        PopupMenu = pmReport
        TabOrder = 1
        ViewStyle = vsReport
        OnCustomDrawItem = lvReportCustomDrawItem
      end
      object pbStatus: TProgressBar
        Left = 0
        Top = 384
        Width = 744
        Height = 17
        Align = alBottom
        TabOrder = 2
      end
    end
    object TabSheet2: TTabSheet
      Caption = #22495#21517#25195#25551
      ImageIndex = 1
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object Label1: TLabel
        Left = 304
        Top = 128
        Width = 60
        Height = 13
        Caption = #31561#24453#24320#21457'...'
      end
    end
    object ts2: TTabSheet
      Caption = #26049#31449#26597#35810
      ImageIndex = 2
      ExplicitLeft = 0
      ExplicitTop = 0
      ExplicitWidth = 0
      ExplicitHeight = 0
      object lbl4: TLabel
        Left = 296
        Top = 112
        Width = 60
        Height = 13
        Caption = #31561#24453#24320#21457'...'
      end
    end
  end
  object tmrSpeed: TTimer
    OnTimer = tmrSpeedTimer
    Left = 624
    Top = 208
  end
  object pmReport: TPopupMenu
    OnPopup = pmReportPopup
    Left = 656
    Top = 208
    object O1: TMenuItem
      Caption = #25171#24320#36873#20013'(&O)'
      OnClick = O1Click
    end
    object C1: TMenuItem
      Caption = #22797#21046#36873#20013'(&C)'
      OnClick = C1Click
    end
    object N1: TMenuItem
      Caption = '-'
    end
    object S1: TMenuItem
      Caption = #20445#23384#36873#20013'(&S)'
    end
    object A1: TMenuItem
      Caption = #20445#23384#20840#37096'(&A)'
    end
  end
end
