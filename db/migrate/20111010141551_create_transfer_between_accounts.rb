class CreateTransferBetweenAccounts < ActiveRecord::Migration
  def up
    add_column :movements, :is_transfer, :boolean
    add_column :movements, :movement_id, :integer
  end

  def down
    remove_column :movements, :is_transfer
    remove_column :movements, :movement_id
  end
end
