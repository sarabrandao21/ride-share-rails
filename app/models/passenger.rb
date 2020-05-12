class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true # requires every rider must have a name
  validates :phone_num, presence: true
  
  def total_cost 
    total_cost = 0 
    self.trips.each  { |trip| total_cost += trip.cost }
    return total_cost
  end 
end
