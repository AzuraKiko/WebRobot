*** Settings ***
Library     String
Library     Collections


*** Keywords ***
Generate Random Number Not Start With 0
    [Arguments]    ${digits}

    # Generate a random number for the first digit (1-9)
    ${first_digit}=    Evaluate    random.randint(1, 9)    random

    # For remaining digits, generate random numbers (0-9)
    ${remaining_digits}=    Evaluate    ''.join([str(random.randint(0, 9)) for _ in range(${digits}-1)])    random

    # Combine first digit with remaining digits
    ${random_number}=    Set Variable    ${first_digit}${remaining_digits}

    RETURN    ${random_number}

Generate Random Number
    [Arguments]    ${digits}
    ${random_number}=    Generate Random String    length=${digits}    chars=[NUMBERS]
    RETURN    ${random_number}

Generate Random Email
    ${random_string}=    Generate Random String    length=2    chars=[LOWER][NUMBERS]
    RETURN    lan.nguyen${random_string}@equix.com.au

Generate Random MiddleName
    ${middle_names}=    Create List
    ...    Alexander
    ...    Marie
    ...    Michael
    ...    Grace
    ...    David
    ...    Rose
    ...    Joseph
    ...    Lynn
    ...    Dean
    ...    Joly
    ...    Mean
    ${middle_name}=    Evaluate    random.choice(${middle_names})    random
    RETURN    ${middle_name}

Generate Random Password
    [Arguments]    ${length}=8
    # Validate độ dài đầu vào
    Should Be True    8 <= ${length} <= 255    msg=Password length must be between 8-255 characters

    # Các nhóm ký tự
    ${lower}=    Set Variable    abcdefghijklmnopqrstuvwxyz
    ${upper}=    Set Variable    ABCDEFGHIJKLMNOPQRSTUVWXYZ
    ${numbers}=    Set Variable    0123456789
    ${special}=    Set Variable    @#
    # ${special}=    Set Variable    !@#$%^&*()_+-=[]{}|;:,.<>?

    # Ký tự đầu tiên PHẢI là chữ cái (lower hoặc upper)
    ${letters}=    Set Variable    ${lower}${upper}
    ${first_char}=    Evaluate    random.choice('${letters}')    modules=random

    # Đảm bảo các loại ký tự còn lại có ít nhất 1 (trừ ký tự đầu đã chọn)
    ${char2}=    Evaluate    random.choice('${lower}')    modules=random
    ${char3}=    Evaluate    random.choice('${upper}')    modules=random
    ${char4}=    Evaluate    random.choice('${numbers}')    modules=random
    ${char5}=    Evaluate    random.choice('${special}')    modules=random

    # Tạo phần còn lại của mật khẩu
    ${all_chars}=    Set Variable    ${lower}${upper}${numbers}${special}
    ${remaining}=    Evaluate    ${length} - 5

    # Tạo các ký tự ngẫu nhiên cho phần còn lại
    ${random_chars}=    Create List
    FOR    ${i}    IN RANGE    ${remaining}
        ${random_char}=    Evaluate    random.choice('${all_chars}')    modules=random
        Append To List    ${random_chars}    ${random_char}
    END

    # Kết hợp các ký tự (trừ ký tự đầu tiên)
    ${middle_chars}=    Create List    ${char2}    ${char3}    ${char4}    ${char5}
    ${middle_chars}=    Combine Lists    ${middle_chars}    ${random_chars}

    # Xáo trộn phần giữa (không bao gồm ký tự đầu)
    ${shuffled_middle}=    Evaluate    random.sample($middle_chars, len($middle_chars))    modules=random

    # Tạo password với ký tự đầu là chữ cái
    ${password_chars}=    Create List    ${first_char}
    ${password_chars}=    Combine Lists    ${password_chars}    ${shuffled_middle}

    # Chuyển thành chuỗi
    ${password}=    Evaluate    "".join($password_chars)

    RETURN    ${password}
