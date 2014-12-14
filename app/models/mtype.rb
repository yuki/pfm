class Mtype < ActiveRecord::Base
    has_many    :movements, -> {order 'mdate ASC, created_at ASC'}, :dependent => :destroy
    validates_presence_of :name
end
