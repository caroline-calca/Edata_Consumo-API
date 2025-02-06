# 🚀 Projeto: Aplicação Delphi - Consulta de Dados COVID-19

## 📖 Sobre o Projeto
Este projeto é uma aplicação desenvolvida em **Delphi** utilizando o padrão **MVVM**, que consome uma API de dados sobre COVID-19 e exibe as informações de forma estruturada em uma interface visual.

A aplicação permite:
- Listar dados de COVID-19 por país.
- Filtrar os dados pelo nome do país.
- Ordenar os resultados por diferentes critérios.
- Utilizar uma interface organizada e desacoplada do código-fonte.

---

## 🛠️ **Tecnologias Utilizadas**
- **Delphi (VCL)**
- **TClientDataSet** para manipulação dos dados.
- **TNetHTTPClient** para comunicação com a API.
- **JSON (System.JSON)** para manipulação dos dados recebidos.

---

## 📦 **Dependências Necessárias**
Para executar o projeto corretamente, certifique-se de ter:
- **Delphi XE7 ou superior** (pode funcionar em versões anteriores, mas não foi testado).
- **Bibliotecas nativas do Delphi:**
  - `System.Net.HttpClientComponent`
  - `System.JSON`
  - `System.Generics.Collections`
  - `System.Variants`
  - `Data.DB`
  - `Datasnap.DBClient`

---

## 🔧 **Como Configurar e Executar o Projeto**
### 1️⃣ **Clonar o Repositório**
Caso o projeto esteja em um repositório Git, clone com:
```
git clone https://github.com/caroline-calca/Edata_Consumo-API.git
```
Ou baixe os arquivos manualmente.

### 2️⃣ **Abrir o Projeto no Delphi**
Abra o Delphi e carregue o projeto principal.
Certifique-se de que todas as units necessárias estão no caminho correto.

### 3️⃣ **Executar a Aplicação**
Compile e rode o projeto (F9 no Delphi).
A aplicação irá buscar os dados da API e exibi-los na interface.

---

## 🔍 **Estrutura do Projeto**
```
📂 Projeto_Delphi
 ├──📁 exe
 │   ├── # Executável do projeto
 ├──📁 src
 │   ├──📁 Common
 │   │   ├── uConstantes.pas       # Constantes globais usadas no projeto
 │   ├──📁 Factories
 │   │   ├── uDadosCOVIDFactory.pas # Factory para criação do ViewModel
 │   ├──📁 Models
 │   │   ├── uDadosCOVID.pas       # Estrutura dos dados
 │   │   ├── uIDadosCOVID.pas      # Interface para os dados
 │   ├──📁 Services
 │   │   ├── uDadosCOVIDService.pas # Comunicação com a API
 │   │   ├── uIDadosCOVIDService.pas # Interface do Service
 │   ├──📁 ViewModels
 │   │   ├── uDadosCOVIDViewModel.pas # ViewModel (Regras de UI)
 │   │   ├── uIDadosCOVIDViewModel.pas # Interface do ViewModel
 │   ├──📁 Views
 │   │   ├── frmPrincipal.pas/.dfm # Tela principal (VCL)
 ├── README.md   # Instruções do projeto
 └── Projeto.dpr  # Arquivo principal do Delphi
```
---

## 🛠️ **Funcionalidades Implementadas**
- ✅ Consumo de API via TNetHTTPClient.
- ✅ Filtragem automática por nome conforme o usuário digita.
- ✅ Ordenação dinâmica dos dados conforme seleção no ComboBox.
- ✅ Separação de camadas com MVVM para desacoplamento da interface gráfica.
- ✅ Utilização de TList<TCampoDef> para controle dinâmico dos campos.

---

## ⚠️ **Possíveis Problemas e Soluções**
### ❌ **Erro ao carregar os dados**
- ✔️ Verifique sua conexão com a internet.
- ✔️ Confirme se a API https://covid19-brazil-api.vercel.app/api/report/v1/countries está acessível no navegador.
