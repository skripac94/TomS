object frmPocetna: TfrmPocetna
  Left = 0
  Top = 0
  BorderStyle = bsDialog
  Caption = 'Po'#269'etna'
  ClientHeight = 77
  ClientWidth = 420
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poScreenCenter
  TextHeight = 15
  object lbNaslov: TLabel
    Left = 16
    Top = 8
    Width = 193
    Height = 15
    Caption = 'Testni zadatak za kompaniju Tomsoft'
  end
  object Label1: TLabel
    Left = 16
    Top = 29
    Width = 73
    Height = 15
    Caption = 'Miroslav Riki'#263
  end
  object Button1: TButton
    Left = 296
    Top = 25
    Width = 75
    Height = 25
    Caption = 'Pokreni'
    DisabledImageName = 'btnPokerni'
    TabOrder = 0
    OnClick = Button1Click
  end
end
