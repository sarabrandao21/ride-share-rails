class Trip < ApplicationRecord
  belongs_to :passenger 
  belongs_to :driver

  validates :date, presence: true # requires every trip must have a date
  validates :cost, presence: true # requires every trip must have a cost
  
  def self.find_driver 
    driver = Driver.all.select {|driver| driver.available == true }.first
    driver.available = false
    driver.save
    return driver
    
    # @drivers.each do |driver|
    #   if driver.available == true
    #     chosen_driver = driver
    #     driver.available = false
    #     driver.save
    #     return driver.first
    #   end
    # end
  end

end
