class Driver < ApplicationRecord
  has_many :trips
  
  def average_rating
    all_ratings = self.trips.map { |trip| trip.rating }
    sum = all_ratings.sum
    return sum / all_ratings.length.to_f
  end 
  
  def total_rides
    total_cost = 0 
    self.trips.each { |trip| total_cost += trip.cost }
    return total_cost
  end
end
