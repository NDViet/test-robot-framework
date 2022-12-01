*** Settings ***
Library    com.ndviet.WebUI    WITH NAME    WebUI
Library    com.ndviet.Configuration    WITH NAME    Configuration

**** Test Cases ***
Sample Test Case
    [Documentation]    This sample test case is used to test library keywords which are retained by Java
    [Tags]    test01
    Open Browser    https://google.com
    [Teardown]    Close Browser

Get My Global Configuration In Test
    [Documentation]    This sample test case is used to test Configuration
    [Tags]    test02
    ${configuration.base}    Get Value    configuration.base
    Log    ${configuration.base}
    ${ip}    Get Value    ip
    Log    ${ip}
    ${configRuleArn}    Get Value    invokingEvent
    Log    ${configRuleArn}
    ${maven_repo.url}    Get Value    maven_repo.url
    Log    ${maven_repo.url}
    ${keyValue.in.properties}    Get Value    keyValue.in.properties
    Log    ${keyValue.in.properties}
    ${currentExecTestTag}    Get Value    includes
    Log    ${currentExecTestTag}
