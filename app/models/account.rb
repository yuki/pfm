class Account < ActiveRecord::Base
  validates_presence_of :name, :amount
  validates_numericality_of :amount

end
