Feature: Adding a group

  As a calcentral developer
  So that I can see overlapping fields for models
  I want to group json and xml files by
  properties.

  Scenario: Creating a new group
   Given I visit the file upload page
   When I upload 'sample1.json'
   Given I visit the file upload page
   When I upload 'sample4.json'
   When I visit the 'shared files' page for property 'a'
   And I visit the 'Create New Group' page
   Then I should see the 'Create New Group' page



