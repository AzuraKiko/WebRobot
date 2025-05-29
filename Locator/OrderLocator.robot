*** Variables ***
# Account Variables
${account}                          100025

# Symbol Variables
${equity}                           BHP.ASX
${etf}                              AAA.ASX
${mf}                               MGOC.ASX
${warrant}                          WAFKOA.ASX
${option}                           ABXO.ASX
${14D.CXA}                          14D.CXA

# Navigation Locators
${leftHumbergerMenu}                //div[contains(@class,'headerRoot')]//img/preceding-sibling::*
${leftTradingMenu}                  //*[@id="mainMenu"]//div[text()='trading']
${menuOrdersList}                   //div[@id='menu-6-1']/div/div

# New Order Form Locators
${btnNewOrder}                      (//div[text()='new order'])[1]
${inputSearch_Account}              //div[contains(text(),'search account')]//preceding-sibling::input
${inputSearch_Symbol}               //div[contains(text(),'search symbol')]//preceding-sibling::input
${suggestAccount}                   (//div[@class="itemSuggest searchAllAccounts showTitle"])[1]
${suggestSymbol}                    (//div[contains(@class,'itemSuggestSymbol')])[1]

# Symbol Search Result Locators
${clickSearch_equity}               //span[@title='${equity}']
${clickSearch_etf}                  //span[@title='${etf}']
${clickSearch_mf}                   //span[@title='${mf}']
${clickSearch_warrant}              //span[@title='${warrant}']
${clickSearch_option}               //span[@title='${option}']

# Order Type Selection Locators
${clickSelectOderType}              //div[normalize-space()='order type']/following-sibling::div
${clickOrderType_Limit}             //div[@id="dropDownContent"]//label[text()='limit']
${clickOrderType_MarketToLimit}     //div[@id="dropDownContent"]//label[text()='market to limit']
${clickOrderTypeSt_StopLimit}       //div[@id="dropDownContent"]//label[text()='stop limit']

# Order Details Input Locators
${inputQuantity}                    css=.inputDrop:nth-child(1) .inputDrop
${inputLimitPrice}                  css=.inputDropLimitPrice > .inputDrop
${inputTriggerPrice}                //div[contains(text(),'trigger price')]/following-sibling::div/div/input

# Duration Selection Locators
${clickSelectDuration}              //div[normalize-space()='duration']/following-sibling::div
${clickSelectDuration_DayOnly}      //*[@id="dropDownContent"]//label[text()='Day Only']
${clickSelectDuration_GTC}          //*[@id="dropDownContent"]//label[text()='Good Till Cancelled']
${clickSelectDuration_GTD}          //*[@id="dropDownContent"]//label[text()='Good Till Date']
${clickSelectDuration_FOK}          //*[@id="dropDownContent"]//label[text()='Fill or Kill']
${clickSelectDuration_IOC}          //*[@id="dropDownContent"]//label[text()='Immediate or Cancel']

# Destination Selection Locators
${clickDestination}                 //div[text()='destination']/following-sibling::div
${clickdestination_BESTMKT}         //*[@id="dropDownContent"]//label[text()='BESTMKT']
${clickdestination_ASX}             //*[@id="dropDownContent"]//label[text()='ASX']
${clickdestination_ASXCP}           //*[@id="dropDownContent"]//label[text()='ASXCP']
${clickdestination_qASX}            //*[@id="dropDownContent"]//label[text()='qASX']
${clickdestination_CXA}             //*[@id="dropDownContent"]//label[text()='CXA']
${clickdestination_qCXA}            //*[@id="dropDownContent"]//label[text()='qCXA']
${clickdestination_AXW}             //*[@id="dropDownContent"]//label[text()='AXW']

# Order Action Button Locators
${btnReviewOrder}                   //div[contains(text(),'review order')][@class='text-uppercase ']
${btnPlaceBuyOrder}                 //div[contains(text(),'place buy order')]
${btnPlaceSellOrder}                //div[contains(text(),'place sell order')]
${txtVerifyOrderSuccess}            //div[contains(text(),'Place order successfully')]
${sell}                             //div[@class='windowBodyForm']//div[text()='sell']

# Order List Locators
${inputSearchOrderList}             //input[@class='size--3']
${clickBtnSearch}                   //div[@id='orderRoot']/div/div/div/div/div[2]/div/div[2]/span
${canvasLocator_OrderList}          //div[3]/div/div/canvas
${quickFilter}                      //div[@class='orderSearch ']//input
${btnGo}                            //span[text()='go']
${canvas}                           //div[3]/div/div/canvas

# Order Modification Locators
${btnModifyOrder}                   //span[@class='text-uppercase'][contains(text(),'modify order')]
${btnCancelOrder}                   //span[@class='text-uppercase'][contains(text(),'cancel order')]
${btnModifyBuyOrder}                //div[@class='text-uppercase'][contains(text(),'modify buy order')]
${btnModifySellOrder}               //div[@class='text-uppercase'][contains(text(),'modify sell order')]
${btnCancelOrderInPopup}            //span[@class='flex text-uppercase'][contains(text(),'cancel order')]
${btnOK}                            //span[@class='text-uppercase'][contains(text(),'ok')]

# Review Order Modal Locators
${accountID}                        (//div[text()='account id'])[1]/following-sibling::div
${side}                             (//div[text()='side'])[1]/following-sibling::div
${orderType}                        (//div[text()='order type'])[1]/following-sibling::div
${security}                         (//div[text()='security'])[1]/following-sibling::div
${qty}                              (//div[text()='quantity'])[1]/following-sibling::div
${limitPrice}                       (//div[text()='limit price'])[1]/following-sibling::div
${duration}                         (//div[text()='duration'])[1]/following-sibling::div
${destination}                      (//div[text()='destination'])[1]/following-sibling::div
${orderAmount}                      (//div[text()='order amount'])[1]/following-sibling::div
${estimateFee}                      (//div[text()='estimated fees'])[1]/following-sibling::div
${estimateTotal}                    (//div[text()='estimated total'])[1]/parent::div/following-sibling::div
${errorReviewMessage}               //div[@class='errorOrder size--3']

# Order Detail Modal Locators
${quantityDetail}                   //div[contains(text(),'quantity')]/following-sibling::div
${filledDtail}                      //div[text()='filled']/following-sibling::div
${orderTypeDetail}                  //div[text()='order type']/following-sibling::div
${limitPriceDetail}                 //div[text()='limit price']/following-sibling::div
${filledPrice}                      //div[text()='filled price']/following-sibling::div
${durationDetail}                   //div[text()='duration']/following-sibling::div
${exchangeDetail}                   //div[text()='exchange']/following-sibling::div
${sideDetail}                       //div[text()='side']/following-sibling::div
${productDetail}                    //div[text()='product']/following-sibling::div
${codeDetail}                       //div[text()='code']/following-sibling::div

# Trading Balance Locators
${tradingBalance}                   //div[text()='trading balance']/following-sibling::div//span
${clickDateTimePicker}              //div[text()='duration']/following-sibling::div//div[@class='react-datepicker__input-container']
