class TripsController < ApplicationController
   
  def index
    if params[:passenger_id] != nil
      @passenger = Passenger.find_by(id: params[:passenger_id])
      @trips = @passenger.trips
    elsif params[:driver_id] != nil
      @driver = Driver.find_by(id: params[:driver_id])
      @trips = @driver.trips
    else 
      @trips = Trip.all
    end
  end 
  
  def show
    trip_id = params[:id]
    @trip = Trip.find_by(id: trip_id)
    if @trip.nil?
      head :not_found
      return
    end
  end
  
  def destroy
    @trip = Trip.find_by(id: params[:id]) # searches by param you specify
    
    if @trip.nil?
      head :not_found  
      return
    end
    
    @trip.destroy
    
    redirect_to trips_path
    return
  end
  
  def create
    driver = Trip.find_driver
    date = Date.today
    cost = rand(1..100).to_f
    @trip = Trip.new(
      passenger_id: params[:passenger_id], 
      rating: nil, 
      cost: cost,
      date: date, 
      driver_id: driver.id
    )
    if @trip.save
      redirect_to trip_path(@trip.id) # Send them to the trip just created
      return
    else
      redirect_to passenger_path(params[:passenger_id])
      return
    end
  end
  
  def edit
    @trip = Trip.find_by(id: params[:id])
    
    if @trip.nil?
      head :not_found
      return
    end
  end
  
  def update
    @trip = Trip.find_by(id: params[:id])
    
    
    if @trip.nil?
      head :not_found
      return
    elsif @trip.update(trip_params)
      redirect_to trip_path(@trip.id) # Send them to the trip just edited
      return
    else
      render :show
      return
    end
  end
  
  private
  
  def trip_params
    return params.require(:trip).permit(:rating, :cost, :driver_id, :passenger_id, :date)
  end
  
end
