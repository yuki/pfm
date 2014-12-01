class Movement < ActiveRecord::Base
  belongs_to :account
  belongs_to :mtype
  validates_presence_of :name, :amount, :account_id, :mtype_id
  validates_numericality_of :amount
  after_destroy :consolidate_after_destroy

  def consolidate_after_destroy
    if self.is_transfer
      m = Movement.find(self.movement_id)
      m.is_transfer = false
      m.movement_id = nil
      m.save!
      m.destroy
    end
    if self.account.movements.length == 0
      self.account.amount = self.account.amount - self.amount
      self.account.save!
    else
      self.account.consolidate
    end
  end

  def consolidate
    make_movement(self)
    make_transfer(self) if self.is_transfer
    self.account.consolidate
  end


  def make_movement(movement)
    if movement.is_transfer and movement.amount > 0
      #we get sure that the amount to transfer is negative in the origin
      movement.amount = 0-movement.amount
    end
    movement.save!
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
