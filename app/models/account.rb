class Account < ActiveRecord::Base
  #default_scope {order(name: :asc)}
  has_many :movements, -> {order 'mdate ASC, created_at ASC'}, :dependent => :destroy
  validates_presence_of :name, :amount
  validates_numericality_of :amount


  def consolidate(movement)
    a = self
    if a.movements.length > 1
      if movement == a.movements.last
        #we just update the last movement
        movement.account_amount = a.movements[-2].account_amount + movement.amount
        movement.save!
        a.amount = movement.account_amount
        a.save!
        return
      elsif movement == a.movements.first
        #only update the first movement we have added
        movement.account_amount = a.movements.second.account_amount - a.movements.second.amount
        movement.save!
        return
      else
        #must update all the movements from the last we have added
        idx = a.movements.find_index(movement)
        a.movements[idx..-1].each do |m|
          i = a.movements.find_index(m)
          m.account_amount = a.movements[i-1].account_amount + m.amount
          m.save!
        end
        a.amount = a.movements.last.account_amount
        a.save!
        return
      end
    else
        movement.account_amount = a.amount + movement.amount
        movement.save!
    end
    a.amount = a.amount + movement.amount
    a.save!
  end

end
