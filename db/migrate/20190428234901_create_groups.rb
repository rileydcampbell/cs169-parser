class CreateGroups < ActiveRecord::Migration
  def change
    create_table :groups do |t|
      t.string :name
      t.timestamps null: false
    end

    create_table :group_xfiles, id: false do |t|
      t.belongs_to :group, index: true
      t.belongs_to :xfile, index: true
    end
  end
end
