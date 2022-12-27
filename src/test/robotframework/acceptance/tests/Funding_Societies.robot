*** Settings ***
Test Setup       Open Browser    https://fundingsocieties.com
Test Teardown    Close Browser
Resource         ../adapters/High_Charts.robot

**** Test Cases ***
Verify General Tab > SME Financing Chart
    [Tags]    test10
    Click    Menu.Statistics
    Click    Statistics.General.Toggle.Total approved
    ${results}    Get Line Chart Details
    Log    ${results}
    Click    Statistics.General.Toggle.Amount disbursed
    ${results}    Get Line Chart Details
    Log    ${results}
    Click    Statistics.General.Toggle.Default rate
    ${results}    Get Line Chart Details
    Log    ${results}

Verify Repayment Tab > Repayment Chart
    [Tags]    test10
    Click    Menu.Statistics
    Click    Statistics.Tab.Repayment
    ${results}    Get Column Chart Details
    Log    ${results}

Verify Disbursement Tab > Industry Chart
    [Tags]    test10
    Click    Menu.Statistics
    Click    Statistics.Tab.Disbursement
    ${results}    Get Pie Chart Details
    ${results}    Sort By Values    ${results}    ${False}
    Log    ${results}