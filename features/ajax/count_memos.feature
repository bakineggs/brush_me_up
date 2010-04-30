@javascript
Feature: Count memos left to see
  In order to measure progress,
  users want to see how many memos they have left to view

  Scenario: Increase count when you write a memo
    Given I am on the home page
    Then the page should not change again
    When I follow "Write a new memo"
    And I fill in "some fact" for "New memo"
    And I press "Remind Me"
    Then there should be one more memo left to view

  Scenario: Decrease count when you view a memo
    Given I have some old memos
    And I am on the home page
    Then the page should not change again
    When I view a memo
    Then there should be one less memo left to view

  Scenario: Decrease count by two when you view two memos (ensures form action updated)
    Given I have three old memos
    And I am on the home page
    Then the page should not change again
    When I view a memo
    And I view a memo
    Then there should be one memo left to view
