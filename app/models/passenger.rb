class Passenger < ApplicationRecord
  has_many :trips
  
  # TODO Need to add total cost of trips
  def self.total_cost 
    total_cost = 0 
    @passenger.trips do |trip|
      total_cost += trip.cost 
    end 
    return total_cost
  end 
end
