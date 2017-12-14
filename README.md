Integra��o Delphi

      A Dll da Cappta foi desenvolvida utilizando as melhores pr�ticas de programa��o e desenvolvimento de software. Utilizamos o padr�o COM pensando justamente na integra��o entre aplica��es constru�das em v�rias linguagens. O Delphi tem suporte ao padr�o COM portanto a integra��o ser� simples e f�cil.

Obs: Durante a instala��o do CapptaGpPlus o mesmo encarrega-se de registrar a DLL em seu computador.

Primeira etapa para integra��o.
	A primeira etapa consiste na importa��o do componente (dll) para dentro do projeto. Para isto siga os passos descritos na documenta��o.
	A primeira fun��o a ser utilizada � AutenticarPdv().
	Para autenticar � necess�rio os seguintes dados: CNPJ, PDV e chave de autentica��o, estes dados s�o os mesmos fornecidos durante a instala��o do GP.
Chave: 795180024C04479982560F61B3C2C06E
OBS: aqui utilizamos um xml para guardar os dados de autentica��o
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
        raise Exception.Create('O valor passado na tag <cnpj> n�o tem 14 digitos (use um CNPJ sem pontua��o).');
     if TryStrToInt64(cnpj, valorNumericoCnpj) = false then
        raise Exception.Create('O valor passado na tag <cnpj> n�o � n�merico.');

     PdvNode := BuscarNodeXML(XMLAutenticacao, 'pdv');
     pdv := StrtoIntDef(PdvNode.ChildNodes.First.NodeValue, -1);
     if pdv = -1 then
        raise Exception.Create('O valor passado na tag <pdv> n�o � num�rico.');

     resultadoAutenticacao:= cliente.AutenticarPdv(cnpj, pdv, chaveAutenticacao);

     Case resultadoAutenticacao of
       0 : exit;
       1 : ShowMessage('N�o autorizado. Por favor, realize a autentica��o para utilizar o CapptaGpPlus.');
       2 : ShowMessage('O CapptaGpPlus esta sendo inicializado, tente novamente em alguns instantes.');
       3 : ShowMessage('O formato da requisi��o recebida pelo CapptaGpPlus � inv�lido.');
       4 : ShowMessage('Opera��o cancelada pelo operador.');
       7 : ShowMessage('Ocorreu um erro interno no CapptaGpPlus.');
       8 : ShowMessage('Ocorreu um erro na comunica��o entre a CappAPI e o CapptaGpPlus.');

     end;
     Application.Terminate;
  except on ex : Exception do
     begin
       erro := Format('%s%s%s%s%s',
            ['N�o foi poss�vel carregar o arquivo "autenticacao.xml".',
            sLineBreak,
            sLineBreak,
            'Erro: ',
            ex.Message]);
       ShowMessage(erro);
       Application.Terminate;
     end;
  end;
end;
O resultado para autentica��o com sucesso �: 0

Primeiro esfor�o.
	Toda vez que realizar uma a��o com o GP, vai perceber que ele come�a a exibir o c�digo 2 para autentica��o, n�o se preocupe � assim mesmo, para recuperar os estados do GP, vamos direto para a etapa 2.


