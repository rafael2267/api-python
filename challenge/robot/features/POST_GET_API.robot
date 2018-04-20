*** Settings ***
Documentation  Consulta api python
Resource    ../keywords/keyword_POST_GET_API.robot

*** Test Cases ***
1. Cenário: Post com body válido
    [Tags]    post
    Chama a API POST válido
    Faz o Post
    Espera retorno 200

2. Cenário: Post com body inválido (vazio)
    [Tags]    post_invalido
    Chama a API POST inválido
    Faz o Post do arquivo em branco
    Espera retorno 400

3. Cenário: Get de arquivo existente
    [Tags]    get
    Chama a API POST válido para Get
    Faz o Post para get
    Chama a API Get
    Faz o get do arquivo
    Espera retorno do texto do arquivo

4. Cenário: Get de arquivo inexistente
    [Tags]    get_inexistente
    Chama a API Get unexist
    Faz o get do arquivo inexistente
    Espera retorno 400 para inexistente