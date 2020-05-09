class PassengersController < ApplicationController

  def index
    @passengers = Passenger.all
  end

  def show
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id)
    if @passenger.nil?
      head :not_found # This would be the better way to do this
      return
    end
  end
    
  def destroy
    passenger_id = params[:id]
    @passenger = Passenger.find_by(id: passenger_id) # searches by param you specify
      
    if @passenger.nil?
      head :not_found  
      return
    end

    @passenger.destroy

    redirect_to passenger_path
    return
  end

  def create
    @passenger = Passenger.new(
      name: params[:passenger][:name],
      phone_num: params[:passenger][:phone_num]
    )
    if @passenger.save
      redirect_to passenger_path(@passenger.id) # Send them to the passenger just created
      return
    else
      render :new, :bad_request # show the new passenger form again
      return
    end
  end

  def new
    @passenger = Passenger.new
  end

  def edit
    @passenger = Passenger.find_by(id: params[:id])

    if @passenger.nil?
      head :not_found
      return
    end
  end

  def update
    @passenger = Passenger.find_by(id: params[:id])
    if @passenger.nil?
      head :not_found
      return
    elsif @passenger.update(
      name: params[:passenger][:name],
      phone_num: params[:passenger][:phone_num]
    )
      redirect_to passenger_path(@passenger.id) # Send them to the passenger just edited
      return
    else
      render :edit
      return
    end
  end

end
