class Account < ActiveRecord::Base
    belongs_to  :currency
    has_many    :movements
end
