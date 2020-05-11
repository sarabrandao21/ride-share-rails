class Trip < ApplicationRecord
  belongs_to :passenger 
  belongs_to :driver

  validates :date, presence: true # requires every trip must have a date
  validates :cost, presence: true # requires every trip must have a cost
  
  def self.find_driver 
    @drivers = Driver.all 
    
    @drivers.each do |driver|
      if driver.available == "false"
        return driver
      end
    end
  end

end
