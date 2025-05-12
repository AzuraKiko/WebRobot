*** Settings ***
Library     String


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
