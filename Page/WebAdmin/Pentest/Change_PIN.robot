*** Settings ***
Library         SeleniumLibrary
Library         XML
Library         String
Resource        ../../../Utils/Common.robot
Resource        ../../../Page/WebAdmin/Pentest/Forgot_Pin.robot
Variables       ../../../data/Env.py

*** Variables ***
#${Enter_Pin}                            //*[@class="ReactCodeInput react-code-input"]
${Enter_Pin}                            //*[@class="pinFormRoot fadeInAnimation qe-firstPinForm"]//*[@class='pinInputRoot']
${textbox_Enter_Pin}                    //*[@class="ReactCodeInput react-code-input"]//input
${error_PIN}                            //*[contains(@class,"MuiFormHelperText-root Mui-error")]
${logo_Equix}                           //*[@alt="Logo"]
${erro_PIN_mess}                        //*[contains(@class,"MuiTypography-root MuiTypography-body2")]
${dialog_Sign_Out}                      //*[@role="dialog"]//div[contains(@class,'MuiDialogContent')]

*** Keywords ***
Login successfully
    [Arguments]     ${username}     ${password}
    Input textbox Email    ${username}
    Input textbox Password    ${password}
    Click button [Login]
    
Verify direct to enter PIN screen
    Wait Until Element Is Visible    ${Enter_Pin}
    Element Should Be Visible    ${Enter_Pin}

Verify still in PIN screen
    Element Should Be Visible    ${Enter_Pin}

Enter PIN
    [Arguments]     ${character}
    Wait Until Element Is Visible    ${Enter_Pin}    20s
    Press Keys    ${None}    ${character}

Verify textbox Enter PIN receive character
    [Arguments]     ${text_Expected}
    Wait Until Element Is Visible    ${textbox_Enter_Pin}
    ${Enter_Pin}    Set Variable        (${textbox_Enter_Pin})[1]
    ${text_Actual}=     Get Element Attribute    ${Enter_Pin}    value
    FOR    ${i}    IN RANGE   2    7
        ${text}    Set Variable        (${textbox_Enter_Pin})[${i}]
        ${text_Actual1}=     Get Element Attribute    ${text}       value
        ${text_Actual}=       Set Variable      ${text_Actual}${text_Actual1}
    END
    Should Be Equal    ${text_Actual}    ${text_Expected}

Clear enter PIN
    Click To Element   (${textbox_Enter_Pin})[6]
    FOR    ${i}    IN RANGE   1    7
        Press Keys    ${None}    ${BackSpace}
    END

Verify error PIN message
    [Arguments]         ${text_Expected}
    Verify message      ${error_PIN}      ${text_Expected}

Verify go to dashboard screen
    Wait Until Element Is Visible    ${logo_Equix}
    Element Should Be Visible   ${logo_Equix}

Verify wrong PIN message
    [Arguments]     ${text_Expected}
    Verify message      ${erro_PIN_mess}      ${text_Expected}
    Wait Until Element Is Not Visible    ${erro_PIN_mess}       10s
    
Verify display popup Sign out
    Verify element display      ${dialog_Sign_Out}