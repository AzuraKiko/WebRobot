*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     JSONSchemaLibrary
Library     Collections
Resource    ../../../Utils/API.robot
Resource    ../../../Page/WebTrading/OrderPage.robot
Resource    ../../../Page/WebTrading/LoginPage.robot
Resource    ../../../Page/WebTrading/CBOE/AlertPage.robot


*** Variables ***
${environment}      ${EMPTY}


*** Test Cases ***
Create And Verify Price Alert
    [Documentation]    Test to create and verify a price alert
    [Tags]    alert    smoke
    Open Alert
    Open New Alert
    Verify New Alert Screen
    Create Price Alert    Test Alert    price    above    100.00
    Verify Alert Created    Test Alert

Delete Price Alert
    [Documentation]    Test to delete an existing price alert
    [Tags]    alert    smoke
    Open Alert
    Delete Alert    Test Alert
    Element Should Not Be Visible    //div[contains(text(),'Test Alert')]

Create Multiple Alerts
    [Documentation]    Test to create multiple alerts with different conditions
    [Tags]    alert    regression
    Open Alert
    Open New Alert
    Verify New Alert Screen

    # Create first alert
    Create Price Alert    Alert Above    price    above    150.00
    Verify Alert Created    Alert Above

    # Create second alert
    Open New Alert
    Create Price Alert    Alert Below    price    below    50.00
    Verify Alert Created    Alert Below

    # Clean up
    Delete Alert    Alert Above
    Delete Alert    Alert Below
