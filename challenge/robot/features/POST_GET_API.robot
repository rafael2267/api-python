*** Settings ***
Documentation  Consulta api python
Resource    ../keywords/keyword_POST_GET_API.robot

*** Test Cases ***
1. Cenário: Post com body valido
    [Tags]    post
    Chama a API POST valido
    Faz o Post do arquivo "test_file" com corpo "Texto para arquivo"
    Espera retorno "200" corpo existente

2. Cenário: Post com body invalido (vazio)
    [Tags]    post_invalido
    Chama a API POST invalido
    Faz o Post do arquivo em branco "test_file_empty" com corpo ""
    Espera retorno "400" vazio

3. Cenário: Get de arquivo existente
    [Tags]    get
    Chama a API POST valido para Get
    Faz o Post para get do arquivo "test_file_get" com corpo "Texto para get"
    Chama a API Get
    Faz o get do arquivo "test_file_get"
    Espera retorno do texto "Texto para get"

4. Cenário: Get de arquivo inexistente
    [Tags]    get_inexistente
    Chama a API Get unexist
    Faz o get do arquivo inexistente "test_file_unexist"
    Espera retorno "404" para inexistente