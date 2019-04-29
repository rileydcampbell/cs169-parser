class CreateGroupsAndGroupsXfiles < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :groups_xfiles, id: false do |t|
      t.references "group", index: true
      t.references "xfile", index: true
    end
  end
end
