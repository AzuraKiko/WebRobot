*** Settings ***
Resource        ../../Utils/Common.robot
Resource        ../../Page/WebTrading/LoginPage.robot
Resource        ../../Page/WebTrading/Pentest/Forgot_Pin.robot
Variables       ../../data/Env.py

*** Variables ***
${icon_Hamberger}                       //div[contains(@class,'headerRoot')]//img/preceding-sibling::*
${option_Portfolio}                     //*[@id="menu-7"]
${option_Portfolio_mo}                  //*[@id="menu-4"]
${option_Portfolio_sw2}                 //*[@id="menu-5"]
${option_Portfolio_Summary}             //*[@id="menu-7-1"]
${option_Portfolio_Summary_mo}          //*[@id="menu-4-1"]
${option_Portfolio_Summary_sw2}         //*[@id="menu-5-1"]
${Transaction_Not_Block}                //*[@class="itemLeft"]
${T0}                                   (//*[@class="itemLeft firstLetterUpperCase itemToggle showTitle"])[1]
${T1}                                   (//*[@class="itemLeft firstLetterUpperCase itemToggle showTitle"])[2]
${T2}                                   (//*[@class="itemLeft firstLetterUpperCase itemToggle showTitle"])[3]
${key1}                                 //div[@class="keyBoardRoot"]//div[normalize-space()='1']
${Pending_Settlement_Field}             //*[text()='pending settlement']//parent::div[@class="toggleSub"]
${textbox_Search_Account}               (//*[contains(@class,'accountSummaryContainer')]//*[@class="accSearchRowAd"])[2]//input
${textbox_Search_Account_MO}            (//*[contains(@class,'accountSummaryContainer')]//*[@class="accSearchRowAd"])[1]//input
${First_Option_In_Dropdown}             (//*[@class="itemSuggest searchAllAccounts showTitle"])[1]
${Icon_Loading}                         //*[@class="lm_tab lm_active loading theme-dark"]
${Field_By_Text1}                        (//*[@id="accountSummary"]//*[text()='CHANGE_ME']//following-sibling::div//div)[2]
${Field_By_Text2}                        //*[@id="accountSummary"]//*[text()='CHANGE_ME']//following-sibling::div//div

*** Keywords ***
Login successful
    [Arguments]     ${URL_wlb}    ${username}      ${password}
    Open Link Page     ${URL_wlb}     ${Browser}
    Click Sign In link
    Input textbox Email in Trading     ${username}
    Input textbox Password in Trading       ${password}
    Click button [Sign In]
    Wait Until Element Is Visible    ${popup_Enter_Pin}    30s
    Click To Element    ${key1}
    Click To Element    ${key1}
    Click To Element    ${key1}
    Click To Element    ${key1}
    Click To Element    ${key1}
    Click To Element    ${key1}
    Wait Until Element Is Not Visible    ${popup_Enter_Pin}     30s
    ${status}=      Run Keyword And Return Status     Element Should Be Visible    ${btnOk}
    IF   '${status}'=='True'
        Click To Element    ${btnOk}
    END
    Wait Until Element Is Not Visible    ${popup_Enter_Pin}     30s
    sleep   6s
    Wait Until Element Is Not Visible    ${textbox_Email}       30s

Go to Portfolio Summary
    Wait Until Element Is Not Visible    ${popup_Enter_Pin}     30s
    Wait Until Element Is Not Visible    ${textbox_Email}       30s
    Click To Element    ${icon_Hamberger}
    Hover To Element    ${option_Portfolio}
    Click To Element    ${option_Portfolio_Summary}

Go to Portfolio Summary MO
    Wait Until Element Is Not Visible    ${popup_Enter_Pin}     30s
    Wait Until Element Is Not Visible    ${textbox_Email}       30s
    Click To Element    ${icon_Hamberger}
    Hover To Element    ${option_Portfolio_mo}
    Click To Element    ${option_Portfolio_Summary_mo}

Go to Portfolio Summary SW2
    Wait Until Element Is Not Visible    ${popup_Enter_Pin}     30s
    Wait Until Element Is Not Visible    ${textbox_Email}       30s
    Click To Element    ${icon_Hamberger}
    Hover To Element    ${option_Portfolio_sw2}
    Click To Element    ${option_Portfolio_Summary_sw2}

Click Transaction not block
    Click To Element    ${Transaction_Not_Block}

Verify element undisplay
    [Arguments]         ${locator}
    Element Should Not Be Visible     ${locator}

Verify T0, T1, T2 display
    Verify element display      ${T0}
    Verify element display      ${T1}
    Verify element display      ${T2}

Verify T0, T1, T2 undisplay
    Verify element undisplay    ${Transaction_Not_Block}
    Verify element undisplay      ${T0}
    Verify element undisplay      ${T1}
    Verify element undisplay      ${T2}
    
Verify Pending Settlement Field undisplay
    Element Should Not Be Visible    ${Pending_Settlement_Field}

Input textbox Search Account and choose Account
    [Arguments]     ${text_Input}
    Input Text To Element    ${textbox_Search_Account}    ${text_Input}
    Click To Element    ${First_Option_In_Dropdown}
    Wait Until Element Is Not Visible    ${Icon_Loading}
    sleep    5s

Input textbox Search Account and choose Account MO
    [Arguments]     ${text_Input}
    Input Text To Element    ${textbox_Search_Account_MO}    ${text_Input}
    Click To Element    ${First_Option_In_Dropdown}
    Wait Until Element Is Not Visible    ${Icon_Loading}
    sleep    5s

Get number by text
    [Arguments]     ${text}
    ${locator_Field}     Replace String     ${Field_By_Text1}     CHANGE_ME     ${text}
    ${status}=      Run Keyword And Return Status    Element Should Be Visible    ${locator_Field}
    IF     '${status}'=='True'
        ${locator_Field}        Set Variable        ${locator_Field}
    ELSE
        ${locator_Field}     Replace String     ${Field_By_Text2}     CHANGE_ME     ${text}
    END
    ${Value_Field}=     Get Text    ${locator_Field}
    ${Value_Field1}=     Get Regexp Matches    ${Value_Field}    [-\\d.,]+
    ${Value_Field}=     Get From List       ${Value_Field1}      0
    IF   '${Value_Field}'=='-'
        ${Value_Field1}=     Get From List       ${Value_Field1}      1
        ${Value_Field1}=     Replace String       ${Value_Field1}      ,    ${EMPTY}
        ${Value_Field1}=     Evaluate       -${Value_Field1}
    ELSE
        ${Value_Field1}=     Replace String       ${Value_Field}      ,    ${EMPTY}
    END
#    ${Value_Field}=     Convert To Number    ${Value_Field}
    RETURN      ${Value_Field1}

Verify Trading Balance = Cash At Bank + Transaction not Booked
    ${Trading_Balance}=       Get number by text      trading balance
    ${Cash_At_Bank}=       Get number by text      Cash At Bank
    ${String}=       Get text        (//*[text()='Transactions not Booked']//parent::div//parent::div[@class="itemLeft"]//following-sibling::div)[4]
    ${Array}=      Get Regexp Matches    ${String}    [-\\d.,]+
    ${sign}=     Get From List       ${Array}      0
    IF   '${sign}'=='-'
        ${Transaction_not_Booked}=     Get From List       ${Array}      1
        ${Transaction_not_Booked}=     Replace String       ${Transaction_not_Booked}      ,    ${EMPTY}
        ${Transaction_not_Booked}=     Convert To Number    ${Transaction_not_Booked}
        ${Expected}=    Evaluate    ${Cash_At_Bank}-${Transaction_not_Booked}
    ELSE
        ${Transaction_not_Booked}=     Get From List       ${Array}      0
        ${Transaction_not_Booked}=     Replace String       ${Transaction_not_Booked}      ,    ${EMPTY}
        ${Transaction_not_Booked}=     Convert To Number    ${Transaction_not_Booked}
        ${Expected}=    Evaluate    ${Cash_At_Bank}+${Transaction_not_Booked}
    END
    Should Be Equal    ${Trading_Balance}    ${Expected}
