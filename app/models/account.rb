class Account < ActiveRecord::Base
  has_many :movements, -> {order 'mdate ASC, created_at ASC'}, :dependent => :destroy
  validates_presence_of :name, :amount
  validates_numericality_of :amount


  def consolidate2(movement)
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

  def consolidate
    a = self
#    if a.movements.length > 1
#      index = 0
#      movement = a.movements.first
#      if movement.account_amount == nil
#        #the first movement is new
#        movement.account_amount = a.movements[index+1].account_amount - a.movements[index+1].amount
#        movement.save!
#      end
#      a.movements[1..-1].each do |m|
#        idx = a.movements.index(m)
##        if m.destroyed?
##          m.account_amount = a.movements[idx-1].account_amount
##        else
#          m.account_amount = a.movements[idx-1].account_amount + m.amount
##        end
##        m.save! unless idx == -1
#        m.save!
#      end
#    else
#      movement = a.movements.first
#      if movement.account_amount == nil
#        movement.account_amount = a.amount + movement.amount
#        movement.save!
#      end
#    end
#    a.amount = a.movements.last.account_amount
    a.save!
  end


end
