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
14-12-2020 16:26:41.381 | DEBUG   | [Landing] Performing elements search, type: single, locator: {:id=>"android:id/button1"}
14-12-2020 16:26:41.572 | DEBUG   | [Landing] Element was not found
14-12-2020 16:26:41.573 | INFO    | [Landing.genymotion_err_ok_btn] Getting element presense: false
14-12-2020 16:26:41.576 | DEBUG   | [Landing] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/seehowitwork"}
14-12-2020 16:26:41.664 | INFO    | [Landing.how_it_works_btn] Getting element presense: true
14-12-2020 16:26:41.759 | INFO    | [Landing.how_it_works_btn] Click on an element
14-12-2020 16:26:41.761 | DEBUG   | [Landing] Performing elements search, type: single, locator: {:xpath=>"//*[@resource-id=\"vivino.web.app.beta:id/viewFlipperproductshowcase\"][last()]"}
14-12-2020 16:26:42.928 | DEBUG   | [Landing] Element was not found
14-12-2020 16:26:42.929 | INFO    | [Landing.how_it_works_slide] Getting element presense: false
14-12-2020 16:26:43.929 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:xpath=>"//*[@resource-id=\"vivino.web.app.beta:id/viewFlipperproductshowcase\"][last()]"}
14-12-2020 16:26:45.991 | INFO    | [Landing.how_it_works_slide] Getting element presense: true
14-12-2020 16:26:45.992 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/description\"] | .//android.widget.TextView"}
14-12-2020 16:26:46.033 | INFO    | [Landing.how_it_works_slide.description] Getting element presense: true
14-12-2020 16:26:46.053 | INFO    | [Landing.how_it_works_slide.description] Getting element text: Get honest wine ratings on any wine from our community of millions of wine drinkers
14-12-2020 16:26:46.056 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/next"}
14-12-2020 16:26:46.077 | INFO    | [Landing.how_it_works_slide.next_btn] Getting element presense: true
14-12-2020 16:26:48.652 | INFO    | [Landing.how_it_works_slide.next_btn] Click on an element
14-12-2020 16:26:48.653 | INFO    | [Landing.how_it_works_slide] Getting element presense: true
14-12-2020 16:26:48.654 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/description\"] | .//android.widget.TextView"}
14-12-2020 16:26:49.541 | INFO    | [Landing.how_it_works_slide.description] Getting element presense: true
14-12-2020 16:26:49.555 | INFO    | [Landing.how_it_works_slide.description] Getting element text: Shop the world's largest wine selection directly from your phone
14-12-2020 16:26:49.556 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/next"}
14-12-2020 16:26:49.573 | INFO    | [Landing.how_it_works_slide.next_btn] Getting element presense: true
14-12-2020 16:26:49.620 | INFO    | [Landing.how_it_works_slide.next_btn] Click on an element
14-12-2020 16:26:49.621 | INFO    | [Landing.how_it_works_slide] Getting element presense: true
14-12-2020 16:26:49.622 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/description\"] | .//android.widget.TextView"}
14-12-2020 16:26:50.485 | INFO    | [Landing.how_it_works_slide.description] Getting element presense: true
14-12-2020 16:26:50.501 | INFO    | [Landing.how_it_works_slide.description] Getting element text: Scan any bottle to learn all about the wine inside
14-12-2020 16:26:50.502 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/next"}
14-12-2020 16:26:50.528 | INFO    | [Landing.how_it_works_slide.next_btn] Getting element presense: true
14-12-2020 16:26:50.591 | INFO    | [Landing.how_it_works_slide.next_btn] Click on an element
14-12-2020 16:26:50.593 | INFO    | [Landing.how_it_works_slide] Getting element presense: true
14-12-2020 16:26:50.593 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/description\"] | .//android.widget.TextView"}
14-12-2020 16:26:51.489 | INFO    | [Landing.how_it_works_slide.description] Getting element presense: true
14-12-2020 16:26:51.503 | INFO    | [Landing.how_it_works_slide.description] Getting element text: Scan a restaurant wine list and choose your wine with confidence
14-12-2020 16:26:51.505 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/next"}
14-12-2020 16:26:51.536 | INFO    | [Landing.how_it_works_slide.next_btn] Getting element presense: true
14-12-2020 16:26:51.588 | INFO    | [Landing.how_it_works_slide.next_btn] Click on an element
14-12-2020 16:26:51.589 | INFO    | [Landing.how_it_works_slide] Getting element presense: true
14-12-2020 16:26:51.590 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/description\"] | .//android.widget.TextView"}
14-12-2020 16:26:52.372 | INFO    | [Landing.how_it_works_slide.description] Getting element presense: true
14-12-2020 16:26:52.388 | INFO    | [Landing.how_it_works_slide.description] Getting element text: Create a free account to save your wine scans, forever
14-12-2020 16:26:52.390 | DEBUG   | [Landing] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/continue_with_email"}
14-12-2020 16:26:52.411 | INFO    | [Landing.continue_with_email] Getting element presense: true
14-12-2020 16:26:52.411 | DEBUG   | [Landing] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/continue_with_facebook"}
14-12-2020 16:26:52.429 | INFO    | [Landing.continue_with_facebook] Getting element presense: true
14-12-2020 16:26:52.429 | DEBUG   | [Landing] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/continue_with_google"}
14-12-2020 16:26:52.449 | INFO    | [Landing.continue_with_google] Getting element presense: true
14-12-2020 16:26:52.450 | DEBUG   | [Landing] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/txtTryUsOut"}
14-12-2020 16:26:52.466 | INFO    | [Landing.try_out_btn] Getting element presense: true
14-12-2020 16:26:52.467 | INFO    | [Landing.try_out_btn] Getting element presense: true
14-12-2020 16:26:52.523 | INFO    | [Landing.try_out_btn] Click on an element
14-12-2020 16:26:52.525 | DEBUG   | [Home] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/user_name"}
14-12-2020 16:26:53.161 | DEBUG   | [Home] Element was not found
14-12-2020 16:26:53.161 | INFO    | [Home.user_name] Getting element presense: false
14-12-2020 16:26:54.166 | DEBUG   | [Home.user_name] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/user_name"}
14-12-2020 16:26:54.197 | DEBUG   | [Home.user_name] Element was not found
14-12-2020 16:26:54.197 | INFO    | [Home.user_name] Getting element presense: false
14-12-2020 16:26:55.203 | DEBUG   | [Home.user_name] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/user_name"}
14-12-2020 16:26:55.528 | DEBUG   | [Home.user_name] Element was not found
14-12-2020 16:26:55.528 | INFO    | [Home.user_name] Getting element presense: false
14-12-2020 16:26:56.534 | DEBUG   | [Home.user_name] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/user_name"}
14-12-2020 16:26:57.650 | DEBUG   | [Home.user_name] Element was not found
14-12-2020 16:26:57.651 | INFO    | [Home.user_name] Getting element presense: false
14-12-2020 16:26:58.658 | DEBUG   | [Home.user_name] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/user_name"}
14-12-2020 16:26:59.286 | INFO    | [Home.user_name] Getting element presense: true
14-12-2020 16:26:59.287 | INFO    | [Home.user_name] Getting element presense: true
14-12-2020 16:27:00.198 | INFO    | [Home.user_name] Getting element text: Welcome to Vivino
14-12-2020 16:27:00.205 | DEBUG   | [Home] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/tabs"}
14-12-2020 16:27:00.232 | DEBUG   | [Home.nav_bar] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/wine_explorer_tab"}
14-12-2020 16:27:00.252 | INFO    | [Home.nav_bar.search] Getting element presense: true
14-12-2020 16:27:00.252 | INFO    | [Home.nav_bar.search] Getting element presense: true
14-12-2020 16:27:00.316 | INFO    | [Home.nav_bar.search] Click on an element
14-12-2020 16:27:00.318 | DEBUG   | [Search] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/search_vivino"}
14-12-2020 16:27:01.174 | INFO    | [Search.search_btn] Getting element presense: true
14-12-2020 16:27:01.174 | INFO    | [Search.search_btn] Getting element presense: true
14-12-2020 16:27:01.177 | INFO    | [Search.search_btn] Getting element presense: true
14-12-2020 16:27:01.177 | INFO    | [Search.search_btn] Getting element presense: true
14-12-2020 16:27:04.487 | INFO    | [Search.search_btn] Click on an element
14-12-2020 16:27:04.488 | DEBUG   | [Search] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/editText_input"}
14-12-2020 16:27:04.521 | INFO    | [Search.search_query] Getting element presense: true
14-12-2020 16:27:04.521 | INFO    | [Search.search_query] Getting element presense: true
14-12-2020 16:27:05.197 | INFO    | [Search.search_query] Sending bordo input to an element
14-12-2020 16:27:05.199 | DEBUG   | [Search] Performing elements search, type: multiple, locator: {:xpath=>"//*[@resource-id=\"vivino.web.app.beta:id/pager\"]//android.widget.FrameLayout"}
```