*** Settings ***
Library         SeleniumLibrary
Library         RequestsLibrary
Library         DateTime
Library         String
Library         Collections
Library         JSONSchemaLibrary
Library         OperatingSystem
Library         Crypto.py
Resource        APIHelper.robot
Resource        ../data/Const.robot
Variables       ../data/Env.py


*** Keywords ***
Create Session ID
    ${date}=    Get Current Date
    ${timestamp}=    Convert Date    ${date}    result_format=epoch    date_format=%Y-%m-%d %H:%M:%S.%f
    ${sessionId}=    Evaluate    ${timestamp}*1000
    ${sessionId}=    Convert To String    ${sessionId}
    ${timestamp1}=    Split String    ${sessionId}    .
    ${sessionId}=    Set Variable    ${timestamp1}[0]
    RETURN    ${sessionId}

Create API Session
    [Arguments]    ${baseUrl}    ${version}
    Initialize API Helper    ${baseUrl}/${version}
    RETURN    ${API_SESSION}

Get Session Encryption Key
    [Arguments]    ${session}    ${sessionId}    ${env}    ${origin}
    &{params}=    Create Dictionary    session_id=${sessionId}
    &{header}=    Create Dictionary    Cache-Control=no-cache    environment=${env}    origin=${origin}
    ${response}=    Send POST Request    /auth/session    params=${params}    headers=${header}
    ${encryptionKey}=    Get Response Value    ${response}    data.key
    Set Suite Variable    ${sessionEncryptionKey}    ${encryptionKey}
    RETURN    ${encryptionKey}

Login And Get Refresh Token
    [Arguments]    ${session}    ${username}    ${password}    ${sessionId}    ${env}    ${origin}    ${encryptionKey}
    ${encrypted_Password}=    encrypt    ${password}    ${encryptionKey}
    ${header}=    Create Dictionary    Environment=${env}    origin=${origin}
    ${data}=    Create Dictionary
    ...    username=${username}
    ...    password=${encrypted_Password}
    ...    provider=paritech
    ...    storage_token=${TRUE}
    ...    session_id=${sessionId}
    ${body}=    Create Dictionary    data=${data}
    ${response}=    Send POST Request    /auth    data=${body}    headers=${header}
    ${encryptedRefreshToken}=    Get Response Value    ${response}    refreshToken
    ${deviceID}=    Get Response Value    ${response}    deviceID
    RETURN    ${encryptedRefreshToken}    ${deviceID}

Decode Refresh Token
    [Arguments]
    ...    ${session}
    ...    ${encryptedRefreshToken}
    ...    ${pin}
    ...    ${env}
    ...    ${origin}
    ...    ${encryptionKey}
    ${header}=    Create Dictionary    Environment=${env}    origin=${origin}
    ${data}=    Create Dictionary    token=${encryptedRefreshToken}    pin=${pin}
    ${body}=    Create Dictionary    data=${data}
    ${response}=    Send POST Request    /auth/decode    data=${body}    headers=${header}
    ${refreshToken}=    Get Response Value    ${response}    token
    RETURN    ${refreshToken}

Get Access Token
    [Arguments]    ${session}    ${deviceID}    ${refreshToken}    ${env}    ${origin}
    ${header}=    Create Dictionary    Environment=${env}    origin=${origin}
    ${data}=    Create Dictionary    deviceID=${deviceID}    refreshToken=${refreshToken}    stay_sign_in=false
    ${body}=    Create Dictionary    data=${data}
    ${response}=    Send POST Request    /auth/refresh    data=${body}    headers=${header}
    ${token_data}=    Get Response Value    ${response}    accessToken
    # ${token}=    Set Variable    Bearer ${token_data}
    ${token}=    Set Variable    ${token_data}
    RETURN    ${token}

Get Authentication Token
    [Documentation]    Generic method to get authentication token for both admin portal and web trading
    [Arguments]    ${baseUrl}    ${username}    ${password}    ${origin}    ${version}    ${env}
    ${sessionId}=    Create Session ID
    ${session}=    Create API Session    ${baseUrl}    ${version}
    ${encryptionKey}=    Get Session Encryption Key    ${session}    ${sessionId}    ${env}    ${origin}
    ${encryptedRefreshToken}    ${deviceID}=    Login And Get Refresh Token
    ...    ${session}
    ...    ${username}
    ...    ${password}
    ...    ${sessionId}
    ...    ${env}
    ...    ${origin}
    ...    ${encryptionKey}
    ${refreshToken}=    Decode Refresh Token
    ...    ${session}
    ...    ${encryptedRefreshToken}
    ...    ${pin}
    ...    ${env}
    ...    ${origin}
    ...    ${encryptionKey}
    ${token}=    Get Access Token    ${session}    ${deviceID}    ${refreshToken}    ${env}    ${origin}
    RETURN    ${token}

Get Token Trading User
    [Documentation]    Get token for trading user
    ${token}=    Get Authentication Token
    ...    ${urlLogin}
    ...    ${username}
    ...    ${password}
    ...    ${origin}
    ...    ${version}
    ...    ${environment}
    RETURN    ${token}

Get Token Admin Portal
    [Documentation]    Get token for admin portal
    ${token}=    Get Authentication Token
    ...    ${urlLogin}
    ...    ${username}
    ...    ${password}
    ...    ${originAdminPortal}
    ...    ${version}
    ...    ${environment}
    RETURN    ${token}

Update User Type
    [Documentation]    etail, advisor, operation
    ...    user: autotest@equix.com.au
    [Arguments]    ${user_id}    ${user_type}    ${token}
    Set Auth Token    ${token}
    ${data}=    Create Dictionary    user_type=${user_type}
    ${body}=    Create Dictionary    data=${data}
    ${response}=    Send PUT Request    /user/user-details/${user_id}    ${body}
    RETURN    ${response}

Update User Status
    [Documentation]    2: Active, 5: security block, 4: admin block
    ...    user: autotest@equix.com.au
    [Arguments]    ${user_id}    ${user_status}    ${token}
    Set Auth Token    ${token}
    ${user_status_int}=    Convert To Integer    ${user_status}
    ${data}=    Create Dictionary    status=${user_status_int}
    ${body}=    Create Dictionary    data=${data}
    ${response}=    Send PUT Request    /user/user-details/${user_id}    ${body}
    RETURN    ${response}
