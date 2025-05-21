*** Settings ***
Library         SeleniumLibrary
Library         Collections
Resource        ../../../Page/WebTrading/LoginPage.robot
Resource        ../../../Page/WebAdmin/Pentest/Forgot_Pin.robot
Resource        ../../../Page/API.robot

*** Variables ***
${username}        autotest@equix.com.au
${password}         Abc@1234

*** Test Cases ***
PT_LI/LO_0002, 0006, 0018: Check default loading
    [Tags]       PENTEST
    Get token Admin portal
    API set status of user      2
    Open Link Page Admin Portal         ${Browser}
    Verify text placeholder of textbox Email
    Verify text placeholder of textbox Password
    Verify button [Login] disable

PT_LI/LO_0003,0004,0005: Check status of Login button
    [Tags]          PENTEST
    Input textbox Email         ${username}
    Verify button [Login] disable
    Clear text into textbox Email
    Input textbox Password      ${password}
    Verify button [Login] disable
    Clear text into textbox Password
    Input textbox Email         autotest
    Verify button [Login] disable

PT_LI/LO_0006, 0007, 0008: Check validate - Email textbox. Check require/ Check input 1 character/ Check input 64 character
    [Tags]          PENTEST
    Open Link Page Admin Portal         ${Browser}
    Clear text into textbox Email
    Input textbox Email          ${EMPTY}
    Click outside
    Verify error message Email           Email is required
    Input textbox Email         a
    Verify textbox Email receive character      a
    Input textbox Email         1khljkhfjvhvjhfglvcjkfhvjchfjghjfghdlgjkhjfghjfkhgjgkfjghjfhfhu1
    Verify textbox Email receive character      1khljkhfjvhvjhfglvcjkfhvjchfjghjfghdlgjkhjfghjfkhgjgkfjghjfhfhu1
    Input textbox Email         1khljkhfjvhvjhfglvcjkfhvjchfjghjfghdlgjkhjfghjfkhgjgkfjghjfhfhu11
    Verify textbox Email receive character      1khljkhfjvhvjhfglvcjkfhvjchfjghjfghdlgjkhjfghjfkhgjgkfjghjfhfhu1

PT_LI/LO_00011: Check validate - Email textbox. Check Prefix side - Check distinction between uppercase and lowercase
    [Tags]          PENTEST
    Input textbox Email             AUTOtest@equix.com.au
    Input textbox Password          ${password}
    Click button [Login]
    Verify login successfully
    Close Browser

PT_LI/LO_0012: Check validate - Email textbox. Check Prefix side - Check input numberic + special charater
    [Tags]          PENTEST
    Open Link Page Admin Portal         ${Browser}
    Input textbox Email                 thao.le1+10@equix.com.au
    Input textbox Password              ${password}
    Click button [Login]
    Verify login successfully
    Close Browser

PT_LI/LO_00013,0014,0015: Check validate - Email textbox. Check Prefix side - Check input dot "." which is first character/ Check Prefix side - Check input dot "." which is last character/ "Check Prefix side - Check input There are 2 dots next to each other"
    [Tags]          PENTEST
    Open Link Page Admin Portal         ${Browser}
    Input textbox Email                 .
    Click outside
    Verify error message Email          Email is invalid
    Input textbox Email                 ${username}.
    Click outside
    Verify error message Email          Email is invalid
    Input textbox Email                 autotest..
    Click outside
    Verify error message Email          Email is invalid

PT_LI/LO_0016: Check validate - Email textbox. Check Prefix side - Check distinction between uppercase and lowercase
    [Tags]          PENTEST
    Input textbox Email         autotest@EQUIX.com.au
    Input textbox Password      ${password}
    Click button [Login]
    Verify login successfully
    Close Browser

PT_LI/LO_0018, 0020,0021: Check validate - Password textbox. Check require/ Check distinction between lowercase and uppercase
    [Tags]          PENTEST
    Open Link Page Admin Portal         ${Browser}
    Input textbox Password          ${EMPTY}
    Click outside
    Verify error message Password       Password is required
    ${number}=      Random number      4
    Input textbox Email         ${number}${username}
    Input textbox Password      ABC@1234
    Click button [Login]
    Verify error message Admin        Incorrect Password or User Login. Please make sure your details are correct and try again
    ${number}=      Random number       4
    Input textbox Email         ${number}${username}
    Input textbox Password      abc@1234
    Click button [Login]
    Verify error message Admin        Incorrect Password or User Login. Please make sure your details are correct and try again

PT_LI/LO_0022,0024,0025: Check Login sucessfully.User is Advisor/Operator
    [Tags]          PENTEST
    API set right of user      advisor
    Input textbox Email         ${username}
    Input textbox Password      ${password}
    Click button [Login]
    Verify login successfully
    Close Browser
    API set right of user      operation
    Open Link Page Admin Portal         ${Browser}
    Input textbox Email         ${username}
    Input textbox Password      ${password}
    Click button [Login]
    Verify login successfully
    Close Browser

PT_LI/LO_0026: Check input incorrect email 1 times
    [Tags]          PENTEST
    Open Link Page Admin Portal         ${Browser}
    ${number}=      Random number       4
    Input textbox Email         ${number}${username}
    Input textbox Password      ${password}
    Click button [Login]
    Verify error message Admin           Incorrect Password or User Login. Please make sure your details are correct and try again

PT_LI/LO_0028: Check input incorrect email 2 times
    [Tags]          PENTEST
    Click button [Login]
    Verify button disable in time       10
    Verify error message Admin           You have tried too many times. Please try again later.

PT_LI/LO_0030: Check input incorrect password 3 times
    [Tags]          PENTEST
    Wait button [Login] enable
    Click button [Login]
    Verify button disable in time       20
    Verify error message Admin            You have tried too many times. Please try again later.

PT_LI/LO_0032: Check input incorrect email 4 times
    [Tags]          PENTEST
    Wait button [Login] enable
    Click button [Login]
    Verify button disable in time       120
    Verify error message Admin            You have tried too many times. Please try again later.

PT_LI/LO_0034: Check input incorrect password 5 times
    [Tags]          PENTEST
    Wait button [Login] enable
    Click button [Login]
    Verify error message Admin            Your username has been temporarily blocked for security reason. Please contact hello@equix.app for support.

PT_LI/LO_0036: Check input incorrect username or password 5 times after that input correct in 6th
    [Tags]          PENTEST
    Click button [Login]
    Verify error message Admin            Your username has been temporarily blocked for security reason. Please contact hello@equix.app for support.
    Close Browser

PT_LI/LO_0040: Check case login with incorrect email
    [Tags]          PENTEST
    Open Link Page Admin Portal         ${Browser}
    ${number}=      Random number       4
    Input textbox Email         ${number}${username}
    Input textbox Password      ${password}
    Click button [Login]
    Verify error message Admin            Incorrect Password or User Login. Please make sure your details are correct and try again

PT_LI/LO_0042: Check case login with incorrect password
    [Tags]          PENTEST
    Input textbox Email         ${username}
    Input textbox Password      ${number}${password}
    Click button [Login]
    Verify error message Admin            Incorrect Password or User Login. Please make sure your details are correct and try again

PT_LI/LO_0044: Check login fail in the first time then login successfully in the second time
    [Tags]          PENTEST
    ${number}=      Random number       4
    Input textbox Email         ${number}${username}
    Input textbox Password      ${number}${password}
    Click button [Login]
    Verify error message Admin            Incorrect Password or User Login. Please make sure your details are correct and try again
    Input textbox Email         ${username}
    Input textbox Password      ${password}
    Click button [Login]
    Verify login successfully
    Close Browser

PT_LI/LO_0045: Check use Retail to Login
    [Tags]          PENTEST
    API set right of user       retail
    Open Link Page Admin Portal         ${Browser}
    Input textbox Email         ${username}
    Input textbox Password      ${password}
    Click button [Login]
    Verify error message Admin         Retail user cannot login to the Admin Portal

PT_LI/LO_0047: Check use username exist on system but not belongs to envir
    [Tags]          PENTEST
    Input textbox Email         autotest.mo@novus-fintech.com
    Input textbox Password      ${password}
    Click button [Login]
    Verify error message Admin         It looks like you are accessing the wrong environment. Questions or confusions? Email hello@equix.app, and a team member of us will be happy to help.

PT_LI/LO_0049: Check user's status = ADMIN BLOCKED
    [Tags]          PENTEST
    API set right of user       operation
    API set status of user      4
    Input textbox Email         ${username}
    Input textbox Password      ${password}
    Click button [Login]
    Verify error message Admin         Your username has been temporarily blocked for security reason. Please contact hello@equix.app for support.

PT_LI/LO_0051: Check user's status = SECURITY BLOCKED
    [Tags]          PENTEST
    API set status of user      5
    Input textbox Email         ${username}
    Input textbox Password      ${password}
    Click button [Login]
    Verify error message Admin         Your username has been temporarily blocked for security reason. Please contact hello@equix.app for support.

