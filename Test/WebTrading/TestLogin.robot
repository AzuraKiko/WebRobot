*** Settings ***
Library             SeleniumLibrary
Resource            ../../Page/WebTrading/Pentest/LoginPage.robot
Resource            ../../Utils/RandomData.robot
Test Teardown       Close All Browsers


*** Test Cases ***
TC-01: Login test success
    Login    ${username}    ${password}
    Input Pin Code 1
    Assert Login Success

TC-02: Login test invalid username
    ${emailRandom}    Generate Random Email
    Login    ${emailRandom}    ${password}
    Assert Warning Message Username Password    ${ExpectedWarningMessage}

TC-03: Login test invalid password
    Login    ${username}    112113Hh@
    Assert Warning Message Username Password    ${ExpectedWarningMessage}

TC-04: Login test invalid PIN code
    Login    ${username}    ${password}
    Input Wrong Pin Code
    Assert Warning PIN    ${ExpectedModalText}
