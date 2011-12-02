class Account < ActiveRecord::Base
    belongs_to  :currency
    has_many    :movements, :order => 'mdate ASC, created_at ASC', :dependent => :destroy
    validates_presence_of :name, :currency_id

  def consolidate
    #if the movement is not the last one, the account must be consolidate
    a = self
    if a.movements.length > 1
      index = a.movements.index(a.movements.second)
      movement = a.movements.second
      if index.zero?
        movement.account_amount = a.movements[index+1].account_amount - a.movements[index+1].amount
        movement.save!
      else
        movement.account_amount = a.movements[index-1].account_amount + movement.amount
        movement.save!
        a.movements[index..-1].each do |m|
          idx = a.movements.index(m)
          m.account_amount = a.movements[idx-1].account_amount + m.amount
          m.save! unless idx == -1
        end
      end
      a.amount = a.movements.last.account_amount
      a.save!
    end
  end

end
