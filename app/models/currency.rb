class Currency < ActiveRecord::Base
    has_many    :accounts
end
