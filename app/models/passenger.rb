class Passenger < ApplicationRecord
  has_many :trips

  validates :name, presence: true # requires every rider must have a name
  validates :phone_num, presence: true, format: /([0-9]){0,1}[\.\s]?[\\(\.\s]{0,1}([0-9]){3}[\\)\.\s]{0,1}[\.\s]?([^0-1]){1}([0-9]){2}[\.\s]?[-]?[\.\s]?([0-9]){4}[ ]*((x){0,1}([0-9]){1,5}){0,1}/ 
  # requires phone_num must have a value, and that it must be a valid format
  
  
  def total_cost 
    total_cost = 0 
    self.trips.each  { |trip| total_cost += trip.cost }
    return total_cost
  end 
end
