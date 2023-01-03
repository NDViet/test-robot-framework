*** Settings ***
Resource          ../libraries/Web.robot
Resource          ../libraries/Utilities.robot

*** Keywords ***
Get Total Funded
    [Arguments]    ${listValues}    ${stringFormat}
    Log    ${listValues}
    ${convertMap}    readYamlConfiguration    ${TEST_DATA_DIR}/Amount_convert.yml
    ${components}    getListStringMatchesRegex    ${listValues}[3]    \\w+
    ${numberPlace}    Set Variable    ${components}[0]
    ${currencyString}    Set Variable    ${convertMap.getValue("Currency.${components}[1]")}
    ${number}    Number Decimal Format    ${listValues}[2]    \#0.00    ${None}
    &{variables}    Create Dictionary    Currency=${currencyString}    Number=${number}    Place=${numberPlace}
    ${TotalFunded}    Format String Template    ${stringFormat}    &{variables}
    [Return]    ${TotalFunded}

Get No of Financing
    [Arguments]    ${listValues}    ${valueIndex}=2
    Log    ${listValues}
    [Return]    ${listValues}[${valueIndex}]

Get Default Rate
    [Arguments]    ${listValues}    ${stringFormat}
    Log    ${listValues}
    ${number}    Number Decimal Format    ${listValues}[2]    \#0.00    ${None}
    &{variables}    Create Dictionary    Number=${number}    Place=${listValues}[3]
    ${DefaultRate}    Format String Template    ${stringFormat}    &{variables}
    [Return]    ${DefaultRate}

Get Financing Fulfillment Rate
    [Arguments]    ${value}    ${stringFormat}
    ${number}    Number Decimal Format    ${value}    \#    ${None}
    &{variables}    Create Dictionary    Number=${number}    Place=%
    ${rate}    Format String Template    ${stringFormat}    &{variables}
    [Return]    ${rate}

Get Disbursement Percentage By Industry
    [Arguments]    ${listValues}    ${valueIndex}=2
    &{mapKeyValue}    Create Dictionary
    FOR    ${key}    IN    @{listValues.keys()}
        &{mapKeyValue}    Create Dictionary    &{mapKeyValue}    ${key}=${listValues['${key}']}[${valueIndex}]
    END
    Log    ${mapKeyValue}
    [Return]    ${mapKeyValue}

Get Sum of Disbursement Percentage
    [Arguments]    ${mapKeyValue}
    ${sum}    Set Variable    0
    FOR    ${key}    IN    @{mapKeyValue.keys()}
        ${sum}    Evaluate    ${sum} + ${mapKeyValue['${key}']}
    END
    Log    ${sum}
    [Return]    ${sum}
