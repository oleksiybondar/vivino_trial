@android @vivino @gui @trial
Feature: Vivino Trial
  An exploration test, which checks a new user ability to try out the application without an need to create an account,
  basically this is 'Happy Pass' test implementation

  @visitor @how_it_works @search
  Scenario: How it works
    Given Launched Vivino application
    When  User click 'How it works' button
    Then  Slide description is 'Get honest wine ratings on any wine from our community of millions of wine drinkers'
    When  User click 'next' button
    Then  Slide description is 'Shop the world\'s largest wine selection directly from your phone'
    When  User click 'next' button
    Then  Slide description is 'Scan any bottle to learn all about the wine inside'
    When  User click 'next' button
    Then  Slide description is 'Scan a restaurant wine list and choose your wine with confidence'
    When  User click 'next' button
    Then  Slide description is 'Create a free account to save your wine scans, forever'
    And   Account creation buttons shown
    When  User click 'Try us out'
    Then  User see a 'Welcome to Vivino' message
    When  User navigates to a wine search
    Then  Search query is shown
    When  User enters a '<keyword>'
    Then  Search results are shown
    And   All results contains given '<keyword>'

    Examples:
      | keyword |
      | bordo   |
      | Italy   |
      | red     |