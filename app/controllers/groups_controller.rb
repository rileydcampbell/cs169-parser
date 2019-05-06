class GroupsController < ApplicationController

  def group_params
    params.require(:group).permit(:name, :xfile_id)
  end


  def index
    @groups = Group.all
    if @groups.empty?
      flash[:notice] = "No groups created yet."
    end
  end

  #Render new template
  def new
    @prop = params[:prop]
    @xfiles = Xfile.where("content like ?", "%\"#{@prop}\"%")
    puts params[:prop]
    render 'new'

  end

  #To create a new group
  def create
    xfile_ids = params[:xfile_id]
    prop = params[:prop]
    @group = Group.create!(group_params) do |group|
      if group.name.empty?
        group.name = "Group #{prop}"
      end
      group.prop = prop
    end
    xfile_ids.each do |id|
      xfile = Xfile.find(id.to_i)
      @group.xfiles << xfile
    end
    @group.save
    redirect_to groups_path

  end

  #To edit a group: either adding or removing a file.
  def edit
  end

  #To show all the xfiles within a group
  def show
    id = params[:id] # retrieve group ID from URI route
    @group = Group.find_by(:id => id)
    @xfiles = @group.xfiles


  end

  #To update the file, but also not necessary at the moment.
  def update
  end

  #To delete group from database.
  def destroy
    @group = Group.find(params[:id])
    @group.destroy
    flash[:notice] = "Group '#{@group.name}' deleted."
    redirect_to groups_path
  end


end

