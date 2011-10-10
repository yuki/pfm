class SetDefaults < ActiveRecord::Migration
  def up
    change_column :movements, :amount, :decimal, :default => 0.0
  end

  def down
  end
end
