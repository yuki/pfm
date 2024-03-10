class ChartsController < ApplicationController
  def index
  end

  def annual_status
    accounts = Account.all
    @movements = Movement.all.order("mdate asc")

    @first = @movements.first ?  @movements.first.mdate : Time.now.year
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
    accounts = Account.all
    movements = Movement.all.order("mdate asc")
    @first = movements.first ?  movements.first.mdate : Time.now.year
    @last = Time.now.year
    @annual_profit={}
    @annual_profit[0]=0
    @annual_loss={}
    @annual_loss[0]=0
    @chart_data = []

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

    @mtype = "All"
    @movements = Movement.all.group_by_year(:mdate, format: "%Y").sum(:amount).to_a
    @movements.each do |movement|
      @chart_data += [{:name => movement[0], :data => [movement[1].to_f]}]
    end
  end

  def movements_types
    movements = []
    @mtype = ""
    @chart_data = []

    if params[:id].to_i != 0
      @mtype = Mtype.find(params[:id]).name
      movements = Mtype.find(params[:id]).movements
    else
      @mtype = "All"
      movements = Movement.all
    end

    drill = []
    movements.group_by_year(:mdate, format: "%Y").sum(:amount).to_a.each do |movement|
      @chart_data += [{:name => movement[0], :y => movement[1].to_f, :drilldown => movement[0]} ]

      month_data = movements.group_by_month(
        :mdate, format: "%Y-%m", range:Date.new(movement[0].to_i)..Date.new(movement[0].to_i).end_of_year
      ).sum(:amount).to_a
      total_data = []
      month_data.each do |month|
        total_data.append([month[0],month[1].to_f])
      end
      drill.append({name: movement[0], id: movement[0], data: total_data})

    end

    @chart_data = [{:name => "Movimientos", :colorByPoint => true, :data => @chart_data }]
    @drilldown = { :series => drill }

    @total = movements.sum(:amount)
  end

end
