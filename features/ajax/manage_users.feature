@javascript
Feature: Manage users
  In order to save and retrieve their memos,
  users want to ceate accounts.

  Scenario: Choose username and password initially
    Given I am on the home page
    Then the page should not change again
    When I follow "Choose Username and Password"
    And I fill in "bob" for "Login"
    And I fill in "smells" for "Password"
    And I press "Save"
    Then I should see "Change Username / Password"

  Scenario: Log in
    Given a username and password
    And I am on the home page
    Then the page should not change again
    When I follow "Log In"
    And I fill in the username and password
    And I press "Log In"
    Then I should see "Log Out"

  Scenario: Log Out
    Given I am logged in
    And I am on the home page
    Then the page should not change again
    When I follow "Log Out"
    Then I should see "Log In"

  Scenario: Absorb Login-less account when logging in
    Given I have some old memos
    And a username and password
    And I am on the home page
    Then the page should not change again
    When I follow "Log In"
    And I fill in the username and password
    And I press "Log In"
    Then I should have memos left to view
