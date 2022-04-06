class CreateAccounts < ActiveRecord::Migration[4.2]
  def change
    create_table :accounts do |t|
      t.string :name
      t.text :description
      t.decimal :amount
      t.string :currency
      t.boolean :is_disabled, :default => false

      t.timestamps
    end
  end
end
