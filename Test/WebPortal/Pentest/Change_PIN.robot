*** Settings ***
Resource    ../../../Page/WebTrading/LoginPage.robot
Resource    ../../../Page/WebAdmin/Pentest/Change_PIN.robot
Resource    ../../../Page/API.robot

*** Variables ***
${username1}        autotest3@equix.com.au
${username2}        autotest@equix.com.au
${password}         Abc@1234

*** Test Cases ***
PT_LI/LO_0002: Check access Create PIN screen
    [Tags]    PENTEST
    Open Link Page Admin Portal    ${Browser}
    Login successfully      ${username1}         ${password}
    Verify direct to enter PIN screen

PT_LI/LO_0003, 0004, 0005, 0006: Create PIN flow - Check validate
    [Tags]      PENTEST
    Enter PIN           a
    Verify textbox Enter PIN receive character      ${EMPTY}
    Enter PIN           !@#$%^%
    Verify textbox Enter PIN receive character      ${EMPTY}
    Enter PIN           11111
    Verify textbox Enter PIN receive character      11111
    Verify still in PIN screen
#    Clear enter PIN
#    Enter PIN           1111111
#    Verify textbox Enter PIN receive character      111111
#    Verify still in PIN screen
    Close Browser

PT_LI/LO_0013: Create PIN flow - Check Confirm PIN screen
    [Tags]      PENTEST
    Open Link Page Admin Portal    ${Browser}
    Login successfully      ${username1}         ${password}
    Enter PIN           111111
    Sleep    2s
    Enter PIN           111122
    Verify error PIN message        PIN did not match. Try again
    Close Browser

PT_LI/LO_0014, 0015: Check UI, Check access Input PIN screen
    [Tags]      PENTEST
    Open Link Page Admin Portal    ${Browser}
    Login successfully      ${username2}         ${password}
    Verify direct to enter PIN screen
    Verify textbox Enter PIN receive character      ${EMPTY}

PT_LI/LO_0016, 0017, 0018, 0019: Check validate textbox
    [Tags]      PENTEST
    Enter PIN           a
    Verify textbox Enter PIN receive character      ${EMPTY}
    Enter PIN           !@#$%^%
    Verify textbox Enter PIN receive character      ${EMPTY}
    Enter PIN           11111
    Verify still in PIN screen
#    Clear enter PIN
#    Enter PIN           1111111
#    Verify textbox Enter PIN receive character      111111
#    Verify still in PIN screen
    Close Browser

PT_LI/LO_0020: Check input PIN. Check input correct PIN
    [Tags]      PENTEST
    Open Link Page Admin Portal    ${Browser}
    Login successfully      ${username2}         ${password}
    Enter PIN           111111
    Verify go to dashboard screen
    Close Browser

PT_LI/LO_0022: Check input PIN. Input wrong PIN 1 time
    [Tags]      PENTEST
    Open Link Page Admin Portal    ${Browser}
    Login successfully      ${username2}         ${password}
    Enter PIN           111112
    Verify wrong PIN message        1 Failed PIN Attempt

PT_LI/LO_0024: Check input PIN. Input wrong PIN 2 time
    [Tags]      PENTEST
    Clear enter PIN
    Enter PIN           111112
    Verify wrong PIN message        2 Failed PIN Attempts
    Clear enter PIN
    Enter PIN           111111
    Verify go to dashboard screen
    Close Browser

PT_LI/LO_0025: Check input PIN. Input wrong PIN 3 times in a row then re-login
    [Tags]      PENTEST
    Open Link Page Admin Portal    ${Browser}
    Login successfully      ${username2}         ${password}
    Enter PIN           111112
    Verify wrong PIN message        1 Failed PIN Attempt
    Clear enter PIN
    Enter PIN           111112
    Verify wrong PIN message        2 Failed PIN Attempts
    Clear enter PIN
    Enter PIN           111112
    Verify display popup Sign out
    Close Browser

PT_LI/LO_0026: Check input PIN. Input wrong PIN 1 time and reload then input wrong 2 times in a row
    [Tags]      PENTEST
    Open Link Page Admin Portal    ${Browser}
    Login successfully      ${username2}         ${password}
    Enter PIN           111112
    Verify wrong PIN message        1 Failed PIN Attempt
    Go To    ${URL_ADMIN_PORTAL}
    Login successfully      ${username2}         ${password}
    Enter PIN           111112
    Verify wrong PIN message        2 Failed PIN Attempts
    Clear enter PIN
    Enter PIN           111112
    Verify display popup Sign out
    Close Browser

PT_LI/LO_0027: Check input PIN. Input wrong PIN 2 times and reload then input 3rd time is incorrect
    [Tags]      PENTEST
    Open Link Page Admin Portal    ${Browser}
    Login successfully      ${username2}         ${password}
    Enter PIN           111112
    Verify wrong PIN message        1 Failed PIN Attempt
    Clear enter PIN
    Enter PIN           111112
    Verify wrong PIN message        2 Failed PIN Attempts
    Go To    ${URL_ADMIN_PORTAL}
    Login successfully      ${username2}         ${password}
    Enter PIN           111112
    Verify display popup Sign out
    Close Browser