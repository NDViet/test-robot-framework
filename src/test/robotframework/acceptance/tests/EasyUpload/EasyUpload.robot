*** Settings ***
Documentation     This resource contains the test cases for EasyUpload
Suite Setup
Suite Teardown
Test Setup        WebUI.Open Browser    https://easyupload.io/
Test Teardown     Close Browser
Test Timeout      5 minutes
Force Tags        EasyUpload
Resource          ../../libraries/Web.robot

*** Test Cases ***
Perform To Upload File
    [Documentation]    @Author: Viet Nguyen
    ...    ---
    ...    This test is used to perform upload a file to https://easyupload.io/
    ...    ---
    [Setup]    Run Keywords    Open Browser    https://easyupload.io/
    ...    AND    Capture Page Screenshot    ${TEST NAME}
    [Timeout]    10 minutes
    [Tags]    Regression
    Verify Element Visible    Easy Upload.Upload.Drop Zone
    Capture Page Screenshot    ${TEST NAME}
    Upload File    Easy Upload.Upload.File    ${testData.directory}/Amount_convert.yml
    Click    Easy Upload.Upload.Settings.Expiration Dropdown
    &{variables}    Create Dictionary    value=1 day
    Click    Easy Upload.Upload.Settings.Option    ${variables}
    Capture Page Screenshot    ${TEST NAME}
    Click    Easy Upload.Upload.Submit Button
    Capture Page Screenshot    ${TEST NAME}
    Verify Element Visible    Easy Upload.Upload.Link
    Capture Page Screenshot    ${TEST NAME}