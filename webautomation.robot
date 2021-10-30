*** Settings ***
Documentation            Aqui estarão presentes os teste web do curso prime hero

Library    SeleniumLibrary
Library    FakerLibrary   
Library    String
 
Suite Setup    Abrir Navegador
Suite Teardown     Fechar Navegador


*** Variables ***
${URL}            http://automationpractice.com/index.php
${BROWSER}        chrome

*** Keywords ***
Abrir Navegador
    Open Browser         browser=chrome
    Maximize Browser Window

Fechar Navegador
    Capture Page Screenshot
    Close Browser

Acessar A Pagina Home do Site Automation Practice
    Go to                              ${URL}
    Title Should Be                    My Store
    Wait Until Element Is Visible      id=search_block_top

Digitar o nome do produto "${itemNãoExistente}" no campo de pesquisa
       input text            id=search_query_top            ${itemNãoExistente}


Clicar no botão pesquisar
    Click Element    xpath=//*[@name='submit_search' and @type='submit']    



Conferir se o produto "Blouse" foi listado no site
    Wait Until Element Is Visible            id=center_column
    Title Should Be                           Search - My Store
    Page Should Contain Image                 xpath=//*[@id='center_column']//*[@src='http://automationpractice.com/img/p/7/7-home_default.jpg']

Conferir mensagem "No results were found for your search" "itemNãoExistente"
    Wait Until Element Is Visible    //*[@id="center_column"]/p
    Element Text Should Be    //*[@id="center_column"]/p    No results were found for your search "itemNãoExistente"

 Acessar a página home do site
    Go to                              ${URL}
    Title Should Be                    My Store
    Wait Until Element Is Visible      id=search_block_top
 
 Passar o mouse por cima da categoria "Women" no menu principal superior de categorias
    Mouse Over    //*[@id="block_top_menu"]/ul/li[1]/a
Clicar na sub categoria "Summer Dresses"
    Click Element    //*[@id="block_top_menu"]/ul/li[1]/ul/li[2]/ul/li[3]/a

Conferir se os produtos da sub-categoria "Summer Dresses" foram mostrados na página
    Wait Until Element Is Visible     //*[@id="center_column"]/ul

Quando o cliente acessar a página home do site
    Go to                              ${URL}
    Title Should Be                    My Store
    Wait Until Element Is Visible      id=search_block_top
Clicar em "Sign in"
  Click Element    //*[@id="header"]/div[2]/div/div/nav/div[1]/a

Informar um e-mail válido
    ${EMAIL}    FakerLibrary.Email
    Log To Console    ${EMAIL}
    Input Text    //*[@id="email_create"]   ${EMAIL}
Clicar em "Create an account"
    Double Click Element    //*[@id="SubmitCreate"]/span
Preencher os dados obrigatórios
    
       Wait Until Element Is Visible    //*[@id="customer_firstname"] 
       Input Text       //*[@id="customer_firstname"]   Flavio
       Input Text       //*[@id="customer_lastname"]    pio
       ${EMAIL}                    Get Text    //*[@id="email"]  
       Input Password    //*[@id="passwd"]     12345
       Wait Until Element Is Visible        //*[@id="company"]
       Input Text    //*[@id="firstname"]    vinicius    
       Input Text    //*[@id="lastname"]    henrique
       Input Text    //*[@id="company"]    PauBrasil
      Wait Until Element Is Visible      //*[@id="address1"] 
       ${Address}    FakerLibrary.Mac Address
       Log To Console    ${Address}
       Input Text    //*[@id="address1"]    ${Address}
       ${CITY}        FakerLibrary.City
       Log To Console    ${CITY}
       Input Text    //*[@id="city"]    ${CITY}
       Select From List By Value        //*[@id="id_state"]       2
       ${POSTAL}           FakerLibrary.Postalcode
       Log To Console    ${POSTAL}
        Input Text     //*[@id="postcode"]   ${POSTAL}
       ${NUMBERS}             FakerLibrary.Random Number
       Log To Console    ${NUMBERS}
       Input Text    //*[@id="phone_mobile"]    ${NUMBERS}
       Wait Until Element Is Visible        //*[@id="alias"]
       ${Address}      FakerLibrary.Address
       Log To Console    ${Address}  
       Input Text    //*[@id="alias"]     ${Address}
    
Submeter cadastro
  Click Element       id=submitAccount

Conferir se o cadastro foi efetuado com sucesso
    Wait Until Element Is Visible    //*[@id="my-account"]


*** Test Cases ***

Caso de Teste 01: Pesquisar produto não existente
    Acessar a pagina home do site Automation Practice
    Digitar o nome do produto "itemNãoExistente" no campo de pesquisa
    Clicar no botão pesquisar
    Conferir mensagem "No results were found for your search" "itemNãoExistente"

Caso de Teste 02: Listar Produtos
    Acessar a página home do site
    Passar o mouse por cima da categoria "Women" no menu principal superior de categorias
    Clicar na sub categoria "Summer Dresses"
    Conferir se os produtos da sub-categoria "Summer Dresses" foram mostrados na página

Caso de Teste 03: Adicionar Cliente
    Quando o cliente acessar a página home do site
    Clicar em "Sign in"
    Informar um e-mail válido
    Clicar em "Create an account"
    Preencher os dados obrigatórios
    Submeter cadastro
    Conferir se o cadastro foi efetuado com sucesso

    
