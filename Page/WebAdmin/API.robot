*** Settings ***
Library         SeleniumLibrary
Library         RequestsLibrary
Library         DateTime
Library         String
Library         Collections
Library         JSONSchemaLibrary
Library         OperatingSystem
Variables       ../data/Global.py
Library         ../Page/encrypt.py
*** Variables ***
${baseUrl}        https://equix-${env}-retail-api.equix.app
${version}          v1
${username_API}                thao.le1@equix.com.au
${originAdminPortal}           https://portal-equix-uat.equix.app

*** Keywords ***
Get token Admin portal
#    create session
    ${date}=    Get Current Date
    ${timestamp}=   Convert Date    ${date}    result_format=epoch    date_format=%Y-%m-%d %H:%M:%S.%f
    ${sessionId}=       Evaluate      ${timestamp}*1000
    ${sessionId}=       Convert To String    ${sessionId}
    ${timestamp1}=    Split String      ${sessionId}         .
    ${sessionId}=       Set Variable   ${timestamp1}[0]
    Log     Session ID: ${sessionId}
    Create Session   mysession     ${baseUrl}/${version}     verify=true
    &{body}=  Create Dictionary    session_id=${sessionId}
    &{header}=  Create Dictionary  Cache-Control=no-cache    environment=equix
    ${response}=  POST On Session  mysession  url=/auth/session  data=${body}  headers=${header}
    log     res: ${response.content}
#    xử lý data sau API create session
    ${jsonData}=    To Json    ${response.content}
    ${encryptionKey}=   Set Variable  ${jsonData['data']['key']}

#   api login
    Set Suite Variable      ${sessionEncryptionKey}     ${encryptionKey}
    Log     Session Encryption Key: ${sessionEncryptionKey}
    ${encrypted_Password}=      encrypt   ${password}   ${encryptionKey}
    ${encrypted_Password}       Set Variable    ${encrypted_Password}
    log     ${encrypted_Password}
    ${header}=      Create Dictionary    Environment=equix
    ${data}=      Create Dictionary    username=${username_API}   password=${encrypted_Password}   provider=paritech    storage_token=${True}    session_id=${sessionId}
    ${body}=      Create Dictionary         data=${data}
    Create Session    mysession     ${baseUrl}/${version}
    ${response}=  POST On Session   mysession  url=/auth     json=${body}        headers=${header}
    Log   ${response.json()}
#    xử lý data lấy encryptedRefreshToken
    ${jsonData}=    To Json    ${response.content}
    ${encryptedRefreshToken}=   Set Variable  ${jsonData['refreshToken']}
    ${deviceID}=    Set Variable    ${jsonData['deviceID']}
    log     ${encryptedRefreshToken}

#    create session2
    ${date}=    Get Current Date
    ${timestamp}=   Convert Date    ${date}    result_format=epoch    date_format=%Y-%m-%d %H:%M:%S.%f
    ${sessionId}=       Evaluate      ${timestamp}*1000
    ${sessionId}=       Convert To String    ${sessionId}
    ${timestamp1}=    Split String      ${sessionId}         .
    ${sessionId}=       Set Variable   ${timestamp1}[0]
    Log     Session ID: ${sessionId}
    Create Session   mysession     ${baseUrl}/${version}     verify=true
    &{body}=  Create Dictionary    session_id=${sessionId}
    &{header}=  Create Dictionary  Cache-Control=no-cache
    ${response}=  POST On Session  mysession  url=/auth/session  data=${body}  headers=${header}
    log     res: ${response.content}
#    xử lý data sau API create session
    ${jsonData}=    To Json    ${response.content}
    ${String}=   Set Variable  ${jsonData['data']['key']}
    ${pin}=      encrypt   ${pin}   ${String}
    ${pin}       Set Variable    ${pin}
    log     ${pin}

#    enter pin
    ${header}=      Create Dictionary    Environment=equix
    ${data}=      Create Dictionary     token=${encryptedRefreshToken}     pin=${pin}       session_id=${sessionId}
    ${body}=      Create Dictionary         data=${data}
    Create Session    mysession     ${baseUrl}/${version}
    ${response}=  POST On Session   mysession  url=/auth/decode    json=${body}        headers=${header}
    Log   ${response.json()}
#    xử lý data lấy RefreshToken
    ${jsonData}=    To Json    ${response.content}
    ${refreshToken}=   Set Variable  ${jsonData['token']}
    log     ${refreshToken}

    ${header}=      Create Dictionary    Environment=equix
    ${data}=      Create Dictionary     deviceID=${deviceID}      refreshToken=${refreshToken}
    ${body}=      Create Dictionary         data=${data}
    Create Session    mysession     ${baseUrl}/${version}
    ${response}=  POST On Session   mysession  url=/auth/refresh    json=${body}        headers=${header}
    Log   ${response.json()}
    ${jsonData}=    To Json    ${response.content}
    ${token}=   Set Variable  ${jsonData['accessToken']}
    ${token}     Set Variable       Bearer ${token}
    ${token}     Set Global Variable       ${token}
    RETURN      ${token}

#Check API Trading
#    ${date}=    Get Current Date
#    ${timestamp}=   Convert Date    ${date}    result_format=epoch    date_format=%Y-%m-%d %H:%M:%S.%f
#    ${timestamp}=       Convert To String    ${timestamp}
#    ${timestamp1}=    Split String      ${timestamp}         .
#    ${sessionId}=       Set Variable   ${timestamp1}[0]
#    Log     Session ID: ${sessionId}
#
##    create session
#    Create Session  mysession  https://equix-uat-retail-api.equix.app  verify=true
#    &{body}=  Create Dictionary    session_id=${sessionId}
#    &{header}=  Create Dictionary  Cache-Control=no-cache
#    ${response}=  POST On Session  mysession  url=/v1/auth/session?session_id=${sessionId}  data=${body}  headers=${header}
#    log     res: ${response.content}
#
##    xử lý data sau API create session
#    ${jsonData}=    To Json    ${response.content}
#    ${encryptionKey}=   Set Variable  ${jsonData['data']['key']}
#
##   pre xử lý encryp
#    Set Suite Variable      ${sessionEncryptionKey}     ${encryptionKey}
#    Log     Session Encryption Key: ${sessionEncryptionKey}
##    ${encrypted_Password}=     Run Process     node ../../ScrpitJs/encrypt-aes.js ${password} ${sessionEncryptionKey}
#    log     ${encrypted_Password}
#
##    call api login
#    ${header}=      Create Dictionary    Environment=equix
#    ${data}=      Create Dictionary    username=${username}   password=${encrypted_Password}   provider=paritech    storage_token=${True}    session_id=${sessionId}
#    ${body}=      Create Dictionary         data=${data}
#    Create Session    mysession    https://equix-uat-retail-api.equix.app
#    ${response}=  POST On Session   mysession  url=/v1/auth     json=${body}        headers=${header}
#    Log To Console    ${response.json()}
#    #đang lỗi
#
###    xử lý data sau khi call api login
##    ${status_code}=     Get From Dictionary     ${response}     status_code
##    Should Be Equal As Numbers      ${status_code}      200
##    ${json_data}=   To Json     ${response.content}
##    Log    ${json_data}
##    Validate Json     ${json_data}    {"type": "object", "additionalProperties": false, "require": ["deviceID"], "properties": { "refreshToken": { "type": "string" }, "accessToken": { "type": "string" }, "deviceID": { "type": "string" }, "user_type": { "type": "string" } } };
##    Log         JSON Schema Validation Passed
##
##    ${json_data}=       To Json     ${response.content}
##    ${deviceID}=    Get From Dictionary     ${json_data}    deviceID
##    Set Suite Variable      ${sessionEncryptionKey}     ${deviceID}
##    Log      Device ID: ${deviceID}
##    ${refreshToken}=    Get From Dictionary     ${json_data}    refreshToken
##    ${accessToken}=     Get From Dictionary     ${json_data}    accessToken
##    Run Keyword If      ${refreshToken}     Set Suite Variable      ${encryptedRefreshToken}    ${refreshToken}
##    Run Keyword If      ${refreshToken}     Log     Encrypted Refresh Token Set      ELSE   Set Suite Variable      ${setPinAccessToken}    ${accessToken}
##    Run Keyword If      ${refreshToken}     Log     Access Token Set
##    Run Keyword If      ${refreshToken}     Log     Enter pin       ELSE     Log     Set new pin
##    ${user_type}=       Get From Dictionary      ${json_data}   user_type
##    Should Be Equal     ${user_type}    retail
##    Log     User type is retail

API set right of user
    [Documentation]     retail, advisor, operation
    ...       user: autotest@equix.com.au
    [Arguments]     ${type_right}
    Create Session      mysession1      ${baseUrl}/${version}  verify=true
    ${data}=      Create Dictionary     user_type=${type_right}
    ${body}=      Create Dictionary         data=${data}
    &{header}=  Create Dictionary   Cache-Control=no-cache       Content-Type=application/json      authorization=${token}
    ${response}=  PUT On Session   mysession1   url=/user/user-details/eq1732179482946       json=${body}        headers=${header}

API set status of user
    [Documentation]     2: Active, 5: security block, 4: admin block
    ...       user: autotest@equix.com.au
    [Arguments]     ${type_status}      ${id_user}=eq1732179482946
    Create Session      mysession1    ${baseUrl}/${version}    verify=true
    ${type_status}      Convert To Number    ${type_status}
    ${data}=      Create Dictionary     status=${type_status}
    ${body}=      Create Dictionary         data=${data}
    &{header}=  Create Dictionary   Cache-Control=no-cache       Content-Type=application/json      authorization=${token}      environment=equix       origin=${originAdminPortal}
    ${response}=  PUT On Session   mysession1  url=/user/user-details/${id_user}    json=${body}  headers=${header}

*** Test Cases ***
Test 01
        Get token Admin portal


















