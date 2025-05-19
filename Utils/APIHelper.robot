*** Settings ***
Library     RequestsLibrary
Library     Collections
Library     String
Library     OperatingSystem
Library     DateTime


*** Variables ***
${DEFAULT_TIMEOUT}          30
${DEFAULT_HEADERS}          {"Content-Type": "application/json", "Accept": "application/json"}
${API_SESSION}              ${EMPTY}
# Khởi tạo AUTH_HEADERS là một dictionary trống
&{AUTH_HEADERS}             &{EMPTY}
${sessionEncryptionKey}     ${EMPTY}


*** Keywords ***
Initialize API Helper
    [Documentation]    Khởi tạo API Helper với các tùy chọn cơ bản
    ...    base_url: URL cơ sở cho API
    ...    headers: Headers mặc định cho request
    ...    timeout: Timeout cho request (giây)
    [Arguments]    ${base_url}=${EMPTY}    ${headers}=${DEFAULT_HEADERS}    ${timeout}=${DEFAULT_TIMEOUT}
    ${headers_dict}=    Evaluate    json.loads('''${headers}''')    json
    Create Session    api_session    ${base_url}    headers=${headers_dict}    timeout=${timeout}
    Set Suite Variable    ${API_SESSION}    api_session
    Log    API Helper initialized with base URL: ${base_url}    level=INFO

Set Auth Token
    [Documentation]    Thêm token xác thực vào headers
    [Arguments]    ${token}
    &{headers}=    Create Dictionary    Authorization=Bearer ${token}
    Set Suite Variable    &{AUTH_HEADERS}    &{headers}
    Log    Auth token set for API requests    level=INFO

Clear Auth Token
    [Documentation]    Xóa token xác thực khỏi headers
    &{empty_dict}=    Create Dictionary
    Set Suite Variable    &{AUTH_HEADERS}    &{empty_dict}
    Log    Auth token cleared from API requests    level=INFO

Send GET Request
    [Documentation]    Thực hiện GET request
    ...    endpoint: URL endpoint
    ...    params: Query parameters
    ...    expected_status: Status code mong đợi
    [Arguments]    ${endpoint}    ${params}=${EMPTY}    ${expected_status}=200
    ${response}=    GET On Session
    ...    ${API_SESSION}
    ...    ${endpoint}
    ...    params=${params}
    ...    headers=${AUTH_HEADERS}
    ...    expected_status=${expected_status}
    Log    GET Request: ${endpoint}    level=INFO
    Log    Response: ${response.text}    level=DEBUG
    RETURN    ${response}

Send POST Request
    [Documentation]    Thực hiện POST request
    ...    endpoint: URL endpoint
    ...    data: Request body
    ...    headers: Custom headers
    ...    params: Query parameters
    ...    expected_status: Status code mong đợi
    [Arguments]
    ...    ${endpoint}
    ...    ${data}=${EMPTY}
    ...    ${headers}=${EMPTY}
    ...    ${params}=${EMPTY}
    ...    ${expected_status}=200

    # Tạo merged_headers từ AUTH_HEADERS
    &{merged_headers}=    Copy Dictionary    ${AUTH_HEADERS}

    # Nếu có custom headers, thêm vào merged_headers
    IF    "${headers}" != "${EMPTY}"
        Set To Dictionary    ${merged_headers}    &{headers}
    END

    IF    "${data}" != "${EMPTY}"
        ${response}=    POST On Session
        ...    ${API_SESSION}
        ...    ${endpoint}
        ...    json=${data}
        ...    params=${params}
        ...    headers=${merged_headers}
        ...    expected_status=${expected_status}
    ELSE
        ${response}=    POST On Session
        ...    ${API_SESSION}
        ...    ${endpoint}
        ...    params=${params}
        ...    headers=${merged_headers}
        ...    expected_status=${expected_status}
    END
    Log To Console    POST Request: ${endpoint}    level=INFO
    Log To Console    Response: ${response.text}    level=DEBUG
    RETURN    ${response}

Send PUT Request
    [Documentation]    Thực hiện PUT request
    ...    endpoint: URL endpoint
    ...    data: Request body
    ...    expected_status: Status code mong đợi
    [Arguments]    ${endpoint}    ${data}=${EMPTY}    ${expected_status}=200
    ${response}=    PUT On Session
    ...    ${API_SESSION}
    ...    ${endpoint}
    ...    json=${data}
    ...    headers=${AUTH_HEADERS}
    ...    expected_status=${expected_status}
    Log    PUT Request: ${endpoint}    level=INFO
    Log    Response: ${response.text}    level=DEBUG
    RETURN    ${response}

Send PATCH Request
    [Documentation]    Thực hiện PATCH request
    ...    endpoint: URL endpoint
    ...    data: Request body
    ...    expected_status: Status code mong đợi
    [Arguments]    ${endpoint}    ${data}=${EMPTY}    ${expected_status}=200
    ${response}=    PATCH On Session
    ...    ${API_SESSION}
    ...    ${endpoint}
    ...    json=${data}
    ...    headers=${AUTH_HEADERS}
    ...    expected_status=${expected_status}
    Log    PATCH Request: ${endpoint}    level=INFO
    Log    Response: ${response.text}    level=DEBUG
    RETURN    ${response}

Send DELETE Request
    [Documentation]    Thực hiện DELETE request
    ...    endpoint: URL endpoint
    ...    expected_status: Status code mong đợi
    [Arguments]    ${endpoint}    ${expected_status}=200
    ${response}=    DELETE On Session
    ...    ${API_SESSION}
    ...    ${endpoint}
    ...    headers=${AUTH_HEADERS}
    ...    expected_status=${expected_status}
    Log    DELETE Request: ${endpoint}    level=INFO
    Log    Response: ${response.text}    level=DEBUG
    RETURN    ${response}

Get Response Value
    [Arguments]    ${response}    ${json_path}
    ${dict}=    Evaluate    json.loads($response.text)    modules=json
    ${json_path}=    Replace String    ${json_path}    $.    ${EMPTY}
    ${parts}=    Split String    ${json_path}    .
    ${value}=    Set Variable    ${dict}
    FOR    ${part}    IN    @{parts}
        ${value}=    Evaluate    $value[$part]
    END
    RETURN    ${value}

Get API Data
    [Documentation]    Gọi API và trả về JSON response
    [Arguments]    ${endpoint}    ${params}=${EMPTY}    ${expected_status}=200
    ${response}=    Send GET Request
    ...    ${endpoint}
    ...    params=${params}
    ...    expected_status=${expected_status}
    IF    ${response.status_code} != ${expected_status}
        Fail    API call failed with status ${response.status_code}
    END
    RETURN    ${response.json()}

Verify Response Status
    [Documentation]    Kiểm tra status code của response
    [Arguments]    ${response}    ${expected_status}=200
    Should Be Equal As Strings    ${response.status_code}    ${expected_status}
    Log    Response status code verified: ${response.status_code}    level=INFO

Verify Response Contains
    [Documentation]    Kiểm tra response có chứa nội dung mong đợi
    [Arguments]    ${response}    ${key}    ${value}
    ${response_json}=    Set Variable    ${response.json()}
    Dictionary Should Contain Item    ${response_json}    ${key}    ${value}
    Log    Response contains expected content    level=INFO

Format Number
    [Documentation]    Định dạng số thành chuỗi với 2 chữ số thập phân
    [Arguments]    ${number}
    ${formatted}=    Evaluate
    ...    "{:.2f}".format(float('${number}')) if '${number}' not in ['', '--'] else '0.00'
    RETURN    ${formatted}

Compare Float Values
    [Arguments]    ${actual}    ${expected}    ${msg}=Value mismatch
    Should Be True    ${actual} == ${expected}    msg=${msg}
