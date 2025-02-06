object fPrincipal: TfPrincipal
  Left = 0
  Top = 0
  Caption = 'Ocorr'#234'ncias da COVID-19 no Mundo (por pa'#237's)'
  ClientHeight = 441
  ClientWidth = 633
  Color = clBtnFace
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -12
  Font.Name = 'Segoe UI'
  Font.Style = []
  Position = poDesktopCenter
  OnCreate = FormCreate
  TextHeight = 15
  object pnlFiltros: TPanel
    Left = 0
    Top = 0
    Width = 633
    Height = 43
    Align = alTop
    TabOrder = 0
    ExplicitWidth = 666
    DesignSize = (
      633
      43)
    object Label1: TLabel
      Left = 6
      Top = 14
      Width = 77
      Height = 15
      Caption = 'Nome do Pa'#237's:'
    end
    object Label2: TLabel
      Left = 350
      Top = 14
      Width = 67
      Height = 15
      Caption = 'Ordenar por:'
    end
    object edtNomePais: TEdit
      Left = 86
      Top = 11
      Width = 256
      Height = 23
      Hint = 'Digite o nome do pa'#237's.'
      ParentShowHint = False
      ShowHint = True
      TabOrder = 0
      OnChange = edtNomePaisChange
    end
    object cmbOrdenacao: TComboBox
      Left = 420
      Top = 11
      Width = 115
      Height = 23
      Hint = 'Escolha a ordena'#231#227'o dos dados.'
      Style = csDropDownList
      ItemIndex = 0
      ParentShowHint = False
      ShowHint = True
      TabOrder = 1
      Text = 'Pa'#237's'
      OnSelect = cmbOrdenacaoSelect
      Items.Strings = (
        'Pa'#237's'
        'Confirmados'
        'Mortes'
        'Recuperados')
    end
    object btnAtualizarDados: TBitBtn
      Left = 596
      Top = 9
      Width = 27
      Height = 27
      Hint = 'Atualizar dados da tabela.'
      Anchors = [akRight, akBottom]
      Kind = bkRetry
      NumGlyphs = 2
      ParentShowHint = False
      ShowHint = True
      TabOrder = 2
      OnClick = btnAtualizarDadosClick
      ExplicitLeft = 642
    end
  end
  object pnlGrid: TPanel
    Left = 0
    Top = 43
    Width = 633
    Height = 398
    Align = alClient
    TabOrder = 1
    ExplicitWidth = 666
    object dbgDadosCOVID: TDBGrid
      Left = 1
      Top = 1
      Width = 631
      Height = 396
      Align = alClient
      Options = [dgTitles, dgIndicator, dgColumnResize, dgColLines, dgRowLines, dgRowSelect, dgAlwaysShowSelection, dgConfirmDelete, dgCancelOnExit, dgTitleClick, dgTitleHotTrack]
      TabOrder = 0
      TitleFont.Charset = DEFAULT_CHARSET
      TitleFont.Color = clWindowText
      TitleFont.Height = -12
      TitleFont.Name = 'Segoe UI'
      TitleFont.Style = []
    end
  end
  object ClientDataSet1: TClientDataSet
    Aggregates = <>
    Params = <>
    Left = 368
    Top = 227
    object ClientDataSet1aa: TStringField
      FieldName = 'aa'
      Size = 10
    end
  end
end
