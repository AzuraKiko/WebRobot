*** Settings ***
Library     SeleniumLibrary
Resource    ../../../Locator/OrderLocator.robot
Resource    ../../../Utils/CustomKeys.robot
*** Variables ***
${buttonBuy}        //div[text()='buy']
*** Keywords ***
Enter Button Buy
    Click To Element        ${buttonBuy}
Input symbol
    [Arguments]      ${symbol}          ${company}
    Input Text To Element                      ${inputSearch_Symbol}   ${symbol}
    Click To Element                           ${suggestSymbol}
    Wait Until Page Contains                   ${company}
Click destination
    Click To Element            ${clickDestination}
Verify destination - BESTMKT enable
    Verify element enable       ${clickdestination_BESTMKT}         default

Verify destination CXA enable
    Verify element enable       ${clickdestination_CXA}             default

Verify destination qCXA enable
    Verify element enable       ${clickdestination_qCXA}            default
Verify destination ASX enable
    Verify element enable       ${clickdestination_ASX}             default
Verify destination qASX enable
    Verify element enable       ${clickdestination_qASX}             default

Verify destination AXW enable
    Verify element enable       ${clickdestination_AXW}             default
