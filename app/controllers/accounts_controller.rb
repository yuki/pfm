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
    #FIXME: should be a better way to do this
    if params[:get_movements]
        params[:from_date] = Date.new(params[:get_movements]["from(1i)"].to_i,params[:get_movements]["from(2i)"].to_i).to_s(:db)
        params[:to_date] = Date.new(params[:get_movements]["to(1i)"].to_i,params[:get_movements]["to(2i)"].to_i).to_s(:db)
    end
    @from_month = (params[:from_date]) ?
        Date.new(params[:get_movements]["from(1i)"].to_i,params[:get_movements]["from(2i)"].to_i) :
        Date.today.beginning_of_month
    @to_month = (params[:to_date]) ?
        Date.new(params[:get_movements]["to(1i)"].to_i,params[:get_movements]["to(2i)"].to_i).end_of_month :
        Date.today.end_of_month


    @movements = @account.movements.where("mdate >= '#{@from_month}' and mdate <= '#{@to_month}'")

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

  def show_year
    @account = Account.find(params[:id])
    @chart_data = {:profits => [], :loss => []}
    @chart_data2 = {:profits => "", :loss => ""}
    @account.movements.group_by(&:mtype).each do |mtype|
      months = [Array.new(12,0.0),Array.new(12,0.0)]
      mtype[1].each do |movement|
        i = movement.amount > 0 ? 0 : 1
        months[i][movement.vdate.month-1] += movement.amount.to_f
      end
      @chart_data[:profits] += [{:name => mtype[0].name, :data => months[0] }]
      @chart_data[:loss] += [{:name => mtype[0].name, :data => months[1] }]
    end

    #grafic 2
    @months = Array.new(12,0.0)
    @mtypes = {}
    @account.movements.each do |movement|
      if movement.amount > 0
        @months[movement.vdate.month-1] += movement.amount.to_f
        #@mtypes[movement.vdate.month-1] += [movement.mtype.name, movement.amount.to_f]
        #FIXME: this should be done better, it's crap
        if @mtypes.has_key?(movement.vdate.month-1)
          if @mtypes[movement.vdate.month-1].has_key?(movement.mtype.name)
            @mtypes[movement.vdate.month-1][movement.mtype.name] += movement.amount.to_f
          else
            @mtypes[movement.vdate.month-1].merge!(Hash[movement.mtype.name,movement.amount.to_f])
          end
        else
          @mtypes.merge!(Hash[movement.vdate.month-1,{}])
          @mtypes[movement.vdate.month-1].merge!(Hash[movement.mtype.name,movement.amount.to_f])
        end
      end
    end
    @months.each do |month|
      if month == 0.0
        @chart_data2[:profits] += "{y: 0},"
      else
        @chart_data2[:profits] +=
          "{y: #{month}, color: colors[#{@months.index(month)}], drilldown: { name: 'blabla', categories: #{@mtypes[@months.index(month)].keys}, data: #{@mtypes[@months.index(month)].values}, color: colors[#{@months.index(month)}]}},"
#          Hash["y",month],
#          Hash["drilldown",
#              Hash["name","enero"]
#          ]
      end
    end

    respond_to do |format|
      format.html
    end

  end
end
