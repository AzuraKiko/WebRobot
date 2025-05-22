*** Settings ***
Library      SeleniumLibrary
Resource     ../../Page/WebTrading/LoginPage.robot
Resource     ../../Page/WebTrading/OrderPage.robot
Resource     ../../Data/Const.robot
Resource     ../../Data/Env.py

*** Test Cases ***

Test1
    Login Happy Cases    ${URL}    ${Browser}    ${username}    ${password}
    Go To List Order
    Search Account
    Search Class Filter     EQ
    Click Icon Detail Order

### Equity ###
TC Validate Not Input Account
    [Tags]                                   Validate
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Click Review Order
    Page Should Contain       Code must be selected first

TC Validate Not Input Account
    [Tags]                                   Validate
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input equity                             ${equity}
    Click Review Order
    Page Should Contain       Account must be selected

TC Validate Not Input quantity
    [Tags]                                   Validate
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                           ${user}
    Input equity                             ${equity}
    Click Review Order
    Page Should Contain    Quantity must be greater than 0
    Close Browser


TC Validate Not Enough Cash
    [Tags]                                   Validate
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                           ${user}
    Input equity                             ${equity}
    Select Order Type Limit
    Input Quantity                           ${quantity}
    Input Price                              ${price} 
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                      ${user}        BUY           LIMIT          ${equity}      ${GTC}    BESTMKT
    Click Place Buy Order Not Enough Cash
    Close Browser

TC-05: Create Order Buy LIMIT GTC BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input equity                    ${equity}
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        BUY           LIMIT          ${equity}      ${GTC}    BESTMKT
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-06: Create Order Buy LIMIT GTC ASX
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration GTC
    Select Destination ASX
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${equity}      ${GTC}    ASX
     Click Place Buy Order
     Detail Order    EQ
     Close Browser

TC-07: Create Order Buy LIMIT DO BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input equity                    ${equity}
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        BUY           LIMIT          ${equity}      ${DO}    BESTMKT
     Click Place Buy Order
     Detail Order    EQ
     Close Browser

TC-08: Create Order Buy LIMIT DO ASX
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration DO
    Select Destination ASX
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${equity}      ${DO}    ASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-09: Create Order Buy LIMIT DO ASXCP
    [Tags]                      Regression
    Login Happy Cases           ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username              ${user}
    Input equity                ${equity}
    Select Order Type Limit
    Input Quantity              ${quantity}
    Input Price                 ${price} 
    Select Duration DO
    Select Destination ASXCP
    Click Review Order
    Verify Review Order         ${user}        BUY           LIMIT          ${equity}      ${DO}    ASXCP
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-10: Create Order Buy LIMIT DO CXA
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration DO
    Select Destination CXA
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${equity}      ${DO}    CXA
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-11: Create Order Buy LIMIT DO qCXA
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration DO
    Select Destination qCXA
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${equity}      ${DO}    qCXA
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-12: Create Order Buy LIMIT GTD BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input equity                    ${equity}
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration GTD
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        BUY           LIMIT          ${equity}      ${GTD}    BESTMKT
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-13: Create Order Buy LIMIT GTD ASX
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration GTD
    Select Destination ASX
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${equity}      ${GTD}    ASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser



TC-14: Create Order Buy LIMIT FOK BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input equity                    ${equity}
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration FOK
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        BUY           LIMIT          ${equity}      ${FOK}    BESTMKT
    Click Place Buy Order
    Detail Order    EQ
    Close Browser


TC-15: Create Order Buy LIMIT FOK ASX
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration FOK
    Select Destination ASX
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${equity}      ${FOK}    ASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser



TC-16: Create Order Buy LIMIT FOK ASXCP
    [Tags]                      Regression
    Login Happy Cases           ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username              ${user}
    Input equity                ${equity}
    Select Order Type Limit
    Input Quantity              ${quantity}
    Input Price                 ${price} 
    Select Duration FOK
    Select Destination ASXCP
    Click Review Order
    Verify Review Order         ${user}        BUY           LIMIT          ${equity}      ${FOK}    ASXCP
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-17: Create Order Buy LIMIT FOK CXA
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration FOK
    Select Destination CXA
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${equity}      ${FOK}    CXA
    Click Place Buy Order
    Detail Order    EQ
    Close Browser



TC-18: Create Order Buy LIMIT IOC BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input equity                    ${equity}
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration IOC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        BUY           LIMIT          ${equity}      ${IOC}    BESTMKT
    Click Place Buy Order
    Detail Order    EQ
    Close Browser


TC-19: Create Order Buy LIMIT IOC ASX
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration IOC
    Select Destination ASX
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${equity}      ${IOC}    ASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser



TC-20: Create Order Buy LIMIT IOC ASXCP
    [Tags]                      Regression
    Login Happy Cases           ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username              ${user}
    Input equity                ${equity}
    Select Order Type Limit
    Input Quantity              ${quantity}
    Input Price                 ${price} 
    Select Duration IOC
    Select Destination ASXCP
    Click Review Order
    Verify Review Order         ${user}        BUY           LIMIT          ${equity}      ${IOC}    ASXCP
    Click Place Buy Order
    Detail Order    EQ
    Close Browser


TC-21: Create Order Buy LIMIT IOC CXA
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration IOC
    Select Destination CXA
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${equity}      ${IOC}    CXA
    Click Place Buy Order
    Detail Order    EQ
    Close Browser


TC-22: Create Order Buy LIMIT IOC qCXA
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration IOC
    Select Destination qCXA
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${equity}      ${IOC}    qCXA
    Click Place Buy Order
    Detail Order    EQ
    Close Browser


TC-23: Create Order Buy MTL GTC BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${GTC}    BESTMKT
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-24: Create Order Buy MTL GTC ASX
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Select Destination ASX
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${GTC}    ASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser


TC-25: Create Order Buy MTL DO BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${DO}    BESTMKT
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-26: Create Order Buy MTL DO ASX
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Select Destination ASX
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${DO}    ASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser


TC-27: Create Order Buy MTL DO CXA
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Select Destination CXA
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${DO}    CXA
    Click Place Buy Order
    Detail Order    EQ
    Close Browser


TC-28: Create Order Buy MTL GTD BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTD
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${GTD}    BESTMKT
    Click Place Buy Order
    Detail Order    EQ
    Close Browser


TC-29: Create Order Buy MTL GTD ASX
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTD
    Select Destination ASX
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${GTD}    ASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-30: Create Order Buy MTL FOK BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration FOK
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${FOK}    BESTMKT
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-31: Create Order Buy MTL FOK ASX
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration FOK
    Select Destination ASX
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${FOK}    ASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-32: Create Order Buy MTL FOK CXA
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration FOK
    Select Destination CXA
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${FOK}    CXA
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-33: Create Order Buy MTL IOC BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration IOC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${IOC}    BESTMKT
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-34: Create Order Buy MTL IOC ASX
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration IOC
    Select Destination ASX
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${IOC}    ASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-35: Create Order Buy MTL IOC CXA
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration IOC
    Select Destination CXA
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${IOC}    CXA
    Click Place Buy Order
    Detail Order    EQ
    Close Browser







# SELL
TC-36: Create Order Sell LIMIT GTC BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input equity                    ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        SELL          LIMIT          ${equity}      ${GTC}    BESTMKT
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-37: Create Order Sell LIMIT GTC ASX
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration GTC
    Select Destination ASX
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${equity}      ${GTC}    ASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser


TC-38: Create Order Sell LIMIT DO BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input equity                    ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        SELL          LIMIT          ${equity}      ${DO}    BESTMKT
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-39: Create Order Sell LIMIT DO BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input equity                    ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        SELL          LIMIT          ${equity}      ${DO}    BESTMKT
    Click Place Sell Order
    Detail Order    EQ
    Close Browser


TC-40: Create Order Sell LIMIT DO ASX
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration DO
    Select Destination ASX
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${equity}      ${DO}    ASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser


TC-41: Create Order Sell LIMIT DO ASXCP
    [Tags]                      Regression
    Login Happy Cases           ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username              ${user}
    Input equity                ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity              ${quantity}
    Input Price                 ${price} 
    Select Duration DO
    Select Destination ASXCP
    Click Review Order
    Verify Review Order         ${user}        SELL          LIMIT          ${equity}      ${DO}    ASXCP
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-42: Create Order Sell LIMIT DO CXA
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration DO
    Select Destination CXA
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${equity}      ${DO}    CXA
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-43: Create Order Sell LIMIT DO qCXA
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration DO
    Select Destination qCXA
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${equity}      ${DO}    qCXA
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-44: Create Order Sell LIMIT GTD BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input equity                    ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration GTD
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        SELL          LIMIT          ${equity}      ${GTD}    BESTMKT
    Click Place Sell Order
    Detail Order    EQ
    Close Browser


TC-45: Create Order Sell LIMIT GTD ASX
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration GTD
    Select Destination ASX
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${equity}      ${GTD}    ASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser



TC-46: Create Order Sell LIMIT FOK BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input equity                    ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration FOK
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        SELL          LIMIT          ${equity}      ${FOK}    BESTMKT
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-47: Create Order Sell LIMIT FOK ASX
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration FOK
    Select Destination ASX
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${equity}      ${FOK}    ASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-48: Create Order Sell LIMIT FOK ASXCP
    [Tags]                      Regression
    Login Happy Cases           ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username              ${user}
    Input equity                ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity              ${quantity}
    Input Price                 ${price} 
    Select Duration FOK
    Select Destination ASXCP
    Click Review Order
    Verify Review Order         ${user}        SELL          LIMIT          ${equity}      ${FOK}    ASXCP
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-49: Create Order Sell LIMIT FOK CXA
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration FOK
    Select Destination CXA
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${equity}      ${FOK}    CXA
    Click Place Sell Order
    Detail Order    EQ
    Close Browser


TC-50: Create Order Sell LIMIT IOC BESTMKT
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input equity                    ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration IOC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        SELL          LIMIT          ${equity}      ${IOC}    BESTMKT
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-51: Create Order Sell LIMIT IOC ASX
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration IOC
    Select Destination ASX
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${equity}      ${IOC}    ASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-52: Create Order Sell LIMIT IOC ASXCP
    [Tags]                      Regression
    Login Happy Cases           ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username              ${user}
    Input equity                ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity              ${quantity}
    Input Price                 ${price} 
    Select Duration IOC
    Select Destination ASXCP
    Click Review Order
    Verify Review Order         ${user}        SELL          LIMIT          ${equity}      ${IOC}    ASXCP
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-53: Create Order Sell LIMIT IOC CXA
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration IOC
    Select Destination CXA
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${equity}      ${IOC}    CXA
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-54: Create Order Sell LIMIT IOC qCXA
    [Tags]                     Regression
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration IOC
    Select Destination qCXA
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${equity}      ${IOC}    qCXA
    Click Place Sell Order
    Detail Order    EQ
    Close Browser


TC-55: Create Order Sell MTL GTC BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${GTC}    BESTMKT
    Click Place Sell Order
    Detail Order    EQ
    Close Browser


TC-56: Create Order Sell MTL GTC ASX
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Select Destination ASX
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${GTC}    ASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser


TC-57: Create Order Sell MTL DO BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${DO}    BESTMKT
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-58: Create Order Sell MTL DO ASX
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Select Destination ASX
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${DO}    ASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-59: Create Order Sell MTL DO CXA
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Select Destination CXA
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${DO}    CXA
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-60: Create Order Sell MTL GTD BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTD
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${GTD}    BESTMKT
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-61: Create Order Sell MTL GTD ASX
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTD
    Select Destination ASX
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${GTD}    ASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser


TC-62: Create Order Sell MTL FOK BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration FOK
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${FOK}    BESTMKT
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-63: Create Order Sell MTL FOK ASX
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration FOK
    Select Destination ASX
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${FOK}    ASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-64: Create Order Sell MTL FOK CXA
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration FOK
    Select Destination CXA
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${FOK}    CXA
    Click Place Sell Order
    Detail Order    EQ
    Close Browser


TC-65: Create Order Sell MTL IOC BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration IOC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${IOC}    BESTMKT
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-66: Create Order Sell MTL IOC ASX
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration IOC
    Select Destination ASX
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${IOC}    ASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-67: Create Order Sell MTL IOC CXA
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration IOC
    Select Destination CXA
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${IOC}    CXA
    Click Place Sell Order
    Detail Order    EQ
    Close Browser


TC-68: Create Order Sell STOPLIMIT GTC BESTMKT
    [Tags]                          Regression
    Login Happy Cases               ${URL}              ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input equity                    ${equity}
    Click Sell
    Select Order Type STOPLIMIT
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Input trigger price             ${trigger_price}
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}             SELL          STOP LIMIT     ${equity}      ${GTC}    BESTMKT
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-69: Create Order Sell STOPLIMIT GTC ASX
    [Tags]                         Regression
    Login Happy Cases              ${URL}              ${Browser}    ${username}    ${password}
    Open new Order
    Input username                 ${user}
    Input equity                   ${equity}
    Click Sell
    Select Order Type STOPLIMIT
    Input Quantity                 ${quantity}
    Input Price                    ${price} 
    Input trigger price            ${trigger_price}
    Select Destination ASX
    Click Review Order
    Verify Review Order            ${user}             SELL          STOP LIMIT     ${equity}      ${GTC}    ASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser




### ETFs ###
TC-70: Create Order Buy LIMIT GTC BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input etf                       ${etf}
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        BUY           LIMIT          ${etf}         ${GTC}    BESTMKT
    Click Place Buy Order
    Detail Order    ETF
    Close Browser

TC-71: Create Order Buy LIMIT DO BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input etf                       ${etf}
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        BUY           LIMIT          ${etf}         ${DO}    BESTMKT
    Click Place Buy Order
    Detail Order    ETF
    Close Browser

TC-72: Create Order Buy MTL GTC
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input etf                          ${etf}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${etf}         ${GTC}    BESTMKT
    Click Place Buy Order
    Detail Order    ETF
    Close Browser

TC-73: Create Order Buy MTL DO
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input etf                          ${etf}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${etf}         ${DO}    BESTMKT
    Click Place Buy Order
    Detail Order    ETF
    Close Browser


TC-74: Create Order Sell Limit GTC BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input etf                       ${etf}
    Click Sell
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        SELL          LIMIT          ${etf}         ${GTC}    BESTMKT
    Click Place Sell Order
    Detail Order    ETF
    Close Browser

TC-75: Create Order Sell Limit DO BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input etf                       ${etf}
    Click Sell
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        SELL          LIMIT          ${etf}         ${DO}    BESTMKT
    Click Place Sell Order
    Detail Order    ETF
    Close Browser

TC-76: Create Order Sell MTL GTC BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input etf                          ${etf}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${etf}         ${GTC}    BESTMKT
    Click Place Sell Order
    Detail Order    ETF
    Close Browser

TC-77: Create Order Sell MTL DO BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input etf                          ${etf}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${etf}         ${DO}    BESTMKT
    Click Place Sell Order
    Detail Order    ETF
    Close Browser

TC-78: Create Order Sell Stop Limit GTC BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}              ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input etf                       ${etf}
    Click Sell
    Select Order Type STOPLIMIT
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Input trigger price             ${trigger_price}
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}             SELL          STOP LIMIT     ${etf}         ${GTC}    BESTMKT
    Click Place Sell Order
    Detail Order    ETF
    Close Browser


### MF ###
TC-79: Create Order Buy LIMIT GTC BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input mf                        ${mf}
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        BUY           LIMIT          ${mf}          ${GTC}    BESTMKT
    Click Place Buy Order
    Detail Order    MF
    Close Browser

TC-80: Create Order Buy LIMIT DO BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input mf                        ${mf}
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        BUY           LIMIT          ${mf}          ${DO}    BESTMKT
    Click Place Buy Order
    Detail Order    MF
    Close Browser


TC-81: Create Order Buy MTL GTC BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input mf                           ${mf}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${mf}          ${GTC}    BESTMKT
    Click Place Buy Order
    Detail Order    MF
    Close Browser

TC-82: Create Order Buy MTL DO BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input mf                           ${mf}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${mf}          ${DO}    BESTMKT
    Click Place Buy Order
    Detail Order    MF
    Close Browser

TC-83: Create Order Sell LIMIT GTC BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input mf                        ${mf}
    Click Sell
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        SELL          LIMIT          ${mf}          ${GTC}    BESTMKT
    Click Place Sell Order
    Detail Order    MF
    Close Browser

TC-84: Create Order Sell LIMIT DO BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input mf                        ${mf}
    Click Sell
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        SELL          LIMIT          ${mf}          ${DO}    BESTMKT
    Click Place Sell Order
    Detail Order    MF
    Close Browser

TC-85: Create Order Sell MTL GTC BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input mf                           ${mf}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC 
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${mf}          ${GTC}    BESTMKT
    Click Place Sell Order
    Detail Order    MF
    Close Browser

TC-86: Create Order Sell MTL DO BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input mf                           ${mf}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${mf}          ${DO}    BESTMKT
    Click Place Sell Order
    Detail Order    MF
    Close Browser

TC-87: Create Order Sell STOPLIMIT GTC BESTMARKET
    [Tags]                         Regression
    Login Happy Cases              ${URL}              ${Browser}    ${username}    ${password}
    Open new Order
    Input username                 ${user}
    Input mf                       ${mf}
    Click Sell
    Select Order Type STOPLIMIT
    Input Quantity                 ${quantity}
    Input Price                    ${price} 
    Input trigger price            ${trigger_price}
    Select Duration GTC
    Click Review Order
    Verify Review Order            ${user}             SELL          STOP LIMIT     ${mf}          ${GTC}    BESTMKT
    Click Place Sell Order
    Detail Order    MF
    Close Browser


#WARRANT

TC-88: Create Order Buy LIMIT GTC BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input warrant                   ${warrant}
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        BUY           LIMIT          ${warrant}     ${GTC}    BESTMKT
    Click Place Buy Order
    Detail Order    WAFKOA
    Close Browser

TC-89: Create Order Buy MTL GTC BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input warrant                      ${warrant}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${warrant}     ${GTC}    BESTMKT
    Click Place Buy Order
    Detail Order    WAFKOA
    Close Browser

TC-90: Create Order Sell LIMIT GTC BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input warrant                   ${warrant}
    Click Sell
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        SELL          LIMIT          ${warrant}     ${GTC}    BESTMKT
    Click Place Sell Order
    Detail Order    WAFKOA
    Close Browser

TC-91: Create Order Sell MTL GTC BESTMARKET
    [Tags]                             Regression
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input warrant                      ${warrant}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${warrant}     ${GTC}    BESTMKT
    Click Place Sell Order
    Detail Order    WAFKOA
    Close Browser

TC-92: Create Order Sell STOPLIMIT GTC BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}              ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input warrant                   ${warrant}
    Click Sell
    Select Order Type STOPLIMIT
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Input trigger price             ${trigger_price}
    Select Duration GTC
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}             SELL          STOP LIMIT     ${warrant}     ${GTC}    BESTMKT
    Click Place Sell Order
    Detail Order    WAFKOA
    Close Browser



#OPTION
TC-93: Create Order Buy Limit DO BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input option                    ${option}
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        BUY           LIMIT          ${option}      ${DO}    BESTMKT
    Click Place Buy Order
    Detail Order    ABXO
    Close Browser

TC-94: Create Order Sell DO BESTMARKET
    [Tags]                          Regression
    Login Happy Cases               ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                  ${user}
    Input option                    ${option}
    Click Sell
    Select Order Type Limit
    Input Quantity                  ${quantity}
    Input Price                     ${price} 
    Select Duration DO
    Select Destination BESTMARKET
    Click Review Order
    Verify Review Order             ${user}        SELL          LIMIT          ${option}      ${DO}    BESTMKT
    Click Place Sell Order
    Detail Order    ABXO
    Close Browser





### OUT TRADING ###
TC-Out Validate Not Enough Cash
    [Tags]                                   ValidateOut
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username                           ${user}
    Input equity                             ${equity}
    Select Order Type Limit
    Input Quantity                           ${quantity}
    Input Price                              ${price} 
    Select Duration GTC
    Click Review Order
    Verify Review Order                      ${user}        BUY           LIMIT          ${equity}      ${GTC}    qASX
    Click Place Buy Order Not Enough Cash
    Close Browser

TC-95: Create Order Buy LIMIT GTC qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration GTC
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${equity}      ${GTC}    qASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-96: Create Order Buy LIMIT DO qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration DO
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${equity}      ${DO}    qASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-97: Create Order Buy LIMIT GTD qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration GTD
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${equity}      ${GTD}    qASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-98: Create Order Buy MTL GTC qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${GTC}    qASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-99: Create Order Buy MTL DO qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${DO}    qASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-99: Create Order Buy MTL GTD qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTD
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${equity}      ${GTD}    qASX
    Click Place Buy Order
    Detail Order    EQ
    Close Browser

TC-100: Create Order Sell LIMIT GTC qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration GTC
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${equity}      ${GTC}    qASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-101: Create Order Sell LIMIT DO qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input equity               ${equity}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration DO
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${equity}      ${DO}    qASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-102: Create Order Sell MTL GTC qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${GTC}    qASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-103: Create Order Sell MTL DO qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${DO}    qASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-104: Create Order Sell MTL GTD qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input equity                       ${equity}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTD
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${equity}      ${GTD}    qASX
    Click Place Sell Order
    Detail Order    EQ
    Close Browser

TC-105: Create Order Buy LIMIT DO qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input etf                  ${etf}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration DO
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${etf}         ${DO}    qASX
    Click Place Buy Order
    Detail Order    ETF
    Close Browser

TC-106: Create Order Buy LIMIT GTC qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input etf                  ${etf}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration GTC
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${etf}         ${GTC}    qASX
    Click Place Buy Order
    Detail Order    ETF
    Close Browser

TC-107: Create Order Buy MTL DO qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input etf                          ${etf}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${etf}         ${DO}    qASX
    Click Place Buy Order
    Detail Order    ETF
    Close Browser

TC-108: Create Order Buy MTL GTC qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input etf                          ${etf}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Click Review Order
    Verify Review Order                ${user}        BUY            MARKET TO LIMIT    ${etf}         ${GTC}    qASX
    Click Place Buy Order
    Detail Order    ETF
    Close Browser

TC-109: Create Order Sell LIMIT DO qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input etf                  ${etf}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration DO
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${etf}         ${DO}    qASX
    Click Place Sell Order
    Detail Order    ETF
    Close Browser


TC-110: Create Order Sell LIMIT GTC qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input etf                  ${etf}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration GTC
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${etf}         ${GTC}    qASX
    Click Place Sell Order
    Detail Order    ETF
    Close Browser

TC-111: Create Order Sell MTL DO qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input etf                          ${etf}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${etf}         ${DO}    qASX
    Click Place Sell Order
    Detail Order    ETF
    Close Browser

TC-112: Create Order Sell MTL GTC qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input etf                          ${etf}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Click Review Order
    Verify Review Order                ${user}        SELL           MARKET TO LIMIT    ${etf}         ${GTC}    qASX
    Click Place Sell Order
    Detail Order    ETF
    Close Browser

TC-113: Create Order Sell STOPLIMIT GTC qASX
    [Tags]                         outTrading
    Login Happy Cases              ${URL}              ${Browser}    ${username}    ${password}
    Open new Order
    Input username                 ${user}
    Input etf                      ${etf}
    Click Sell
    Select Order Type STOPLIMIT
    Input Quantity                 ${quantity}
    Input Price                    ${price} 
    Input trigger price            ${trigger_price}
    Select Duration GTC
    Click Review Order
    Verify Review Order            ${user}             SELL          STOP LIMIT     ${etf}         ${GTC}    qASX
    Click Place Sell Order
    Detail Order    ETF
    Close Browser


TC-114: Create Order Buy LIMIT DO qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input mf                   ${mf}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration DO
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${mf}          ${DO}    qASX
    Click Place Buy Order
    Detail Order    MF
    Close Browser

TC-115: Create Order Buy LIMIT GTC qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input mf                   ${mf}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration GTC
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${mf}          ${GTC}    qASX
    Click Place Buy Order
    Detail Order    MF
    Close Browser

TC-116: Create Order Buy MTL DO qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input mf                           ${mf}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Click Review Order
    Verify Review Order                ${user}        BUY           MARKET TO LIMIT    ${mf}          ${DO}    qASX
    Click Place Buy Order
    Detail Order    MF
    Close Browser

TC-117: Create Order Buy MTL GTC qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input mf                           ${mf}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Click Review Order
    Verify Review Order                ${user}        BUY           MARKET TO LIMIT    ${mf}          ${GTC}    qASX
    Click Place Buy Order
    Detail Order    MF
    Close Browser

TC-118: Create Order Sell LIMIT DO qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input mf                   ${mf}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration DO
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${mf}          ${DO}    qASX
    Click Place Sell Order
    Detail Order    MF
    Close Browser


TC-119: Create Order Sell LIMIT GTC qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input mf                   ${mf}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration GTC
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${mf}          ${GTC}    qASX
    Click Place Sell Order
    Detail Order    MF
    Close Browser

TC-120: Create Order Sell MTL DO qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input mf                           ${mf}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration DO
    Click Review Order
    Verify Review Order                ${user}        SELL          MARKET TO LIMIT    ${mf}          ${DO}    qASX
    Click Place Sell Order
    Detail Order    MF
    Close Browser

TC-121: Create Order Sell MTL GTC qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input mf                           ${mf}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Click Review Order
    Verify Review Order                ${user}        SELL          MARKET TO LIMIT    ${mf}          ${GTC}    qASX
    Click Place Sell Order
    Detail Order    MF
    Close Browser

TC-122: Create Order Sell STOPLIMIT GTC qASX
    [Tags]                         outTrading
    Login Happy Cases              ${URL}              ${Browser}    ${username}    ${password}
    Open new Order
    Input username                 ${user}
    Input mf                       ${mf}
    Click Sell
    Select Order Type STOPLIMIT
    Input Quantity                 ${quantity}
    Input Price                    ${price} 
    Input trigger price            ${trigger_price}
    Select Duration GTC
    Click Review Order
    Verify Review Order            ${user}             SELL          STOP LIMIT     ${mf}          ${GTC}    qASX
    Click Place Sell Order
    Detail Order    MF
    Close Browser

TC-123: Create Order Buy LIMIT GTC qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input warrant              ${warrant}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration GTC
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${warrant}     ${GTC}    qASX
    Click Place Buy Order
    Detail Order    WAFKOA
    Close Browser

TC-124: Create Order Buy MTL GTC qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input warrant                      ${warrant}
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Click Review Order
    Verify Review Order                ${user}        BUY           MARKET TO LIMIT    ${warrant}     ${GTC}    qASX
    Click Place Buy Order
    Detail Order    WAFKOA
    Close Browser

TC-125: Create Order Sell LIMIT GTC qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input warrant              ${warrant}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration GTC
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${warrant}     ${GTC}    qASX
    Click Place Sell Order
    Detail Order    WAFKOA
    Close Browser


TC-126: Create Order Sell MTL GTC qASX
    [Tags]                             outTrading
    Login Happy Cases                  ${URL}         ${Browser}    ${username}       ${password}
    Open new Order
    Input username                     ${user}
    Input warrant                      ${warrant}
    Click Sell
    Select Order Type MarketToLimit
    Input Quantity                     ${quantity}
    Select Duration GTC
    Click Review Order
    Verify Review Order                ${user}        SELL          MARKET TO LIMIT    ${warrant}     ${GTC}    qASX
    Click Place Sell Order
    Detail Order    WAFKOA
    Close Browser

TC-127: Create Order Sell STOPLIMIT GTC qASX
    [Tags]                         outTrading
    Login Happy Cases              ${URL}              ${Browser}    ${username}    ${password}
    Open new Order
    Input username                 ${user}
    Input warrant                  ${warrant}
    Click Sell
    Select Order Type STOPLIMIT
    Input Quantity                 ${quantity}
    Input Price                    ${price} 
    Input trigger price            ${trigger_price}
    Select Duration GTC
    Click Review Order
    Verify Review Order            ${user}             SELL          STOP LIMIT     ${warrant}     ${GTC}    qASX
    Click Place Sell Order
    Detail Order    WAFKOA
    Close Browser

TC-128: Create Order Buy Limit DO qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input option               ${option}
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Select Duration DO
    Click Review Order
    Verify Review Order        ${user}        BUY           LIMIT          ${option}      ${DO}    qASX
    Click Place Buy Order
    Detail Order    ABXO
    Close Browser

TC-129: Create Order Sell LIMIT DO qASX
    [Tags]                     outTrading
    Login Happy Cases          ${URL}         ${Browser}    ${username}    ${password}
    Open new Order
    Input username             ${user}
    Input option               ${option}
    Click Sell
    Select Order Type Limit
    Input Quantity             ${quantity}
    Input Price                ${price} 
    Click Review Order
    Verify Review Order        ${user}        SELL          LIMIT          ${option}      ${DO}    qASX
    Click Place Sell Order
    Detail Order    ABXO
    Close Browser

















