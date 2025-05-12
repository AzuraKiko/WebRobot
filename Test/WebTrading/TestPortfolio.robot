*** Settings ***
Library           SeleniumLibrary
Library           BrowserMobProxyLibrary
Resource          ../../Page/WebTrading/LoginPage.robot
Variables         ../../Data/Global.py
Resource          ../../Page/WebTrading/PortfolioPage.robot
*** Variables ***
${username}         hoan.nguyen@equix.com.au
${password}         123456Hh@
${API_ENDPOINT}     /market-info/symbol/ANN
*** Test Cases ***



