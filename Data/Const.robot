*** Variables ***
# Message
${ExpectedWarningMessage}       Incorrect Password or User Login. Please make sure your details are correct and try again
${ExpectedModalText}            Enter Your PIN
# Side
${BUY}                          BUY
${SELL}                         SELL

# Order Type
${LIMIT}                        LIMIT
${MARKETTOLIMIT}                MARKET TO LIMIT
${STOPLIMIT}                    STOP LIMIT

# Duration
${GTC}                          Good Till Cancelled
${GTD}                          Good Till
${FOK}                          Fill or Kill
${IOC}                          Immediate or Cancel
${DO}                           Day Only

# Destinations
${BESTMKT}                      BESTMARKET
${ASX}                          ASX
${ASXCP}                        ASXCP
${CXA}                          CXA
${qCXA}                         qCXA
${qASX}                         qASX

# Price
${quantity}                     2
${price}                        38.49
${trigger_price}                2
${max_qty}                      100

# ${Browser}    headlesschrome
# ${Browser}    edge
${Browser}                      chrome

# Symbol
${symbol}                       BHP
${exchangeCXA}                  CXA
${exchangeASX}                  ASX
${session_name}                 mysession1

# API
# ${urlLogin}    https://dev2-retail-api.equix.app
${urlLogin}                     https://equix-uat-retail-api.equix.app

# Icon
${icon_Loading}                 //img[@src="common/Spinner-white.svg"]
${role_list}                    //div[@class="list "]//div[contains(@id,'itemDropDown')]
