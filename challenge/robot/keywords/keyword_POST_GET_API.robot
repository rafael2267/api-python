*** Settings ***
Documentation       A resource file with reusable keywords and variables.
...                 The system specific keywords created here form our own
...                 domain specific language. They utilize keywords provided
...                 by the imported SeleniumLibrary.
Library             SeleniumLibrary
Library             DebugLibrary
Library             RequestsLibrary
Library             Collections


*** Variables ***

${FILE_NAME}                test_file
${FILE_NAME_EMPTY}          test_file_empty
${FILE_NAME_UNEXIST}        test_file_unexist
${BODY}                     Texto para arquivo
${EMPTY_BODY}
${HOST}                     http://localhost:8888/content
${STATUS_200}               200
${STATUS_400}               400
${STATUS_404}               404
${RESPONSE_TEXT}            Texto para arquivo

*** Keywords ***

#1. Cenário: Post com body válido
Chama a API POST válido
    Create Session      Post_Body    ${HOST}     disable_warnings=1

Faz o Post
    ${RESP}=  Post Request  Post_Body  ${FILE_NAME}   data=${BODY}

    Log     Resposta: ${RESP.status_code}
    Set Test Variable       ${RESP}

Espera retorno 200
    Should Be Equal As Strings   ${RESP.status_code}     ${STATUS_200}




#2. Cenário: Post com body inválido (vazio)
Chama a API POST inválido
    Create Session      Post_Body_Invalid    ${HOST}     disable_warnings=1

Faz o Post do arquivo em branco
    ${RESP}=  Post Request  Post_Body_Invalid  ${FILE_NAME_EMPTY}   data=${EMPTY_BODY}

    Log     Resposta: ${RESP.status_code}
    Set Test Variable       ${RESP}

Espera retorno 400
    Should Be Equal As Strings   ${RESP.status_code}     ${STATUS_400}




#3. Cenário: Get de arquivo existente
Chama a API POST válido para Get
    Create Session      Post_Body_To_Get    ${HOST}     disable_warnings=1

Faz o Post para get
    ${RESP}=  Post Request  Post_Body_To_Get  ${FILE_NAME}   data=${BODY}

Chama a API Get
    Create Session      Get_Body    ${HOST}     disable_warnings=1

Faz o get do arquivo
    ${RESP}=  Get Request  Get_Body  ${FILE_NAME}

    Log     Resposta: ${RESP.text}
    Set Test Variable       ${RESP}

Espera retorno do texto do arquivo
    Should Be Equal As Strings   ${RESP.text}     ${RESPONSE_TEXT}




#4. Cenário: Get de arquivo inexistente
Chama a API Get unexist
    Create Session      Get_Body_Unexist    ${HOST}     disable_warnings=1

Faz o get do arquivo inexistente
    ${RESP}=  Get Request  Get_Body_Unexist  ${FILE_NAME_UNEXIST}

    Log     Resposta: ${RESP.status_code}
    Set Test Variable       ${RESP}

Espera retorno 400 para inexistente
    Should Be Equal As Strings   ${RESP.status_code}     ${STATUS_404}


