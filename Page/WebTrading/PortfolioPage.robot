*** Settings ***
Library           SeleniumLibrary
Resource    ../../Utils/CustomKeys.robot
Resource    ../../Locator/OrderLocator.robot

*** Variables ***
${portfolio}                //div[text()='portfolio']
${portfolioHolding}         //div[text()='portfolio (holdings)']
${portfolioSumary}          //div[text()='portfolio Summary']
${inputAcc}                 //input[contains(@id,'searchBoxSelector')]
*** Keywords ***
Open portfolio holding
    Click To Element        ${leftHumbergerMenu}
    Click To Element        ${portfolioHolding}

Input account
    Clear Text By Key Delete    ${inputAcc}
    Input Text To Element    ${inputAcc}    200100