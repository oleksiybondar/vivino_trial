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

2. in a project folder run 'cucumber --format html --out report.html'

**NOTE** I found Genymotion extremely unstable environments it often hangs, at least under Mac OS Big Sur, so Android SDK is preferable

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

Android SDK https://www.dropbox.com/s/ddy43pfggitztdr/Android_SDK.mov?dl=0
Genymotion  https://www.dropbox.com/s/yd5rmwrmlzc2oxg/Genymotion.mov?dl=0

## cucumber build it reporting tool

please take a look download or clone and look committed report sample ``<root>/last_report.html``

## Frameworks low level logging

```
14-12-2020 22:56:20.878 | DEBUG   | [Landing] Performing elements search, type: single, locator: {:id=>"android:id/button1"}
14-12-2020 22:56:20.933 | DEBUG   | [Landing] Element was not found!
14-12-2020 22:56:20.933 | INFO    | [Landing.genymotion_err_ok_btn] Getting element presense: false
14-12-2020 22:56:20.937 | DEBUG   | [Landing] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/seehowitwork"}
14-12-2020 22:56:20.980 | INFO    | [Landing.how_it_works_btn] Getting element presense: true
14-12-2020 22:56:21.068 | INFO    | [Landing.how_it_works_btn] Click on an element
14-12-2020 22:56:21.069 | DEBUG   | [Landing] Performing elements search, type: single, locator: {:xpath=>"//*[@resource-id=\"vivino.web.app.beta:id/viewFlipperproductshowcase\"][last()]"}
14-12-2020 22:56:22.106 | INFO    | [Landing.how_it_works_slide] Getting element presense: true
14-12-2020 22:56:22.106 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/description\"] | .//android.widget.TextView"}
14-12-2020 22:56:22.477 | INFO    | [Landing.how_it_works_slide.description] Getting element presense: true
14-12-2020 22:56:22.497 | INFO    | [Landing.how_it_works_slide.description] Getting element text: Get honest wine ratings on any wine from our community of millions of wine drinkers
14-12-2020 22:56:22.499 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/next"}
14-12-2020 22:56:22.520 | INFO    | [Landing.how_it_works_slide.next_btn] Getting element presense: true
14-12-2020 22:56:22.572 | INFO    | [Landing.how_it_works_slide.next_btn] Click on an element
14-12-2020 22:56:22.574 | INFO    | [Landing.how_it_works_slide] Getting element presense: true
14-12-2020 22:56:22.574 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/description\"] | .//android.widget.TextView"}
14-12-2020 22:56:23.484 | INFO    | [Landing.how_it_works_slide.description] Getting element presense: true
14-12-2020 22:56:23.525 | INFO    | [Landing.how_it_works_slide.description] Getting element text: Shop the world's largest wine selection directly from your phone
14-12-2020 22:56:23.525 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/next"}
14-12-2020 22:56:23.584 | INFO    | [Landing.how_it_works_slide.next_btn] Getting element presense: true
14-12-2020 22:56:23.671 | INFO    | [Landing.how_it_works_slide.next_btn] Click on an element
14-12-2020 22:56:23.673 | INFO    | [Landing.how_it_works_slide] Getting element presense: true
14-12-2020 22:56:23.674 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/description\"] | .//android.widget.TextView"}
14-12-2020 22:56:24.632 | INFO    | [Landing.how_it_works_slide.description] Getting element presense: true
14-12-2020 22:56:24.655 | INFO    | [Landing.how_it_works_slide.description] Getting element text: Scan any bottle to learn all about the wine inside
14-12-2020 22:56:24.656 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/next"}
14-12-2020 22:56:24.683 | INFO    | [Landing.how_it_works_slide.next_btn] Getting element presense: true
14-12-2020 22:56:25.563 | INFO    | [Landing.how_it_works_slide.next_btn] Click on an element
14-12-2020 22:56:25.564 | INFO    | [Landing.how_it_works_slide] Getting element presense: true
14-12-2020 22:56:25.569 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/description\"] | .//android.widget.TextView"}
14-12-2020 22:56:25.609 | INFO    | [Landing.how_it_works_slide.description] Getting element presense: true
14-12-2020 22:56:25.629 | INFO    | [Landing.how_it_works_slide.description] Getting element text: Scan a restaurant wine list and choose your wine with confidence
14-12-2020 22:56:25.630 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/next"}
14-12-2020 22:56:25.693 | INFO    | [Landing.how_it_works_slide.next_btn] Getting element presense: true
14-12-2020 22:56:25.753 | INFO    | [Landing.how_it_works_slide.next_btn] Click on an element
14-12-2020 22:56:25.755 | INFO    | [Landing.how_it_works_slide] Getting element presense: true
14-12-2020 22:56:25.755 | DEBUG   | [Landing.how_it_works_slide] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/description\"] | .//android.widget.TextView"}
14-12-2020 22:56:26.531 | INFO    | [Landing.how_it_works_slide.description] Getting element presense: true
14-12-2020 22:56:26.548 | INFO    | [Landing.how_it_works_slide.description] Getting element text: Create a free account to save your wine scans, forever
14-12-2020 22:56:26.549 | DEBUG   | [Landing] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/continue_with_email"}
14-12-2020 22:56:26.572 | INFO    | [Landing.continue_with_email] Getting element presense: true
14-12-2020 22:56:26.572 | DEBUG   | [Landing] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/continue_with_facebook"}
14-12-2020 22:56:26.593 | INFO    | [Landing.continue_with_facebook] Getting element presense: true
14-12-2020 22:56:26.593 | DEBUG   | [Landing] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/continue_with_google"}
14-12-2020 22:56:26.614 | INFO    | [Landing.continue_with_google] Getting element presense: true
14-12-2020 22:56:26.615 | DEBUG   | [Landing] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/txtTryUsOut"}
14-12-2020 22:56:26.639 | INFO    | [Landing.try_out_btn] Getting element presense: true
14-12-2020 22:56:26.639 | INFO    | [Landing.try_out_btn] Getting element presense: true
14-12-2020 22:56:26.726 | INFO    | [Landing.try_out_btn] Click on an element
14-12-2020 22:56:26.727 | DEBUG   | [Home] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/user_name"}
14-12-2020 22:56:27.358 | DEBUG   | [Home] Element was not found!
14-12-2020 22:56:27.358 | INFO    | [Home.user_name] Getting element presense: false
14-12-2020 22:56:28.365 | DEBUG   | [Home.user_name] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/user_name"}
14-12-2020 22:56:28.394 | DEBUG   | [Home.user_name] Element was not found!
14-12-2020 22:56:28.395 | INFO    | [Home.user_name] Getting element presense: false
14-12-2020 22:56:29.400 | DEBUG   | [Home.user_name] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/user_name"}
14-12-2020 22:56:29.489 | DEBUG   | [Home.user_name] Element was not found!
14-12-2020 22:56:29.489 | INFO    | [Home.user_name] Getting element presense: false
14-12-2020 22:56:30.493 | DEBUG   | [Home.user_name] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/user_name"}
14-12-2020 22:56:36.904 | DEBUG   | [Home.user_name] Element was not found!
14-12-2020 22:56:36.905 | INFO    | [Home.user_name] Getting element presense: false
14-12-2020 22:56:37.909 | DEBUG   | [Home.user_name] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/user_name"}
14-12-2020 22:56:39.622 | INFO    | [Home.user_name] Getting element presense: true
14-12-2020 22:56:39.623 | INFO    | [Home.user_name] Getting element presense: true
14-12-2020 22:56:39.659 | INFO    | [Home.user_name] Getting element text: Vivino User
14-12-2020 22:56:39.664 | DEBUG   | [Home] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/tabs"}
14-12-2020 22:56:39.726 | DEBUG   | [Home.nav_bar] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/wine_explorer_tab"}
14-12-2020 22:56:39.770 | INFO    | [Home.nav_bar.search] Getting element presense: true
14-12-2020 22:56:39.770 | INFO    | [Home.nav_bar.search] Getting element presense: true
14-12-2020 22:56:39.862 | INFO    | [Home.nav_bar.search] Click on an element
14-12-2020 22:56:39.864 | DEBUG   | [Search] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/search_vivino"}
14-12-2020 22:56:41.449 | INFO    | [Search.search_btn] Getting element presense: true
14-12-2020 22:56:41.449 | INFO    | [Search.search_btn] Getting element presense: true
14-12-2020 22:56:41.451 | INFO    | [Search.search_btn] Getting element presense: true
14-12-2020 22:56:41.451 | INFO    | [Search.search_btn] Getting element presense: true
14-12-2020 22:56:41.951 | INFO    | [Search.search_btn] Click on an element
14-12-2020 22:56:41.951 | DEBUG   | [Search] Performing elements search, type: single, locator: {:id=>"vivino.web.app.beta:id/editText_input"}
14-12-2020 22:56:44.056 | INFO    | [Search.search_query] Getting element presense: true
14-12-2020 22:56:44.056 | INFO    | [Search.search_query] Getting element presense: true
14-12-2020 22:56:44.130 | INFO    | [Search.search_query] Sending bordo input to an element
14-12-2020 22:56:44.131 | DEBUG   | [Search] Performing elements search, type: multiple, locator: {:xpath=>"//*[@resource-id=\"vivino.web.app.beta:id/pager\"]//android.widget.FrameLayout"}
14-12-2020 22:56:54.683 | INFO    | [Search.search_results[0]] Getting element presense: true
14-12-2020 22:56:54.684 | DEBUG   | [Search.search_results[0]] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/winename_textView\"]"}
14-12-2020 22:56:54.725 | INFO    | [Search.search_results[0].name] Getting element presense: true
14-12-2020 22:56:54.741 | INFO    | [Search.search_results[0].name] Getting element text: Rioja Bordon Gran Reserva
14-12-2020 22:56:54.741 | INFO    | Search result 0 contains given bordo
14-12-2020 22:56:54.742 | DEBUG   | [Search.search_results[1]] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/winename_textView\"]"}
14-12-2020 22:56:54.766 | INFO    | [Search.search_results[1].name] Getting element presense: true
14-12-2020 22:56:54.784 | INFO    | [Search.search_results[1].name] Getting element text: Rioja Bordon Gran Reserva
14-12-2020 22:56:54.784 | INFO    | Search result 1 contains given bordo
14-12-2020 22:56:54.785 | DEBUG   | [Search.search_results[2]] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/winename_textView\"]"}
14-12-2020 22:56:54.810 | INFO    | [Search.search_results[2].name] Getting element presense: true
14-12-2020 22:56:54.823 | INFO    | [Search.search_results[2].name] Getting element text: Rioja Bordon Crianza
14-12-2020 22:56:54.823 | INFO    | Search result 2 contains given bordo
14-12-2020 22:56:54.824 | DEBUG   | [Search.search_results[3]] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/winename_textView\"]"}
14-12-2020 22:56:54.851 | INFO    | [Search.search_results[3].name] Getting element presense: true
14-12-2020 22:56:54.866 | INFO    | [Search.search_results[3].name] Getting element text: Rioja Bordon Crianza
14-12-2020 22:56:54.866 | INFO    | Search result 3 contains given bordo
14-12-2020 22:56:54.866 | DEBUG   | [Search.search_results[4]] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/winename_textView\"]"}
14-12-2020 22:56:54.893 | INFO    | [Search.search_results[4].name] Getting element presense: true
14-12-2020 22:56:54.909 | INFO    | [Search.search_results[4].name] Getting element text: Rioja Bordon Reserva
14-12-2020 22:56:54.909 | INFO    | Search result 4 contains given bordo
14-12-2020 22:56:54.910 | DEBUG   | [Search.search_results[5]] Performing elements search, type: single, locator: {:xpath=>".//*[@resource-id=\"vivino.web.app.beta:id/winename_textView\"]"}
14-12-2020 22:56:54.940 | INFO    | [Search.search_results[5].name] Getting element presense: true
14-12-2020 22:56:54.958 | INFO    | [Search.search_results[5].name] Getting element text: Rioja Bordon Reserva
14-12-2020 22:56:54.958 | INFO    | Search result 5 contains given bordo

```