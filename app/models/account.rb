class Account < ActiveRecord::Base
    validates_presence_of :name, :amount
end
