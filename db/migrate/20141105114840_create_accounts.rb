class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.text :description
      t.decimal :amount
      t.string :currency
      t.boolean :is_disabled

      t.timestamps
    end
  end
end
