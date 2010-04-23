Feature: Manage users
  In order to save and retrieve their memos,
  users want to ceate accounts.

  Scenario: Choose username and password initially
    Given I am on the home page
    When I follow "Choose Username and Password"
    And I fill in "bob" for "Login"
    And I fill in "smells" for "Password"
    And I press "Save"
    Then I should see "Change Username / Password"
