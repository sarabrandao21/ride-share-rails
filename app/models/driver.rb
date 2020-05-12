class Driver < ApplicationRecord
  has_many :trips
  
  validates :name, presence: true # requires every driver must have a name
  # note: vins actually have a fancy check sum validation, a basic regex would only catch the most obvious fake VINs - would need to make a more complex method to truly validate the vin
  validates :vin, presence: true#, format: /[A-HJ-NPR-Z0-9]{17}/ 
  # TODO - add vin verification back in, hiding for ease of creating new records during build
  # requires vin must have a value, and that it must be a combination of 17 numbers and certain capital letters.
  
  
  def average_rating
    all_ratings = []
    self.trips.each do |trip| 
      if !trip.rating.nil?
        all_ratings << trip.rating 
      end 
    end 
    sum = all_ratings.sum / all_ratings.length.to_f
    return all_ratings.empty? ? 0 : sum
  end 
  
  def total_rides
    
    total_cost = 0 
    self.trips.each do |trip| 
      cost = trip.cost 
      if cost > 1.65 
        cost -= 1.65 
        total_cost += (0.8 * cost)
      else 
        total_cost += cost 
      end 
    end 
    return total_cost
  end
end
