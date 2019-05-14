# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the (FileParser )?home\s?page$/ then '/xfiles'

    when /^group index page$/i
      groups_path()

    when /^group (.+)$/i
      group_path(1)

    when /^file upload page$/i
      new_xfile_path()

    when /^'Create New Group' page$/i
      new_group_path()

    when /^groups index page$/i
      groups_path()

    when /^'shared files' page for property '(.+)'$/i
      shared_files_path($1)

    when /^shared properties page$/i
      shared_props_path()

    when /^groups index page$/i
      groups_path()

    when /^products index page$/i
      xfiles_path()

    # Add more mappings here.
    # Here is an example that pulls values out of the Regexp:
    #
    #   when /^(.*)'s profile page$/i
    #     user_profile_path(User.find_by_login($1))

    when /^edit page for "(.+)"$/i
      edit_xfile_path(Xfile.find_by_name($1))

    when /^details page for '(.+)'$/i
      xfile_path(1)

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
          "Now, go and add a mapping in #{__FILE__}"
        end
      end
  end
end

World(NavigationHelpers)
