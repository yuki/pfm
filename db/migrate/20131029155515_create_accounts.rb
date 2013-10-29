class CreateAccounts < ActiveRecord::Migration
  def change
    create_table :accounts do |t|
      t.string :name
      t.text :description
      t.decimal :amount
      t.string :currency

      t.timestamps
    end
    a = Account.new()
    a.name = "Test1"
    a.description = "first account"
    a.amount = 20000
    a.currency = "EUR"
    a.save!
    a = Account.new()
    a.name = "Test2"
    a.description = "second account"
    a.amount = 10000
    a.currency = "USD"
    a.save!
  end
end
