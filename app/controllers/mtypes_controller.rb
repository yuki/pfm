class MtypesController < ApplicationController
  before_action :set_mtype, only: [:show, :edit, :update, :destroy]

  def index
    @mtypes = Mtype.all.order("lower(name)")
  end

  def show
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
        format.html { redirect_to mtypes_url, notice: 'Mtype was successfully created.' }
      else
        format.html { render :new }
      end
    end
  end

  def update
    respond_to do |format|
      if @mtype.update(mtype_params)
        format.html { redirect_to mtypes_url, notice: 'Mtype was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  def destroy
    @mtype.destroy
    respond_to do |format|
      format.html { redirect_to mtypes_url, notice: 'Mtype was successfully destroyed.' }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_mtype
      @mtype = Mtype.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def mtype_params
      params.require(:mtype).permit(:name)
    end
end
