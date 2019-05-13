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
   And I click 'Create'
   Then I should be on the groups page
   And I should see "Group a"

   Scenario: Deleting a group
     Given group a exists
     When I upload an invalid file
     Then I should see "Incompatible file type, please attach a valid file"
     And I should see the file upload page again


