*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     JSONLibrary
Library     Collections
Resource    ../../../Utils/API.robot
Resource    ../../../Page/WebTrading/OrderPage.robot

*** Variables ***
${menuAllOrder}                        //div[text()='all orders']
${menuOperator}                        //div[text()='operator']
${canvas}                              //div[@class="goldenLayout"]//canvas
*** Keywords ***
Open all order
    Hover To Element    ${leftHumbergerMenu}
    Hover To Element    ${menuOperator}
    Click To Element    ${menuAllOrder}
Search symbol
    [Arguments]     ${text}
    Click To Element        //div[text()='quick filter']/preceding-sibling::input
    Input Text To Element    //div[text()='quick filter']/preceding-sibling::input    ${text}