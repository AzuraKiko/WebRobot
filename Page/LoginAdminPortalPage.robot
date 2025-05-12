*** Settings ***
Library     SeleniumLibrary
Resource    ../Utils/CustomKeys.robot
Resource    ../Locator/LoginLorcatorAdminPortal.robot

*** Keywords ***
Open Link Page
    [Arguments]                  ${SiteUrl}    ${Browser}
    Open Browser                 ${SiteUrl}    ${Browser}
    Maximize Browser Window
    Wait Until Page Contains    Please login to your account

Click Login
    Click To Element    ${btnLoginAdminPortal}

Input Username And password
    [Arguments]               ${username}         ${password}
    Input Text To Element     ${inputUserNameAdminPortal}    ${username}
    Input Text To Element     ${inputPasswordAdminPortal}    ${password}

Input Pin Code 1
    Input Text To Element       ${inputPin1}     1
    Input Text To Element       ${inputPin2}     1
    Input Text To Element       ${inputPin3}     1
    Input Text To Element       ${inputPin4}     1
    Input Text To Element       ${inputPin5}     1
    Input Text To Element       ${inputPin6}     1

Login Admin Portal
    [Arguments]         ${SiteUrl}    ${Browser}    ${username}         ${password}
    Open Link Page      ${SiteUrl}    ${Browser}
    Input Username And password         ${username}         ${password}
    Click Login
    Input Pin Code 1