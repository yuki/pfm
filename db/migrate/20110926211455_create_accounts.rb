class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.integer :currency_id
      t.text :description
      t.decimal :value_init
      t.decimal :value_last

      t.timestamps
    end
  end
end
