class MovementsController < ApplicationController
  before_action :set_movement, only: [:show, :edit, :update, :destroy]

  # GET /movements
  # GET /movements.json
  def index
    @movements = Movement.all
  end

  # GET /movements/1
  # GET /movements/1.json
  def show
  end

  # GET /movements/new
  def new
    @movement = Movement.new
  end

  # GET /movements/1/edit
  def edit
  end

  # POST /movements
  # POST /movements.json
  def create
    @movement = Movement.new(movement_params)
    @movement.mdate = @movement.vdate

    respond_to do |format|
      if @movement.is_transfer? and @movement.account.id == @movement.movement_id
        flash[:error] = "Cannot make transfer into the same account"
        redirect_to account_path(@movement.account)
        return
      end
      if @movement.save
        format.html { redirect_to account_path(@movement.account), notice: 'Movement was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /movements/1
  # PATCH/PUT /movements/1.json
  def update
    respond_to do |format|
      if @movement.update(movement_params)
        format.html { redirect_to account_path(@movement.account), notice: 'Movement was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /movements/1
  # DELETE /movements/1.json
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
      params.require(:movement).permit(:account_id, :mtype_id, :name, :description, :amount, :mdate, :vdate, :account_amount, :is_transfer, :movement_id)
    end
end
