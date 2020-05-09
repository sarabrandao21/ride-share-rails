class Passenger < ApplicationRecord
  has_many :trips

  # TODO Need to add total cost of trips
end
