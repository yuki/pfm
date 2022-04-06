class DeleteVdateToMovements < ActiveRecord::Migration[4.2]
  def change
    remove_column :movements, :vdate, :datetime

    change_column :movements, :amount, :decimal, :default => 0.0
  end
end
