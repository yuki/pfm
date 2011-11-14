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
        redirect_to movements_path
        return
      end
      if @movement.save
        make_movement(@movement)
        make_transfer(@movement) if @movement.is_transfer
        consolidate_account(@movement)

        format.html { redirect_to account_path(@movement.account.id), notice: 'Movement was successfully created.' }
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
      if @movement.update_attributes(params[:movement])
        format.html { redirect_to @movement, notice: 'Movement was successfully updated.' }
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
      format.html { redirect_to movements_url }
      format.json { head :ok }
    end
  end

  def make_movement(movement)
    if movement.is_transfer and movement.amount > 0
        #we get sure that the amount to transfer is negative in the origin
        movement.amount = 0-movement.amount
    end
    movement.account.amount += movement.amount
    movement.account_amount = movement.account.amount
    movement.account.save!
    movement.save!
  end

  def make_transfer(movement)
    m = Movement.new()
    m.mtype_id = movement.mtype_id
    m.account_id = movement.movement_id
    m.name = movement.name
    m.description = movement.description
    m.amount = movement.amount.abs
    m.is_transfer = movement.is_transfer
    m.movement_id = m.id
    m.mdate = movement.mdate
    m.vdate = movement.vdate
    m.account = Account.find(movement.movement_id)
    m.account.amount += m.amount
    m.account_amount = m.account.amount
    m.account.save!
    m.save!
    movement.movement_id = m.id
    movement.save!
  end

  def consolidate_account(movement)
    #if the movement is not the last one, the account must be consolidate
    a = Account.find(movement.account)
    unless a.movements.last == movement and a.movements.length > 1
      index = a.movements.index(movement)
      if index.zero?
        movement.account_amount = a.movements[index+1].account_amount - a.movements[index+1].amount
        movement.save!
        a.movements[index+2..-1].each do |m|
          idx = a.movements.index(m) - 1
          m.account_amount = a.movements[idx].account_amount + m.amount
          m.save! unless idx == -1
        end
      else
        movement.account_amount = a.movements[index-1].account_amount + movement.amount
        movement.save!
        a.movements[index..-1].each do |m|
          idx = a.movements.index(m)
          m.account_amount = a.movements[idx-1].account_amount + m.amount
          m.save! unless idx == -1
        end
      end
      a.amount = a.movements.last.account_amount
      a.save!
    end
  end

end
