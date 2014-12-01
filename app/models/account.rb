class Account < ActiveRecord::Base
  has_many :movements, -> {order 'mdate ASC, created_at ASC'}, :dependent => :destroy
  validates_presence_of :name, :amount
  validates_numericality_of :amount
end
