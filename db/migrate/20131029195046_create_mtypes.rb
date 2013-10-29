class CreateMtypes < ActiveRecord::Migration
  def change
    create_table :mtypes do |t|
      t.string :name

      t.timestamps
    end
    m = Mtype.new()
    m.name = "party"
    m.save!
    m = Mtype.new()
    m.name = "food"
    m.save!
    m = Mtype.new()
    m.name = "mobile phone"
    m.save
  end
end
