class TripsController < ApplicationController

  # TODO do we need index?
  def index
    @trips = Trip.all
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
    @trip = Trip.new(
      passenger_id: params[:passenger_id], 
      rating: nil, 
      cost: rand(1..100).to_f, 
      date: Date.today, 
      driver_id: driver.id
    )
    if @trip.save
      driver.status = "unavailable"
      driver.save
      redirect_to passenger_path(params[:passenger_id]) # Send them to the trip just created
      return
    else
      render :new, status: :bad_request # show the new trip form again
      return
    end
  end

  # def new
  #   @trip = Trip.new
  # end

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
      render :edit
      return
    end
  end

  private

  def trip_params
    return params.require(:trip).permit(:date, :driver_id, :passenger_id, :cost, :rating)
  end

end
