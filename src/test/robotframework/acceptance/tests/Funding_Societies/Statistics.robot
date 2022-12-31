*** Settings ***
Test Setup        Open Browser    https://fundingsocieties.com
Test Teardown     Close Browser
Resource          ../../adapters/High_Charts.robot
Resource          ../../adapters/General.robot
Resource          ../../components/Statistics.robot

*** Test Cases ***
Verify Statistics Details In Current Quarter
    [Tags]    test11
    ${DATA}    Read Yaml Configuration    ${TEST_DATA_DIR}/Statistics_Detail.yml
    ${currentMonthYear}    Get Current Date In Format    ${DATA.getValue("Month Box.Date Format")}
    ${currentQuarterYear}    Get Current Quarter Year
    ${thisQuarterLabel}    Format String Template    ${DATA.getValue("Chart.QuarterFormat")}    &{currentQuarterYear}
    ${expectListLabels}    Create List    @{DATA.getListValues("Progress Statistic.Labels")}
    ${chartValuePatterns}    Create List    @{DATA.getListValues("Chart.Value Patterns")}
    ${chartRemovePattern}    Set Variable    ${DATA.getValue("Chart.Remove Value Pattern")}
    Click    Menu.Statistics
    Click    Statistics.General.Toggle.Total approved
    ${totalApproved}    Get Line Chart Details
    ${totalApproved}    Extract Chart Details    ${totalApproved}    ${chartValuePatterns}    0    ${chartRemovePattern}
    Capture Page Screenshot    ${TEST NAME}
    ${totalApproved}    Sort By Keys    ${totalApproved}    ${False}
    Pretty Print Object Details    ${totalApproved}
    ${noOfFinancing}    Get No of Financing    ${totalApproved['${thisQuarterLabel}']}
    Verify Element Text Equals    Statistics.Statistic Detail.Value.No of financing    ${noOfFinancing}
    Click    Statistics.General.Toggle.Amount disbursed
    ${amountDisbursed}    Get Line Chart Details
    ${amountDisbursed}    Extract Chart Details    ${amountDisbursed}    ${chartValuePatterns}    0    ${chartRemovePattern}
    Capture Page Screenshot    ${TEST NAME}
    ${amountDisbursed}    Sort By Keys    ${amountDisbursed}    ${False}
    Pretty Print Object Details    ${amountDisbursed}
    ${totalFundedValue}    Get Total Funded    ${amountDisbursed['${thisQuarterLabel}']}    ${DATA.getValue("Progress Statistic.Value Format.Total funded")}
    Run Keyword And Continue On Failure    Verify Element Text Equals    Statistics.Statistic Detail.Value.Total funded    ${totalFundedValue}
    Click    Statistics.General.Toggle.Default rate
    ${defaultRate}    Get Line Chart Details
    ${defaultRate}    Extract Chart Details    ${defaultRate}    ${chartValuePatterns}    0    ${chartRemovePattern}
    Capture Page Screenshot    ${TEST NAME}
    ${defaultRate}    Sort By Keys    ${defaultRate}    ${False}
    Pretty Print Object Details    ${defaultRate}
    ${defaultRateValue}    Get Default Rate    ${defaultRate['${thisQuarterLabel}']}    ${DATA.getValue("Progress Statistic.Value Format.Default rate")}
    Verify Element Text Equals    Statistics.Statistic Detail.Value.Default rate    ${defaultRateValue}
    Click    Statistics.Tab.Repayment
    ${repayment}    Get Column Chart Details
    ${repayment}    Extract Chart Details    ${repayment}    ${chartValuePatterns}    1    ${chartRemovePattern}
    Capture Page Screenshot    ${TEST NAME}
    ${repayment}    Sort By Keys    ${repayment}    ${False}
    Pretty Print Object Details    ${repayment}
    Click    Statistics.Tab.Disbursement
    ${disbursement}    Get Pie Chart Details
    ${disbursement}    Extract Chart Details    ${disbursement}    ${chartValuePatterns}    0    ${chartRemovePattern}
    Capture Page Screenshot    ${TEST NAME}
    ${disbursement}    Sort By Keys    ${disbursement}    ${False}
    Pretty Print Object Details    ${disbursement}
    ${disbursementPercentage}    Get Disbursement Percentage By Industry    ${disbursement}
    ${disbursementPercentageAscending}    Sort By Values    ${disbursementPercentage}    ${False}
    Pretty Print Object Details    ${disbursementPercentageAscending}
    ${sumOfDisbursement}    Get Sum of Disbursement Percentage    ${disbursementPercentageAscending}

Verify Elements In General tab
    [Tags]    test10
    ${DATA}    Read Yaml Configuration    ${TEST_DATA_DIR}/Statistics_Detail.yml
    ${currentMonthYear}    Get Current Date In Format    ${DATA.getValue("Month Box.Date Format")}
    ${currentQuarterYear}    Get Current Quarter Year
    ${thisQuarterLabel}    Format String Template    ${DATA.getValue("Chart.QuarterFormat")}    &{currentQuarterYear}
    ${expectListLabels}    Create List    @{DATA.getListValues("Progress Statistic.Labels")}
    ${chartValuePatterns}    Create List    @{DATA.getListValues("Chart.Value Patterns")}
    ${chartRemovePattern}    Set Variable    ${DATA.getValue("Chart.Remove Value Pattern")}
    Click    Menu.Statistics
    Verify Element Text Equals    Statistics.Progress Page.Title    ${DATA.getValue("Title")}
    FOR    ${text}    IN    @{DATA.getListValues("Subtitle")}
        Verify Element Text Contains    Statistics.Progress Page.Subtitle    ${text}
    END
    ${actualListLabels}    Get Texts    Statistics.Statistic Detail.Label
    ${actualListLabels}    Replace In List String    ${actualListLabels}
    Should Be Equal    ${actualListLabels}    ${expectListLabels}
    Verify Element Text Contains    Statistics.Statistic Detail.Month Box    ${DATA.getValue("Month Box.Prefix")}
    Verify Element Text Contains    Statistics.Statistic Detail.Month Box    ${currentMonthYear}

Verify General Tab > SME Financing Chart
    [Documentation]    @Author: Viet Nguyen
    ...    ---
    ...    Test Description:
    ...
    ...    1) Go to URL https://fundingsocieties.com/
    ...    2) Click on Statistic in the top navigation bar
    ...    3) Verify that the Title should be present: Our Progress
    ...    4) Verify that the sub title should be present:
    ...    "We are in 5 countries, Singapore, Malaysia, Indonesia, Thailand and Vietnam
    ...    check our statistics across the region."
    ...    5) Verify progress statistic row should be aligned center with below details
    ...    5.1) Top label should be Statistics | <Current Month> <Current Year>
    ...    5.2) Total funded:
    ...    Label: Total funded
    ...    Value:
    ...    + Start with the currency S$ (Dollar Singapore)
    ...    + Round the number to two decimal place (e.g: 4.03) with format grouped string representation (e.g: billion, million)
    ...    5.3) Number of financing:
    ...    Label: No. of financing
    ...    Value: The number contains comma to separate groups of thousands
    ...    5.4) Default rate:
    ...    Label: Default rate
    ...    Value in percentage. Round the number to two decimal place.
    ...    5.5) Financing fulfilment rate:
    ...    Label: Financing fulfilment rate
    ...    Value in percentage. Round the number to two decimal place.
    ...    6) Verify there are 3 tabs below the Statistic row detail
    ...    6.1) General
    ...    6.2) Repayment
    ...    6.3) Disbursement
    ...    7) Verify that General tab is selected by default
    ...    8) Verify the first chart in General with tile is "SME Financing" and subtitle is "Cumulative number of financing approved."
    [Tags]    Statistics
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
    [Tags]    Statistics
    Click    Menu.Statistics
    Click    Statistics.Tab.Repayment
    ${results}    Get Column Chart Details
    Log    ${results}

Verify Disbursement Tab > Industry Chart
    [Tags]    Statistics
    Click    Menu.Statistics
    Click    Statistics.Tab.Disbursement
    ${results}    Get Pie Chart Details
    ${results}    Sort By Values    ${results}    ${False}
    Log    ${results}
