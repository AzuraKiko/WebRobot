*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     Collections
Resource    ../../../Utils/API.robot
Resource    ../../../Page/WebTrading/OrderPage.robot
*** Variables ***
${symbolDisplay}                        (//p[contains(@class,'showTitle')])[1]
${market_Analysis}                      //*[@id="mainMenu"]//div[text()='market analysis']
${menuAlert}                            //*[@id="mainMenu"]//div[text()='alerts']
${iconNotice}                           (//div[@class="goldenLayout"]//div[@class="navbar more"]//div)[1]
${tabAlert}                             //span[text()='new alert']
*** Keywords ***
Open alert
    Hover To Element    ${leftHumbergerMenu}
    Hover To Element    ${market_Analysis}
    Click To Element    ${menuAlert}

Open new alert
    Click To Element    ${iconNotice}

Verify new alert screen
    Element Should Be Visible    ${tabAlert}