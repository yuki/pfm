class Mtype < ApplicationRecord
    default_scope {order('LOWER(name)')}
    has_many    :movements, -> {order 'mdate ASC, created_at ASC'}, :dependent => :destroy
    validates :name, presence: true, uniqueness: true
end
