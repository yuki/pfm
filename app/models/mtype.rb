class Mtype < ActiveRecord::Base
    has_many  :movements, :dependent => :destroy
    validates_presence_of :name
end
