object frmRadna: TfrmRadna
  Left = 0
  Top = 0
  Caption = 'Radna'
  ClientHeight = 590
  ClientWidth = 934
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Menu = mnuRadni
  Position = poScreenCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlNavigator: TPanel
    Left = 0
    Top = 0
    Width = 934
    Height = 41
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 930
    object btnPretrazi: TButton
      Left = 848
      Top = 7
      Width = 75
      Height = 25
      Caption = 'Pretra'#382'i'
      TabOrder = 0
      OnClick = btnPretraziClick
    end
    object edtPretraga: TEdit
      Left = 8
      Top = 8
      Width = 121
      Height = 23
      TabOrder = 1
      TextHint = 'Unesi parametar'
    end
    object cbxOdZapisa: TComboBox
      Left = 135
      Top = 8
      Width = 74
      Height = 23
      TabOrder = 2
      Text = 'Od zapisa'
      Items.Strings = (
        '1'
        '2'
        '3'
        '4'
        '5'
        '6'
        '7'
        '8'
        '9'
        '10'
        '11'
        '12'
        '13'
        '14'
        '15')
    end
    object cbxBrojZapisa: TComboBox
      Left = 215
      Top = 8
      Width = 90
      Height = 23
      TabOrder = 3
      Text = 'Koliko zapisa'
      Items.Strings = (
        '5'
        '10'
        '20'
        '50'
        '100'
        '200'
        '500')
    end
  end
  object StatusBar1: TStatusBar
    Left = 0
    Top = 571
    Width = 934
    Height = 19
    Panels = <>
    ExplicitTop = 570
    ExplicitWidth = 930
  end
  object DBGrid1: TDBGrid
    Left = 0
    Top = 41
    Width = 934
    Height = 530
    Align = alClient
    DataSource = dsRadni
    TabOrder = 2
    TitleFont.Charset = DEFAULT_CHARSET
    TitleFont.Color = clWindowText
    TitleFont.Height = -12
    TitleFont.Name = 'Segoe UI'
    TitleFont.Style = []
  end
  object mnuRadni: TMainMenu
    Left = 456
    Top = 304
    object Izvjetaji1: TMenuItem
      Caption = 'Izvje'#353'taji'
      object MPobrPlac: TMenuItem
        Caption = 'MP Obra'#269'un'
        OnClick = MPobrPlacClick
      end
    end
  end
  object fdmRadni: TFDMemTable
    FetchOptions.AssignedValues = [evMode]
    FetchOptions.Mode = fmAll
    ResourceOptions.AssignedValues = [rvSilentMode]
    ResourceOptions.SilentMode = True
    UpdateOptions.AssignedValues = [uvCheckRequired, uvAutoCommitUpdates]
    UpdateOptions.CheckRequired = False
    UpdateOptions.AutoCommitUpdates = True
    Left = 184
    Top = 208
  end
  object dsRadni: TDataSource
    DataSet = fdmRadni
    Left = 304
    Top = 296
  end
end
