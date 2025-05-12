*** Settings ***
Resource        ../../../Page/WebTrading/LoginPage.robot
Resource        ../../../Page/WebTrading/OrderPage.robot
Resource        ../../../Page/WebTrading/CBOE/Order_MTL.robot
Resource        ../../../Data/Const.robot

*** Variables ***
${acc}                     100026
${symbolCXA}                  14D.CXA
${companyCXA}                 1414DEGREE FPO [14D]
${symbolASX}                  14D.ASX
${companyASX}                 1414DEGREE FPO
*** Test Cases ***
Order MTL-0016 duration=GTC
    [Tags]      outTrading
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            ${symbolCXA}         ${companyCXA}
    Select Order Type MarketToLimit
    Select Duration GTC
    Click destination
    Verify destination - BESTMKT enable
    Verify destination CXA enable
    Verify destination qCXA enable

Order MTL-0017 duration=DO
    [Tags]      outTrading
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            ${symbolCXA}         ${companyCXA}
    Select Order Type MarketToLimit
    Select Duration DO
    Click destination
    Verify destination - BESTMKT enable
    Verify destination CXA enable
    Verify destination qCXA enable

Order MTL-0018 duration=GTD
    [Tags]      outTrading
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            ${symbolCXA}         ${companyCXA}
    Select Order Type MarketToLimit
    Select Duration GTD
    Click destination
    Verify destination - BESTMKT enable
    Verify destination CXA enable
    Verify destination qCXA enable

Order MTL-0019 duration=FOK
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            ${symbolCXA}         ${companyCXA}
    Select Order Type MarketToLimit
    Select Duration FOK
    Click destination
    Verify destination - BESTMKT enable
    Verify destination CXA enable


Order MTL-0020 duration=IOC
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            ${symbolCXA}         ${companyCXA}
    Select Order Type MarketToLimit
    Select Duration IOC
    Click destination
    Verify destination - BESTMKT enable
    Verify destination CXA enable

Order MTL-0021 duration=GTC
    [Tags]      outTrading
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            ${symbolASX}         ${companyASX}
    Select Order Type MarketToLimit
    Select Duration GTC
    Click destination
    Verify destination - BESTMKT enable
    Verify destination ASX enable
    Verify destination qASX enable

Order MTL-0022 duration=DO
    [Tags]      outTrading
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            ${symbolASX}         ${companyASX}
    Select Order Type MarketToLimit
    Select Duration DO
    Click destination
    Verify destination - BESTMKT enable
    Verify destination ASX enable
    Verify destination qASX enable

Order MTL-0023 duration=GTD
    [Tags]      outTrading
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            ${symbolASX}         ${companyASX}
    Select Order Type MarketToLimit
    Select Duration GTD
    Click destination
    Verify destination - BESTMKT enable
    Verify destination ASX enable
    Verify destination qASX enable

Order MTL-0024 duration=FOK
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            ${symbolASX}         ${companyASX}
    Select Order Type MarketToLimit
    Select Duration FOK
    Click destination
    Verify destination - BESTMKT enable
    Verify destination ASX enable

Order MTL-0025 duration=IOC
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            ${symbolASX}         ${companyASX}
    Select Order Type MarketToLimit
    Select Duration IOC
    Click destination
    Verify destination - BESTMKT enable
    Verify destination ASX enable

Order MTL-0035 duration=GTC
    [Tags]      outTrading
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            A200.CXA         BETAAUS200 ETF UNITS [A200]
    Select Order Type MarketToLimit
    Select Duration GTC
    Click destination
    Verify destination - BESTMKT enable
    Verify destination qCXA enable

Order MTL-0036 duration=DO
    [Tags]      outTrading
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            A200.CXA         BETAAUS200 ETF UNITS [A200]
    Select Order Type MarketToLimit
    Select Duration DO
    Click destination
    Verify destination - BESTMKT enable
    Verify destination qCXA enable

Order MTL-0037 duration=GTC
    [Tags]      outTrading
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            A200.ASX        BETAAUS200 ETF UNITS
    Select Order Type MarketToLimit
    Select Duration GTC
    Click destination
    Verify destination - BESTMKT enable
    Verify destination qASX enable

Order MTL-0038 duration=DO
    [Tags]      outTrading
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            A200.ASX         BETAAUS200 ETF UNITS
    Select Order Type MarketToLimit
    Select Duration DO
    Click destination
    Verify destination - BESTMKT enable
    Verify destination qASX enable

Order MTL-0047 duration=GTC
    [Tags]      outTrading
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            360JCA.CXA         Citiwarrants 8.7141 360 08-Sep-33 Instal Mini
    Select Order Type MarketToLimit
    Select Duration GTC
    Click destination
    Verify destination qCXA enable
    Verify destination CXA enable

Order MTL-0048 duration=GTC
    [Tags]      outTrading
    Login Happy Cases       ${URL_DEV}    ${Browser}    ${usernameDev}    ${passwordDev}
    Enter Button Buy
    Input username          ${acc}
    Input symbol            BHPBOA.ASX         BHP GROUP CTWJUL23B
    Select Order Type MarketToLimit
    Select Duration GTC
    Click destination
    Verify destination qASX enable
    Verify destination AXW enable