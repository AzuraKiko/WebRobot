*** Settings ***
Library     SeleniumLibrary
Library     Collections
Library     XML
Library     String
Library     OperatingSystem
# Variables    ${CURDIR}${/}..${/}data${/}Env.py


*** Variables ***
${time}                         30
${BackSpace}                    BACKSPACE
${CtrA}                         CTRL+A
${Delete}                       DELETE
${TC_INDEX}                     0
${popup_Confirm_Bound}          //div[contains(@class, 'confirmBound')]
${popup_Confirm_Bound_OK}       //div[contains(@class, "confirmBtnRoot")]//div[contains(@class, "btn") and .//span[normalize-space(text())="ok"]]


*** Keywords ***
# ===== Element Interaction Keywords =====
Click To Element
    [Documentation]    Clicks on an element after ensuring it's visible and enabled
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${time}
    Wait Until Element Is Enabled    ${locator}    ${time}
    Scroll To Element By JS    ${locator}
    Click Element    ${locator}

Click To Element On Widget
    [Arguments]    ${locator}    ${name_tab}
    ${panel_xpath}=    Get Active Widget By Name    ${name_tab}
    ${element_xpath}=    Catenate    SEPARATOR=    ${panel_xpath}    ${locator}
    Wait Until Element Is Visible    ${element_xpath}    ${time}
    Wait Until Element Is Enabled    ${element_xpath}    ${time}
    Click Element    ${element_xpath}

Click To Coordinate
    [Documentation]    Clicks at specific coordinates on an element
    [Arguments]    ${locator}    ${x}    ${y}
    Wait Until Element Is Visible    ${locator}    ${time}
    Wait Until Element Is Enabled    ${locator}    ${time}
    Hover To Element    ${locator}
    Click Element At Coordinates    ${locator}    ${x}    ${y}

Click Element If Visible
    [Documentation]    Clicks first element if visible, otherwise clicks second element
    [Arguments]    ${locator1}    ${locator2}
    ${isVisible}=    Run Keyword And Return Status    Element Should Be Visible    ${locator1}
    IF    ${isVisible}
        Click Element    ${locator1}
    ELSE
        Click Element    ${locator2}
    END

Hover To Element
    [Documentation]    Hovers over an element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${time}
    Wait Until Element Is Enabled    ${locator}    ${time}
    Mouse Over    ${locator}

# ===== Text Input Keywords =====

Input Text To Element
    [Documentation]    Inputs text to an element if it's empty and enabled
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}    ${time}
    Scroll To Element By JS    ${locator}
    Set Focus To Element    ${locator}
    ${current_value}=    Get Value    ${locator}
    ${is_enabled}=    Run Keyword And Return Status    Element Should Be Enabled    ${locator}
    IF    '${current_value}' == '' and ${is_enabled}
        Input Text    ${locator}    ${text}
    END

Input Text To Element On Widget
    [Documentation]    Inputs text to an element within a specific widget panel if it's empty and enabled
    [Arguments]    ${locator}    ${text}    ${name_tab}
    ${panel_xpath}=    Get Active Widget By Name    ${name_tab}
    ${element_xpath}=    Catenate    SEPARATOR=    ${panel_xpath}    ${locator}
    Wait Until Element Is Visible    ${element_xpath}    ${time}
    Wait Until Element Is Enabled    ${element_xpath}    ${time}
    Click Element    ${element_xpath}
    Clear Element Text    ${element_xpath}
    Input Text    ${element_xpath}    ${text}
    # ${current_value}=    Get Value    ${element_xpath}
    # IF    '${current_value}' == ''
    #    Input Text    ${element_xpath}    ${text}
    # ELSE
    #    Clear Element Text    ${element_xpath}
    #    Input Text    ${element_xpath}    ${text}
    # END

Clear And Input Text To Element
    [Documentation]    Clears existing text and inputs new text
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}    ${time}
    Scroll To Element By JS    ${locator}
    Set Focus To Element    ${locator}
    Press Keys    ${locator}    CTRL+A+BACKSPACE
    Input Text    ${locator}    ${text}

Clear Text To Element
    [Documentation]    Clears text from an element
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${time}
    Wait Until Element Is Enabled    ${locator}    ${time}
    Click To Element    ${locator}
    Clear Element Text    ${locator}

Clear Text By Key BackSpace
    [Documentation]    Clears text using Backspace key
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${time}
    Wait Until Element Is Enabled    ${locator}    ${time}
    Click To Element    ${locator}
    Press Keys    ${locator}    ${CtrA}+${BackSpace}

Clear Text By Key Delete
    [Documentation]    Clears text using Delete key
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${time}
    Wait Until Element Is Enabled    ${locator}    ${time}
    Click To Element    ${locator}
    Press Keys    ${locator}    ${CtrA}+${Delete}

# ===== Dropdown Keywords =====

Select Random Value From Dropdown
    [Documentation]    Selects a random value from a dropdown
    [Arguments]    ${dropdown_locator}    ${options_locator}
    Wait Until Element Is Visible    ${dropdown_locator}    ${time}
    Scroll To Element    ${dropdown_locator}
    Click Element    ${dropdown_locator}
    Wait Until Element Is Visible    ${options_locator}    ${time}
    ${options}=    Get WebElements    ${options_locator}
    ${count}=    Get Length    ${options}
    IF    ${count} == 0    Fail    Dropdown is empty!
    ${random_index}=    Evaluate    random.randint(0, ${count}-1)    modules=random
    ${random_option}=    Get From List    ${options}    ${random_index}
    ${random_value}=    Get Text    ${random_option}
    Sleep    0.5s
    Click Element    ${random_option}
    RETURN    ${random_value}

Select Value From Dropdown By Index
    [Documentation]    Selects a value from dropdown by index
    [Arguments]    ${dropdown_locator}    ${options_locator}    ${index}
    Wait Until Element Is Visible    ${dropdown_locator}    ${time}
    Scroll To Element    ${dropdown_locator}
    Click Element    ${dropdown_locator}
    Wait Until Element Is Visible    ${options_locator}    ${time}
    ${options}=    Get WebElements    ${options_locator}
    ${count}=    Get Length    ${options}
    IF    ${count} == 0    Fail    Dropdown is empty!
    IF    ${index} >= ${count}
        Fail    Index out of range! Max index: ${count - 1}
    END
    ${selected_option}=    Get From List    ${options}    ${index}
    ${selected_value}=    Get Text    ${selected_option}
    Sleep    0.5s
    Click Element    ${selected_option}
    RETURN    ${selected_value}

Select Fixed Value From Dropdown
    [Documentation]    Selects a specific value from dropdown
    [Arguments]    ${dropdown_xpath}    ${value_xpath}
    Wait Until Element Is Visible    ${dropdown_xpath}    ${time}
    Scroll To Element    ${dropdown_xpath}
    Click Element    ${dropdown_xpath}
    Wait Until Element Is Visible    ${value_xpath}    ${time}
    Sleep    0.5s
    Click Element    ${value_xpath}
    Sleep    0.5s

Select Value From Dropdown
    [Documentation]    Selects a value from dropdown by cycling through options
    [Arguments]    ${dropdown_xpath}    ${value_xpath}    ${expected_value}
    Click To Element    ${dropdown_xpath}
    Sleep    0.5s
    ${current_value}=    Get Text    ${value_xpath}
    WHILE    '${expected_value}' not in '${current_value}'
        Press Keys    ${dropdown_xpath}    ARROW_DOWN
        Press Keys    ${dropdown_xpath}    ENTER
        ${current_value}=    Get Text    ${value_xpath}
        Sleep    0.2s
    END
    Click Element    ${value_xpath}

Get List Values From Dropdown
    [Documentation]    Gets all values from a dropdown list
    [Arguments]    ${dropdown_locator}    ${options_locator}
    Wait Until Element Is Visible    ${dropdown_locator}    ${time}
    Scroll To Element By JS    ${dropdown_locator}
    Click Element    ${dropdown_locator}
    Wait Until Element Is Visible    ${options_locator}    ${time}

    ${options}=    Get WebElements    ${options_locator}
    ${count}=    Get Length    ${options}
    IF    ${count} == 0    Fail    Dropdown is empty!

    ${list_values}=    Create List
    FOR    ${option}    IN    @{options}
        ${value}=    Get Text    ${option}
        ${value}=    Strip String    ${value}
        Append To List    ${list_values}    ${value}
    END

    RETURN    ${list_values}

# ===== Verification Keywords =====

Verify Text Element
    [Documentation]    Verifies that an element contains the expected text
    [Arguments]    ${locator}    ${expect}
    Wait Until Element Is Visible    ${locator}    ${time}
    Wait Until Element Is Enabled    ${locator}    ${time}
    SeleniumLibrary.Element Text Should Be    ${locator}    ${expect}

Verify Text Placeholder
    [Arguments]    ${locator}    ${textExpected}
    Wait Until Element Is Visible    ${locator}    ${time}
    ${textActual}=    SeleniumLibrary.Get Element Attribute    ${locator}    placeholder
    IF    '${textActual}' == 'None'
        ${textActual}=    Get Text    ${locator}
        Log    ${textActual}
        IF    '${textActual}' == 'None'
            Fail    Cannot get placeholder or text for element: ${locator}
        END
    END
    ${textActual}=    Strip String    ${textActual}
    Should Be Equal    ${textExpected}    ${textActual}

Verify Button Disable
    [Documentation]    Verifies if a button is disabled
    [Arguments]    ${button}
    Wait Until Element Is Visible    ${button}    ${time}
    ${text}=    SeleniumLibrary.Get Element Attribute    ${button}    class
    ${text}=    Strip String    ${text}
    Should Contain    ${text}    disable

Verify Button Enable
    [Documentation]    Verifies if a button is enabled
    [Arguments]    ${button}
    Wait Until Element Is Visible    ${button}    ${time}
    ${text}=    SeleniumLibrary.Get Element Attribute    ${button}    class
    ${text}=    Strip String    ${text}
    Should Not Contain    ${text}    disable

Verify Button Disable/Enable By JS
    [Documentation]    Verifies button state using JavaScript
    [Arguments]    ${button}    ${status}
    Wait Until Element Is Visible    ${button}    ${time}
    ${value}=    Execute Javascript
    ...    return window.getComputedStyle(document.evaluate(`${button}`, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue,null).getPropertyValue("cursor");
    Should Be Equal    ${value}    ${status}

Verify Element Display
    [Documentation]    Verifies if an element is displayed
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${time}
    Element Should Be Visible    ${locator}

Verify Flash Error Message
    [Arguments]    ${locator}    ${text_Expected}
    Wait Until Keyword Succeeds    ${time}    0.1s    Verify Error Message Once    ${text_Expected}    ${locator}

Verify Error Message Once
    [Arguments]    ${text_Expected}    ${locator}
    ${text_Actual}=    Get Text    ${locator}
    Should Be Equal    ${text_Expected}    ${text_Actual}

Verify Element Not Display
    [Documentation]    Verifies if an element is not displayed
    [Arguments]    ${locator}
    Wait Until Element Is Not Visible    ${locator}    ${time}
    Element Should Not Be Visible    ${locator}

Verify Message Confirm Bound
    [Documentation]    Verifies confirmation popup message
    [Arguments]    ${text_Expected}
    Wait Until Element Is Visible    ${popup_Confirm_Bound}    ${time}
    ${text_Actual}=    Get Text    ${popup_Confirm_Bound}
    ${text_Actual}=    Strip String    ${text_Actual}
    ${text_Expected}=    Strip String    ${text_Expected}
    Should Be Equal    ${text_Expected}    ${text_Actual}

Verify button disable in time
    [Documentation]    Verifies button is disabled with a specific timeout
    [Arguments]    ${button}    ${time_block}
    Verify button disable/enable by JS    ${button}    not-allowed
    ${actual_time}=    Get Text    ${button}
    Should Be Equal    ${time_block}    ${actual_time}
    Wait button enable by JS    ${button}

Verify message display slowly
    [Arguments]    ${locator}    ${text_Expected}
    Wait Until Element Is Visible    ${locator}
    FOR    ${i}    IN RANGE    1000
        ${text_Actual}=    Get Element Text By JS    ${locator}
        IF    '${text_Actual}'=='${text_Expected}'    BREAK
    END
    Should Be Equal    ${text_Actual}    ${text_Expected}

Verify Message
    [Documentation]    Verifies text content of an element
    [Arguments]    ${locator}    ${text_Expected}
    Wait Until Element Is Visible    ${locator}    ${time}
    ${text_Actual}=    Get Element Text By JS    ${locator}
    ${text_Actual}=    Strip String    ${text_Actual}
    ${text_Expected}=    Strip String    ${text_Expected}
    Should Be Equal    ${text_Expected}    ${text_Actual}

Verify Textbox Value Should Be
    [Arguments]    ${locator}    ${expected_value}
    Wait Until Element Is Visible    ${locator}
    ${actual_value}=    SeleniumLibrary.Get Element Attribute    ${locator}    value
    Should Be Equal    ${expected_value}    ${actual_value}

Verify Textbox Allow Characters
    [Arguments]    ${locator}    ${text_Expected}
    Wait Until Element Is Visible    ${locator}
    ${text_Actual}=    SeleniumLibrary.Get Element Attribute    ${locator}    pattern
    Should Be Equal    ${text_Expected}    ${text_Actual}

# ===== Scroll Keywords =====

Scroll To Element
    [Documentation]    Scrolls to make an element visible
    [Arguments]    ${locator}
    Wait Until Element Is Visible    ${locator}    ${time}
    Scroll Element Into View    ${locator}

Scroll To Element By JS
    [Documentation]    Scrolls to element using JavaScript with smooth behavior
    [Arguments]    ${locator}
    ${elements}=    Get WebElements    xpath=${locator}
    FOR    ${element}    IN    @{elements}
        Execute JavaScript
        ...    arguments[0].scrollIntoView({behavior: "smooth", block: "center"});
        ...    ARGUMENTS    ${element}
        Sleep    0.3s
        ${is_in_viewport}=    Execute JavaScript
        ...    return arguments[0].getBoundingClientRect().top >= 0 &&
        ...    arguments[0].getBoundingClientRect().bottom <= window.innerHeight;
        ...    ARGUMENTS    ${element}
        WHILE    not ${is_in_viewport}
            Press Keys    ${None}    PAGE_DOWN
            Sleep    0.5s
            ${is_in_viewport}=    Execute JavaScript
            ...    return arguments[0].getBoundingClientRect().top >= 0 &&
            ...    arguments[0].getBoundingClientRect().bottom <= window.innerHeight;
            ...    ARGUMENTS    ${element}
        END
    END

# ===== Wait Keywords =====

Wait Button Enable By JS
    [Documentation]    Waits for a button to become enabled
    [Arguments]    ${button}
    FOR    ${i}    IN RANGE    1000
        ${element}=    Execute Javascript
        ...    return document.evaluate(`${button}`, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
        IF    '${element}' == 'None'
            Log    Button not found: ${button}
            RETURN
        END
        ${atribute}=    Execute Javascript
        ...    return window.getComputedStyle(arguments[0], null).getPropertyValue("cursor");
        ...    ARGUMENTS    ${element}
        IF    '${atribute}' != 'not-allowed'    BREAK
        Sleep    1s
    END

Wait Button Enable By Text
    [Documentation]    Waits for a button to become enabled
    [Arguments]    ${locator}    ${text}
    Wait Until Element Is Visible    ${locator}
    FOR    ${i}    IN RANGE    1000
        ${time_Actual}=    Get Element Text By JS    ${locator}
        IF    '${time_Actual}'=='${text}'    BREAK
        Sleep    2s
    END
    Wait button enable by JS    ${locator}

Wait Button Disable By JS
    [Documentation]    Waits for a button to become disabled
    [Arguments]    ${button}
    FOR    ${i}    IN RANGE    1000
        ${value}=    Execute Javascript
        ...    const element = document.evaluate(`${button}`, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
        ...    if (!element) {
        ...    return 'element-not-found';
        ...    }
        ...    return window.getComputedStyle(element, null).getPropertyValue("cursor");
        IF    '${value}'=='not-allowed'    BREAK
        IF    '${value}'=='element-not-found'    Sleep    1s    CONTINUE
        Sleep    1s
    END

# ===== Screenshot Keywords =====

Capture Screenshot With Index
    [Documentation]    Captures screenshot with indexed filename based on test suite
    ${full_suite_name}=    Get Variable Value    ${SUITE_NAME}
    ${suite_name}=    Evaluate    '${full_suite_name}'.split('.')[-1]
    ${TC_INDEX}=    Get Variable Value    ${TC_INDEX}    default=0
    ${TC_INDEX}=    Evaluate    ${TC_INDEX} + 1
    Set Suite Variable    ${TC_INDEX}
    ${screenshot_path}=    Set Variable    ${OUTPUT_DIR}/screenshots/${suite_name}_TC${TC_INDEX}.png
    Capture Page Screenshot    filename=${screenshot_path}

# ===== New Utility Keywords =====

Get Element Text By JS
    [Documentation]    Gets text content using JavaScript with null check
    [Arguments]    ${locator}
    ${text}=    Execute Javascript
    ...    const node = document.evaluate(`${locator}`, document, null, XPathResult.FIRST_ORDERED_NODE_TYPE, null).singleNodeValue;
    ...    return node ? node.innerText : null;
    RETURN    ${text}

Get Element Count
    [Documentation]    Gets count of elements matching locator
    [Arguments]    ${locator}
    ${elements}=    Get WebElements    ${locator}
    ${count}=    Get Length    ${elements}
    RETURN    ${count}

# ===== Drag And Drop Keywords =====

Drag And Drop By Offset Custom
    [Documentation]    Drags and drops an element by offset
    [Arguments]    ${locator}    ${x}    ${y}
    Wait Until Element Is Visible    ${locator}    ${time}
    SeleniumLibrary.Drag And Drop By Offset    ${locator}    ${x}    ${y}

Drag And Drop To Element
    [Documentation]    Drags and drops an element to another element
    [Arguments]    ${source}    ${target}
    Wait Until Element Is Visible    ${source}    ${time}
    Wait Until Element Is Visible    ${target}    ${time}
    Drag And Drop    ${source}    ${target}

# ===== Get Active Widget =====

Get Active Widget By Name
    [Arguments]    ${name_tab}
    ${tab_xpath}=    Set Variable
    ...    //li[contains(@class, "lm_tab") and contains(@class, "lm_active") and contains(normalize-space(), "${name_tab}")]
    ${panel_xpath}=    Set Variable    ${tab_xpath}/ancestor::div[@class="lm_item lm_stack"]
    RETURN    ${panel_xpath}
