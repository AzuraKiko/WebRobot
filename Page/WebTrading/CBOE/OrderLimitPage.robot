*** Settings ***
Library     SeleniumLibrary
Library     RequestsLibrary
Library     Collections
Resource    ../../../Utils/API.robot
Resource    ../../../Utils/CommonKeyword.robot


*** Variables ***
# Menu Elements
${leftHumbergerMenu}    //div[contains(@class, 'hamburger-menu')]
${menuAllOrder}         //div[text()='all orders']
${menuOperator}         //div[text()='operator']

# Canvas Elements
${canvas}               //div[@class="goldenLayout"]//canvas
${tableContainer}       //div[contains(@class, 'ag-body-viewport')]
${tableRows}            //div[contains(@class, 'ag-row')]
${tableCells}           .//div[contains(@class, 'ag-cell')]

# Search Elements
${quickFilterInput}     //div[text()='quick filter']/preceding-sibling::input


*** Keywords ***
Open All Orders
    [Documentation]    Opens the All Orders section from the operator menu
    Hover To Element    ${leftHumbergerMenu}
    Hover To Element    ${menuOperator}
    Click To Element    ${menuAllOrder}

Search Symbol
    [Documentation]    Searches for a symbol in the quick filter input
    [Arguments]    ${symbol}
    Click To Element    ${quickFilterInput}
    Input Text To Element    ${quickFilterInput}    ${symbol}

Verify Symbol In Orders List
    [Documentation]    Verifies if the searched symbol appears in the orders list
    [Arguments]    ${symbol}
    Wait Until Element Is Visible    //div[contains(text(), '${symbol}')]    ${time}
    Element Should Be Visible    //div[contains(text(), '${symbol}')]

Capture Orders Canvas
    [Documentation]    Captures a screenshot of the orders canvas
    [Arguments]    ${output_path}
    Wait Until Element Is Visible    ${canvas}    ${time}
    Capture Element Screenshot    ${canvas}    filename=${output_path}

Capture Full Table Data
    [Documentation]    Captures all table data including scrollable rows
    [Arguments]    ${output_path}
    Wait Until Element Is Visible    ${tableContainer}    ${time}

    # Get initial visible rows
    ${initial_rows}=    Get WebElements    ${tableRows}
    ${initial_count}=    Get Length    ${initial_rows}

    # Scroll to bottom and capture new rows
    ${last_height}=    Execute Javascript    return document.querySelector('${tableContainer}').scrollHeight
    WHILE    True
        # Scroll to bottom
        Execute Javascript
        ...    document.querySelector('${tableContainer}').scrollTo(0, document.querySelector('${tableContainer}').scrollHeight)
        Sleep    1s

        # Get new height
        ${new_height}=    Execute Javascript    return document.querySelector('${tableContainer}').scrollHeight

        # Break if no more scrolling possible
        ${scroll_possible}=    Evaluate    ${new_height} > ${last_height}
        IF    not ${scroll_possible}    BREAK

        ${last_height}=    Set Variable    ${new_height}
    END

    # Scroll back to top
    Execute Javascript    document.querySelector('${tableContainer}').scrollTo(0, 0)
    Sleep    1s

    # Capture full table screenshot
    Capture Element Screenshot    ${tableContainer}    filename=${output_path}

    # Get all rows after scrolling
    ${all_rows}=    Get WebElements    ${tableRows}
    ${total_rows}=    Get Length    ${all_rows}
    RETURN    ${total_rows}

Extract Table Data To CSV
    [Documentation]    Extracts all table data to CSV including scrollable rows
    [Arguments]    ${output_path}
    Wait Until Element Is Visible    ${tableContainer}    ${time}

    # Get all visible rows
    ${rows}=    Get WebElements    ${tableRows}
    ${data}=    Create List

    FOR    ${row}    IN    @{rows}
        # Get all cells in the row using relative XPath
        ${cells}=    Get WebElements    ${row}${tableCells}
        ${row_data}=    Create List

        FOR    ${cell}    IN    @{cells}
            ${text}=    Get Text    ${cell}
            Append To List    ${row_data}    ${text}
        END

        Append To List    ${data}    ${row_data}
    END

    # Write to CSV
    ${csv_content}=    Create List
    FOR    ${row}    IN    @{data}
        ${row_str}=    Catenate    SEPARATOR=,    @{row}
        Append To List    ${csv_content}    ${row_str}
    END

    ${csv_text}=    Catenate    SEPARATOR=\n    @{csv_content}
    Create File    ${output_path}    ${csv_text}
    RETURN    ${data}
