*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     JSONSchemaLibrary
Library     OperatingSystem
Library     Collections
Library     Screenshot
Resource    ../../../Page/WebTrading/LoginPage.robot
Resource    ../../../Page/WebTrading/CBOE/MarketDepthPage.robot
Resource    ../../../Utils/API.robot
Resource    ../../../Page/WebTrading/CBOE/OrderLimitPage.robot
Library     ../../../Utils/Common.py


*** Variables ***
# Environment Configuration
${environment}          equix
${apiUrlDev}            https://dev2-operator-api.equix.app
${origin}               https://dev2.equix.app
${originPortal}         https://portal-${environment}-dev2.equix.app
${version}              v1
${baseUrl}              https://dev2.equix.app/?wlb=${environment}
${baseUrlPortalDev}     https://portal-${environment}-dev2.equix.app/login
${userIDDev}            eq1740025808137
${env}                  ${environment}

# Test Data
${username}             test1@equix.com.au
${password}             Abc@1111
${testSymbol}           9Z9
${outputImagePath}      ${EXECDIR}/Data/image.png
${outputCsvPath}        ${EXECDIR}/Data/data.csv


*** Test Cases ***
LM-01 Verify Order Limit Functionality
    [Documentation]    Test case to verify order limit functionality and symbol search
    [Tags]    order    limit    search

    # Setup - Get authentication token
    ${token}=    Get Token Web Trading
    ...    ${apiUrlDev}
    ...    ${username}
    ...    ${password}
    ...    ${origin}
    ...    ${version}
    ...    ${env}

    # Setup - Create API session
    Create Session    mysession1    ${apiUrlDev}/${version}    verify=true
    &{header}=    Create Dictionary    authorization=${token}    environment=${env}

    # Get market info for symbol
    ${response}=    GET On Session    mysession1    url=/market-info/symbol/${testSymbol}    headers=${header}
    ${json_response}=    To JSON    ${response.content}
    ${symData}=    Get From Dictionary    ${json_response[0]}    symbol

    # Login to web trading
    Login Happy Cases    ${baseUrl}    ${Browser}    ${username}    ${password}

    # Test Steps
    Open All Orders
    Search Symbol    ${testSymbol}
    Sleep    5s

    # Verification
    Verify Symbol In Orders List    ${testSymbol}

    # Capture and Process Data
    ${total_rows}=    Capture Full Table Data    ${outputImagePath}
    ${table_data}=    Extract Table Data To CSV    ${outputCsvPath}

    # Verify data capture
    Should Not Be Empty    ${table_data}    No data was captured from the table
    Log    Captured ${total_rows} rows of data
