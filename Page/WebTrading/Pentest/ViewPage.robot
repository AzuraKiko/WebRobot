*** Settings ***
Library     SeleniumLibrary
Resource    ../Locator/ViewLocator.robot
Resource    ../Utils/CustomKeys.robot
*** Keywords ***
View Profile
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Fundamentals}
    Click To Element                ${btnMenu_Fundamentals_Profile}
View Statistics
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Fundamentals}
    Click To Element                ${btnMenu_Fundamentals_Statistics}
View Analysis
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Fundamentals}
    Click To Element                ${btnMenu_Fundamentals_Analysis}
View Holders
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Fundamentals}
    Click To Element                ${btnMenu_Fundamentals_Holders}
View Market Overview
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_MarketAnalysis}
    Click To Element                ${btnMenu_MarketAnalysis_MarketOverview}
View Chart
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_MarketAnalysis}
    Click To Element                ${btnMenu_MarketAnalysis_Chart}
View Alert
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_MarketAnalysis}
    Click To Element                ${btnMenu_MarketAnalysis_Alert}
View Derivatives
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_MarketAnalysis}
    Click To Element                ${btnMenu_MarketAnalysis_Derivatives}
View Market News
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_MarketAnalysis}
    Click To Element                ${btnMenu_MarketAnalysis_News}
View Market Depth
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Trading}
    Click To Element                ${btnMenu_Trading_MarketDepth}
View Course Of Sales
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Trading}
    Click To Element                ${btnMenu_Trading_CourseOfSales}
View Security Details
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Trading}
    Click To Element                ${btnMenu_Trading_SecurityDetails}
View Watchlist
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Trading}
    Click To Element                ${btnMenu_Trading_Watchlist}
View Portfolio(Holding)
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Portfolio}
    Click To Element                ${btnMenu_Portfolio_Holdings}
View Portfolio Summary
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Portfolio}
    Click To Element                ${btnMenu_Portfolio_Summary}
View Account Details
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Account}
    Click To Element                ${btnMenu_Account_AccountDetails}
View Contract Notes
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Account}
    Click To Element                ${btnMenu_Account_ContractNotes}
View Insights
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Account}
    Click To Element                ${btnMenu_Account_Insights}
View Reports
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Account}
    Click To Element                ${btnMenu_Account_Reports}
View Activities
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Account}
    Click To Element                ${btnMenu_Account_Activities}
View User Info
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Account}
    Click To Element                ${btnMenu_Account_UserInfo}
View All Holding
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Operator}
    Click To Element                ${btnMenu_Operator_AllHoldings}
View All Orders
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_Operator}
    Click To Element                ${btnMenu_Operator_AllOrders}
Verify View Market Overview
    Page Should Contain    ASX S&P 20
    Page Should Contain    ASX S&P 50
    Page Should Contain    ASX S&P 100
    Page Should Contain    ASX S&P 200

Verify View Profile
    Page Should Contain    ANZ Group Holdings Limited
    Page Should Contain    ANZ Centre
    Page Should Contain    Australia
    Page Should Contain    https://www.anz.com.au
    Page Should Contain    Banks - Diversified
    Page Should Contain    Level 9 833 Collins Street Docklands

Verify View Fundamental Statistics
    Page Should Contain    Market Cap (intraday)
    Page Should Contain    Trailing P/E
    Page Should Contain    Forward P/E
    Page Should Contain    Price/Sales (ttm)
    Page Should Contain    Price/Book (mrq)
    Page Should Contain    Currency in AUD

Verify View Fundamental Analysis
    Page Should Contain    No. of Analysts
    Page Should Contain    Avg. Estimate
    Page Should Contain    Low Estimate
    Page Should Contain    High Estimate
    Page Should Contain    Year Ago EPS
    Page Should Contain    No. of Analysts

Verify View Major Holder
    Page Should Contain    % of Shares Held by All Insider
    Page Should Contain    % of Shares Held by Institutions
    Page Should Contain    % of Float Held by Institutions
    Page Should Contain    Number of Institutions Holding Shares
    Page Should Contain    Top Mutual Fund Holders
    Page Should Contain    Top Institutional Holders

View Major Holder
    Click To Element                ${majorHolder}
       

View insider roaster
    Click To Element                ${insiderRoster}

View insider transactions
    Click To Element                ${insiderTransactions}

Verify View insider transactions
    Page Should Contain    Purchases
    Page Should Contain    Sales
    Page Should Contain    Net Shares Purchased (Sold)
    Page Should Contain    Total Insider Shares Held
    Page Should Contain    % Net Shares Purchased (Sold)
    Page Should Contain    Net Shares Purchased (Sold)
    Page Should Contain    % Change in Institutional Shares Held

Setting chart
    Double Click Element                    ${indicator}
    Click To Element                ${aroon}

Create alert
    Click To Element                ${btnCreateAlert}
    Input Text To Element    ${searchCode}    BHP.ASX
    Click To Element                ${itemSuggest}
    Click To Element                ${btnConfirm}
       

Verify create alert
    Page Should Contain    Create new alert successfully

Edit alert
    Click Element At Coordinates    ${btnCreateAlert}      5      80
    Input Text To Element    ${targetValue}    1
    Click To Element                ${btnConfirm}

Verify edit alert
    Page Should Not Contain   Modifying alert successfully

Delete alert
    Click Element At Coordinates    ${btnCreateAlert}      15    80
    Click To Element                ${btnOk}
      

Active alert
    Click Element At Coordinates    ${btnCreateAlert}      2380    80
    
View Market News relatedNews
    Mouse Over    ${btnMenu}
    Mouse Over    ${btnMenu_MarketAnalysis}
    Click To Element                ${btnMenu_MarketAnalysis_News}
    Click To Element                ${relatedNews}