Feature: Count memos left to see
  In order to measure progress,
  users want to see how many memos they have left to view

  Scenario: Count of memos
    Given I have some old memos
    And I am on the home page
    Then I should be told how many memos are left to see

  Scenario: Decrease count when you view a memo
    Given I have some old memos
    And I am on the home page
    When I view a memo
    Then there should be one less memo left to view

  Scenario: Increase count when memos need to be viewed
    Given I have some old and new memos
    When some time passes
    Given I am on the home page
    Then there should be more memos left to view
