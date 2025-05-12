*** Settings ***
Library         SeleniumLibrary
Library         XML
Library         String
Resource        ../../../Locator/LoginLocator.robot
Resource        ../../../Utils/Common.robot
Variables       ../../../data/Env.py

*** Variables ***
${textbox_Email}            //*[@id="email"]
${placeholder_Email}        //*[@id="email"]//parent::div//legend//span
${textbox_Pass}             //*[@id="password"]
${placeholder_Pass}         //*[@id="password"]//parent::div//legend//span
${button_Login}             //*[@type="submit"]
${error_Mess_Email}         //*[@id="email-helper-text"]
#${enter_Pin}                //*[@class="ReactCodeInput react-code-input"]
${Enter_Pin}                //*[@class="pinFormRoot fadeInAnimation qe-firstPinForm"]//*[@class='pinInputRoot']
${error_Mess_Pass}          //*[@id="password-helper-text"]
${error_Mess}               //*[@class="notistack-CollapseWrapper"]//p[contains(@class,'body2')]
${text_Hello}               //*[text()='Hello']
${icon_Loading}             //button//span[@role="progressbar"]

*** Keywords ***
Verify text placeholder
    [Arguments]     ${locator}      ${textExpected}
    sleep      3s
    ${textActual}=     Get text by JS     ${locator}
    ${textActual}=      Remove Last Character       ${textActual}
    Should Be Equal    ${textExpected}    ${textActual}

Verify text placeholder of textbox Email
    Verify text placeholder     ${placeholder_Email}     Email

Verify text placeholder of textbox Password
    Verify text placeholder     ${placeholder_Pass}     Password
    
Verify button [Login] disable
    Wait Until Element Is Visible    ${button_Login}
    Element Should Be Disabled    ${button_Login}

Input textbox Email
    [Arguments]     ${text}
    Input Text To Element    ${textbox_Email}    ${text}

Input textbox Password
    [Arguments]     ${text}
    Input Text To Element    ${textbox_Pass}    ${text}
    
Click button [Login]
    Click To Element    ${button_Login}

Click outside
    Click Element       ${text_Hello}

Clear text into textbox Email
    Clear text into textbox    ${textbox_Email}

Clear text into textbox Password
    Clear text into textbox    ${textbox_Pass}

Verify login successfully
    Wait Until Element Is Visible    ${enter_Pin}
    Element Should Be Visible    ${enter_Pin}

Verify error message Email
    [Arguments]       ${textExpected}
    Verify message      ${error_Mess_Email}      ${text_Expected}

Verify error message Password
    [Arguments]       ${textExpected}
    Wait Until Element Is Visible    ${error_Mess_Pass}   timeout=10s
    ${textActual}=      Get Text    ${error_Mess_Pass}
    Should Be Equal    ${textActual}    ${textExpected}

Verify error message Admin
    [Arguments]       ${textExpected}
    Wait Until Element Is Visible    ${error_Mess}   timeout=10s
    ${textActual}=      Get Text    ${error_Mess}
    Should Be Equal    ${textActual}    ${textExpected}
    Wait Until Element Is Not Visible    ${error_Mess}      20s
    
Verify button disable in time
    [Arguments]     ${expectedTime}
    Wait Until Element Is Not Visible    ${icon_Loading} 
    ${text}=        Get Text    ${button_Login}
    Should Be Equal    ${expectedTime}s    ${text}
    Verify button [Login] disable
    
Wait button [Login] enable
    Wait Until Element Is Visible    ${button_Login}
    FOR    ${i}    IN RANGE    1   1000
        ${status}=      Run Keyword And Return Status    Element Should Be Enabled    ${button_Login}
        Exit For Loop If    '${status}'=='True'
        sleep     10s
    END

Remove Last Character
    [Arguments]         ${String}
    ${new_string}=      Remove String    ${String}      *
    ${new_string}=      Strip String    ${new_string}
    RETURN      ${new_string}

Verify textbox Email receive character
    [Arguments]     ${text_Expect}
    ${text_Actual}=     Get Element Attribute    ${textbox_Email}    value
    Should Be Equal    ${text_Expect}    ${text_Actual}