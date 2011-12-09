class MovementsController < ApplicationController
  # GET /movements
  # GET /movements.json
  def index
    @movements = Movement.all

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @movements }
    end
  end

  # GET /movements/1
  # GET /movements/1.json
  def show
    @movement = Movement.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @movement }
    end
  end

  # GET /movements/new
  # GET /movements/new.json
  def new
    @movement = Movement.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @movement }
    end
  end

  # GET /movements/1/edit
  def edit
    @movement = Movement.find(params[:id])
  end

  # POST /movements
  # POST /movements.json
  def create
    @movement = Movement.new(params[:movement])

    respond_to do |format|
      if @movement.is_transfer? and @movement.account.id == @movement.movement_id
        flash[:error] = "Cannot make transfer into the same account"
        redirect_to account_path(@movement.account)
        return
      end
      if @movement.save
        #FIXME: it should be in the model, with "after_create"
        @movement.consolidate
        format.html { redirect_to account_path(@movement.account), notice: 'Movement was successfully created.' }
        format.json { render json: @movement, status: :created, location: @movement }
      else
        format.html { render action: "new" }
        format.json { render json: @movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /movements/1
  # PUT /movements/1.json
  def update
    @movement = Movement.find(params[:id])

    respond_to do |format|
      old_account_id = @movement.account_id
      if @movement.update_attributes(params[:movement])
        #if movement is updated to other account, it must be consolidated
        if old_account_id != params[:movement]["account_id"]
          a = Account.find(old_account_id)
          a.consolidate
        end
       @movement.account.consolidate
        format.html { redirect_to account_path(@movement.account), notice: 'Movement was successfully updated.' }
        format.json { head :ok }
      else
        format.html { render action: "edit" }
        format.json { render json: @movement.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movements/1
  # DELETE /movements/1.json
  def destroy
    @movement = Movement.find(params[:id])
    @movement.destroy

    respond_to do |format|
      format.html { redirect_to account_path(@movement.account) }
      format.json { head :ok }
    end
  end

end
