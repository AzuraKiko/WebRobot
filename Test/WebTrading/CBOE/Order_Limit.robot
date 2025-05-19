*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Resource    ../../../Page/WebTrading/LoginPage.robot
Resource    ../../../Page/WebTrading/CBOE/MarketDepthPage.robot
Resource    ../../../Utils/API.robot
Resource    ../../../Page/LoginAdminPortalPage.robot
Resource    ../../../Page/WebTrading/CBOE/OrderLimitPage.robot
Library     JSONSchemaLibrary
Library     ../../../Utils/Common.py
Library     OperatingSystem
Library     Collections
Library     Screenshot


*** Variables ***
${environment}=           equix

#DEV2 TFG
${apiUrlDev}              https://dev2-operator-api.equix.app
${username}               test1@equix.com.au
${password}               Abc@1111
${origin}                 https://dev2.equix.app
${originPortal}           https://portal-${environment}-dev2.equix.app
${version}                v1
${baseUrl}                https://dev2.equix.app/?wlb=${environment}
${baseUrlPortalDev}       https://portal-${environment}-dev2.equix.app/login
${userIDDev}              eq1740025808137
${env}                    ${environment}
*** Test Cases ***
LM-01
    ${token}=   Get token web trading    ${apiUrlDev}    ${username}    ${password}    ${origin}    ${version}    ${env}
    Create Session      mysession1      ${apiUrlDev}/${version}      verify=true
    &{header}=  Create Dictionary      authorization=${token}       environment=${env}
    ${response}=  GET On Session   mysession1   url=/market-info/symbol/${symbol}        headers=${header}
    ${json_response}=  To JSON  ${response.content}
    ${symData}=     Get From Dictionary    ${json_response[0]}    symbol
    Login Happy Cases    ${baseUrl}    ${Browser}    ${username}    ${password}
    Open all order
    Search symbol    9Z9
    Sleep    5s
    Capture Element Screenshot    ${canvas}     filename=${EXECDIR}/Data/image.png
    Extract Text To Csv     Data/image.png       ${EXECDIR}/Data/data.csv
