Feature: json and xml file upload

  As a calcentral developer
  So that I can see overlapping fields for models
  I want to upload json and xml files corresponding to each model and see their contents.

  Scenario: Not uploading a file
   Given I visit the file upload page
   When I don't upload a file
   Then I should see "Please attach a valid file"
   And I should see the file upload page again


   Scenario: Uploading an invalid file that is not json or xml
     Given I visit the file upload page
     When I upload an invalid file
     Then I should see "Incompatible file type, please attach a valid file"
     And I should see the file upload page again

  Scenario: Deleting a file
    Given the database is empty
    Given I visit the file upload page
    When I upload 'sample1.json'
    And I visit the details page for 'sample1'
    When I click 'Delete File'
    Then I should see "File 'sample1.json' deleted."
    And I should see the products index page again


  Scenario: Downloading a file
    Given the database is empty
    Given I visit the file upload page
    When I upload 'sample4.json'
    When I click 'download'
    Then I should receive a file 'sample4.json'

