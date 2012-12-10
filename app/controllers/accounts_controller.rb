class AccountsController < ApplicationController
  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all(:order => 'name')

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @accounts }
    end
  end

  # GET /accounts/1
  # GET /accounts/1.json
  def show
    @account = Account.find(params[:id])

    @from_month, @to_month = get_dates()
    @days = (@to_month.to_date - @from_month.to_date).to_i
    @movements = @account.movements.where("mdate >= '#{@from_month}' and mdate <= '#{@to_month}' and is_group is not ?",true)

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/new
  # GET /accounts/new.json
  def new
    @account = Account.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @account }
    end
  end

  # GET /accounts/1/edit
  def edit
    @account = Account.find(params[:id])
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(params[:account])

    respond_to do |format|
      if @account.save
        format.html { redirect_to accounts_path, notice: 'Account was successfully created.' }
        format.json { render json: @account, status: :created, location: @account }
      else
        format.html { render action: "new" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /accounts/1
  # PUT /accounts/1.json
  def update
    @account = Account.find(params[:id])

    respond_to do |format|
      if @account.update_attributes(params[:account])
        format.html { redirect_to accounts_path, notice: 'Account was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @account.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account = Account.find(params[:id])
    @account.destroy

    respond_to do |format|
      format.html { redirect_to accounts_url }
      format.json { head :ok }
    end
  end

  def monthly_report
    @account = Account.find(params[:id])
    
  end

  def get_chart_data(movements)
    chart_data = {:profits => [], :loss => []}
    movements.group_by(&:mtype).each do |mtype|
      months = [Array.new(12,0.0),Array.new(12,0.0)]
      mtype[1].each do |movement|
        i = movement.amount > 0 ? 0 : 1
        months[i][movement.vdate.month-1] += movement.amount.to_f
      end
      chart_data[:profits] += [{:name => mtype[0].name, :data => months[0] }]
      chart_data[:loss] += [{:name => mtype[0].name, :data => months[1] }]
    end
    return chart_data
  end

  def month_chart_data(profit_loss,months,mtypes)
    text = ""
    months[profit_loss].each do |month|
      if month == 0.0
        text += "{y: 0},"
      else
        text +=
          "{y: #{month}, color: colors[#{months[profit_loss].index(month)}], drilldown: { name: 'blabla', categories: #{mtypes[profit_loss][months[profit_loss].index(month)].keys}, data: #{mtypes[profit_loss][months[profit_loss].index(month)].values}, color: colors[#{months[profit_loss].index(month)}]}},"
      end
    end
    return text
  end

  def show_year
    @account = params[:id] ? Account.find(params[:id]) : Account.all
    from_month, to_month = get_dates()
    @from_month = from_month.beginning_of_year
    @to_month = @from_month.year == Time.now.year ? Time.now : @from_month.end_of_year
    @days = (@to_month.to_date - @from_month.to_date).to_i
    @chart_data2 = {:profits => "", :loss => ""}
    @params_mtypes = []
    if params.has_key?("mtype")
      @params_mtypes = params[:mtype].select{|k,v| v == "1"}.keys
    end
    @params_mtypes = Mtype.all if @params_mtypes.length == 0
    if params[:id]
      @movements = @account.movements.find(:all, :conditions => ["mdate >= ? and mdate <= ? and is_transfer = ? and mtype_id in (?)", @from_month, @to_month, false, @params_mtypes ])
    else
      @movements = Movement.find(:all, :conditions => ["mdate >= ? and mdate <= ? and is_transfer = ? and mtype_id in (?)", @from_month, @to_month, false, @params_mtypes ])
    end

    #grafic 1
    @chart_data = get_chart_data(@movements)

   #grafic 2
   @months = [Array.new(12,0.0),Array.new(12,0.0)]
   #[profits,loss]
   @mtypes = [{},{}]
    @movements.each do |movement|
      i = movement.amount > 0 ? 0 : 1
 
      #if movement.amount > 0
        @months[i][movement.vdate.month-1] += movement.amount.to_f
        #@mtypes[movement.vdate.month-1] += [movement.mtype.name, movement.amount.to_f]
        #FIXME: this should be done better, it's crap
        if @mtypes[i].has_key?(movement.vdate.month-1)
          if @mtypes[i][movement.vdate.month-1].has_key?(movement.mtype.name)
            @mtypes[i][movement.vdate.month-1][movement.mtype.name] += movement.amount.to_f
          else
            @mtypes[i][movement.vdate.month-1].merge!(Hash[movement.mtype.name,movement.amount.to_f])
          end
        else
          @mtypes[i].merge!(Hash[movement.vdate.month-1,{}])
          @mtypes[i][movement.vdate.month-1].merge!(Hash[movement.mtype.name,movement.amount.to_f])
        end
      #end
    end

    @chart_data2[:profits] = month_chart_data(0,@months,@mtypes)
    @chart_data2[:loss] = month_chart_data(1,@months,@mtypes)

    respond_to do |format|
      format.html
    end

  end


end
