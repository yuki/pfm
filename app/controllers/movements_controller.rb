class MovementsController < ApplicationController
  before_action :set_movement, only: [:show, :edit, :update, :destroy]

  def index
    @movements = Movement.all
  end

  def show
  end

  def new
    @movement = Movement.new
  end

  def edit
  end

  def create
    @movement = Movement.new(movement_params)

    respond_to do |format|
      if @movement.save
        @movement.consolidate
        format.html { redirect_to account_path(@movement.account), notice: 'Movement was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @movement.update(movement_params)
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
