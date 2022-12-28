*** Settings ***
Test Setup        Open Browser    https://fundingsocieties.com
Test Teardown     Close Browser
Resource          ../adapters/High_Charts.robot

*** Test Cases ***
Verify Elements In General tab
    [Tags]    test11
    Click    Menu.Statistics
    Verify Element Text Equals    Statistics.Progress Page.Title    Our Progress
    Verify Element Text Contains    Statistics.Progress Page.Subtitle    We are in 5 countries, Singapore, Malaysia, Indonesia, Thailand and Vietnam
    Verify Element Text Contains    Statistics.Progress Page.Subtitle    check our statistics across the region.
    ${currentMonthYear}    Get Current Date In Format    MMMM yyyy
    Verify Element Text Contains    Statistics.Statistic Detail.Month Box    Statistics
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
    ...    	5.1) Top label should be Statistics | <Current Month> <Current Year>
    ...    	5.2) Total funded:
    ...    	\	Label: Total funded
    ...    	\	Value:
    ...    	\	\	+ Start with the currency S$ (Dollar Singapore)
    ...    	\	\	+ Round the number to two decimal place (e.g: 4.03) with format grouped string representation (e.g: billion, million)
    ...    	5.3) Number of financing:
    ...    	\	Label: No. of financing
    ...    	\	Value: The number contains comma to separate groups of thousands
    ...    	5.4) Default rate:
    ...    	\	Label: Default rate
    ...    	\	Value in percentage. Round the number to two decimal place.
    ...    	5.5) Financing fulfilment rate:
    ...    	\	Label: Financing fulfilment rate
    ...    	\	Value in percentage. Round the number to two decimal place.
    ...    6) Verify there are 3 tabs below the Statistic row detail
    ...    	6.1) General
    ...    	6.2) Repayment
    ...    	6.3) Disbursement
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
