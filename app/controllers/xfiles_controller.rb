class XfilesController < ApplicationController

  require 'crack' # XML and JSON parsingrequire 'crack/json' # Only JSON parsing
  require 'crack/xml' # Only XML parsing
  require 'json'

  def xfile_params
    params.require(:xfile).permit(:name, :content, :property, :value)
  end

  #To show the data fields and their relationships in a data file.
  def show
    id = params[:id] # retrieve xfile ID from URI route
    @xfile = Xfile.find(id) # look up xfile by unique ID
    @content = eval(@xfile.content)
    @properties = Xfile.get_properties(@content)
    @groups = @xfile.groups
  end

  #To show the list of files uploaded to the application.
  def index
    @xfiles = Xfile.all
    shared_props(Xfile.ids)
    if @xfiles.empty?
      @shared_props = Hash.new()
      @shared_set = Hash.new()
    end
  end

  # default: render 'new' template
  def new
  end

  #To create the file and store it into our database.
  def create
    @content = params[:content]
    if @content.nil?
      flash[:notice] = "Please attach a valid file"
      redirect_to new_xfile_path
    else
      params[:content].each do |file|
        @xfile = file.read
        @name = file.original_filename
        @extension = @name.split('.').last
        if @extension == "json"
          @data = Crack::JSON.parse(@xfile)
        elsif @extension == "xml"
          @data = Crack::XML.parse(@xfile)
        else
          flash[:notice] = "Incompatible file type, please attach a valid file"
          redirect_to new_xfile_path and return
        end
        @xfile = Xfile.create!(xfile_params) do |xfile|
          xfile.content = @data
          if xfile.name.empty?
            xfile.name = @name
          end
        end
        flash[:notice] = "#{@xfile.name} was successfully created."
      end
      redirect_to xfiles_path
    end
  end

  #To edit the file, should populate a table of its group.
  def edit
    @id = params[:id]
    @xfile = Xfile.find(@id)
    @prop = params[:prop]
    @group_id = params[:groupid]
    @group = Group.find(@group_id)
  end

  def edit_file(xfile, prop, val)
    puts "value should not be nil and " + val
    puts "property should not be nil and " + prop
    data = xfile.content
    data = eval(data)
    data[prop] = val
    xfile.update!(name: xfile.name, content: data)
  end

  #Edit both selected files and its group
  def edit_post
    # id = params[:id] # retrieve movie ID from URI route
    # edit_file(Xfile.find(id), params[:property], params[:value])

    params[:group_id].each do |group_id|
      group = Group.find(group_id)
      group.xfiles.each do |xfile|
        edit_file(xfile, params[:property], params[:value])
      end
    end

    redirect_to xfiles_path
  end



  #To update the file, but also not necessary at the moment.
  def update
  end

  def shared_files
    @prop = params[:prop]
    @xfiles = Xfile.where("content like ?", "%\"#{@prop}\"%")
    @groups = Group.where("prop = ?", @prop.to_s)
    render 'shared_files'
  end

  # def get_shared_props(xfile_ids)
  #   prop_sets = Hash.new()
  #   @file_names = []
  #   xfile_ids.each do |id|
  #     current_xfile = Xfile.find(id.to_i)
  #     content = current_xfile.content
  #     properties = Xfile.get_properties_from_string(content)
  #     properties.each do |prop|
  #       if prop_sets.key?(prop)
  #         prop_sets[prop] += 1
  #       else
  #         prop_sets[prop] = 1
  #       end
  #     end
  #     @file_names.append(current_xfile)
  #   end

  #   shared_set = prop_sets[0]


  #   prop_sets.each do |set|
  #     shared_set = shared_set & set
  #   end
  #   @shared_set = shared_set.nil? ? [] : shared_set
  # end

  def shared_props(xfile_ids)
      prop_sets = Hash.new()
      @file_names = []
      xfile_ids.each do |id|
        current_xfile = Xfile.find(id.to_i)
        content = current_xfile.content
        properties = Xfile.get_properties_from_string(content)
        properties.each do |prop|
          if prop_sets.key?(prop)
            prop_sets[prop] += 1
          else
            prop_sets[prop] = 1
          end
        end
        @file_names.append(current_xfile)
      end
      non_unique_props = Hash.new()
      prop_sets.each_pair do |prop, count|
        if count > 1
          non_unique_props[prop] = count
        end
      @shared_set = non_unique_props
      end
  end

  def download_xfile
    id = params[:id]
    @xfile = Xfile.find(id)
    content = @xfile.content
    # f = File.new("#{Rails.root}/app/assets/docs/#{@xfile.name}.json", "w+")
    # f.write(eval(@xfile.content).to_json)
    # f.close
    data = eval(content).to_json
    if @xfile.name.include? '.json'
      send_data data, :filename => "#{@xfile.name}"
    else
      send_data data, :filename => "#{@xfile.name}.json"
    end
    # send_file "#{Rails.root}/app/assets/docs/#{@xfile.name}.json", type: "application/json", x_sendfile: true
    flash[:notice] = "#{@xfile.name} was successfully downloaded."
  end

  #To delete the file from database.
  def destroy
    @xfile = Xfile.find(params[:id])
    @xfile.destroy
    flash[:notice] = "File '#{@xfile.name}' deleted."
    redirect_to xfiles_path
  end

end
