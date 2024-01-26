class AccountsController < ApplicationController
  before_action :set_account, only: %i[ show edit update destroy ]

  def index
    @accounts = Account.where(is_disabled: false)
    @accounts_disabled = Account.where(is_disabled: true)
  end

  def show
    @account = Account.find(params[:id])
    @accounts = Account.where(is_disabled: false)
    @from = DateTime.now.beginning_of_month
    @to = DateTime.now.end_of_month

    if not params[:from].nil? and not params[:from].empty?
      @from = DateTime.parse(params[:from])
    end

    if not params[:to].nil? and not params[:to].empty?
      @to = DateTime.parse(params[:to])
    end

    @movements = @account.movements.where("mdate >= ? and mdate <= ?",@from,@to)

    respond_to do |format|
      format.html
    end
  end

  def new
    @account = Account.new
  end

  def edit
  end

  def create
    @account = Account.new(account_params)

    respond_to do |format|
      if @account.save
        format.html { redirect_to accounts_path, notice: "Account was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @account.update(account_params)
        format.html { redirect_to accounts_path, notice: "Account was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @account.destroy!

    respond_to do |format|
      format.html { redirect_to accounts_url, notice: "Account was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_account
      @account = Account.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def account_params
      params.require(:account).permit(:name, :description, :amount, :currency, :is_disabled)
    end
end
