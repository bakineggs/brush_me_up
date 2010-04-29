@javascript
Feature: Count memos left to see
  In order to measure progress,
  users want to see how many memos they have left to view

  Scenario: Decrease count when you view a memo
    Given I have some old memos
    And I am on the home page
    Then the page should not change again
    When I view a memo
    Then there should be one less memo left to view
