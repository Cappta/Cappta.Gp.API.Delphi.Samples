<h1>Integração Delphi</h1>

A Dll da Cappta foi desenvolvida utilizando as melhores práticas de programação e desenvolvimento de software. Utilizamos o padrão COM pensando justamente na integração entre aplicações construídas em várias linguagens. O Delphi tem suporte ao padrão COM portanto a integração será simples e fácil.

Obs: Durante a instalação do CapptaGpPlus o mesmo encarrega-se de registrar a DLL em seu computador.

<h3>Primeira etapa para integração.</h3></br>

 A primeira etapa consiste na importação do componente (dll) para dentro do projeto. Para isto siga os passos descritos na documentação.</br>
	
A primeira função a ser utilizada é **AutenticarPdv()**.</br>
     
Para autenticar é necessário os seguintes dados: CNPJ, PDV e chave de autenticação, estes dados são os mesmos fornecidos durante a instalação do GP.</br>
	
Chave: 795180024C04479982560F61B3C2C06E </br>

OBS: aqui utilizamos um xml para guardar os dados de autenticação

```javascript
procedure TForm1.AutenticarPdv(cliente: IClienteCappta);
var
  XMLAutenticacao: TXMLDocument;
  ChaveAutenticacaoNode: IXMLNode;
  CnpjNode: IXMLNode;
  PdvNode: IXMLNode;
  erro: string;
  resultadoAutenticacao: integer;
  valorNumericoCnpj: Int64;
begin
  try
     XMLAutenticacao := TXMLDocument.Create(Self);
     XMLAutenticacao.LoadFromFile('autenticacao.xml');

     ChaveAutenticacaoNode :=  BuscarNodeXML(XMLAutenticacao, 'chaveAutenticacao');
     chaveAutenticacao := ChaveAutenticacaoNode.ChildNodes.First.NodeValue;

     CnpjNode := BuscarNodeXML(XMLAutenticacao, 'cnpj');
     cnpj := CnpjNode.ChildNodes.First.NodeValue;
     if Length(cnpj) <> 14 then
        raise Exception.Create('O valor passado na tag <cnpj> não tem 14 digitos (use um CNPJ sem pontuação).');
     if TryStrToInt64(cnpj, valorNumericoCnpj) = false then
        raise Exception.Create('O valor passado na tag <cnpj> não é númerico.');

     PdvNode := BuscarNodeXML(XMLAutenticacao, 'pdv');
     pdv := StrtoIntDef(PdvNode.ChildNodes.First.NodeValue, -1);
     if pdv = -1 then
        raise Exception.Create('O valor passado na tag <pdv> não é numérico.');

     resultadoAutenticacao:= cliente.AutenticarPdv(cnpj, pdv, chaveAutenticacao);

     Case resultadoAutenticacao of
       0 : exit;
       1 : ShowMessage('Não autorizado. Por favor, realize a autenticação para utilizar o CapptaGpPlus.');
       2 : ShowMessage('O CapptaGpPlus esta sendo inicializado, tente novamente em alguns instantes.');
       3 : ShowMessage('O formato da requisição recebida pelo CapptaGpPlus é inválido.');
       4 : ShowMessage('Operação cancelada pelo operador.');
       7 : ShowMessage('Ocorreu um erro interno no CapptaGpPlus.');
       8 : ShowMessage('Ocorreu um erro na comunicação entre a CappAPI e o CapptaGpPlus.');

     end;
     Application.Terminate;
  except on ex : Exception do
     begin
       erro := Format('%s%s%s%s%s',
            ['Não foi possível carregar o arquivo "autenticacao.xml".',
            sLineBreak,
            sLineBreak,
            'Erro: ',
            ex.Message]);
       ShowMessage(erro);
       Application.Terminate;
     end;
  end;
end;
```
O resultado para autenticação com sucesso é: 0

<h1>Primeiro esforço.</h1>
	Toda vez que realizar uma ação com o GP, vai perceber que ele começa a exibir o código 2 para autenticação, não se preocupe é assim mesmo, para recuperar os estados do GP, vamos direto para a etapa 3.

<h1> Etapa 2 </h1>

Temos duas formas de integração, a visivel, onde a interação com o usuário fica por conta da Cappta, e a invisivel onde o form pode ser personalizado.
![Cappta](documents/EscolhaDoTipoDeParcelamento.png)

<h3>Para configurar o modo de integração</h3>

```javascript
procedure TForm1.ConfigurarModoIntegracao(exibirInterface: boolean);
var
    configs: Configuracoes;
begin
     configs := CoConfiguracoes.Create;
     configs.ExibirInterface := exibirInterface;
     cliente.Configurar(configs);
end;
```

<h1>Etapa 3</h1>

Conforme mencionado acima a Iteração Tef é muito importante para o perfeito funcionamento da integração, toda as ações de venda e administrativas passam por esta função. 

```javascript
procedure TForm1.IterarOperacaoTef();
var
  iteracaoTef: IIteracaoTef;
begin
  if RadioButtonUsarMultiTef.Enabled then DesabilitarControlesMultiTef();
  DesabilitarBotoes();

  Repeat

    iteracaoTef := cliente.IterarOperacaoTef();

    if Supports(iteracaoTef, IMensagem) then
    begin
       ExibirMensagem(iteracaoTef as IMensagem);
       Sleep(INTERVALO_MILISEGUNDOS);
    end;

    if Supports(iteracaoTef, IRequisicaoParametro) then RequisitarParametros(iteracaoTef as IRequisicaoParametro);
    if Supports(iteracaoTef, IRespostaTransacaoPendente) then ResolverTransacaoPendente(iteracaoTef as IRespostaTransacaoPendente);

    if Supports(iteracaoTef, IRespostaOperacaoRecusada) then ExibirDadosOperacaoRecusada(iteracaoTef as IRespostaOperacaoRecusada);
    if Supports(iteracaoTef, IRespostaOperacaoAprovada) then
    begin
       ExibirDadosOperacaoAprovada(iteracaoTef as IRespostaOperacaoAprovada);
       FinalizarPagamento();
    end;

    Until OperacaoNaoFinalizada(iteracaoTef) = false;

  if (sessaoMultiTefEmAndamento = false) then HabilitarControlesMultiTef();
  HabilitarBotoes();
end;
```

Dentro de IterarOperacaoTef() temos alguns métodos:

<h3>Requisitar Parametros</h3>


```javascript
procedure TForm1.RequisitarParametros(requisicaoParametros: IRequisicaoParametro);
var
  parametro: string;
  mensagemConvertida: string;
  acao: Int32;
begin
    mensagemConvertida := AnsiToUtf8(requisicaoParametros.Mensagem);
    parametro := InputBox('Sample API COM', mensagemConvertida, '');

    if Length(parametro) = 0 then
    begin
       acao := 2;
       parametro := ' ';
    end
    else begin acao := 1; end;

    cliente.EnviarParametro(parametro, acao);
end;

```


<h3>Resolver Transacao Pendente</h3>

```javascript
procedure TForm1.ResolverTransacaoPendente(respostaTransacaoPendente: IRespostaTransacaoPendente);
var
  parametro: string;
  mensagemConvertida: string;
  acao: Int32;
  lowerBound, upperBound, contador: LongInt;
  listaTransacoes: PSafeArray;
  transacaoPendente: ITransacaoPendente;
begin
     mensagemConvertida := AnsiToUtf8(respostaTransacaoPendente.Mensagem);
     listaTransacoes := respostaTransacaoPendente.ListaTransacoesPendentes;

     SafeArrayGetLBound(listaTransacoes, 1, lowerBound);
     SafeArrayGetUBound(listaTransacoes, 1, upperBound);
     for contador := lowerBound to upperBound do
      begin
           SafeArrayGetElement(listaTransacoes, contador, transacaoPendente);
           mensagemConvertida := Concat(mensagemConvertida, sLineBreak, 'Número de Controle: ', transacaoPendente.numeroControle);
           mensagemConvertida := Concat(mensagemConvertida, sLineBreak, 'Bandeira: ', transacaoPendente.NomeBandeiraCartao);
           mensagemConvertida := Concat(mensagemConvertida, sLineBreak, 'Adquirente: ', transacaoPendente.NomeAdquirente);
           mensagemConvertida := Concat(mensagemConvertida, sLineBreak, 'Valor: ', FloatToStr(transacaoPendente.valor));
           mensagemConvertida := Concat(mensagemConvertida, sLineBreak, 'Data: ', DateTimeToStr(transacaoPendente.DataHoraAutorizacao));
      end;

     parametro := InputBox('Sample API COM', mensagemConvertida, '');

     if Length(parametro) = 0 then
     begin
       acao := 2;
       parametro := ' ';
     end
     else begin acao := 1; end;

    cliente.EnviarParametro(parametro, acao);
end;
```

<h3>Exibir Dados Operacao Aprovada</h3>

```javascript

procedure TForm1.ExibirDadosOperacaoAprovada(resposta: IRespostaOperacaoAprovada);
var mensagemAprovada: string;
begin
    mensagemAprovada := String.Empty;

   if (resposta.CupomCliente <> null) then mensagemAprovada := Format('%s%s',[ConcatenarCupons(mensagemAprovada, resposta.CupomCliente), sLineBreak]);
   if (resposta.CupomLojista <> null) then mensagemAprovada := ConcatenarCupons(mensagemAprovada, resposta.CupomLojista);
   if (resposta.CupomReduzido <> null) then mensagemAprovada := ConcatenarCupons(mensagemAprovada, resposta.CupomReduzido);

   AtualizarResultado(mensagemAprovada);
end;
```

<h3>Finalizar Pagamento</h3>

```javascript
procedure TForm1.FinalizarPagamento();
var botaoSelecionado: Integer;
var mensagem: string;
begin
  if processandoPagamento = false then exit;
  if sessaoMultiTefEmAndamento then
  begin
     botaoSelecionado := 0;
     quantidadeCartoes:= quantidadeCartoes - 1;
     if quantidadeCartoes > 0 then exit;
  end;

  mensagem := GerarMensagemTransacaoAprovada;

  processandoPagamento := false;
  sessaoMultiTefEmAndamento := false;
  RadioButtonNaoUsarMultiTef.Checked := True;

  botaoSelecionado := MessageDlg(mensagem, mtConfirmation, mbOKCancel, 0);
  if botaoSelecionado = mrOK then cliente.ConfirmarPagamentos()
  else cliente.DesfazerPagamentos();

end;
```

<h1>Etapa 4</h1>

Parabéns agora falta pouco, lembrando que a qualquer momento você pode entrar em contato com a equipe tecnica.

Tel: (11) 4302-6179.

Por se tratar de um ambiente de testes, pode ser utilizado cartões reais para as transações, não sera cobrado nada em sua fatura. Se precisar pode utilizar os cartões presentes em nosso [roteiro de teste](http://docs.desktop.cappta.com.br/docs/portf%C3%B3lio-de-cart%C3%B5es-de-testes). Lembrando que vendas digitadas é permitido apenas para a modalidade crédito.

Vamos para a elaboração dos metodos para pagamento.

O primeiro é pagamento débito, o mais simples.

```javascript
procedure TForm1.ButtonExecutarDebitoClick(Sender: TObject);
var
  valor: double;
  exibirInterface: boolean;
  configs: Configuracoes;
begin

  valor := StrToFloat(TEditValorPagamentoDebito.Text);

  if DeveIniciarMultiCartoes() then
  begin
     IniciarMultiCartoes();
  end;

  cliente.PagamentoDebito(valor);

  processandoPagamento := true;
  IterarOperacaoTef();
end;
```
<h3>Agora pagamento credito:</h3>

```javascript
procedure TForm1.ButtonExecutarCreditoClick(Sender: TObject);
var
  detalhes: DetalhesCredito;
  quantidadeParcelas: integer;
  tipoParcelamento: integer;
  transacaoParcelada: boolean;
  valor: double;
begin
  quantidadeParcelas := Trunc(FloatSpinEditQuantidadeParcelasPagamentoCredito.Value);
  tipoParcelamento := ComboBoxTipoParcelamentoPagamentoCredito.ItemIndex + 1;
  transacaoParcelada := RadioButtonPagamentoCreditoComParcelas.Checked;
  valor := StrToFloat(TEditValorPagamentoCredito.Text);

  detalhes := CoDetalhesCredito.Create;
  detalhes.QuantidadeParcelas := quantidadeParcelas;
  detalhes.TransacaoParcelada := transacaoParcelada;
  detalhes.TipoParcelamento := tipoParcelamento;

  if (DeveIniciarMultiCartoes()) then
  begin
     IniciarMultiCartoes();
  end;

  cliente.PagamentoCredito(valor, detalhes);

  processandoPagamento := true;
  IterarOperacaoTef();

end;
```

<h3>Crediário </h3>

```javascript
procedure TForm1.ButtonExecutarCrediarioClick(Sender: TObject);
var
  detalhes: DetalhesCrediario;
  quantidadeParcelas: integer;
  valor: double;
begin
  quantidadeParcelas := Trunc(FloatSpinEditQuantidadeParcelasPagamentoCrediario.Value);
  valor := StrToFloat(TEditValorPagamentoCrediario.Text);

  detalhes := CoDetalhesCrediario.Create;
  detalhes.QuantidadeParcelas := quantidadeParcelas;

  if (DeveIniciarMultiCartoes()) then
  begin
     IniciarMultiCartoes();
  end;

  cliente.PagamentoCrediario(valor, detalhes);

  processandoPagamento := true;
  IterarOperacaoTef();
end;
```

<h1>Etapa 5 </h1>

**Funções** **administrativas**

Agora que tratamos as formas de pagamento, podemos partir para as funções administrativas. 

Clientes com frequência pedem a reimpressão de um comprovante ou um cancelamento, as funções administrativas tem a função de deixar praticas e acessiveis estas funções.

<h3>Para reimpressão </h3>
Temos as seguintes formas: 

*Reimpressão por número de controle
*Reimpressão cupom lojista
*Reimpressão cupom cliente
*Reimpressão de todas as vias

```javascript
procedure TForm1.ButtonExecutarReimpressaoClick(Sender: TObject);
var
  reimprimirUltimoCupom: boolean;
  numeroControle: string;
begin
  if sessaoMultiTefEmAndamento = true then
  begin
     CriarMensagemErro('Não é possível reimprimir um cupom com uma sessão multitef em andamento.'); exit;
  end;

  reimprimirUltimoCupom := RadioButtonReimprimirUltimoCupom.Checked;

  if (reimprimirUltimoCupom) then
  begin
     cliente.ReimprimirUltimoCupom(tipoVia)
  end
  else
  begin
       numeroControle := FormatarNumeroControle(StrToInt64(TextEditNumeroControleReimpressaoCupom.Text));
       cliente.ReimprimirCupom(numeroControle, tipoVia);
  end;

  processandoPagamento := false;
  IterarOperacaoTef();
end;
```

<h3>Para Cancelamento </h3>

Para cancelar uma transação é preciso do número de controle e da senha administrativa, esta senha é configurável no Pinpad e por padrão é: **cappta**.  O número de controle é informado na resposta da operação aprovada.

```javascript
procedure TForm1.ButtonExecutarCancelamentoClick(Sender: TObject);
var
  numeroControle: string;
  senhaAdministrativa: string;
begin
  if sessaoMultiTefEmAndamento = true then
  begin
     CriarMensagemErro('Não é possível cancelar um pagamento com uma sessão multitef em andamento.'); exit;
  end;

  numeroControle := FormatarNumeroControle(StrToInt64(TextEditNumeroControleCancelamento.Text));
  senhaAdministrativa:= EditSenhaAdministrativaCancelamento.Text;

  if Length(senhaAdministrativa) = 0 then
  begin
     CriarMensagemErro('A senha administrativa não pode ser vazia.');
     exit;
  end;

  cliente.CancelarPagamento(senhaAdministrativa, numeroControle);

  processandoPagamento := false;
  IterarOperacaoTef();
end;
```
<h1> Etapa 6 </h1>

Agora que ja fizemos 80% da integração precisamos trabalhar no Multicartões.

Multicartões ou MultiTef é uma forma de passar mais de um cartão em uma transação, nossa forma de realizar esta tarefa é diferente, se cancelarmos uma venda no meio de uma transação multtef todas são canceladas.

```javascript
procedure TForm1.IniciarMultiCartoes();
begin
  quantidadeCartoes:= Trunc(FloatSpinEditQuantidadeDePagamentosMultiTef.Value);
  sessaoMultiTefEmAndamento:= true;
  cliente.IniciarMultiCartoes(quantidadeCartoes);
end;
```

Para o código completo basta clonar o repositório, qualquer dúvida entre em contato com o time de homologação e parceria Cappta.
Quando completar a integração basta acessar nossa documentação e seguir os passos do nosso [roteiro](http://docs.desktop.cappta.com.br/docs). 
