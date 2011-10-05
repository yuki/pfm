class ModifyCurrencies < ActiveRecord::Migration
  def up
    remove_column :currencies, :value_in_eur
  end

  def down
    add_columnt :currencies, :value_in_eur, :decimal
  end
end
