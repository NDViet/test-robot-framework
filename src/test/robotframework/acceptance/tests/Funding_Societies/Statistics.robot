*** Settings ***
Test Setup        Open Browser    https://fundingsocieties.com
Test Teardown     Close Browser
Force Tags        Statistics
Resource          ../../adapters/High_Charts.robot
Resource          ../../adapters/General.robot
Resource          ../../components/Statistics.robot

*** Test Cases ***
Verify Statistics Details In Current Quarter
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
    [Tags]    test11
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
    Verify Element Visible    Statistics.Statistic Detail.Label
    ${actualListLabels}    Get Texts    Statistics.Statistic Detail.Label
    ${actualListLabels}    Replace In List String    ${actualListLabels}
    Should Be Equal    ${actualListLabels}    ${expectListLabels}    Expect all these labels should present in Statistic detail row
    Verify Element Text Contains    Statistics.Statistic Detail.Month Box    ${DATA.getValue("Month Box.Prefix")}
    Verify Element Text Contains    Statistics.Statistic Detail.Month Box    ${currentMonthYear}
    Capture Page Screenshot    ${TEST NAME}
    Click    Statistics.General.Toggle.Total approved
    ${totalApproved}    Get Line Chart Details
    ${totalApproved}    Extract Chart Details    ${totalApproved}    ${chartValuePatterns}    0    ${chartRemovePattern}
    Capture Page Screenshot    ${TEST NAME}
    Pretty Print Object Details    ${totalApproved}
    ${numberOfTotalApproved}    Get List Chart Values     ${totalApproved}
    ${isIncreased}    ListUtils.Is Sorted    ${numberOfTotalApproved}    ${False}
    Run Keyword And Continue On Failure    Should Be True    ${isIncreased}    Total approved of the current Quarter should be greater or equal to the previous Quarter
    ${latestDatePoint}    Get Last Element    ${totalApproved.keys()}
    Run Keyword And Continue On Failure    Should Be Equal    ${latestDatePoint}    ${thisQuarterLabel}    Expect the Date in latest point should match with current date
    ${noOfFinancing}    Get No of Financing    ${totalApproved['${latestDatePoint}']}
    Run Keyword And Continue On Failure    Verify Element Text Equals    Statistics.Statistic Detail.Value.No of financing    ${noOfFinancing}
    Click    Statistics.General.Toggle.Amount disbursed
    ${amountDisbursed}    Get Line Chart Details
    ${amountDisbursed}    Extract Chart Details    ${amountDisbursed}    ${chartValuePatterns}    0    ${chartRemovePattern}
    Capture Page Screenshot    ${TEST NAME}
    Pretty Print Object Details    ${amountDisbursed}
    ${numberOfAmountDisbursed}    Get List Chart Values     ${amountDisbursed}
    ${isIncreased}    ListUtils.Is Sorted    ${numberOfAmountDisbursed}    ${False}
    Run Keyword And Continue On Failure    Should Be True    ${isIncreased}    Amount Disbursed of the current Quarter should be greater or equal to the previous Quarter
    ${latestDatePoint}    Get Last Element    ${amountDisbursed.keys()}
    Run Keyword And Continue On Failure    Should Be Equal    ${latestDatePoint}    ${thisQuarterLabel}    Expect the Date in latest point should match with current date
    ${totalFundedValue}    Get Total Funded    ${amountDisbursed['${latestDatePoint}']}    ${DATA.getValue("Progress Statistic.Value Format.Total funded")}
    Run Keyword And Continue On Failure    Verify Element Text Equals    Statistics.Statistic Detail.Value.Total funded    ${totalFundedValue}
    Click    Statistics.General.Toggle.Default rate
    ${defaultRate}    Get Line Chart Details
    ${defaultRate}    Extract Chart Details    ${defaultRate}    ${chartValuePatterns}    0    ${chartRemovePattern}
    Capture Page Screenshot    ${TEST NAME}
    Pretty Print Object Details    ${defaultRate}
    ${latestDatePoint}    Get The Last Key In Dictionary    ${defaultRate}
    Run Keyword And Continue On Failure    Should Be Equal    ${latestDatePoint}    ${thisQuarterLabel}    Expect the Date in latest point should match with current date
    ${defaultRateValue}    Get Default Rate    ${defaultRate['${latestDatePoint}']}    ${DATA.getValue("Progress Statistic.Value Format.Default rate")}
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
    ${financingFulfillmentRate}    Get Financing Fulfillment Rate    ${sumOfDisbursement}    ${DATA.getValue("Progress Statistic.Value Format.Financing fulfilment rate")}
    Verify Element Text Equals    Statistics.Statistic Detail.Value.Financing fulfillment rate    ${financingFulfillmentRate}
