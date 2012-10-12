Feature: If I use the blogo software
  as a user
  i want to be able to create a new post easily

Scenario: Creating a new post
  Given I am on the homepage
  And I follow "New Post"
  And I fill in "Title" with "New post"
  And I fill in "Text" with "This is a post."
  And I press "Create Post"
  Then I should see "Your post has been created."
  And I should be on the homepage

Scenario: Editing a post
  Given I am on the homepage
  And I follow "Edit post"
  And I fill in "Title" with "changed title"
  And I press "Update Post"
  Then I should see "Your post has been updated."
  And I should be on the homepage

