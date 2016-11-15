class ChartsController < ApplicationController
  def index
  end

  def annual_status
    accounts = Account.all.order("name asc")
    @movements = Movement.all.order("mdate asc")
    @first = @movements.first.mdate
    @last = Time.now.year
    @annual_status = []
    @total={}
    i = 0
    accounts.each do |account|
      y = {}
      (@first.year..@last).each do |year|
        m = account.movements.where("mdate <= ?",Time.new(year).end_of_year)
        unless m.empty?
          y[year]=m.last.account_amount
          if @total[year].nil?
            @total[year] = m.last.account_amount
          else
            @total[year] += m.last.account_amount
          end
        end
      end
      @annual_status[i]=[account,y]
      i+=1
    end
  end

  def annual_earns
    accounts = Account.all.order("name asc")
    movements = Movement.all.order("mdate asc")
    @first = movements.first.mdate
    @last = Time.now.year
    @annual_profit={}
    @annual_profit[0]=0
    @annual_loss={}
    @annual_loss[0]=0
    movements.each do |movement|
      year = movement.mdate.year
      if movement.amount > 0 and movement.is_transfer == false
        @annual_profit[0] += movement.amount
        if @annual_profit[year].nil?
          @annual_profit[year] = movement.amount
        else
          @annual_profit[year] += movement.amount
        end
      elsif movement.amount < 0 and movement.is_transfer == false
        @annual_loss[0] += movement.amount
        if @annual_loss[year].nil?
          @annual_loss[year] = movement.amount
        else
          @annual_loss[year] -= movement.amount
        end
      end
    end
  end


end
