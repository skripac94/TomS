object frmPeriodOdDo: TfrmPeriodOdDo
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Izbor perioda'
  ClientHeight = 178
  ClientWidth = 377
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object Label1: TLabel
    Left = 47
    Top = 56
    Width = 83
    Height = 15
    Caption = 'Tip obra'#269'una : *'
  end
  object Label2: TLabel
    Left = 47
    Top = 85
    Width = 72
    Height = 15
    Caption = 'Od Datuma :*'
  end
  object Label3: TLabel
    Left = 47
    Top = 113
    Width = 70
    Height = 15
    Caption = 'Do datuma :*'
  end
  object Label4: TLabel
    Left = 136
    Top = 24
    Width = 147
    Height = 15
    Caption = 'Pregled obra'#269'una u periodu'
  end
  object cbxIzvjestaj: TComboBox
    Left = 136
    Top = 53
    Width = 186
    Height = 23
    Style = csDropDownList
    TabOrder = 0
    TextHint = 'Odaberi vrstu obracuna'
    Items.Strings = (
      'MP Obracun - Placanja'
      'MP Obracun - Artikli')
  end
  object DateTimePicker1: TDateTimePicker
    Left = 136
    Top = 82
    Width = 186
    Height = 23
    Date = 41275.000000000000000000
    Format = 'MM.dd.yyyy'
    Time = 0.815728912035410800
    TabOrder = 1
  end
  object DateTimePicker2: TDateTimePicker
    Left = 136
    Top = 111
    Width = 186
    Height = 23
    Date = 45243.000000000000000000
    Format = 'MM.dd.yyyy'
    Time = 0.815728912035410800
    TabOrder = 2
  end
  object btnPrihvati: TButton
    Left = 232
    Top = 140
    Width = 75
    Height = 25
    Caption = 'Prihvati'
    TabOrder = 3
    OnClick = btnPrihvatiClick
  end
end
