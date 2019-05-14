Feature: Adding a group

  As a calcentral developer
  So that I can see overlapping fields for models
  I want to group json and xml files by
  properties.

  Scenario: Seeing the groups
   Given I visit the group index page
   Then I should see "No groups created yet."

  Scenario: Creating a new group
   Given I visit the file upload page
   When I upload 'sample1.json'
   Given I visit the file upload page
   When I upload 'sample4.json'
   When I visit the 'shared files' page for property 'a'
   And I click 'Create New Group'
   And I click 'Create'
   Then I should see the groups index page
   And I should see "Group a"

  Scenario: Deleting a new group
   Given I visit the file upload page
   When I upload 'sample1.json'
   Given I visit the file upload page
   When I upload 'sample4.json'
   When I visit the 'shared files' page for property 'a'
   And I click 'Create New Group'
   And I click 'Create'
   And I click 'Back to All Files'
   And I click 'List of All Groups'
   And I click on the group info link for 'group a'
   And I click 'Delete Group'
   Then I should see the groups index page again

