class Trip < ApplicationRecord
  belongs_to :driver #foreign key - driver_id
  belongs_tp :passenger #foreign key - passenger_id
end
