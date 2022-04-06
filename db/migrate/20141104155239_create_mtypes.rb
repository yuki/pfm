class CreateMtypes < ActiveRecord::Migration[4.2]
  def change
    create_table :mtypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
