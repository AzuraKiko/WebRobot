*** Settings ***
Library     SeleniumLibrary
Resource    ../../../Locator/OrderLocator.robot
Resource    ../../../Utils/CommonKeyword.robot
Resource    ../../../Utils/APIHelper.robot
Resource     ../../../Data/Const.robot


*** Variables ***
${menuMarketDepth}              //*[@id="mainMenu"]//div[text()='Market Depth']
${menuAdvanceMarketDepth}       //*[@id="mainMenu"]//div[text()='Advanced Market Depth']
${symbolDisplay}                (//p[contains(@class,'showTitle')])[1]
${lastTradePrice}               //div[@class="header-wrap flex "]//div[contains(@class,'showTitle')][1]
${lastChangePoint}              //div[@class="header-wrap flex "]//div[contains(@class,'showTitle')][2]
${lastChangePercent}            //div[@class="header-wrap flex "]//div[contains(@class,'showTitle')][3]
${equilibriumPrice}             //p[text()='Equilibrium Price']/following-sibling::p/span
${notice}                       //div[@class="line expand"]/following-sibling::div[1]//div
${autionVolume}                 //p[text()='Auction Volume / Surplus Volume']/following-sibling::p//span[1]
${surplusVolume}                //p[text()='Auction Volume / Surplus Volume']/following-sibling::p//span[3]

${checkbox1}                    (//span[text()='I have read and agree to the'])[2]
${checkbox2}                    (//span[text()='I have read and agree to the'])[1]
${getAccess1}                   (//div[text()='get access now'])[2]
${getAccess2}                   (//div[text()='get access now'])[1]

${container1}                   (//div[@class="container"])[1]
${container2}                   (//div[@class="container"])[2]
${canvas_bid}                   (//canvas[@class="hypergrid"])[1]
${canvas_ask}                   (//canvas[@class="hypergrid"])[2]
${inputSearch}                  //input[contains(@id,'searchBoxSelector')]
${modalOrder}                   //div[@class='windowHeader']


*** Keywords ***
Check access 1
    SeleniumLibrary.Drag And Drop By Offset    (//div[@class="container"]//div[@class="__vertical"])[2]    0    300
    Click Element    ${checkbox1}
    Click To Element    ${getAccess1}

Check access 2
    SeleniumLibrary.Drag And Drop By Offset    (//div[@class="container"]//div[@class="__vertical"])[1]    0    300
    Click To Element    ${checkbox2}
    Click To Element    ${getAccess2}

Open market depth
    Hover To Element    ${leftHumbergerMenu}
    Hover To Element    ${leftTradingMenu}
    Click To Element    ${menuMarketDepth}

Open advance market depth
    Hover To Element    ${leftHumbergerMenu}
    Hover To Element    ${leftTradingMenu}
    Click To Element    ${menuAdvanceMarketDepth}

Input symbol
    [Arguments]    ${symbol}
    Click To Element    ${inputSymbol}
    Input Text To Element    ${inputSymbol}    ${symbol}
    Click To Element    ${suggestSymbol}

Verify symbol and exchange display
    [Arguments]    ${symbol}
    Verify Text Element    ${symbolDisplay}    ${symbol}

Clean Percent String
    [Documentation]    Loại bỏ ký tự ( ), % từ chuỗi phần trăm và định dạng
    [Arguments]    ${text}
    ${cleaned}=    Remove String    ${text}    (    )    %
    ${formatted}=    Format Number    ${cleaned}
    RETURN    ${formatted}

Get Delayed Price Data
    [Documentation]    Lấy dữ liệu giá delayed từ API
    [Arguments]    ${exchange}    ${symbol}    ${token}
    ${json_response}=    Get API Data    /feed-delayed-snapshot-aio/price/${exchange}/${symbol}    ${token}
    ${trade_price}=    Get From Dictionary    ${json_response[0]['quote']}    trade_price
    ${change_point}=    Get From Dictionary    ${json_response[0]['quote']}    change_point
    ${change_percent}=    Get From Dictionary    ${json_response[0]['quote']}    change_percent
    ${formatted_trade_price}=    Format Number    ${trade_price}
    ${formatted_change_point}=    Format Number    ${change_point}
    ${formatted_change_percent}=    Format Number    ${change_percent}
    RETURN    ${formatted_trade_price}    ${formatted_change_point}    ${formatted_change_percent}

Get Web Price Data
    [Documentation]    Lấy dữ liệu giá từ giao diện web
    [Arguments]    ${symbol}    ${exchange}
    Open Market Depth
    Input Symbol    ${symbol}.${exchange}
    Verify Symbol And Exchange Display    ${symbol}.${exchange}
    Wait Until Element Is Visible    ${lastTradePrice}    timeout=10s
    ${lastTradePriceWeb}=    Get Element Text By JS    ${lastTradePrice}
    ${changePointWeb}=    Get Element Text By JS    ${lastChangePoint}
    ${lastChangePercentWeb}=    Get Element Text By JS    ${lastChangePercent}
    ${actual_lastTradePrice}=    Format Number    ${lastTradePriceWeb}
    ${actual_changePoint}=    Format Number    ${changePointWeb}
    ${actual_changePercent}=    Clean Percent String    ${lastChangePercentWeb}
    RETURN    ${actual_lastTradePrice}    ${actual_changePoint}    ${actual_changePercent}

Update User Market Data
    [Documentation]    Cập nhật quyền truy cập market data cho user
    [Arguments]    ${user_id}    ${market_data_type}    ${status}    ${token}
    Set Auth Token    ${token}
    ${exchange_item1}=    Create Dictionary
    ...    exchange=${exchangeASX}
    ...    market_data_type=${market_data_type}
    ...    status=${status}
    ${exchange_item2}=    Create Dictionary
    ...    exchange=${exchangeCXA}
    ...    market_data_type=${market_data_type}
    ...    status=${status}
    ${exchange_list}=    Create List    ${exchange_item1}    ${exchange_item2}
    ${user_data}=    Create Dictionary    user_id=${user_id}    exchange_access=${exchange_list}
    ${body}=    Create List    ${user_data}
    ${response}=    Send PUT Request    /user/market-data    ${body}
    RETURN    ${response}
