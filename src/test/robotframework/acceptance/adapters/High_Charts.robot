*** Settings ***
Resource          ../libraries/Web.robot
Resource          ../libraries/Utilities.robot

*** Keywords ***
Extract Tooltip Results
    [Arguments]    ${text}    ${patterns}    ${removeString}=${None}
    ${matchValues}    getListStringMatchesListRegex    ${text}    ${patterns}
    Log    ${matchValues}
    Return From Keyword If    '${removeString}'=='${None}'
    ${matchValues}    replaceListStringUsingRegex    ${matchValues}    ${removeString}    ${EMPTY}
    Log    ${matchValues}
    [Return]    ${matchValues}

Extract Chart Details
    [Arguments]    ${listResults}    ${patterns}    ${keyIndex}    ${removeString}=${None}
    &{dictionary}    Create Dictionary
    FOR    ${result}    IN    @{listResults}
        ${components}    Extract Tooltip Results    ${result}    ${patterns}    ${removeString}
        &{dictionary}    Create Dictionary    &{dictionary}    ${components}[${keyIndex}]=${components}
    END
    Log    ${dictionary}
    [Return]    ${dictionary}

Get List Chart Values
    [Arguments]    ${chartDetails}    ${valueIndex}=2
    ${listValues}    Create List
    FOR    ${key}    IN    @{chartDetails.keys()}
        ${listValues}    Create List    @{listValues}    ${chartDetails['${key}']}[${valueIndex}]
    END
    [Return]    ${listValues}

Get Line Chart Details
    [Arguments]    ${keyIndex}=1    ${valueIndex}=3
    Verify Element Present    High Charts.Line Chart Paths
    ${chartPoints}    Find Web Elements    High Charts.Line Chart Paths
    ${numberOfPoints}    Get Length    ${chartPoints}
    ${numberOfPoints}    Evaluate    ${numberOfPoints} + 1
    ${results}    Create List
    FOR    ${i}    IN RANGE    1    ${numberOfPoints}
        &{variables}    Create Dictionary    index=${i}
        Move To Element    High Charts.Line Chart Path    ${variables}
        Move To Element    High Charts.Line Chart Path    ${variables}
        Verify Element Present    High Charts.Tooltips.Details
        ${toolTipLabels}    Find Web Elements    High Charts.Tooltips.Details
        ${numberOfLabels}    Get Length    ${toolTipLabels}
        &{toolTipValues}    Create Dictionary    index=${keyIndex}
        ${key}    Get Text    High Charts.Tooltips.Detail    ${toolTipValues}
        &{toolTipValues}    Create Dictionary    index=${valueIndex}
        ${value}    Get Text    High Charts.Tooltips.Detail    ${toolTipValues}
        ${fullText}    Get Text    High Charts.Tooltips.Text
        ${results}    Create List    @{results}    ${fullText}
    END
    Log    ${results}
    [Return]    ${results}

Get Column Chart Details
    [Arguments]    ${keyIndex}=1    ${valueIndex}=3
    Verify Element Present    High Charts.Column Chart Paths
    ${chartPoints}    Find Web Elements    High Charts.Column Chart Paths
    ${numberOfPoints}    Get Length    ${chartPoints}
    ${numberOfPoints}    Evaluate    ${numberOfPoints} + 1
    &{results}    Create Dictionary
    FOR    ${i}    IN RANGE    1    ${numberOfPoints}
        &{variables}    Create Dictionary    index=${i}
        Move To Element    High Charts.Column Chart Path    ${variables}
        Verify Element Present    High Charts.Tooltips.Details
        ${toolTipLabels}    Find Web Elements    High Charts.Tooltips.Details
        ${numberOfLabels}    Get Length    ${toolTipLabels}
        &{toolTipValues}    Create Dictionary    index=${keyIndex}
        ${key}    Get Text    High Charts.Tooltips.Detail    ${toolTipValues}
        &{toolTipValues}    Create Dictionary    index=${valueIndex}
        ${value}    Get Text    High Charts.Tooltips.Detail    ${toolTipValues}
        ${fullText}    Get Text    High Charts.Tooltips.Text
        ${results}    Create List    @{results}    ${fullText}
    END
    Log    ${results}
    [Return]    ${results}

Get Pie Chart Details
    [Arguments]    ${keyIndex}=1    ${valueIndex}=3
    Verify Element Present    High Charts.Pie Chart Paths
    ${chartPoints}    Find Web Elements    High Charts.Pie Chart Paths
    ${numberOfPoints}    Get Length    ${chartPoints}
    ${numberOfPoints}    Evaluate    ${numberOfPoints} + 1
    &{results}    Create Dictionary
    FOR    ${i}    IN RANGE    1    ${numberOfPoints}
        &{variables}    Create Dictionary    index=${i}
        Move To Element    High Charts.Pie Chart Path    ${variables}
        Verify Element Present    High Charts.Tooltips.Details
        ${toolTipLabels}    Find Web Elements    High Charts.Tooltips.Details
        ${numberOfLabels}    Get Length    ${toolTipLabels}
        &{toolTipValues}    Create Dictionary    index=${keyIndex}
        ${key}    Get Text    High Charts.Tooltips.Detail    ${toolTipValues}
        &{toolTipValues}    Create Dictionary    index=${valueIndex}
        ${value}    Get Text    High Charts.Tooltips.Detail    ${toolTipValues}
        ${fullText}    Get Text    High Charts.Tooltips.Text
        ${results}    Create List    @{results}    ${fullText}
    END
    Log    ${results}
    [Return]    ${results}
