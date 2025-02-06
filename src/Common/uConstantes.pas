unit uConstantes;

interface

const
  // URL da API de dados da COVID-19
  API_URL = 'https://covid19-brazil-api.vercel.app/api/report/v1/countries';

  // Valor padrão para campos numéricos ausentes
  VALOR_AUSENTE = -1;

  // Mensagens de erro
  ERRO_API = 'Erro ao acessar API. Código: %d';
  ERRO_JSON_INVALIDO = 'Resposta inválida da API.';
  ERRO_ESTRUTURA_JSON = 'Estrutura do JSON inesperada.';

implementation

end.
