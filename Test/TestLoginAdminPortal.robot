*** Settings ***
Library     SeleniumLibrary
Resource    ../Page/LoginAdminPortalPage.robot
Resource    ../Data/Global.py
*** Test Cases ***

Login Admin Portal
    Login Admin Portal    ${URL_ADMIN_PORTAL}    ${Browser}    ${username}    ${password}