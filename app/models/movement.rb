class Movement < ActiveRecord::Base
  default_scope {order(mdate: :asc)}
  belongs_to :account
  belongs_to :mtype
  validates :account_id, :mtype_id, :mdate, presence: true
  validates :amount, presence: true, numericality: true

  # see http://api.rubyonrails.org/classes/ActiveRecord/Callbacks.html
  before_destroy :consolidate_destroy

  def consolidate_destroy
    movement = self
    a = movement.account
    if movement == movement.account.movements.last
      a.amount = a.amount - movement.amount
    elsif movement != movement.account.movements.first
      #must update all the movements from the one we destroy except if it's the
      #first one
      #NOTE: this could be different, and we could change also the first, but
      # I prefer this way :-p
      idx = a.movements.find_index(movement)
      a.movements[idx+1..-1].each do |m|
        m.account_amount = m.account_amount - movement.amount
        m.save!
      end
      a.amount = a.amount - movement.amount
    end
    a.save!

    if self.is_transfer
      m = Movement.find(self.movement_id)
      m.is_transfer = false
      m.movement_id = nil
      m.save!
      m.destroy
    end
  end

  def consolidate(transferred_amount)
    movement = self
    if movement.is_transfer and movement.amount > 0
      #we get sure that the amount to transfer is negative in the origin
      movement.amount = 0-movement.amount
    end
    movement.save!
    movement.account.consolidate(movement)

    make_transfer(movement,transferred_amount) if self.is_transfer
  end

  def make_transfer(movement,transferred_amount)
    m = Movement.new()
    m.mtype_id = movement.mtype_id
    m.name = movement.name
    m.description = movement.description
    m.is_transfer = movement.is_transfer
    m.mdate = movement.mdate

    #the account_id is first saved in movement_id
    m.account = Account.find(movement.movement_id)
    m.movement_id = movement.id
    if m.account != movement.account
      m.amount = transferred_amount.to_f.abs
    else
      m.amount = movement.amount.abs
    end
    m.save!

    m.account.consolidate(m)

    movement.movement_id = m.id
    movement.save!
  end

end
