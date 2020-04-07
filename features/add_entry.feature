Feature: Add a new blog entry
  
  As a blogger
  So that I can easily contribute content to my blog
  I want to be able to add a new blog entry
  
Scenario: As a blogger I want to be able to navigate from the homepage to the new article form
  Given I am on the home page
  When I click on the "My Blog" link
  Then I should be on the "Listing articles" page
  When I click on the "New article" link
  Then I should be on the "New Article" page
  And I should see the "Title" field
  And I should see the "Text" field
  
  # Below scenario has to be done in one go, as the test does not contain preexisting articles
Scenario: As a blogger I want to be able to add a new article, edit it and delete it
  Given I am on the New Article page
  When I write in the "Title" field with "Tests"
  And I write in the "Text" field with "Test Content"
  When I click on the "Create Article" button
  Then I should be on the "Tests" page
  
  When I click on the "Article List" link
  Then I should be on the "Listing articles" page
  When I click on the "Edit" link
  Then I should be on the "Editing article" page
  
  When I click on the "Back" link
  Then I should be on the "Listing articles" page
  When I click on the "Destroy" link
  Then I should not find the "Tests" article