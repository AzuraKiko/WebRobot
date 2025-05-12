*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     JSONLibrary
Library     JSONSchemaLibrary
Library     Collections
Resource    ../../../Utils/API.robot
Resource    ../../../Page/WebTrading/OrderPage.robot
Resource    ../../../Page/WebTrading/LoginPage.robot
Resource    ../../../Page/WebTrading/CBOE/AlertPage.robot
*** Variables ***
#DEV2 TFG
${environment}=           equix
${url}                    https://dev2-operator-api.equix.app/${version}
${apiUrlDev}              https://dev2-retail-api.equix.app
${username}               test1@equix.com.au
${password}               Abc@1111
${origin}                 https://dev2.equix.app
${originPortal}           https://portal-${environment}-dev2.equix.app
${version}                v1
${baseUrl}                https://dev2.equix.app/?wlb=${environment}
${baseUrlPortalDev}       https://portal-${environment}-dev2.equix.app/login
${userIDDev}              eq1739184156843
${env}                    ${environment}
*** Test Cases ***

Alert 12
    Login Happy Cases       ${baseUrl}    ${Browser}    ${username}    ${password}
    Open alert







