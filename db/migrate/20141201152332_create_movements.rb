class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.references :account, index: true
      t.references :mtype, index: true
      t.string :name
      t.text :description
      t.decimal :amount
      t.datetime :mdate
      t.datetime :vdate
      t.decimal :account_amount
      t.boolean :is_transfer
      t.integer :movement_id

      t.timestamps
    end
  end
end
