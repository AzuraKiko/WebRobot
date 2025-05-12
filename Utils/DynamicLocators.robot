*** Settings ***
Library     String
Library     Collections


*** Keywords ***
Create
    [Documentation]    Create dynamic locator with parameter substitution
    ...
    ...    Args:
    ...    base_locator: Base locator containing placeholders
    ...    *params: Parameters to substitute into placeholders
    ...
    ...    Returns:
    ...    str: Locator with substituted parameters
    ...
    ...    Examples:
    ...    ${locator}=    Create    //button[contains(text(), "{0}")]    Save
    ...    # Result: //button[contains(text(), "Save")]
    ...
    ...    ${locator}=    Create    //table[@id="{0}"]//tr[{1}]/td[{2}]    userTable    3    2
    ...    # Result: //table[@id="userTable"]//tr[3]/td[2]
    [Arguments]    ${base_locator}    @{params}
    IF    not '''${base_locator}'''    Fail    Base locator cannot be empty

    ${result}=    Set Variable    ${base_locator}
    FOR    ${i}    ${param}    IN ENUMERATE    @{params}
        ${placeholder}=    Set Variable    {${i}}
        IF    $param is not None
            ${value}=    Convert To String    ${param}
        ELSE
            ${value}=    Set Variable    ${EMPTY}
        END
        ${result}=    Replace String    ${result}    ${placeholder}    ${value}
    END

    Log    Created dynamic locator: ${result}    DEBUG
    RETURN    ${result}

XPath
    [Documentation]    Create XPath locator with parameter substitution
    [Arguments]    ${base_xpath}    @{params}
    ${result}=    Create    ${base_xpath}    @{params}
    RETURN    ${result}

CSS
    [Documentation]    Create CSS selector with parameter substitution
    [Arguments]    ${base_css}    @{params}
    ${result}=    Create    ${base_css}    @{params}
    RETURN    ${result}

Exact Text
    [Documentation]    Create locator for exact text match
    [Arguments]    ${text}
    RETURN    //*/text()[normalize-space(.)="${text}"]/parent::*

Contains Text
    [Documentation]    Create locator for containing text
    [Arguments]    ${text}
    RETURN    //*[contains(text(), "${text}")]

Button
    [Documentation]    Create locator for button with text
    [Arguments]    ${text}
    RETURN    //button[contains(text(), "${text}") or contains(@value, "${text}")]

Input By Label
    [Documentation]    Create locator for input with label
    [Arguments]    ${label}
    RETURN    //label[contains(text(), "${label}")]/following::input[1]

Input By Placeholder
    [Documentation]    Create locator for input with placeholder
    [Arguments]    ${placeholder}
    RETURN    //input[@placeholder="${placeholder}"]

Link
    [Documentation]    Create locator for link with text
    [Arguments]    ${text}
    RETURN    //a[contains(text(), "${text}")]

Dropdown By Label
    [Documentation]    Create locator for dropdown with label
    [Arguments]    ${label}
    RETURN    //label[contains(text(), "${label}")]/following::select[1]

Dropdown Option
    [Documentation]    Create locator for dropdown option
    [Arguments]    ${text}
    RETURN    //option[contains(text(), "${text}")]

Checkbox By Label
    [Documentation]    Create locator for checkbox with label
    [Arguments]    ${label}
    RETURN    //label[contains(text(), "${label}")]/preceding::input[@type="checkbox"][1] | //label[contains(text(), "${label}")]/following::input[@type="checkbox"][1]

Radio By Label
    [Documentation]    Create locator for radio button with label
    [Arguments]    ${label}
    RETURN    //label[contains(text(), "${label}")]/preceding::input[@type="radio"][1] | //label[contains(text(), "${label}")]/following::input[@type="radio"][1]

Table Cell
    [Documentation]    Create locator for table cell
    [Arguments]    ${table_id}    ${row}    ${column}
    RETURN    //table[@id="${table_id}"]//tr[${row}]/td[${column}]

Table Row With Text
    [Documentation]    Create locator for table row containing text
    [Arguments]    ${table_id}    ${text}
    RETURN    //table[@id="${table_id}"]//tr[contains(., "${text}")]

Element By Attribute
    [Documentation]    Create locator for element with attribute
    [Arguments]    ${tag}    ${attribute}    ${value}
    RETURN    //${tag}[@${attribute}="${value}"]

Element By Attributes
    [Documentation]    Create locator for element with multiple attributes
    [Arguments]    ${tag}    ${attributes}
    ${conditions}=    Set Variable    ${EMPTY}

    ${attributes_length}=    Get Length    ${attributes}
    IF    ${attributes_length} == 0    RETURN    //${tag}

    ${keys}=    Get Dictionary Keys    ${attributes}
    FOR    ${attr}    IN    @{keys}
        ${value}=    Get From Dictionary    ${attributes}    ${attr}
        ${condition}=    Set Variable    @${attr}="${value}"
        ${conditions}=    Set Variable If    $conditions == ''    ${condition}    ${conditions} and ${condition}
    END

    RETURN    //${tag}[${conditions}]

Child Element
    [Documentation]    Create locator for child element
    [Arguments]    ${parent_locator}    ${child_tag}    ${child_attributes}=${None}
    IF    $child_attributes is None or $child_attributes == {}
        RETURN    ${parent_locator}//${child_tag}
    END

    ${conditions}=    Set Variable    ${EMPTY}
    ${keys}=    Get Dictionary Keys    ${child_attributes}
    FOR    ${attr}    IN    @{keys}
        ${value}=    Get From Dictionary    ${child_attributes}    ${attr}
        ${condition}=    Set Variable    @${attr}="${value}"
        ${conditions}=    Set Variable If    $conditions == ''    ${condition}    ${conditions} and ${condition}
    END

    RETURN    ${parent_locator}//${child_tag}[${conditions}]

Next Sibling
    [Documentation]    Create locator for next sibling element
    [Arguments]    ${locator}    ${sibling_tag}
    RETURN    ${locator}/following-sibling::${sibling_tag}[1]

Previous Sibling
    [Documentation]    Create locator for previous sibling element
    [Arguments]    ${locator}    ${sibling_tag}
    RETURN    ${locator}/preceding-sibling::${sibling_tag}[1]

Parent
    [Documentation]    Create locator for parent element
    [Arguments]    ${locator}    ${parent_tag}=*
    RETURN    ${locator}/parent::${parent_tag}

Element By Position
    [Documentation]    Create locator for element by position
    [Arguments]    ${tag}    ${position}
    RETURN    //${tag}[${position}]

Element By Class
    [Documentation]    Create locator for element with class
    [Arguments]    ${tag}    ${class_name}
    RETURN    //${tag}[contains(@class, "${class_name}")]

Element By ID
    [Documentation]    Create locator for element with ID
    [Arguments]    ${tag}    ${id}
    RETURN    //${tag}[@id="${id}"]

Element By Name
    [Documentation]    Create locator for element with name
    [Arguments]    ${tag}    ${name}
    RETURN    //${tag}[@name="${name}"]

CSS By ID
    [Documentation]    Create CSS selector for element with ID
    [Arguments]    ${id}
    RETURN    # ${id}

CSS By Class
    [Documentation]    Create CSS selector for element with class
    [Arguments]    ${class_name}
    RETURN    .${class_name}

CSS By Attribute
    [Documentation]    Create CSS selector for element with attribute
    [Arguments]    ${attribute}    ${value}
    RETURN    [${attribute}="${value}"]
