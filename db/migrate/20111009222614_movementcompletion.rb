class Movementcompletion < ActiveRecord::Migration
  def up
    add_column :movements, :account_amount, :decimal
    remove_column :accounts, :value_init
    rename_column :accounts, :value_last, :amount
  end

  def down
    remove_column :movements, :account_amount
    add_column :accounts, :value_init, :decimal
    rename_column :accounts, :amount, :value_last
  end
end
