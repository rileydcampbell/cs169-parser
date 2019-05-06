class AddPropToGroups < ActiveRecord::Migration
  def change
    add_column :groups, :prop, :string
  end
end
