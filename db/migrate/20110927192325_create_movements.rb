class CreateMovements < ActiveRecord::Migration
  def change
    create_table :movements do |t|
      t.integer :account_id
      t.integer :mtype_id
      t.string :name
      t.text :description
      t.decimal :amount
      t.datetime :mdate
      t.date :vdate

      t.timestamps
    end
  end
end
