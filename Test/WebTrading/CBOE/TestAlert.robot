*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     JSONSchemaLibrary
Library     Collections
Resource    ../../../Utils/API.robot
Resource    ../../../Page/WebTrading/OrderPage.robot
Resource    ../../../Page/WebTrading/LoginPage.robot
Resource    ../../../Page/WebTrading/CBOE/AlertPage.robot

            ${environment}


*** Test Cases ***

