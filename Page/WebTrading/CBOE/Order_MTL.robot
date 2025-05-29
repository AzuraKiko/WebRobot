*** Settings ***
Documentation       Keywords for Market To Limit (MTL) order operations

Library             SeleniumLibrary
Resource            ../../../Locator/OrderLocator.robot
Resource            ../../../Utils/CustomKeys.robot


*** Variables ***
${buttonBuy}    //div[text()='buy']


*** Keywords ***
Enter Button Buy
    [Documentation]    Clicks the Buy button to start a buy order
    Click To Element    ${buttonBuy}

Input symbol
    [Documentation]    Inputs a trading symbol and verifies company name
    [Arguments]    ${symbol}    ${company}
    Input Text To Element    ${inputSearch_Symbol}    ${symbol}
    Click To Element    ${suggestSymbol}
    Wait Until Page Contains    ${company}

Click destination
    [Documentation]    Clicks the destination dropdown
    Click To Element    ${clickDestination}

Verify destination - BESTMKT enable
    [Documentation]    Verifies if BESTMKT destination is enabled
    Verify element enable    ${clickdestination_BESTMKT}    default

Verify destination CXA enable
    [Documentation]    Verifies if CXA destination is enabled
    Verify element enable    ${clickdestination_CXA}    default

Verify destination qCXA enable
    [Documentation]    Verifies if qCXA destination is enabled
    Verify element enable    ${clickdestination_qCXA}    default

Verify destination ASX enable
    [Documentation]    Verifies if ASX destination is enabled
    Verify element enable    ${clickdestination_ASX}    default

Verify destination qASX enable
    [Documentation]    Verifies if qASX destination is enabled
    Verify element enable    ${clickdestination_qASX}    default

Verify destination AXW enable
    [Documentation]    Verifies if AXW destination is enabled
    Verify element enable    ${clickdestination_AXW}    default
