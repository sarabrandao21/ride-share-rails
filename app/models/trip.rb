class Trip < ApplicationRecord
  belongs_to :passenger 
  belongs_to :driver

  def self.find_driver 
    @drivers = Driver.all 
    
    @drivers.each do |driver|
      if driver.status == "available"
        return driver
      end
    end
  end

end
