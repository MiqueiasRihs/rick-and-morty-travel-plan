# Milenio Code Challange - Planos de Viagem Rick and Morty

Este projeto consiste em uma API que gerencia planos de viagem interdimensional no universo de Rick and Morty, desenvolvida utilizando as seguintes ferramentas: Crystal, Kemal, ORM Jennifer, GraphQL e Docker. A API implementa métodos HTTP para criar, visualizar, atualizar e excluir planos de viagem, bem como para otimizar e expandir a resposta dessas operações.

## Métodos disponíveis

### POST /travel_plans

Este método recebe um objeto JSON contendo um array de inteiros chamado "travel_stops". Ele cria um novo plano de viagem com esse array e retorna o ID do novo plano de viagem.

### GET /travel_plans

Este método retorna uma lista de todos os planos de viagem armazenados no sistema. Ele também recebe dois parâmetros opcionais chamados "optimize" e "expand" que são usados para otimizar e detalhar a resposta.

### GET /travel_plans/:id

Este método retorna um plano de viagem específico com base em seu ID. Ele também recebe dois parâmetros opcionais chamados "optimize" e "expand" que são usados para otimizar e detalhar a resposta.

### PUT /travel_plans/:id

Este método atualiza um plano de viagem específico com base em seu ID. Ele recebe um objeto JSON contendo um array de inteiros chamado "travel_stops".

### PUT /travel_plans/:id/append

Este método atualiza uma lista de paradas a um plano de viagem específico com base em seu ID. Ele recebe um objeto JSON contendo um array de inteiros chamado "travel_stops".

### DELETE /travel_plans/:id

Este método exclui um plano de viagem específico com base em seu ID.

## Parâmetros opcionais

Os seguintes parâmetros opcionais podem ser incluídos nas solicitações GET que recebem um ID de plano de viagem:

### optimize

Quando recebido, a API deve retornar o array "travel_stops" reordenado para minimizar o número de saltos interdimensionais e organizar as paradas de viagem indo dos locais menos populares aos mais populares. Para fazer isso, todos os locais na mesma dimensão devem ser visitados antes de saltar para um local em outra dimensão. Dentro da mesma dimensão, os locais devem ser visitados em ordem crescente de popularidade e, em caso de empate, em ordem alfabética de nome. A popularidade de um local é calculada somando o número de episódios em que cada residente desse local apareceu.

### expand

Quando recebido, a API deve retornar os detalhes completos sobre as paradas de viagem, incluindo informações sobre cada local visitado.

## Front-End

Existe um simples front-end para esta aplicação na rota raiz. Foi utilizado HTML, CSS, Bootstrap e JavaScript para construí-lo. Eu também tentei extrair as imagens no site do fadom mas por algum motivo as imagens de lá não estava sendo renderizado no meu HTML, sem isso ficou mais complexo trazer as imagens da localizações, mas acredito que o front ficou bem legal e bonito.

## Documentação completa

A documentação completa da API, incluindo exemplos de solicitações e respostas para cada método, pode ser encontrada no arquivo src/docs/v1/api-documentation.md neste repositório e também no endereço  [/docs](localhos:3000/docs).

## Executando o projeto

Para executar o projeto, siga as etapas abaixo:

1. Clone este repositório em sua máquina local
2. Com o Docker instalado, rode o comando `docker-compose up`

O servidor estará disponível em [http://localhost:3000](http://localhost:3000/).

## Testando o projeto

Para testar o projeto, siga as etapas abaixo:

1. Na raiz do prjeto kemal rode o comando `KEMAL_ENV=test crystal spec`

Os testes unitários e de integração serão executados e seus resultados serão exibidos no console.