class MtypesController < ApplicationController
  before_action :set_mtype, only: %i[ show edit update destroy ]

  def index
    @mtypes = Mtype.all
  end

  def show
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
      @movements = @mtype.movements.where("mdate >= ? and mdate <= ? and account_id = ?",from,to,account_id)
    else
      @movements = @mtype.movements.where("mdate >= ? and mdate <= ?",from,to)
    end
  end

  def new
    @mtype = Mtype.new
  end

  def edit
  end

  def create
    @mtype = Mtype.new(mtype_params)

    respond_to do |format|
      if @mtype.save
        format.html { redirect_to mtypes_url, notice: "Mtype was successfully created." }
      else
        format.html { render :new, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @mtype.update(mtype_params)
        format.html { redirect_to mtypes_url, notice: "Mtype was successfully updated." }
      else
        format.html { render :edit, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @mtype.destroy!

    respond_to do |format|
      format.html { redirect_to mtypes_url, notice: "Mtype was successfully destroyed." }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mtype
      @mtype = Mtype.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def mtype_params
      params.require(:mtype).permit(:name)
    end
end
