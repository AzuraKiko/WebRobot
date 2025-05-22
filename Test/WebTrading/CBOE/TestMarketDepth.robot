*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     Collections
Library     String
Library     OperatingSystem
Library     Screenshot
Library     ../../../Utils/Common.py
Resource    ../../../Page/WebTrading/Pentest/LoginPage.robot
Resource    ../../../Page/WebTrading/CBOE/MarketDepthPage.robot
Resource    ../../../Utils/API.robot
# Library    ../../../Utils/HandleImg.py
# Test Setup    Login And Close All Tabs    ${username}    ${password}
# Test Teardown    Close All Browsers


*** Test Cases ***
Market Depth Delay Last Price
    [Documentation]    Verify market depth displays correct delayed data
    [Tags]    delayed    market_depth
    Login And Close All Tabs    ${username}    ${password}
    # First get UI data while logged in
    ${actual_lastTradePrice}    ${actual_changePoint}    ${actual_changePercent}=
    ...    Get Web Price Data    ${symbol}    ${exchangeASX}
    Sleep    3s

    # Then get API data
    ${token}=    Get Authentication Token
    ...    ${urlLogin}
    ...    ${username}
    ...    ${password}
    ...    ${origin}
    ...    ${version}
    ...    ${environment}
    ${expect_trade_price}    ${expect_change_point}    ${expect_change_percent}=
    ...    Get Delayed Price Data    ${exchangeASX}    ${symbol}    ${token}

    # Log both sets of data for comparison
    Log
    ...    Expected (API): trade_price=${expect_trade_price}, change_point=${expect_change_point}, change_percent=${expect_change_percent}
    Log
    ...    Actual (UI): trade_price=${actual_lastTradePrice}, change_point=${actual_changePoint}, change_percent=${actual_changePercent}

    # Compare values with tolerance to account for potential small differences
    Compare Float Values    ${actual_lastTradePrice}    ${expect_trade_price}    msg=Trade price mismatch
    Compare Float Values    ${actual_changePoint}    ${expect_change_point}    msg=Change point mismatch
    Compare Float Values
    ...    ${actual_changePercent}
    ...    ${expect_change_percent}
    ...    msg=Change percent mismatch

Market Depth No Access
    [Documentation]    Verify market depth behavior when user has no access
    [Tags]    no_access    market_depth
    ${token}=    Get Authentication Token
    ...    ${apiUrl}
    ...    ${username}
    ...    ${password}
    ...    ${originAdminPortal}
    ...    ${version}
    ...    ${environment}
    Update User Market Data    ${userID}    0    0    ${token}
    Login And Close All Tabs    ${username}    ${password}
    Open Market Depth
    Wait Until Element Is Visible    ${lastTradePrice}    timeout=10s
    Sleep    2s
    SeleniumLibrary.Element Text Should Be    ${lastTradePrice}    --
    SeleniumLibrary.Element Text Should Be    ${lastChangePoint}    --
    SeleniumLibrary.Element Text Should Be    ${lastChangePercent}    (--%)
    Update User Market Data    ${userID}    3    2    ${token}
    Check access 1
    Check access 2

Market Depth Sort Bid/Ask
    [Documentation]    Verify bid/ask price ordering in market depth
    [Tags]    bid_ask    market_depth
    Login And Close All Tabs    ${username}    ${password}
    Open Market Depth
    Search Symbol    ${symbol}.${exchangeASX}    ${inputSearch}    Market Depth
    Select Symbol    ${suggestSearch}    ${firstSearch}
    Verify Symbol And Exchange Display    ${symbol}.${exchangeASX}
    Sleep    2s
    Capture Element Screenshot    ${container}    ${EXECDIR}/Data/MarketDepth.png
    Sleep    2s
    Fade Red Green Opacity
    ...    ${EXECDIR}/Data/MarketDepth.png
    ...    ${EXECDIR}/Data/OpacityDepth.png
    Remove Red Green And Replace Color
    ...    ${EXECDIR}/Data/OpacityDepth.png
    ...    ${EXECDIR}/Data/RemoveColorDepth.png    20    (48, 32, 28)
    Preprocess For Ocr
    ...    ${EXECDIR}/Data/RemoveColorDepth.png
    ...    ${EXECDIR}/Data/ProcessDepth.png

    Extract Text To Csv    ${EXECDIR}/Data/ProcessDepth.png    ${EXECDIR}/Data/MarketDepth.csv
    ${line}=    Count Lines In Csv    ${EXECDIR}/Data/MarketDepth.csv
    Log    ${line}
    Should Be True    ${line}<=10    Số dòng phải nhỏ hơn hoặc bằng 10!

    ${token}=    Get Authentication Token
    ...    ${urlLogin}
    ...    ${username}
    ...    ${password}
    ...    ${origin}
    ...    ${version}
    ...    ${environment}

    Set Auth Token    ${token}
    ${json_response}=    Get API Data
    ...    /feed-snapshot-aio/price/${exchangeASX}/${symbol}
    ${has_depth}=    Evaluate    'depth' in ${json_response}
    IF    ${has_depth}
        ${bids}=    Get From Dictionary    ${json_response[0]['depth']}    bid
        ${asks}=    Get From Dictionary    ${json_response[0]['depth']}    ask
        IF    ${bids}!= {}
            ${sortBid}=    Is Price Decreasing    ${bids}
            Should Be True    ${sortBid}    Bids are not in decreasing order
        END
        IF    ${asks}!= {}
            ${sortAsk}=    Is Price Increasing    ${asks}
            Should Be True    ${sortAsk}    Asks are not in increasing order
        END
    ELSE
        Log    Depth is empty
    END

Market Depth Invalid Symbol
    [Documentation]    Verify market depth behavior with invalid symbol
    [Tags]    invalid_symbol    market_depth
    Login And Close All Tabs    ${username}    ${password}
    Open Market Depth
    Search Symbol    INVALID.${exchangeASX}    ${inputSearch}    Market Depth
    Wait Until Element Is Visible    ${suggestSearch}    ${time}
    Wait Until Element Is Visible    ${errorMessage}    ${time}
    ${error_text}=    Get Element Text By JS    ${errorMessage}
    Should Be Equal    ${error_text}    No Data    msg=Invalid symbol error message mismatch

Handle Image
    Extract Text To Csv    ${EXECDIR}/Data/ProcessDepth.png    ${EXECDIR}/Data/MarketDepth.csv
