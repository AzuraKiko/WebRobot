*** Settings ***
Library      SeleniumLibrary
Library      ../../Utils/Common.py
Library      String

Resource     ../../Utils/CustomKeys.robot
Resource     ../../Locator/OrderLocator.robot

*** Keywords ***
Open new Order
    Click To Element                          ${leftHumbergerMenu}
    Click To Element                          ${btnNewOrder}

Input username
    [Arguments]      ${username}
    Input Text To Element                     ${inputSearch_Account}    ${username}
    Click To Element                          ${suggestAccount}

Input etf
    [Arguments]      ${etf}
    Input Text To Element                      ${inputSearch_Symbol}    ${etf}
    Click To Element                           ${clickSearch_etf}

Input mf
    [Arguments]      ${mf}
    Input Text To Element                      ${inputSearch_Symbol}    ${mf}
    Click To Element                          ${clickSearch_mf}

Input warrant
    [Arguments]      ${warrant}
    Input Text To Element                      ${inputSearch_Symbol}     ${warrant}
    Click To Element                          ${clickSearch_warrant}

Input option
    [Arguments]      ${option}
    Input Text To Element                      ${inputSearch_Symbol}    ${option}
    Click To Element                          ${clickSearch_option}

Input equity
    [Arguments]      ${equity}
    Input Text To Element                      ${inputSearch_Symbol}    ${equity}
    Click To Element                          ${clickSearch_equity}

Select Order Type Limit
    Click To Element                          ${clickSelectOderType}
    Click To Element                          ${clickOrderType_LIMIT}

Select Order Type MarketToLimit
    Click To Element                          ${clickSelectOderType}
    Click To Element                          ${clickOrderType_MarketToLimit}

Select Order Type STOPLIMIT
    Click To Element                          ${clickSelectOderType}
    Click To Element                          ${clickOrderTypeSt_StopLimit}

Input Quantity
    [Arguments]    ${quantity}
    Input Text To Element                    ${inputQuantity}    ${quantity}

Input Price
    [Arguments]    ${price}
    Input Text To Element                    ${inputLimitPrice}    ${price}

Input trigger price
    [Arguments]    ${trigger_price}
    Input Text To Element                    ${inputTriggerPrice}    ${trigger_price}

Select Duration GTC
    Click To Element                          ${clickSelectDuration}
    Click To Element                          ${clickSelectDuration_GTC}

Select Duration DO
    Click To Element                          ${clickSelectDuration}
    Click To Element                          ${clickSelectDuration_DayOnly}

Select Duration GTD
    Click To Element                          ${clickSelectDuration}
    Click To Element                          ${clickSelectDuration_GTD}

Select Duration FOK
    Click To Element                          ${clickSelectDuration}
    Click To Element                          ${clickSelectDuration_FOK}

Select Duration IOC
    Click To Element                          ${clickSelectDuration}
    Click To Element                          ${clickSelectDuration_IOC}

Select Destination BESTMARKET
    Click To Element                          ${clickDestination}
    Click To Element                          ${clickdestination_BESTMKT}

Select Destination ASX
    Click To Element                          ${clickDestination}
    Click To Element                          ${clickdestination_ASX}

Select Destination ASXCP
    Click To Element                          ${clickDestination}
    Click To Element                          ${clickdestination_ASXCP}

Select Destination CXA
    Click To Element                          ${clickDestination}
    Click To Element                          ${clickdestination_CXA}

Select Destination qCXA
    Click To Element                          ${clickDestination}
    Click To Element                          ${clickdestination_qCXA}

Click Review Order
    Click To Element                          ${btnReviewOrder}
       

Click Place Buy Order
    Double Click Element        ${btnPlaceBuyOrder}
    Wait Until Page Contains    Place order successfully    70

Click Place Buy Order Not Enough Cash
    Double Click Element                 ${btnPlaceBuyOrder}
    Validate Buy When Not Enough Cash

Click Place Sell Order
    Double Click Element        ${btnPlaceSellOrder}
    Wait Until Page Contains    Place order successfully    70

Click Sell
    Click To Element       ${sell}

Verify Review Order
    [Arguments]    ${expec1}    ${expec2}    ${expec3}    ${expec4}    ${expec5}    ${expec6}

    Element Text Should Be    ${accountID}    ${expec1}

    Element Text Should Be    ${side}    ${expec2}

    Element Text Should Be    ${orderType}    ${expec3}

    Element Text Should Be    ${symbol}    ${expec4}

    Element Should Contain    ${duration}    ${expec5}

    Element Text Should Be    ${destination}    ${expec6}

Get Number Of String
    [Arguments]          ${string}
    ${value}=            Replace String Using Regexp    ${string}    [r'\d+\ \d+\$UAD' ]    0
    ${result}=           Convert To Number              ${value}
    ${integer_value}=    Convert To Integer             ${result}
    RETURN             ${integer_value}

Click Date Time Picker
    ${date}=     Get Text    ${clickDateTimePicker}
    Log    ${date}

Validate Buy When Not Enough Cash
    ${value1}=                Get Text                 ${tradingBalance}
    ${balance}=               Get Number Of String     ${value1}
    Log                       ${balance}
    ${value2}=                Get Text                 ${estimateTotal}
    ${total}=                 Get Number Of String     ${value2}
    Log                       ${total}
    IF                        ${balance}>${total}
    Element Text Should Be    ${errorReviewMessage}    Insufficient cash to trade
    END

Click Orders List
    Mouse Over    ${leftTradingMenu}
    Click To Element      ${menuOrdersList}
    
Search Orders List
    [Arguments]     ${account}
#    Press keys  ${inputSearchOrderList}  Cmd+A+BACKSPACE
    Press keys  ${inputSearchOrderList}  BACKSPACE
    Press keys  ${inputSearchOrderList}  BACKSPACE
    Press keys  ${inputSearchOrderList}  BACKSPACE
    Press keys  ${inputSearchOrderList}  BACKSPACE
    Press keys  ${inputSearchOrderList}  BACKSPACE
    Input Text To Element                     ${inputSearchOrderList}    ${account}
    Click To Element       ${clickSearch_Account}
    Click To Element      ${clickBtnSearch}
       

Click Modify Order
    Click To Element       ${btnModifyOrder}
    
Click Cancel Order
    Click To Element      ${btnCancelOrder}
    
Click Element If Visible
    [Arguments]    ${element1}    ${element2}
    ${isVisible}=    Run Keyword And Return Status    Element Should Be Visible    ${element1}
    Run Keyword If    ${isVisible}    Click To Element       ${element1}    ELSE    Click To Element       ${element2}
    
Click Modify Buy Order
    Drag And Drop By Offset    //div[contains(text(),'review order')]    200    -300
    Click Element If Visible    ${btnModifyBuyOrder}    ${btnModifySellOrder}

Click Cancel Order In Popup
    Click To Element       ${btnCancelOrderInPopup}
    
Click OK
    Click To Element       ${btnOK}

Go To List Order
    Click To Element       ${leftHumbergerMenu}
    Mouse Over       ${leftTradingMenu}
    Mouse Over       ${menuOrdersList}
    Click To Element       ${menuOrdersList}

Search Class Filter
    [Arguments]      ${textFilter}
    Input Text To Element               ${quickFilter}    ${textFilter}
    Click To Element       ${btnGo}

Click Icon Detail Order
    Mouse Over    ${inputSearchOrderList}
    Double Click Element    ${inputSearchOrderList}
    Click Element At Coordinates    ${inputSearchOrderList}      2375      160

Detail Order
    [Arguments]    ${class}
    Go To List Order
    Search Class Filter     ${class}
    Click Icon Detail Order

Search Account
    Clear Text By Key Delete       ${inputSearch_Account}
    Input Text To Element    ${inputSearch_Account}     108723
    Click To Element    ${suggestAccount} 
    