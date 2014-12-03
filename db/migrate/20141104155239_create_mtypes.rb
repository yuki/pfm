class CreateMtypes < ActiveRecord::Migration
  def change
    create_table :mtypes do |t|
      t.string :name

      t.timestamps
    end
  end
end
