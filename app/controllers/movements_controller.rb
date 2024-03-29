class MovementsController < ApplicationController
  before_action :set_movement, only: %i[ show edit update destroy ]

  def index
    @from = DateTime.now.beginning_of_month
    @to = DateTime.now.end_of_month
    @accounts = Account.where(is_disabled: false)
    @account_id = 0

    logger.debug params[:from].nil?
    
    if not params[:from].nil? and not params[:from].empty?
      @from = DateTime.parse(params[:from])
    end

    if not params[:to].nil? and not params[:to].empty?
      @to = DateTime.parse(params[:to])
    end

    if not params[:account_id].nil? and not params[:account_id].empty?
      @account_id = params[:account_id]
    end

    if @account_id != 0
      @movements = Movement.where("mdate >= ? and mdate <= ? and account_id = ?",@from,@to,@account_id)
    else
      @movements = Movement.where("mdate >= ? and mdate <= ?",@from,@to)
    end
  end

  def show
  end

  def new
    @movement = Movement.new
    @accounts = Account.where("is_disabled == false")
    @mtypes = Mtype.all
  end

  def edit
    #@accounts = Account.where("is_disabled == false")
    @accounts = Account.where("id = ?",@movement.account)
    @mtypes = Mtype.all
  end

  def create
    @movement = Movement.new(movement_params)
    #@accounts = Account.where("id != ?",params[:movement][:account_id]).order('lower(name)')
    @accounts = Account.where("is_disabled == false")
    @mtypes = Mtype.all

    respond_to do |format|
      if @movement.save
        @movement.consolidate(params[:movement][:transferred_amount])
        format.html { redirect_to account_path(@movement.account), notice: "Movement was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    if params[:account_id]
      @accounts = Account.where("id != ?",params[:account_id]).order('lower(name)')
    else
      @accounts = Account.all.order('lower(name)')
    end
    @mtypes = Mtype.all
    respond_to do |format|
      if @movement.update(movement_params)
        @movement.account.consolidate(@movement)
        format.html { redirect_to account_path(@movement.account), notice: "Movement was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @movement.destroy!

    respond_to do |format|
      format.html { redirect_to account_path(@movement.account), notice: "Movement was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movement
      @movement = Movement.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def movement_params
      params.require(:movement).permit(:name, :description, :amount, :mdate, :account_amount, :is_transfer, :movement_id, :account_id, :mtype_id)
    end
end
