*** Settings ***
Resource          ../libraries/Web.robot
Resource          ../libraries/Utilities.robot

*** Keywords ***
Format String Template
    [Arguments]    ${string}    &{variables}
    ${map}    Create Dictionary    &{variables}
    ${string}    Process Template    ${string}    ${map}
    [Return]    ${string}

Replace In String
    [Arguments]    ${string}    ${regex}=(\\t|\\r?\\n)+    ${replace}=${SPACE}
    ${string}    Replace String Using Regex    ${string}    ${regex}    ${replace}
    [Return]    ${string}

Replace In List String
    [Arguments]    ${listString}    ${regex}=(\\t|\\r?\\n)+    ${replace}=${SPACE}
    ${returnList}    Create List
    FOR    ${string}    IN    @{listString}
        ${string}    Replace In String    ${string}    ${regex}    ${replace}
        ${returnList}    Create List    @{returnList}    ${string}
    END
    [Return]    ${returnList}
