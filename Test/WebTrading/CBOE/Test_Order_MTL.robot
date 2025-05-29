*** Settings ***
Documentation       Test cases for Market To Limit (MTL) order functionality

Resource            ../../../Page/WebTrading/LoginPage.robot
Resource            ../../../Page/WebTrading/OrderPage.robot
Resource            ../../../Page/WebTrading/CBOE/Order_MTL.robot
Resource            ../../../Data/Const.robot


*** Variables ***
${acc}                  100026
${symbolCXA}            14D.CXA
${companyCXA}           1414DEGREE FPO [14D]
${symbolASX}            14D.ASX
${companyASX}           1414DEGREE FPO
${symbolA200CXA}        A200.CXA
${companyA200CXA}       BETAAUS200 ETF UNITS [A200]
${symbolA200ASX}        A200.ASX
${companyA200ASX}       BETAAUS200 ETF UNITS
${symbol360JCA}         360JCA.CXA
${company360JCA}        Citiwarrants 8.7141 360 08-Sep-33 Instal Mini
${symbolBHPBOA}         BHPBOA.ASX
${companyBHPBOA}        BHP GROUP CTWJUL23B


*** Test Cases ***
Order MTL-0016 duration=GTC
    [Documentation]    Tests MTL order with GTC duration for CXA symbol
    [Tags]    outtrading
    Setup Test    ${symbolCXA}    ${companyCXA}
    Select Duration GTC
    Verify CXA Destinations

Order MTL-0017 duration=DO
    [Documentation]    Tests MTL order with DO duration for CXA symbol
    [Tags]    outtrading
    Setup Test    ${symbolCXA}    ${companyCXA}
    Select Duration DO
    Verify CXA Destinations

Order MTL-0018 duration=GTD
    [Documentation]    Tests MTL order with GTD duration for CXA symbol
    [Tags]    outtrading
    Setup Test    ${symbolCXA}    ${companyCXA}
    Select Duration GTD
    Verify CXA Destinations

Order MTL-0019 duration=FOK
    [Documentation]    Tests MTL order with FOK duration for CXA symbol
    Setup Test    ${symbolCXA}    ${companyCXA}
    Select Duration FOK
    Click destination
    Verify destination - BESTMKT enable
    Verify destination CXA enable

Order MTL-0020 duration=IOC
    [Documentation]    Tests MTL order with IOC duration for CXA symbol
    Setup Test    ${symbolCXA}    ${companyCXA}
    Select Duration IOC
    Click destination
    Verify destination - BESTMKT enable
    Verify destination CXA enable

Order MTL-0021 duration=GTC
    [Documentation]    Tests MTL order with GTC duration for ASX symbol
    [Tags]    outtrading
    Setup Test    ${symbolASX}    ${companyASX}
    Select Duration GTC
    Verify ASX Destinations

Order MTL-0022 duration=DO
    [Documentation]    Tests MTL order with DO duration for ASX symbol
    [Tags]    outtrading
    Setup Test    ${symbolASX}    ${companyASX}
    Select Duration DO
    Verify ASX Destinations

Order MTL-0023 duration=GTD
    [Documentation]    Tests MTL order with GTD duration for ASX symbol
    [Tags]    outtrading
    Setup Test    ${symbolASX}    ${companyASX}
    Select Duration GTD
    Verify ASX Destinations

Order MTL-0024 duration=FOK
    [Documentation]    Tests MTL order with FOK duration for ASX symbol
    Setup Test    ${symbolASX}    ${companyASX}
    Select Duration FOK
    Click destination
    Verify destination - BESTMKT enable
    Verify destination ASX enable

Order MTL-0025 duration=IOC
    [Documentation]    Tests MTL order with IOC duration for ASX symbol
    Setup Test    ${symbolASX}    ${companyASX}
    Select Duration IOC
    Click destination
    Verify destination - BESTMKT enable
    Verify destination ASX enable

Order MTL-0035 duration=GTC
    [Documentation]    Tests MTL order with GTC duration for A200.CXA symbol
    [Tags]    outtrading
    Setup Test    ${symbolA200CXA}    ${companyA200CXA}
    Select Duration GTC
    Click destination
    Verify destination - BESTMKT enable
    Verify destination qCXA enable

Order MTL-0036 duration=DO
    [Documentation]    Tests MTL order with DO duration for A200.CXA symbol
    [Tags]    outtrading
    Setup Test    ${symbolA200CXA}    ${companyA200CXA}
    Select Duration DO
    Click destination
    Verify destination - BESTMKT enable
    Verify destination qCXA enable

Order MTL-0037 duration=GTC
    [Documentation]    Tests MTL order with GTC duration for A200.ASX symbol
    [Tags]    outtrading
    Setup Test    ${symbolA200ASX}    ${companyA200ASX}
    Select Duration GTC
    Click destination
    Verify destination - BESTMKT enable
    Verify destination qASX enable

Order MTL-0038 duration=DO
    [Documentation]    Tests MTL order with DO duration for A200.ASX symbol
    [Tags]    outtrading
    Setup Test    ${symbolA200ASX}    ${companyA200ASX}
    Select Duration DO
    Click destination
    Verify destination - BESTMKT enable
    Verify destination qASX enable

Order MTL-0047 duration=GTC
    [Documentation]    Tests MTL order with GTC duration for 360JCA.CXA symbol
    [Tags]    outtrading
    Setup Test    ${symbol360JCA}    ${company360JCA}
    Select Duration GTC
    Click destination
    Verify destination qCXA enable
    Verify destination CXA enable

Order MTL-0048 duration=GTC
    [Documentation]    Tests MTL order with GTC duration for BHPBOA.ASX symbol
    [Tags]    outtrading
    Setup Test    ${symbolBHPBOA}    ${companyBHPBOA}
    Select Duration GTC
    Click destination
    Verify destination qASX enable
    Verify destination AXW enable


*** Keywords ***
Setup Test
    [Documentation]    Common setup for all MTL order tests
    [Arguments]    ${symbol}    ${company}
    Login Happy Cases    ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username    ${acc}
    Input symbol    ${symbol}    ${company}
    Select Order Type MarketToLimit

Verify CXA Destinations
    [Documentation]    Verifies all CXA-related destinations
    Click destination
    Verify destination - BESTMKT enable
    Verify destination CXA enable
    Verify destination qCXA enable

Verify ASX Destinations
    [Documentation]    Verifies all ASX-related destinations
    Click destination
    Verify destination - BESTMKT enable
    Verify destination ASX enable
    Verify destination qASX enable
