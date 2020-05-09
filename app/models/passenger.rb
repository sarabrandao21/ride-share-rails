class Passenger < ApplicationRecord
  has_many :trips
  
  def total_cost 
    total_cost = 0 
    self.trips.each  { |trip| total_cost += trip.cost }
    return total_cost
  end 
end
