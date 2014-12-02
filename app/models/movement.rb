class Movement < ActiveRecord::Base
  belongs_to :account
  belongs_to :mtype
  validates_presence_of :name, :amount, :account_id, :mtype_id, :vdate
  validates_numericality_of :amount

  # see http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
  before_destroy :consolidate_destroy

  def consolidate_destroy
    movement = self
    a = movement.account
    if movement == movement.account.movements.last
      a.amount = a.amount - movement.amount
    else
      #must update all the movements from the one we destroy
      idx = a.movements.index(movement)
      a.movements[idx+1..-1].each do |m|
        m.account_amount = m.account_amount - movement.amount
        m.save!
      end
      a.amount = a.amount - movement.amount
    end
    a.save!
  end

  def consolidate
    movement = self
    if movement.is_transfer and movement.amount > 0
      #we get sure that the amount to transfer is negative in the origin
      movement.amount = 0-movement.amount
    end
    movement.save!
    movement.account.consolidate(movement)

    make_transfer(movement) if self.is_transfer
  end

  def make_transfer(movement)
    m = Movement.new()
    m.mtype_id = movement.mtype_id
    m.name = movement.name
    m.description = movement.description
    m.amount = movement.amount.abs
    m.is_transfer = movement.is_transfer
    m.mdate = movement.mdate
    m.vdate = movement.vdate

    #the account_id is first saved in movement_id
    m.account = Account.find(movement.movement_id)
    m.movement_id = movement.id
    m.save!

    m.account.consolidate(m)

    movement.movement_id = m.id
    movement.save!
  end

end
