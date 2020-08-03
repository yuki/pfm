class Mtype < ActiveRecord::Base
    default_scope {order('LOWER(name)')}
    has_many    :movements, -> {order 'mdate ASC, created_at ASC'}, :dependent => :destroy
    validates_presence_of :name
end
