class Account < ActiveRecord::Base
  has_many :movements, -> {order 'mdate ASC, created_at ASC'}, :dependent => :destroy
  validates_presence_of :name, :amount
  validates_numericality_of :amount


  def consolidate(movement)
    a = self
    if a.movements.length > 1
      if movement == a.movements.last
        #we just update the last movement
        movement.account_amount = a.amount + movement.amount
        movement.save!
      elsif movement == a.movements.first
        #only update the first movement we have added
        movement.account_amount = a.movements.second.account_amount - a.movements.second.amount
        movement.save!
        return
      else
        #must update all the movements since the last we have added
        idx = a.movements.index(movement)
        a.movements[idx..-1].each do |m|
          i = a.movements.index(m)
          m.account_amount = a.movements[i-1].account_amount + m.amount
          m.save!
        end
      end
    else
        movement.account_amount = a.amount + movement.amount
        movement.save!
    end
    a.amount = a.amount + movement.amount
    a.save!
  end

end
