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

${HOST}                     http://localhost:8888/content

*** Keywords ***

#1. Cenário: Post com body válido
Chama a API POST valido
    Create Session      Post_Body    ${HOST}     disable_warnings=1

Faz o Post do arquivo "${FILE_NAME}" com corpo "${BODY}"
    ${RESP}=  Post Request  Post_Body  ${FILE_NAME}   data=${BODY}

    Log     Resposta: ${RESP.status_code}
    Set Test Variable       ${RESP}

Espera retorno "${STATUS_200}" corpo existente
    Should Be Equal As Strings   ${RESP.status_code}     ${STATUS_200}




#2. Cenário: Post com body inválido (vazio)
Chama a API POST invalido
    Create Session      Post_Body_Invalid    ${HOST}     disable_warnings=1

Faz o Post do arquivo em branco "${FILE_NAME_EMPTY}" com corpo "${EMPTY_BODY}"
    ${RESP}=  Post Request  Post_Body_Invalid  ${FILE_NAME_EMPTY}   data=${EMPTY_BODY}

    Log     Resposta: ${RESP.status_code}
    Set Test Variable       ${RESP}

Espera retorno "${STATUS_400}" vazio
    Should Be Equal As Strings   ${RESP.status_code}     ${STATUS_400}




#3. Cenário: Get de arquivo existente
Chama a API POST valido para Get
    Create Session      Post_Body_To_Get    ${HOST}     disable_warnings=1

Faz o Post para get do arquivo "${FILE_NAME}" com corpo "${BODY}"
    ${RESP}=  Post Request  Post_Body_To_Get  ${FILE_NAME}   data=${BODY}

Chama a API Get
    Create Session      Get_Body    ${HOST}     disable_warnings=1

Faz o get do arquivo "${FILE_NAME}"
    ${RESP}=  Get Request  Get_Body  ${FILE_NAME}

    Log     Resposta: ${RESP.text}
    Set Test Variable       ${RESP}

Espera retorno do texto "${RESPONSE_TEXT}"
    Should Be Equal As Strings   ${RESP.text}     ${RESPONSE_TEXT}




#4. Cenário: Get de arquivo inexistente
Chama a API Get unexist
    Create Session      Get_Body_Unexist    ${HOST}     disable_warnings=1

Faz o get do arquivo inexistente "${FILE_NAME_UNEXIST}"
    ${RESP}=  Get Request  Get_Body_Unexist  ${FILE_NAME_UNEXIST}

    Log     Resposta: ${RESP.status_code}
    Set Test Variable       ${RESP}

Espera retorno "${STATUS_404}" para inexistente
    Should Be Equal As Strings   ${RESP.status_code}     ${STATUS_404}


