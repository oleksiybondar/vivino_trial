# Introduction

This is Oleksiy Bondar's trial task implementation for 'Senior Automation Engineer' at Vivino.

The implementations covers following goals:
1. Create a testing framework from scratch
2. Design and write a test case using created testing framework

# Dependencies

- ruby v.2.5.8 and higher
- appium server v 1.18.3 and higher
- Android Studio/SDK and/or Genymotion with running emulator instance

# Setup and usage

## setup

1. setup Android Studio/SDK and/or Genymotion

1.1 install Android Studio and/or Genymotion

1.1.1 open Android Studio

1.1.2 open configure > AVD Manager

1.1.3. open 'Create Virtual device' and follow the wizard

1.2 install Genymotion

1.2.1 install Virtual box if not installed

1.2.2 open Genymotion and log in with your account

1.2.3 click '(+)' button and follow the wizard

1.3. start just created emulator

2. setup Appium

2.1.1 install node.js if not yet installed

2.2 run 'npm install -g appium' from command lines

2.3 define "JAVA_HOME" environment variable see

2.4 define "ANDROID_HOME" environment variable ss

2.5 run 'appium' from command line 

3. clone a repository 

3.1 run 'git clone https://github.com/oleksiybondar/vivino_trial.git' from command line  

4. install required gems

4.1 install bundler gem if not yet installed

4.2 in a project folder run 'bundle install' from command line


## running test

1. adjust Appium capabilities in 'features/env/config.yaml'

1.1 if you set up Android studio from scratch, then default configuration fits for you  
2. in a project folder run 'cucumber --format html --out report.html'

# Framework Implementation Notes

## Tasks

This testing framework was written with to solve following tasks:

- provide automaticall and detailed logging while running test
- provide a tool agnostic and stable interface for a test
- reduce repetitive Appium/Selenium code in page objects
- reduce find_element Appium/Selenium calls at runtime
- provide automaticall StaleElementReference handling mechanism
- provide Page Object API which increase objects re-usage

## Implementation notes

In order to achieve 'tool agnostic and stable interface for a test' a Wrapper Design Pattern was used to wrap Appium/Selenium objects. Despite that a framework designed for Selenium and Appium usage, current implementation can be adjusted to Adapted Design Pattern with ease and without a need to change anything in test implementation. In addition wrappers decorates action calls with a build in logging.

'add_element' helper was created, which dynamically defines an access method inside of Concrete Page Object and this access method already contains 'find_element' API call and has a build it StaleReferencError handler. This pieces of code are the most repetitive among test writers, so this helper solves 'repetitive Appium/Selenium code reduction'. In addition in most cases page objects does not keep element reference, each user defined action searches for an element, this helper implementation remembers element references so amount of Selenium/Appium API call reduced, and find_element actions happens only when element was not searched yet or it become stale

Decorator Page Object pattern was applied for Element actions in order to add automaticall StaleElementReference handling mechanism for already founded elements

Chain of Responsibility Design Pattern was applied in StaleElementReference handler, it traverses back from a tree until handle all staled subtree

A framework logger was implemented using Listener Design Pattern in order to add an ability to increase amount of supported formats.

**NOTE** some of mentioned pattern may have only partial implementation because this framework implements only minimum living functionality required for a trial task and in rush

# Execution logs

## execution video



## cucumber build it reporting tool

please take a look download or clone and look committed report sample ``<root>/last_report.html``

## Frameworks low level logging

```

```