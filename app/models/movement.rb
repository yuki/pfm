class Movement < ActiveRecord::Base
    belongs_to  :account
    belongs_to  :mtype
end
