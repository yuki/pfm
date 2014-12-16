class MovementsController < ApplicationController
  before_action :set_movement, only: [:show, :edit, :update, :destroy]

  def index
    from = DateTime.now.beginning_of_month
    to = DateTime.now.end_of_month
    account_id = 0

    if params[:get_movements]
      if not params[:get_movements][:from].empty?
        from = DateTime.parse(params[:get_movements][:from])
      end

      if not params[:get_movements][:to].empty?
        to = DateTime.parse(params[:get_movements][:to])
      end

      if not params[:get_movements][:account_id].empty?
        account_id = params[:get_movements][:account_id]
      end
    end

    if account_id != 0
      @movements = Movement.where("mdate >= ? and mdate <= ? and account_id = ?",from,to,account_id)
    else
      @movements = Movement.where("mdate >= ? and mdate <= ?",from,to)
    end
  end

  def show
  end

  def new
    @movement = Movement.new
    if params[:account_id]
      @accounts = Account.where("id != ?",params[:account_id]).order('lower(name)')
    else
      @accounts = Account.all.order('lower(name)')
    end
  end

  def edit
  end

  def create
    @movement = Movement.new(movement_params)
    @accounts = Account.where("id != ?",params[:movement][:account_id]).order('lower(name)')

    respond_to do |format|
      if @movement.save
        @movement.consolidate(params[:movement][:transferred_amount])
        format.html { redirect_to account_path(@movement.account), notice: 'Movement was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @movement.update(movement_params)
        @movement.account.consolidate(@movement)
        format.html { redirect_to account_path(@movement.account), notice: 'Movement was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @movement.destroy
    respond_to do |format|
      format.html { redirect_to account_path(@movement.account), notice: 'Movement was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movement
      @movement = Movement.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movement_params
      params.require(:movement).permit(:account_id, :mtype_id, :name, :description, :amount, :mdate, :account_amount, :is_transfer, :movement_id)
    end
end
