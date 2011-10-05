class Account < ActiveRecord::Base
    belongs_to  :currency
    has_many    :movements, :dependent => :destroy
    validates_presence_of :name, :currency_id
end
