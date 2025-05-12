*** Settings ***
Library         SeleniumLibrary
Library         Collections
Resource    ../../Page/WebTrading/LoginPage.robot
Resource    ../../Page/WebTrading/Summary.robot

*** Variables ***
${url1_wlb}      https://uat.equix.app/?test&wlb=
${password}     Abc@1234
${email}       @novus-fintech.com

*** Test Cases ***
Summary _0023: Check display T+0, T+1, T+2. Wlb = Equix
    [Tags]      SUMMARY
    Login successful       https://uat.equix.app    autotest@equix.com.au       ${password}
    Go to Portfolio Summary
    Click Transaction not block
    Verify T0, T1, T2 display

Summary _0029: Check display Pending Settlement. Wlb = Equix
    [Tags]      SUMMARY
    Verify Pending Settlement Field undisplay

Summary _0036: Check Trading Balance. Wlb = Equix
    [Tags]      SUMMARY
    Input textbox Search Account and choose Account     108723
    Verify Trading Balance = Cash At Bank + Transaction not Booked
    Close Browser

Summary _0024: Check display T+0, T+1, T+2. Wlb = Morrison
    [Tags]      SUMMARY
    Login successful       ${url1_wlb}morrison       autotest.mo@novus-fintech.com        ${password}
    Go to Portfolio Summary
    Click Transaction not block
    Verify T0, T1, T2 display

Summary _0030: Check display Pending Settlement. Wlb = Morrison
    [Tags]      SUMMARY
    Verify Pending Settlement Field undisplay

Summary _0037: Check Trading Balance. Wlb = Morrison
    [Tags]      SUMMARY
    Input textbox Search Account and choose Account MO    108723
    Verify Trading Balance = Cash At Bank + Transaction not Booked
    Close Browser

Summary _0025: Check display T+0, T+1, T+2. Wlb = Tradeforgood2
    [Tags]      SUMMARY
    Login successful           https://tradeforgood2-uat.equix.app/    autotest.tfg2@novus-fintech.com        ${password}
    Go to Portfolio Summary MO
    Click Transaction not block
    Verify T0, T1, T2 display

Summary _0031: Check display Pending Settlement. Wlb = Tradeforgood2
    [Tags]      SUMMARY
    Verify Pending Settlement Field undisplay

Summary _0026: Check display T+0, T+1, T+2. Wlb = Tradeforgood
    [Tags]      SUMMARY
    Login successful        ${url1_wlb}tradeforgood       autotest.tfg@novus-fintech.com        ${password}
    Go to Portfolio Summary
    Click Transaction not block
    Verify T0, T1, T2 display

Summary _0032: Check display Pending Settlement. Wlb = Tradeforgood
    [Tags]      SUMMARY
    Verify Pending Settlement Field undisplay

Summary _0038: Check Trading Balance. Wlb = Tradeforgood
    [Tags]      SUMMARY
    Input textbox Search Account and choose Account MO     108723
    Verify Trading Balance = Cash At Bank + Transaction not Booked
    Close Browser

Summary _0027: Check display T+0, T+1, T+2. Wlb = Sharewise2
    [Tags]      SUMMARY
    Login successful        https://sharewise2-uat.equix.app/       autotest.sw2@novus-fintech.com        ${password}
    Go to Portfolio Summary SW2
    Verify T0, T1, T2 undisplay

Summary _0033: Check display Pending Settlement. Wlb = Sharewise2
    [Tags]      SUMMARY
    Verify Pending Settlement Field undisplay
    Close Browser