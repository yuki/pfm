class CreateCurrencies < ActiveRecord::Migration
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :symbol
      t.decimal :value_in_eur

      t.timestamps
    end
  end
end
