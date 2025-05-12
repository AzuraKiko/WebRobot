*** Settings ***
Library     SeleniumLibrary
Library    Collections
Resource    ../Page/WebTrading/ViewPage.robot
Resource     ../Page/WebTrading/LoginPage.robot
Resource     ../Data/Const.robot
Resource     ../Data/Env.py

*** Test Cases ***

#FUNDARMENTAL
TC-02: Check View Fundamental Profile
    [Tags]    FUNDARMENTAL
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Profile
    Verify View Profile
    Close Browser

TC-02: Check View Fundamental Statistics
    [Tags]    FUNDARMENTAL
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Statistics
    Verify View Fundamental Statistics
    Close Browser

TC-02: Check View Fundamental Analysis
    [Tags]    FUNDARMENTAL
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Analysis
    Verify View Fundamental Analysis
    Close Browser

TC-02: Check View Fundamental Major Holders
    [Tags]    FUNDARMENTAL
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Major Holder
    Verify View Major Holder
    Close Browser

TC-02: Check View insider roaster
    [Tags]    FUNDARMENTAL
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View insider roaster
    Close Browser

TC-02: Check View insider transactions
    [Tags]    FUNDARMENTAL
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View insider transactions
    Verify View insider transactions
    Close Browser

#MARKET ANALYSIS
Test View market overview
    [Tags]    MARKETANALYSIS
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Market Overview
    Verify View Market Overview
    Close Browser
Test View chart
    [Tags]    MARKETANALYSIS
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Chart
    Close Browser



Test View Alert
    [Tags]    MARKETANALYSIS
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Alert
    Close Browser

Test Create alert
    [Tags]    MARKETANALYSIS
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Alert
    Create Alert
    Verify create alert
    Close Browser

Test edit alert
    [Tags]    MARKETANALYSIS
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Alert
    Edit Alert
    Verify edit alert
    Close Browser

Test delete alert
    [Tags]    MARKETANALYSIS
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Alert
    Delete alert
    Create Alert
    Verify create alert
    Close Browser

Test active alert
    [Tags]    MARKETANALYSIS
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Alert
    Active alert
    Close Browser

Test View Derivatives
    [Tags]    MARKETANALYSIS
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Derivatives
    Close Browser

Test view market news all market
    [Tags]    MARKETANALYSIS
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Market News
    Close Browser

Test view market news relatedNews
    [Tags]    MARKETANALYSIS
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Market News relatedNews
    Close Browser

Test view market depth
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Market Depth
    Close Browser

Test view market depth
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Market Depth
    Close Browser

Test View Course Of Sales
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Course Of Sales
    Close Browser

Test View Security Details
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Security Details
    Close Browser

Test View Watchlist
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Watchlist
    Close Browser

Test View Portfolio(Holding)
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Portfolio(Holding)
    Close Browser

Test View Portfolio Summary
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Portfolio Summary
    Close Browser


Test View Account Details
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Account Details
    Close Browser

Test View Contract Notes
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Contract Notes
    Close Browser

Test View Reports
    Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
    View Reports
    Close Browser
Test view Activities
     Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
     View Activities
     Close Browser

Test view User Info
     Login Happy Cases                        ${URL}         ${Browser}    ${username}    ${password}
     View User Info
     Close Browser

Test view operator display all holding
    Login Happy Cases    ${URL}         ${Browser}    ${username}    ${password}
    View All Holding
    Close Browser

Test view operator display All Orders
    Login Happy Cases    ${URL}         ${Browser}    ${username}    ${password}
    View All Orders
    Close Browser
