*** Settings ***
Resource    ../libraries/Web.robot
Resource    ../libraries/Utilities.robot

**** Keywords ***
Get Line Chart Details
    [Arguments]    ${keyIndex}=1    ${valueIndex}=3
    Verify Element Present    High Charts.Line Chart Paths
    ${chartPoints}    Find Web Elements    High Charts.Line Chart Paths
    ${numberOfPoints}    Get Length    ${chartPoints}
    ${numberOfPoints}    Evaluate    ${numberOfPoints} + 1
    &{results}    Create Dictionary
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
        &{results}    Create Dictionary    &{results}    ${key}=${value}
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
        ${key}    Get Text    High Charts.Tooltips.Text
        &{toolTipValues}    Create Dictionary    index=${valueIndex}
        ${value}    Get Text    High Charts.Tooltips.Detail    ${toolTipValues}
        &{results}    Create Dictionary    &{results}    ${key}=${value}
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
        &{results}    Create Dictionary    &{results}    ${key}=${value}
    END
    Log    ${results}
    [Return]    ${results}