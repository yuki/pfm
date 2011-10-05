class Movement < ActiveRecord::Base
    belongs_to  :account
    belongs_to  :mtype
    validates_presence_of :mtype_id, :account_id, :amount
end
