[![Run Test](https://github.com/vietnd96/test-robot-framework/actions/workflows/robotframework-maven.yml/badge.svg)](https://github.com/vietnd96/test-robot-framework/actions/workflows/robotframework-maven.yml)

## Introduction

Test repository with test case is created and executed in Robot Framework.<br>

## List dependency repositories

1. [test-parent-pom](../../../test-parent-pom)
2. [test-automation-fwk](../../../test-automation-fwk)
3. [test-java2robot-adapter](../../../test-java2robot-adapter)

## Source code usage

1. Clone repository "test-parent-pom" (**mandatory**)

```shell
git clone git@github.com:vietnd96/test-parent-pom.git
```

2. Clone this test repository to the same directory

```shell
git clone git@github.com:vietnd96/test-robot-framework.git
```

4. Build source code in each repository following the order

- test-parent-pom
- test-robot-framework

5. Run test cases in test repository

```shell
cd test-robot-framework
```

```shell
mvn initialize robotframework:run -Dincludes=EasyUpload -Dselenium.browser.type=chrome
```

Noted:

* **[includes]** property is used to provide Robot Test Tags would be executed.
* List of configuration can be input from CLI can be referred to [pom.xml](./pom.xml) or layered configuration
  files in [src/test/resources/configuration](src/test/resources/configuration)

## Reference

A sample project with entire repositories together for the test execution.<br>

* [test-automation-project](https://github.com/vietnd96/test-automation-project)
