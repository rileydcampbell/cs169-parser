When(/^I upload '(.+)'$/) do |file_name|
  attach_file('content[]', File.join(RAILS_ROOT, 'features', 'upload-files', file_name))
  click_button "Import"
end

Given("the database is empty") do
  Xfile.delete_all
end

# When /^(?:|I )upload an xml file$/ do
#   attach_file('content[]', File.join(RAILS_ROOT, 'features', 'upload-files', 'sample2.xml'))
#   click_button "Import"
# end

When("I click 'Delete File'") do
  click_button "Delete File"
end

And(/^I click on the group info link for '(.+)'$/) do |group|
  visit path_to(group)
end

When("I click 'Create'") do
  click_button "Create"
end

And("I click 'Delete Group'") do
  click_button "Delete Group"
end

And("I click 'Back to All Files'") do
  click_link "Back to All Files"
end

And("I click 'List of All Groups'") do
  click_link 'List of All Groups'
end

And("I click 'Create New Group'") do
  click_link "Create New Group"
end

When("I click 'download'") do
  click_link "download"
end

When /^(?:|I )upload an invalid file$/ do
  attach_file('content[]', File.join(RAILS_ROOT, 'features', 'upload-files', 'sample3.txt'))
  click_button "Import"
end

Given /^(?:|I )visit the (.+)$/ do |page_name|
  visit path_to(page_name)
end

And /^(?:|I )am on (.+)$/ do |page_name|
  visit path_to(page_name)
end

Then(/^I should see "([^"]*)"$/) do |text|
  if page.respond_to? :should
    page.should have_content(text)
  else
    assert page.has_content?(text)
  end
end

When(/^I click "([^"]*)" for "([^"]*)"$/) do |arg1, arg2|
  pending # Write code here that turns the phrase above into concrete actions
end

Then(/^I should see "([^"]*)"a"([^"]*)"a"([^"]*)"$/) do |arg1, arg2, arg3|
  pending # Write code here that turns the phrase above into concrete actions
end

And(/^I should be sent to the (.+)$/) do |page_name|
  visit path_to(page_name)
end

When(/^I don't upload a file$/) do
  click_button "Import"
end

When /I check the following file: (.*)/ do |field|
  page.all('[id^="xfile_"]').each do |el|
    if el.value != nil
      within find("#xfile_#{el.value}") do
        check("xfile_id_")
      end
    end
  end
end

When /I click Get Shared Properties/ do
  find('#xfile_form').click
end

Then(/^I should see the file upload page again$/) do
  visit path_to("file upload page")
end

Then(/^I should see the groups index page$/) do
  visit path_to("groups index page")
end

Then(/^I should see the 'Create New Group' page$/) do
  visit path_to("'Create New Group' page")
end

Then(/^I should see the products index page again$/) do
  visit path_to("products index page")
end

Then(/^I should see the groups index page again$/) do
  visit path_to("groups index page")
end

Then /^I should receive a file(?: '([^"]*)')?/ do |file|
  result = page.response_headers['Content-Type'].should == "application/json"
  if result
    result = page.response_headers['Content-Disposition'].should =~ /#{file}/
  end
  result
end
