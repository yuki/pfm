class Movement < ActiveRecord::Base
  belongs_to :account
  belongs_to :mtype
  validates_presence_of :name, :amount, :account_id, :mtype_id
  validates_numericality_of :amount
end
