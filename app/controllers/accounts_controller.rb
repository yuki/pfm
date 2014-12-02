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
    from = DateTime.now.beginning_of_month
    to = DateTime.now.end_of_month

    if params[:get_movements]
      if not params[:get_movements][:from].empty?
        from = DateTime.parse(params[:get_movements][:from])
      end

      if not params[:get_movements][:to].empty?
        to = DateTime.parse(params[:get_movements][:to])
      end
    end

    @movements = @account.movements.where("vdate >= ? and vdate <= ?",from,to)

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
