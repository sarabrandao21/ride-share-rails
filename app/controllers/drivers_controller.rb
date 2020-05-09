class DriversController < ApplicationController
  def index 
    @drivers = Driver.all 
  end 
  
  def show 
    driver_id = params[:id]
    @driver = Driver.find_by(id: driver_id)
    if @driver.nil?
      head :not_found 
      return
    end
  end 
  
  def edit
    @driver = Driver.find_by(id: params[:id])
    
    if @driver.nil?
      head :not_found
      return
    end
  end
  
  def update
    @driver = Driver.find_by(id: params[:id])
    if @driver.nil?
      head :not_found
      return
    elsif @driver.update(
      name: params[:driver][:name],
      vin: params[:driver][:vin],
      available: params[:driver][:available])
      redirect_to root_path 
      return
    else
      render :edit
      return
    end
  end
  
  def new
    @driver = Driver.new
  end 
  
  def create 
    @driver = Driver.new(
      name: params[:driver][:name],
      vin: params[:driver][:vin],
      available: params[:driver][:available]
    )
    if @driver.save
      redirect_to driver_path(@driver.id) 
      return
    else
      render :new, :bad_request 
      return
    end
  end 
  
  def destroy
    driver_id = params[:id]
    @driver =  Driver.find_by(id: driver_id) 
    
    if @driver.nil?
      head :not_found  
      return
    end
    
    @driver.destroy
    
    redirect_to driver_path
    return
  end 
end
