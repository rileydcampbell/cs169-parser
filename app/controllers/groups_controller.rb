class GroupsController < ApplicationController

  def group_params
    params.require(:group).permit(:name)
  end


  def index
  end

  #Render new template
  def new
  end

  #To create a new group
  def create
  end

  #To edit a group: either adding or removing a file.
  def edit
  end

  #To show all the xfiles within a group
  def show
    # id = params[:id] # retrieve movie ID from URI route
    # @xfile = Xfile.find(id) # look up movie by unique ID
    # @content = eval(@xfile.content)
    # @properties = Xfile.get_properties(@content)
    # puts "properties: " + @properties.to_s
  end

  #To update the file, but also not necessary at the moment.
  def update
  end


end

