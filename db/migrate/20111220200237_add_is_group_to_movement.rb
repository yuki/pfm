class AddIsGroupToMovement < ActiveRecord::Migration
  def up
    add_column :movements, :is_group, :boolean
  end

  def down
    remove_column :movements, :is_group
  end
end
