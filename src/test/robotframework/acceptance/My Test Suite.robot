*** Settings ***
Library    com.ndviet.WebUI

**** Test Cases ***
Sample Test Case
    [Documentation]    This sample test case is used to test library keywords which are retained by Java
    [Tags]    test01
    Open Browser    https://google.com
    [Teardown]    Close Browser
