*** Settings ***
Library         SeleniumLibrary
Library         RequestsLibrary
Library         Collections
Library         String
Library         OperatingSystem
Library         Screenshot
Resource        ../../../Page/WebTrading/LoginPage.robot
Resource        ../../../Page/WebTrading/CBOE/MarketDepthPage.robot
Resource        ../../../Utils/API.robot
Library         ../../../Utils/HandleTab.py

Test Setup      Login And Input Pin    ${username}    ${password}
# Test Teardown    Close All Browsers


*** Test Cases ***
Market Depth DELAY
    [Documentation]    Verify market depth displays correct delayed data
    [Tags]    delayed    market_depth
    # ${tabs}=    Get All Tabs
    # Log    Current tabs: ${tabs}
    # FOR    ${tab}    IN    ${tabs}
    #     ${tab_text}=    Get From Dictionary    ${tab}    text
    #     Close Tab    ${tab_text}
    #     Sleep    1s
    # END

    # First get UI data while logged in
    ${actual_lastTradePrice}    ${actual_changePoint}    ${actual_changePercent}=
    ...    Get Web Price Data    ${symbol}    ${exchangeCXA}

    # Then get API data
    ${token}=    Get Authentication Token
    ...    ${urlLogin}
    ...    ${username}
    ...    ${password}
    ...    ${origin}
    ...    ${version}
    ...    ${environment}
    ${expect_trade_price}    ${expect_change_point}    ${expect_change_percent}=
    ...    Get Delayed Price Data    ${exchangeCXA}    ${symbol}    ${token}

    # Log both sets of data for comparison
    Log
    ...    Expected (API): trade_price=${expect_trade_price}, change_point=${expect_change_point}, change_percent=${expect_change_percent}
    Log
    ...    Actual (UI): trade_price=${actual_lastTradePrice}, change_point=${actual_changePoint}, change_percent=${actual_changePercent}

    # Compare values with tolerance to account for potential small differences
    Compare Float Values    ${actual_lastTradePrice}    ${expect_trade_price}    ${EMPTY}    msg=Trade price mismatch
    Compare Float Values    ${actual_changePoint}    ${expect_change_point}    ${EMPTY}    msg=Change point mismatch
    Compare Float Values
    ...    ${actual_changePercent}
    ...    ${expect_change_percent}
    ...    ${EMPTY}
    ...    msg=Change percent mismatch

# Market Depth 0010 0011 0012 0013
#    [Documentation]    Verify market depth displays correct indicative price
#    [Tags]    indicative_price    market_depth
#    ${token}=    Get Authentication Token
#    ...    ${apiUrl}
#    ...    ${username}
#    ...    ${password}
#    ...    ${origin}
#    ...    ${version}
#    ...    ${environment}
#    ${json_response}=    Get API Data    /feed-delayed-snapshot-aio/price/${exchangeCXA}/${symbol}    ${token}
#    ${indicative_price}=    Get From Dictionary    ${json_response[0]['quote']}    indicative_price
#    Open Market Depth
#    Input Symbol    ${symbol}.${exchangeCXA}
#    Verify Symbol And Exchange Display    ${symbol}.${exchangeCXA}
#    Wait Until Page Contains Element    ${equilibriumPrice}    timeout=10s
#    IF    ${indicative_price} is None
#    Element Should Not Be Visible    ${equilibriumPrice}
#    ELSE
#    ${equilibriumPriceWeb}=    Get Element Text By JS    ${equilibriumPrice}
#    ${expect_indicative_price}=    Format Number    ${equilibriumPriceWeb}
#    ${actual_equilibriumPrice}=    Format Number    ${indicative_price}
#    Should Be Equal    ${actual_equilibriumPrice}    ${expect_indicative_price}    msg=Indicative price mismatch
#    END
#    ${textNotice}=    Get Element Text By JS    ${notice}
#    Should Be Equal    ${textNotice}    Market Depth isn't available for 20 minutes delayed market data

# Market Depth 0016 0017 0018 0019 0020 0021 0022 0023
#    [Documentation]    Verify market depth behavior when user has no access
#    [Tags]    no_access    market_depth
#    ${token}=    Get Authentication Token
#    ...    ${apiUrl}
#    ...    ${username}
#    ...    ${password}
#    ...    ${originAdminPortal}
#    ...    ${version}
#    ...    ${environment}
#    Update User Market Data    0    0    ${token}
#    Open Market Depth
#    Input Symbol    ${symbol}.${exchangeCXA}
#    Verify Symbol And Exchange Display    ${symbol}.${exchangeCXA}
#    Element Text Should Be    ${lastTradePrice}    --
#    Element Text Should Be    ${lastChangePoint}    --
#    ${lastChangePercentWeb}=    Get Element Text By JS    ${lastChangePercent}
#    ${result}=    Clean Percent String    ${lastChangePercentWeb}
#    Should Be Equal    ${result}    0.00    msg=Change percent should be 0
#    Element Should Not Be Visible    ${equilibriumPrice}
#    Element Should Not Be Visible    ${autionVolume}
#    Element Should Not Be Visible    ${surplusVolume}
#    Update User Market Data    1    3    ${token}

# Market Depth 0026 0027 0028 0029 0030 0031 0032 0033 0034 - CLICK TO REFRESH
#    [Documentation]    Verify market depth click to refresh functionality
#    [Tags]    click_refresh    market_depth
#    ${token}=    Get token Admin portal
#    ...    ${apiUrl}
#    ...    ${username}
#    ...    ${password}
#    ...    ${originAdminPortal}
#    ...    ${version}
#    ...    ${environment}
#    Update User Market Data    2    2    ${token}
#    ${token}=    Get token web trading    ${apiUrl}    ${username}    ${password}    ${origin}    ${version}    ${environment}
#    ${json_response}=    Get API Data    /market-info/symbol/${symbol)?exchange=${exchangeCXA}    ${token}
#    ${display_name}=    Get From Dictionary    ${json_response[0]}    symbol
#    Should Be Equal    ${symbol}    ${display_name}    msg=Symbol name mismatch
#    ${json_response}=    Get API Data    /feed-snapshot-aio/price/${exchangeCXA}/${symbol}    ${token}
#    ${trade_price}=    Get From Dictionary    ${json_response[0]['quote']}    trade_price
#    ${change_point}=    Get From Dictionary    ${json_response[0]['quote']}    change_point
#    ${change_percent}=    Get From Dictionary    ${json_response[0]['quote']}    change_percent
#    ${expect_trade_price}=    Format Number    ${trade_price}
#    ${expect_change_point}=    Format Number    ${change_point}
#    ${expect_change_percent}=    Format Number    ${change_percent}
#    Check access 1
#    Check access 2
#    ${actual_lastTradePrice}    ${actual_changePoint}    ${actual_changePercent}=
#    ...    Get Web Price Data    ${symbol}    ${exchangeCXA}
#    Should Be Equal    ${expect_trade_price}    ${actual_lastTradePrice}    msg=Trade price mismatch
#    Should Be Equal    ${expect_change_point}    ${actual_changePoint}    msg=Change point mismatch
#    Should Be Equal    ${expect_change_percent}    ${actual_changePercent}    msg=Change percent mismatch
#    Update User Market Data    1    3    ${token}

# Market Depth 0038 0039 0040
#    [Documentation]    Verify bid/ask price ordering in market depth
#    [Tags]    bid_ask    market_depth
#    ${token}=    Get token Admin portal
#    ...    ${apiUrl}
#    ...    ${username}
#    ...    ${password}
#    ...    ${originPortal}
#    ...    ${version}
#    ...    ${environment}
#    Update User Market Data    2    2    ${token}
#    ${token}=    Get token web trading    ${apiUrl}    ${username}    ${password}    ${origin}    ${version}    ${environment}
#    ${json_response}=    Get API Data    /feed-snapshot-aio/price/${exchangeCXA}/${symbol}    ${token}
#    ${bids}=    Get From Dictionary    ${json_response[0]['depth']}    bid
#    ${asks}=    Get From Dictionary    ${json_response[0]['depth']}    ask
#    ${is_decreasing}=    Is Price Decreasing    ${bids}
#    ${is_increasing}=    Is Price Increasing    ${asks}
#    Should Be Equal    ${is_decreasing}    True    msg=Bid prices are not decreasing
#    Should Be Equal    ${is_increasing}    True    msg=Ask prices are not increasing
#    ${line_count}=    Count Lines In Csv    Data/data.csv
#    Should Be True    ${line_count} <= 10    msg=CSV file has more than 10 lines
#    Check access 1
#    Check access 2
#    Open Market Depth
#    Input Symbol    ${symbol}.${exchangeCXA}
#    Verify Symbol And Exchange Display    ${symbol}.${exchangeCXA}
#    Mouse Over    ${inputSearch}
#    Double Click Element    ${inputSearch}
#    Click Element At Coordinates    ${inputSearch}    -1200    220
#    Wait Until Element Is Visible    ${modalOrder}    timeout=10s
#    Update User Market Data    1    3    ${token}

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
