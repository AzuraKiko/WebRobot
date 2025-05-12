*** Variables ***
${btnMenu}                                          //div[@id='root']/div/div[2]/div/div[2]/div
${btnMenu_Fundamentals}                             //div[@id='menu-3']
${btnMenu_Fundamentals_Profile}                     //div[@id='menu-3-0']
${btnMenu_Fundamentals_Statistics}                  //div[@id='menu-3-1']
${btnMenu_Fundamentals_Analysis}                    //div[@id='menu-3-2']
${btnMenu_Fundamentals_Holders}                     //div[@id='menu-3-3']

${btnMenu_MarketAnalysis}                           //div[@id='menu-5']
${btnMenu_MarketAnalysis_MarketOverview}            //div[@id='menu-5-0']
${btnMenu_MarketAnalysis_Chart}                     //div[@id='menu-5-1']
${btnMenu_MarketAnalysis_Alert}                     //div[@id='menu-5-2']
${btnMenu_MarketAnalysis_Derivatives}               //div[@id='menu-5-3']
${btnMenu_MarketAnalysis_News}                      //div[@id='menu-5-4']

${btnMenu_Trading}                                  //div[@id='menu-6']
${btnMenu_Trading_MarketDepth}                      //div[@id='menu-6-4']
${btnMenu_Trading_CourseOfSales}                    //div[@id='menu-6-6']
${btnMenu_Trading_SecurityDetails}                  //div[@id='menu-6-7']
${btnMenu_Trading_Watchlist}                        //div[@id='menu-6-9']

${btnMenu_Portfolio}                                //div[@id='menu-7']
${btnMenu_Portfolio_Holdings}                       //div[@id='menu-7-0']
${btnMenu_Portfolio_Summary}                        //div[@id='menu-7-1']

${btnMenu_Account}                                  //div[@id='menu-8']
${btnMenu_Account_AccountDetails}                   //div[@id='menu-8-0']
${btnMenu_Account_ContractNotes}                    //div[@id='menu-8-1']
${btnMenu_Account_Insights}                         //div[@id='menu-8-2']
${btnMenu_Account_Reports}                          //div[@id='menu-8-3']
${btnMenu_Account_Activities}                       //div[@id='menu-8-4']
${btnMenu_Account_UserInfo}                         //div[@id='menu-8-5']

${btnMenu_Operator}                                 //div[@id='menu-10']
${btnMenu_Operator_AllHoldings}                     //div[@id='menu-10-0']
${btnMenu_Operator_AllOrders}                       //div[@id='menu-10-1']

# MARKET OVERVIEW
${quickFilter}                                      (//div[text()='quick filter'])[2]
${canvas}                                           //span[text()='market overview']/ancestor::div[@class='lm_header']/following-sibling::div//canvas
${selectTypeSymbol}                                 (//span[text()='market overview']/ancestor::div[@class='lm_header']/following-sibling::div//*[@class='svgIcon undefined'])[2]
${ASXTopGainer}                                     //label[text()='ASX Top Gainers']
${indices}                                          //label[text()='indices']

${majorHolder}                                      //button[text()='MAJOR HOLDERS']
${insiderRoster}                                    //button[text()='INSIDER ROSTER']
${insiderTransactions}                              //button[text()='INSIDER TRANSACTIONS']
${inputSearchSymbol}                                //input[@data-role='search' and @placeholder='Search']
${indicator}                                        (//div[text()='Indicators'])[2]/ancestor::button
${aroon}                                            //span[text()='Aroon']
${btnCreateAlert}                                   (//div[@class='navbar more']//div)[1]
${searchCode}                                       //input[@class='size--3']
${itemSuggest}                                      (//div[@class='itemSuggestCompanyName showTitle html'])[1]
${btnConfirm}                                       //span[text()='Confirm']
${tabAlert}                                         //span[text()='alerts']
${info}                                             //div[@class='info]
${targetValue}                                      //div[text()='target value']/following-sibling::div//input
${btnOk}                                            //span[text()='ok']
${allMarket}                                        //div[text()='all market']
${relatedNews}                                      //div[text()='related news']
