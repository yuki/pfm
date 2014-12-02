class Movement < ActiveRecord::Base
  belongs_to :account
  belongs_to :mtype
  validates_presence_of :name, :amount, :account_id, :mtype_id
  validates_numericality_of :amount

  # see http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
  after_create :consolidate
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
    #if movement.is_transfer and movement.amount > 0
    #  #we get sure that the amount to transfer is negative in the origin
    #  movement.amount = 0-movement.amount
    #end
    #movement.save!

    #make_transfer(movement) if self.is_transfer
    movement.account.consolidate(movement)
  end

  def make_transfer(movement)
    m = Movement.new()
    m.mtype_id = movement.mtype_id
    m.account_id = movement.movement_id
    m.name = movement.name
    m.description = movement.description
    m.amount = movement.amount.abs
    m.is_transfer = movement.is_transfer
    m.movement_id = movement.id
    m.mdate = movement.mdate
    m.vdate = movement.vdate
    m.account = Account.find(movement.movement_id)
    m.account.amount += m.amount
    m.account_amount = m.account.amount
    m.account.save!
    m.save!
    m.account.consolidate
    movement.movement_id = m.id
    movement.save!
  end

end
