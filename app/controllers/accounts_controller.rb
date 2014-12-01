class AccountsController < ApplicationController
  before_action :set_account, only: [:show, :edit, :update, :destroy]

  # GET /accounts
  # GET /accounts.json
  def index
    @accounts = Account.all.order("lower(name)")
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
      format.html
    end
  end

  # GET /accounts/new
  def new
    @account = Account.new
  end

  # GET /accounts/1/edit
  def edit
  end

  # POST /accounts
  # POST /accounts.json
  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to accounts_path, notice: 'Account was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /accounts/1
  # PATCH/PUT /accounts/1.json
  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to accounts_path, notice: 'Account was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /accounts/1
  # DELETE /accounts/1.json
  def destroy
    @account.destroy
    respond_to do |format|
      format.html { redirect_to accounts_url, notice: 'Account was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def account_params
      params.require(:account).permit(:name, :description, :amount, :currency, :is_disabled)
    end
end
