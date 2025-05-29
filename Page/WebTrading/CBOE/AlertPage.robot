*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     Collections
Resource    ../../../Utils/API.robot
Resource    ../../../Page/WebTrading/OrderPage.robot


*** Variables ***
${symbolDisplay}        (//p[contains(@class,'showTitle')])[1]
${market_Analysis}      //*[@id="mainMenu"]//div[text()='market analysis']
${menuAlert}            //*[@id="mainMenu"]//div[text()='alerts']
${iconNotice}           (//div[@class="goldenLayout"]//div[@class="navbar more"]//div)[1]
${tabAlert}             //span[text()='new alert']
${leftHumbergerMenu}    //div[@class="hamburger-menu"]
${alertName}            //input[@placeholder="Alert Name"]
${alertType}            //select[@id="alertType"]
${priceCondition}       //select[@id="priceCondition"]
${priceValue}           //input[@id="priceValue"]
${createAlertButton}    //button[text()='Create Alert']


*** Keywords ***
Open Alert
    [Documentation]    Opens the alert section from the main menu
    Mouse Over    ${leftHumbergerMenu}
    Mouse Over    ${market_Analysis}
    Click Element    ${menuAlert}

Open New Alert
    [Documentation]    Opens the new alert creation screen
    Click Element    ${iconNotice}

Verify New Alert Screen
    [Documentation]    Verifies that the new alert screen is visible
    Element Should Be Visible    ${tabAlert}

Create Price Alert
    [Documentation]    Creates a new price alert with specified parameters
    [Arguments]    ${name}    ${type}    ${condition}    ${price}
    Input Text    ${alertName}    ${name}
    Select From List By Value    ${alertType}    ${type}
    Select From List By Value    ${priceCondition}    ${condition}
    Input Text    ${priceValue}    ${price}
    Click Element    ${createAlertButton}

Verify Alert Created
    [Documentation]    Verifies that the alert was created successfully
    [Arguments]    ${alertName}
    Element Should Be Visible    //div[contains(text(),'${alertName}')]

Delete Alert
    [Documentation]    Deletes an existing alert
    [Arguments]    ${alertName}
    Click Element    //div[contains(text(),'${alertName}')]//following::button[contains(@class,'delete')]
    Handle Alert    ACCEPT
