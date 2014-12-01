class MtypesController < ApplicationController
  before_action :set_mtype, only: [:show, :edit, :update, :destroy]

  # GET /mtypes
  # GET /mtypes.json
  def index
    @mtypes = Mtype.all.order("lower(name)")
  end

  # GET /mtypes/1
  # GET /mtypes/1.json
  def show
  end

  # GET /mtypes/new
  def new
    @mtype = Mtype.new
  end

  # GET /mtypes/1/edit
  def edit
  end

  # POST /mtypes
  # POST /mtypes.json
  def create
    @mtype = Mtype.new(mtype_params)

    respond_to do |format|
      if @mtype.save
        format.html { redirect_to mtypes_url, notice: 'Mtype was successfully created.' }
        #format.json { render :show, status: :created, location: @mtype }
      else
        format.html { render :new }
      end
    end
  end

  # PATCH/PUT /mtypes/1
  # PATCH/PUT /mtypes/1.json
  def update
    respond_to do |format|
      if @mtype.update(mtype_params)
        format.html { redirect_to mtypes_url, notice: 'Mtype was successfully updated.' }
      else
        format.html { render :edit }
      end
    end
  end

  # DELETE /mtypes/1
  # DELETE /mtypes/1.json
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
