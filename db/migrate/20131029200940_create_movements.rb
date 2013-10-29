class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.string :name
      t.text :description
      t.decimal :amount
      t.integer :mtype_id
      t.integer :account_id
      t.datetime :mdate
      t.decimal :account_amount
      t.boolean :is_transfer
      t.integer :movement_id

      t.timestamps
    end
  end
end
