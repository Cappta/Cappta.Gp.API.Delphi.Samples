object Form1: TForm1
  Left = 0
  Top = 0
  Caption = 'Form1'
  ClientHeight = 502
  ClientWidth = 1162
  Color = clBtnFace
  Constraints.MinHeight = 541
  Constraints.MinWidth = 1178
  Font.Charset = DEFAULT_CHARSET
  Font.Color = clWindowText
  Font.Height = -11
  Font.Name = 'Tahoma'
  Font.Style = []
  OldCreateOrder = False
  OnCreate = FormCreate
  DesignSize = (
    1162
    502)
  PixelsPerInch = 96
  TextHeight = 13
  object LabelUsarMultiTef: TLabel
    Left = 8
    Top = 8
    Width = 102
    Height = 19
    Caption = 'Usar MultiTef?'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object LabelQuantidadeDePagamentosMultiTef: TLabel
    Left = 304
    Top = 8
    Width = 200
    Height = 19
    Caption = 'Quantidade de pagamentos:'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
  end
  object PageControlPrincipal: TPageControl
    Left = 8
    Top = 40
    Width = 721
    Height = 454
    ActivePage = TabSheet2
    Anchors = [akLeft, akTop, akBottom]
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 0
    object TabSheetPagamentoDebito: TTabSheet
      Caption = 'Pagamento D'#233'bito'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      object LabelValorPagamentoDebito: TLabel
        Left = 24
        Top = 24
        Width = 43
        Height = 19
        Caption = 'Valor:'
        Font.Charset = DEFAULT_CHARSET
        Font.Color = clWindowText
        Font.Height = -16
        Font.Name = 'Tahoma'
        Font.Style = []
        ParentFont = False
      end
      object ButtonExecutarDebito: TButton
        Left = 510
        Top = 366
        Width = 198
        Height = 49
        Caption = 'Executar Opera'#231#227'o'
        TabOrder = 0
        OnClick = ButtonExecutarDebitoClick
      end
      object TEditValorPagamentoDebito: TMaskEdit
        Left = 40
        Top = 49
        Width = 120
        Height = 27
        EditMask = '########,##;1;_'
        MaxLength = 11
        TabOrder = 1
        Text = '        ,  '
      end
    end
    object TabSheetPagamentoCredito: TTabSheet
      Caption = 'Pagamento Cr'#233'dito'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 1
      ParentFont = False
      object LabelValorPagamentoCredito: TLabel
        Left = 24
        Top = 24
        Width = 43
        Height = 19
        Caption = 'Valor:'
      end
      object LabelPagamentoCreditoComParcelas: TLabel
        Left = 24
        Top = 89
        Width = 152
        Height = 19
        Caption = 'Transa'#231#227'o Parcelada?'
      end
      object LabelTipoParcelamentoPagamentoCredito: TLabel
        Left = 24
        Top = 152
        Width = 160
        Height = 19
        Caption = 'Tipo de Parcelamento:'
      end
      object LabelQuantidadeParcelasPagamentoCredito: TLabel
        Left = 24
        Top = 232
        Width = 171
        Height = 19
        Caption = 'Quantidade de parcelas:'
      end
      object RadioButtonPagamentoCreditoComParcelas: TRadioButton
        Left = 40
        Top = 115
        Width = 49
        Height = 17
        Caption = 'Sim'
        TabOrder = 0
        OnClick = RadioButtonPagamentoCreditoComParcelasClick
      end
      object RadioButtonPagamentoCreditoSemParcelas: TRadioButton
        Left = 116
        Top = 115
        Width = 49
        Height = 17
        Caption = 'N'#227'o'
        Checked = True
        TabOrder = 1
        TabStop = True
        OnClick = RadioButtonPagamentoCreditoSemParcelasClick
      end
      object ComboBoxTipoParcelamentoPagamentoCredito: TComboBox
        Left = 40
        Top = 184
        Width = 188
        Height = 27
        ItemIndex = 0
        TabOrder = 2
        Text = 'Administra'#231#227'o'
        Items.Strings = (
          'Administra'#231#227'o'
          'Loja')
      end
      object FloatSpinEditQuantidadeParcelasPagamentoCredito: TSpinEdit
        Left = 40
        Top = 265
        Width = 121
        Height = 29
        MaxValue = 99
        MinValue = 0
        TabOrder = 3
        Value = 0
      end
      object ButtonExecutarCredito: TButton
        Left = 512
        Top = 368
        Width = 198
        Height = 49
        Caption = 'Executar Opera'#231#227'o'
        TabOrder = 4
        OnClick = ButtonExecutarCreditoClick
      end
      object TEditValorPagamentoCredito: TMaskEdit
        Left = 40
        Top = 49
        Width = 120
        Height = 27
        EditMask = '########,##;1;_'
        MaxLength = 11
        TabOrder = 5
        Text = '        ,  '
      end
    end
    object TabSheetPagamentoCrediario: TTabSheet
      Caption = 'Pagamento Credi'#225'rio'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 2
      ParentFont = False
      object LabelValorPagamentoCrediario: TLabel
        Left = 24
        Top = 24
        Width = 43
        Height = 19
        Caption = 'Valor:'
      end
      object LabelQuantidadeParcelasPagamentoCrediario: TLabel
        Left = 24
        Top = 96
        Width = 171
        Height = 19
        Caption = 'Quantidade de parcelas:'
      end
      object FloatSpinEditQuantidadeParcelasPagamentoCrediario: TSpinEdit
        Left = 40
        Top = 121
        Width = 121
        Height = 29
        MaxValue = 99
        MinValue = 0
        TabOrder = 0
        Value = 0
      end
      object ButtonExecutarCrediario: TButton
        Left = 512
        Top = 368
        Width = 198
        Height = 49
        Caption = 'Executar Opera'#231#227'o'
        TabOrder = 1
        OnClick = ButtonExecutarCrediarioClick
      end
      object TEditValorPagamentoCrediario: TMaskEdit
        Left = 40
        Top = 49
        Width = 120
        Height = 27
        EditMask = '########,##;1;_'
        MaxLength = 11
        TabOrder = 2
        Text = '        ,  '
      end
    end
    object TabSheetReimpressaoCupom: TTabSheet
      Caption = 'Reimpress'#227'o'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 3
      ParentFont = False
      object LabelNumeroControleReimpressaoCupom: TLabel
        Left = 24
        Top = 98
        Width = 150
        Height = 19
        Caption = 'N'#250'mero de Controle:'
        Visible = False
      end
      object LabelReimprimirUltimoCupom: TLabel
        Left = 24
        Top = 24
        Width = 187
        Height = 19
        Caption = 'Reimprimir '#218'ltimo Cupom'
      end
      object RadioButtonReimprimirUltimoCupom: TRadioButton
        Left = 40
        Top = 49
        Width = 58
        Height = 17
        Caption = 'Sim'
        TabOrder = 0
        OnClick = RadioButtonReimprimirUltimoCupomClick
      end
      object RadioButtonNaoReimprimirUltimoCupom: TRadioButton
        Left = 128
        Top = 49
        Width = 113
        Height = 17
        Caption = 'N'#227'o'
        TabOrder = 1
        OnClick = RadioButtonNaoReimprimirUltimoCupomClick
      end
      object TextEditNumeroControleReimpressaoCupom: TEdit
        Left = 40
        Top = 123
        Width = 197
        Height = 27
        NumbersOnly = True
        TabOrder = 2
        Visible = False
      end
      object ButtonExecutarReimpressao: TButton
        AlignWithMargins = True
        Left = 512
        Top = 368
        Width = 198
        Height = 49
        Margins.Left = 10
        Margins.Top = 10
        Margins.Right = 10
        Margins.Bottom = 10
        Caption = 'Executar Opera'#231#227'o'
        TabOrder = 3
        OnClick = ButtonExecutarReimpressaoClick
      end
      object PanelViaASerImprimida: TGroupBox
        Left = 352
        Top = 24
        Width = 285
        Height = 126
        Caption = 'Qual via?'
        TabOrder = 4
        object RadioButtonReimprimirTodasVias: TRadioButton
          Left = 28
          Top = 53
          Width = 69
          Height = 25
          Caption = 'Todas'
          Checked = True
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 0
          TabStop = True
          OnClick = RadioButtonReimprimirTodasViasClick
        end
        object RadioButtonReimprimirViaCliente: TRadioButton
          Left = 201
          Top = 53
          Width = 81
          Height = 23
          Caption = 'Cliente'
          Color = clBtnFace
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentColor = False
          ParentFont = False
          TabOrder = 1
          OnClick = RadioButtonReimprimirViaClienteClick
        end
        object RadioButtonReimprimirViaLoja: TRadioButton
          Left = 126
          Top = 53
          Width = 53
          Height = 25
          Caption = 'Loja'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -16
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          OnClick = RadioButtonReimprimirViaLojaClick
        end
      end
    end
    object TabSheetCancelamento: TTabSheet
      Caption = 'Cancelamento'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 4
      ParentFont = False
      object LabelSenhaAdministrativaCancelamento: TLabel
        Left = 24
        Top = 24
        Width = 156
        Height = 19
        Caption = 'Senha Administrativa:'
      end
      object LabelNumeroControleCancelamento: TLabel
        Left = 24
        Top = 88
        Width = 150
        Height = 19
        Caption = 'N'#250'mero de Controle:'
      end
      object EditSenhaAdministrativaCancelamento: TEdit
        Left = 40
        Top = 49
        Width = 201
        Height = 27
        TabOrder = 0
        Text = 'cappta'
      end
      object TextEditNumeroControleCancelamento: TEdit
        Left = 40
        Top = 113
        Width = 201
        Height = 27
        NumbersOnly = True
        TabOrder = 1
      end
      object ButtonExecutarCancelamento: TButton
        Left = 512
        Top = 368
        Width = 198
        Height = 49
        Caption = 'Executar Opera'#231#227'o'
        TabOrder = 2
        OnClick = ButtonExecutarCancelamentoClick
      end
    end
    object TabSheet1: TTabSheet
      Caption = 'Pinpad'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 6
      ParentFont = False
      object LabelTipoEntradaPinpad: TLabel
        Left = 24
        Top = 24
        Width = 171
        Height = 19
        Caption = 'Tipo de entrada pinpad:'
        Color = clBtnFace
        ParentColor = False
      end
      object ComboBoxTipoInformacaoPinpad: TComboBox
        Left = 40
        Top = 56
        Width = 110
        Height = 27
        ItemIndex = 0
        TabOrder = 0
        Text = 'Cpf'
        Items.Strings = (
          'Cpf'
          'Telefone'
          'Senha')
      end
      object ButtonSolicitarInformacaoPinpad: TButton
        Left = 512
        Top = 368
        Width = 198
        Height = 49
        Caption = 'Executar Operacao'
        TabOrder = 1
        OnClick = ButtonSolicitarInformacaoPinpadClick
      end
    end
    object TabSheetTicketCar: TTabSheet
      Caption = 'TicketCar'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ImageIndex = 7
      ParentFont = False
      object LabelValorPagamentoTicketCar: TLabel
        Left = 24
        Top = 24
        Width = 43
        Height = 19
        Caption = 'Valor:'
        Color = clBtnFace
        ParentColor = False
      end
      object LabelNumeroSerialPagamentoTicketCar: TLabel
        Left = 24
        Top = 96
        Width = 180
        Height = 19
        Caption = 'N'#250'mero de S'#233'rie do ECF:'
        Color = clBtnFace
        ParentColor = False
      end
      object LabelNumeroDocumentoFiscalPagamentoTicketCar: TLabel
        Left = 24
        Top = 162
        Width = 143
        Height = 19
        Caption = 'N'#250'mero Doc. Fiscal:'
        Color = clBtnFace
        ParentColor = False
      end
      object EditNumeroSerialTicketCar: TEdit
        Left = 40
        Top = 129
        Width = 205
        Height = 27
        TabOrder = 0
      end
      object EditNumeroDocumentoFiscalTicketCar: TEdit
        Left = 40
        Top = 187
        Width = 205
        Height = 27
        TabOrder = 1
      end
      object ButtonExecutarPagamentoTicketCar: TButton
        Left = 512
        Top = 368
        Width = 198
        Height = 49
        Caption = 'Executar Opera'#231#227'o'
        TabOrder = 2
        OnClick = ButtonExecutarPagamentoTicketCarClick
      end
      object TEditValorPagamentoTicketCar: TMaskEdit
        Left = 40
        Top = 49
        Width = 120
        Height = 27
        EditMask = '########,##;1;_'
        MaxLength = 11
        TabOrder = 3
        Text = '        ,  '
      end
    end
    object TabSheet2: TTabSheet
      Caption = 'Pr'#233' Autoriza'#231#227'o'
      ImageIndex = 7
      object GroupBox1: TGroupBox
        Left = 24
        Top = 48
        Width = 641
        Height = 129
        Caption = 'Criar Pr'#233' Autoriza'#231#227'o de Cr'#233'dito'
        TabOrder = 0
        object Label1: TLabel
          Left = 32
          Top = 39
          Width = 37
          Height = 19
          Caption = 'Valor'
        end
        object CriarPreAutorizacaoValor: TEdit
          Left = 32
          Top = 72
          Width = 153
          Height = 27
          TabOrder = 0
          Text = '0,10'
        end
        object CriarPreAutorizacao: TButton
          Left = 500
          Top = 32
          Width = 125
          Height = 81
          Caption = 'Criar Pr'#233' Autoriza'#231#227'o'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 1
          WordWrap = True
          OnClick = CriarPreAutorizacaoClick
        end
      end
      object GroupBox2: TGroupBox
        Left = 24
        Top = 208
        Width = 641
        Height = 137
        Caption = 'Capturar Pr'#233' Autoriza'#231#227'o de Cr'#233'dito'
        TabOrder = 1
        object Label2: TLabel
          Left = 32
          Top = 48
          Width = 60
          Height = 19
          Caption = 'Controle'
        end
        object Label3: TLabel
          Left = 216
          Top = 48
          Width = 37
          Height = 19
          Caption = 'Valor'
        end
        object CapturarPreAutorizacaoControle: TEdit
          Left = 32
          Top = 80
          Width = 153
          Height = 27
          TabOrder = 0
        end
        object CapturarPreAutorizacaoValor: TEdit
          Left = 216
          Top = 80
          Width = 129
          Height = 27
          TabOrder = 1
          Text = '0,10'
        end
        object CapturarPreAutorizacao: TButton
          Left = 500
          Top = 32
          Width = 125
          Height = 89
          Caption = 'Capturar Pr'#233' Autorizacao'
          Font.Charset = DEFAULT_CHARSET
          Font.Color = clWindowText
          Font.Height = -13
          Font.Name = 'Tahoma'
          Font.Style = []
          ParentFont = False
          TabOrder = 2
          WordWrap = True
          OnClick = CapturarPreAutorizacaoClick
        end
      end
    end
  end
  object RadioButtonUsarMultiTef: TRadioButton
    Left = 128
    Top = 8
    Width = 57
    Height = 17
    Caption = 'Sim'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 1
    OnClick = OnRadioButtonUsarMultiTefClick
  end
  object RadioButtonNaoUsarMultiTef: TRadioButton
    Left = 191
    Top = 8
    Width = 49
    Height = 17
    Caption = 'N'#227'o'
    Checked = True
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 2
    TabStop = True
    OnClick = OnRadioButtonNaoUsarMultiTefClick
  end
  object FloatSpinEditQuantidadeDePagamentosMultiTef: TSpinEdit
    Left = 536
    Top = 5
    Width = 121
    Height = 29
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    MaxValue = 9
    MinValue = 2
    ParentFont = False
    TabOrder = 3
    Value = 2
  end
  object GroupBoxResultado: TGroupBox
    Left = 735
    Top = 40
    Width = 419
    Height = 454
    Anchors = [akLeft, akTop, akRight, akBottom]
    Caption = 'Resultado'
    Font.Charset = DEFAULT_CHARSET
    Font.Color = clWindowText
    Font.Height = -16
    Font.Name = 'Tahoma'
    Font.Style = []
    ParentFont = False
    TabOrder = 4
    DesignSize = (
      419
      454)
    object TMemoResultado: TMemo
      Left = 8
      Top = 30
      Width = 402
      Height = 411
      Margins.Left = 10
      Margins.Top = 10
      Margins.Right = 10
      Margins.Bottom = 10
      Anchors = [akLeft, akTop, akRight, akBottom]
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Courier New'
      Font.Style = []
      Lines.Strings = (
        'TMemoResultado')
      ParentFont = False
      ReadOnly = True
      ScrollBars = ssVertical
      TabOrder = 0
    end
  end
  object PanelExibirInterface: TPanel
    Left = 735
    Top = 5
    Width = 419
    Height = 29
    Anchors = [akTop, akRight]
    TabOrder = 5
    object lblConfiguracaoInterface: TLabel
      Left = 5
      Top = 5
      Width = 139
      Height = 19
      Caption = 'Modo de integra'#231#227'o'
      Color = clBtnFace
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -16
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentColor = False
      ParentFont = False
    end
    object RadioButtonInterfaceVisivel: TRadioButton
      Left = 200
      Top = 5
      Width = 113
      Height = 17
      Caption = 'Vis'#237'vel'
      Checked = True
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 0
      TabStop = True
      OnClick = RadioButtonInterfaceVisivelClick
    end
    object RadioButtonInterfaceInvisivel: TRadioButton
      Left = 296
      Top = 5
      Width = 113
      Height = 17
      Caption = 'Invis'#237'vel'
      Font.Charset = DEFAULT_CHARSET
      Font.Color = clWindowText
      Font.Height = -15
      Font.Name = 'Tahoma'
      Font.Style = []
      ParentFont = False
      TabOrder = 1
      OnClick = RadioButtonInterfaceInvisivelClick
    end
  end
end
