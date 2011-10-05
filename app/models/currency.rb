class Currency < ActiveRecord::Base
    has_many    :accounts, :dependent => :destroy
    validates_presence_of :name, :symbol
end
