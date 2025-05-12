*** Settings ***
Library     Collections
Library     String


*** Keywords ***
Create Dynamic Locator
    [Documentation]    Creates a dynamic locator by replacing placeholders with parameters
    ...    Example:
    ...    | ${button_locator}= | Create Dynamic Locator | //button[contains(text(), "{0}")] | Save |
    ...    | ${cell_locator}= | Create Dynamic Locator | //table[@id="{0}"]//tr[{1}]/td[{2}] | userTable | 3 | 2 |
    [Arguments]    ${base_locator}    @{params}

    ${result}=    Set Variable    ${base_locator}
    FOR    ${index}    ${param}    IN ENUMERATE    @{params}
        ${placeholder}=    Set Variable    {${index}}
        ${value}=    Set Variable If    "${param}" != "None"    ${param}    ${EMPTY}
        ${result}=    Replace String    ${result}    ${placeholder}    ${value}
    END
    RETURN    ${result}

Create XPath Locator
    [Documentation]    Creates an XPath locator by replacing placeholders with parameters
    [Arguments]    ${base_xpath}    @{params}
    ${result}=    Create Dynamic Locator    ${base_xpath}    @{params}
    RETURN    ${result}

Create CSS Locator
    [Documentation]    Creates a CSS locator by replacing placeholders with parameters
    [Arguments]    ${base_css}    @{params}
    ${result}=    Create Dynamic Locator    ${base_css}    @{params}
    RETURN    ${result}

Get Element By Exact Text
    [Documentation]    Creates a locator for element with exact text match
    [Arguments]    ${text}
    ${locator}=    Set Variable    //*/text()[normalize-space(.)="${text}"]/parent::*
    RETURN    ${locator}

Get Element By Contains Text
    [Documentation]    Creates a locator for element containing text
    [Arguments]    ${text}
    ${locator}=    Set Variable    //*[contains(text(), "${text}")]
    RETURN    ${locator}

Get Button By Text
    [Documentation]    Creates a locator for button with text
    [Arguments]    ${text}
    ${locator}=    Set Variable    //button[contains(text(), "${text}") or contains(@value, "${text}")]
    RETURN    ${locator}

Get Input By Label
    [Documentation]    Creates a locator for input with label
    [Arguments]    ${label}
    ${locator}=    Set Variable    //label[contains(text(), "${label}")]/following::input[1]
    RETURN    ${locator}

Get Input By Placeholder
    [Documentation]    Creates a locator for input with placeholder
    [Arguments]    ${placeholder}
    ${locator}=    Set Variable    //input[@placeholder="${placeholder}"]
    RETURN    ${locator}

Get Link By Text
    [Documentation]    Creates a locator for link with text
    [Arguments]    ${text}
    ${locator}=    Set Variable    //a[contains(text(), "${text}")]
    RETURN    ${locator}

Get Dropdown By Label
    [Documentation]    Creates a locator for dropdown with label
    [Arguments]    ${label}
    ${locator}=    Set Variable    //label[contains(text(), "${label}")]/following::select[1]
    RETURN    ${locator}

Get Dropdown Option
    [Documentation]    Creates a locator for dropdown option
    [Arguments]    ${text}
    ${locator}=    Set Variable    //option[contains(text(), "${text}")]
    RETURN    ${locator}

Get Checkbox By Label
    [Documentation]    Creates a locator for checkbox with label
    [Arguments]    ${label}
    ${locator}=    Set Variable
    ...    //label[contains(text(), "${label}")]/preceding::input[@type="checkbox"][1] | //label[contains(text(), "${label}")]/following::input[@type="checkbox"][1]
    RETURN    ${locator}

Get Radio By Label
    [Documentation]    Creates a locator for radio button with label
    [Arguments]    ${label}
    ${locator}=    Set Variable
    ...    //label[contains(text(), "${label}")]/preceding::input[@type="radio"][1] | //label[contains(text(), "${label}")]/following::input[@type="radio"][1]
    RETURN    ${locator}

Get Table Cell
    [Documentation]    Creates a locator for table cell
    [Arguments]    ${table_id}    ${row}    ${column}
    ${locator}=    Set Variable    //table[@id="${table_id}"]//tr[${row}]/td[${column}]
    RETURN    ${locator}

Get Table Row With Text
    [Documentation]    Creates a locator for table row containing text
    [Arguments]    ${table_id}    ${text}
    ${locator}=    Set Variable    //table[@id="${table_id}"]//tr[contains(., "${text}")]
    RETURN    ${locator}

Get Element By Attribute
    [Documentation]    Creates a locator for element with attribute
    [Arguments]    ${tag}    ${attribute}    ${value}
    ${locator}=    Set Variable    //${tag}[@${attribute}="${value}"]
    RETURN    ${locator}

Get Element By Attributes
    [Documentation]    Creates a locator for element with multiple attributes
    [Arguments]    ${tag}    &{attributes}
    ${conditions}=    Create List
    FOR    ${attr}    ${value}    IN    &{attributes}
        Append To List    ${conditions}    @${attr}="${value}"
    END
    ${condition_string}=    Evaluate    ' and '.join($conditions)
    ${locator}=    Set Variable If    "${condition_string}" == ""    //${tag}    //${tag}[${condition_string}]
    RETURN    ${locator}

Get Child Element
    [Documentation]    Creates a locator for child element
    [Arguments]    ${parent_locator}    ${child_tag}    &{child_attributes}
    ${conditions}=    Create List
    FOR    ${attr}    ${value}    IN    &{child_attributes}
        Append To List    ${conditions}    @${attr}="${value}"
    END
    ${condition_string}=    Evaluate    ' and '.join($conditions)
    ${locator}=    Set Variable If
    ...    "${condition_string}" == ""
    ...    ${parent_locator}//${child_tag}
    ...    ${parent_locator}//${child_tag}[${condition_string}]
    RETURN    ${locator}

Get Next Sibling
    [Documentation]    Creates a locator for next sibling element
    [Arguments]    ${locator}    ${sibling_tag}
    ${result}=    Set Variable    ${locator}/following-sibling::${sibling_tag}[1]
    RETURN    ${result}

Get Previous Sibling
    [Documentation]    Creates a locator for previous sibling element
    [Arguments]    ${locator}    ${sibling_tag}
    ${result}=    Set Variable    ${locator}/preceding-sibling::${sibling_tag}[1]
    RETURN    ${result}

Get Parent Element
    [Documentation]    Creates a locator for parent element
    [Arguments]    ${locator}    ${parent_tag}=*
    ${result}=    Set Variable    ${locator}/parent::${parent_tag}
    RETURN    ${result}

Get Element By Position
    [Documentation]    Creates a locator for element by position
    [Arguments]    ${tag}    ${position}
    ${result}=    Set Variable    //${tag}[${position}]
    RETURN    ${result}

Get Element By Class
    [Documentation]    Creates a locator for element with class
    [Arguments]    ${tag}    ${class_name}
    ${result}=    Set Variable    //${tag}[contains(@class, "${class_name}")]
    RETURN    ${result}

Get Element By ID
    [Documentation]    Creates a locator for element with ID
    [Arguments]    ${tag}    ${id}
    ${result}=    Set Variable    //${tag}[@id="${id}"]
    RETURN    ${result}

Get Element By Name
    [Documentation]    Creates a locator for element with name
    [Arguments]    ${tag}    ${name}
    ${result}=    Set Variable    //${tag}[@name="${name}"]
    RETURN    ${result}

Get CSS By ID
    [Documentation]    Creates a CSS selector for element with ID
    [Arguments]    ${id}
    ${result}=    Set Variable    # ${id}
    RETURN    ${result}

Get CSS By Class
    [Documentation]    Creates a CSS selector for element with class
    [Arguments]    ${class_name}
    ${result}=    Set Variable    .${class_name}
    RETURN    ${result}

Get CSS By Attribute
    [Documentation]    Creates a CSS selector for element with attribute
    [Arguments]    ${attribute}    ${value}
    ${result}=    Set Variable    [${attribute}="${value}"]
    RETURN    ${result}
