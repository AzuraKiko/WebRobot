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

Market Depth Order Bid/Ask
    [Documentation]    Verify bid/ask price ordering in market depth
    [Tags]    bid_ask    market_depth
    # Login And Close All Tabs    ${username}    ${password}
    # Open Market Depth
    # Search Symbol    ${symbol}.${exchangeASX}    ${inputSearch}    Market Depth
    # Select Symbol    ${suggestSearch}    ${firstSearch}
    # Verify Symbol And Exchange Display    ${symbol}.${exchangeASX}
    # Sleep    2s
    # Capture Element Screenshot    ${container}    ${EXECDIR}/Data/MarketDepth.png
    # Sleep    2s
    # Extract Text To Csv    ${EXECDIR}/Data/MarketDepth.png    ${EXECDIR}/Data/MarketDepth.csv
    Fade Red Green Opacity
    ...    ${EXECDIR}/Data/MarketDepth.png
    ...    ${EXECDIR}/Data/processed4.png
    Remove Red Green And Replace Color
    ...    ${EXECDIR}/Data/processed4.png
    ...    ${EXECDIR}/Data/processed5.png    10    (48, 32, 28)
    Preprocess For Ocr
    ...    ${EXECDIR}/Data/processed5.png
    ...    ${EXECDIR}/Data/processed7.png

    Extract Text To Csv    ${EXECDIR}/Data/processed8.png    ${EXECDIR}/Data/MarketDepth.csv

    # ${token}=    Get Authentication Token
    # ...    ${apiUrl}
    # ...    ${username}
    # ...    ${password}
    # ...    ${origin}
    # ...    ${version}
    # ...    ${environment}
    # ${json_response}=    Get API Data    /feed-snapshot-aio/price/${exchangeASX}/${symbol}    ${token}
    # ${bids}=    Get From Dictionary    ${json_response[0]['depth']}    bid
    # ${asks}=    Get From Dictionary    ${json_response[0]['depth']}    ask
    # ${is_decreasing}=    Is Price Decreasing    ${bids}
    # ${is_increasing}=    Is Price Increasing    ${asks}
    # Should Be Equal    ${is_decreasing}    True    msg=Bid prices are not decreasing
    # Should Be Equal    ${is_increasing}    True    msg=Ask prices are not increasing
    # ${line_count}=    Count Lines In Csv    Data/data.csv
    # Should Be True    ${line_count} <= 10    msg=CSV file has more than 10 lines

# Market Depth 0041 0042 0043 - Invalid Symbol
#    [Documentation]    Verify market depth behavior with invalid symbol
#    [Tags]    invalid_symbol    market_depth
#    Open Market Depth
#    Input Symbol    INVALID.${exchangeCXA}
#    Wait Until Element Is Visible    ${errorMessage}    timeout=5s
#    ${error_text}=    Get Element Text By JS    ${errorMessage}
#    Should Be Equal    ${error_text}    Invalid symbol    msg=Invalid symbol error message mismatch

# Market Depth 0044 0045 0046 - Network Error
#    [Documentation]    Verify market depth behavior during network errors
#    [Tags]    network_error    market_depth
#    Open Market Depth
#    Input Symbol    ${symbol}.${exchangeCXA}
#    ${token}=    Get token web trading    ${apiUrl}    ${username}    ${password}    ${origin}    ${version}    ${environment}
#    ${json_response}=    Get API Data
#    ...    /feed-snapshot-aio/price/${exchangeCXA}/${symbol}
#    ...    ${token}
#    ...    expected_status=500
#    Wait Until Element Is Visible    ${errorMessage}    timeout=5s
#    ${error_text}=    Get Element Text By JS    ${errorMessage}
#    Should Be Equal    ${error_text}    Network error occurred    msg=Network error message mismatch
