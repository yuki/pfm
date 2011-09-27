class MtypesController < ApplicationController
  # GET /mtypes
  # GET /mtypes.json
  def index
    @mtypes = Mtype.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @mtypes }
    end
  end

  # GET /mtypes/1
  # GET /mtypes/1.json
  def show
    @mtype = Mtype.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @mtype }
    end
  end

  # GET /mtypes/new
  # GET /mtypes/new.json
  def new
    @mtype = Mtype.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @mtype }
    end
  end

  # GET /mtypes/1/edit
  def edit
    @mtype = Mtype.find(params[:id])
  end

  # POST /mtypes
  # POST /mtypes.json
  def create
    @mtype = Mtype.new(params[:mtype])

    respond_to do |format|
      if @mtype.save
        format.html { redirect_to @mtype, notice: 'Mtype was successfully created.' }
        format.json { render json: @mtype, status: :created, location: @mtype }
      else
        format.html { render action: "new" }
        format.json { render json: @mtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /mtypes/1
  # PUT /mtypes/1.json
  def update
    @mtype = Mtype.find(params[:id])

    respond_to do |format|
      if @mtype.update_attributes(params[:mtype])
        format.html { redirect_to @mtype, notice: 'Mtype was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @mtype.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /mtypes/1
  # DELETE /mtypes/1.json
  def destroy
    @mtype = Mtype.find(params[:id])
    @mtype.destroy

    respond_to do |format|
      format.html { redirect_to mtypes_url }
      format.json { head :ok }
    end
  end
end
