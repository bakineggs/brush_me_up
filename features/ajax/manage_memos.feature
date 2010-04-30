@javascript
Feature: Manage memos
  In order to retain information better,
  users want to create and view memos.

  Scenario: Write a new memo
    Given I am on the home page
    Then the page should not change again
    When I follow "Write a new memo"
    And I fill in "some fact" for "New memo"
    And I press "Remind Me"
    Then I should see "We'll make sure you remember that"
    And I should see "some fact"

  Scenario: Seeing a memo and remembering it
    Given my memos "some fact" and "some other fact"
    And I am on the home page
    Then I should see "some fact"
    And the page should not change again
    When I press "I'm gettin it"
    Then I should see "We'll remind you less often"
    And I should see "some other fact"

  Scenario: Seeing a memo and not remembering it
    Given my memos "some fact" and "some other fact"
    And I am on the home page
    Then I should see "some fact"
    And the page should not change again
    When I press "Dang, I keep forgetting!"
    Then I should see "We'll remind you more often"
    And I should see "some other fact"
