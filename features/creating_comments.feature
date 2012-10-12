Feature: If I use the blogo software
  as a user
  i want to be able to create to comment on a picture

  Scenario: Creating a new comment
    Given I am on the homepage
    And I fill in "Comment" with "New comment"
    And I press "Create comment"
    Then I should see "Your comment has been saved."
    And I should be on the homepage

