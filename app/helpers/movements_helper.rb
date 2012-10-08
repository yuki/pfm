module MovementsHelper

  def get_total_amount(movements)
    return movements.find_all{|i| !i.is_transfer?}.sum(&:amount)
  end

  def get_movement_amount(movement)
    type = movement.amount > 0 ? "positive":"negative"
    return "<span class='#{type}'>#{number_with_precision(movement.amount, :precision => 2).to_s + ' ' + movement.account.currency.symbol}</span>".html_safe
  end

  def show_total_amount(total)
    type = total> 0 ? "positive":"negative"
    #FIXME: this should be updated with currency
    return "<span class='#{type}'>#{number_with_precision(total,:precision => 2)} </span>".html_safe
  end

end
