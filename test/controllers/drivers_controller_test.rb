require "test_helper"

describe DriversController do
  # Note: If any of these tests have names that conflict with either the requirements or your team's decisions, feel empowered to change the test names. For example, if a given test name says "responds with 404" but your team's decision is to respond with redirect, please change the test name.
  let (:new_driver) {
    Driver.new(name: "Kari", vin: "123", available: true)
  }
  describe "index" do
    it "responds with success when there are many drivers saved" do
      new_driver.save
      get drivers_path
      must_respond_with :success 
      
    end
    
    it "responds with success when there are no drivers saved" do
      get drivers_path
      must_respond_with :success
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid driver" do
      new_driver.save
      get driver_path(new_driver.id)
      must_respond_with :success 
      
    end
    
    it "responds with not_found with an invalid driver id" do
      get driver_path(-1)
      must_respond_with :not_found
    end
  end
  
  describe "new" do
    it "responds with success" do
      get new_driver_path
      must_respond_with :success
    end
  end
  
  describe "create" do
    it "can create a new driver with valid information accurately, and redirect" do
      new_driver.save
      driver_hash = {
        driver: {
          name: "new driver",
          vin: "new driver vin",
          available: true,
        },
      }
      expect {
        post drivers_path, params: driver_hash
      }.must_change "Driver.count", 1
      
      driver_info = Driver.find_by(name: driver_hash[:driver][:name])
      expect(driver_info.vin).must_equal driver_hash[:driver][:vin]
      expect(driver_info.available).must_equal driver_hash[:driver][:available]
      
      must_respond_with :redirect
      must_redirect_to driver_path(driver_info.id)
      
    end
    
    it "does not create a driver if the form data violates Driver validations" do
      invalid_driver = Driver.new(name: "", vin: "", available: true)
      expect(invalid_driver.valid?).must_equal false 
      expect(invalid_driver.errors.messages).must_include :name
      expect(invalid_driver.errors.messages[:name]).must_equal ["can't be blank"]
      expect(invalid_driver.errors.messages).must_include :vin
      expect(invalid_driver.errors.messages[:vin]).must_equal ["can't be blank"] 
      
      
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid driver" do
      
      new_driver.save 
      get edit_driver_path(new_driver.id)
      must_respond_with :success 
      
    end
    
    it "responds with redirect when getting the edit page for a non-existing driver" do
      get edit_driver_path(-2)
      must_respond_with :not_found
    end
  end
  
  describe "update" do
    let (:update_driver_hash) {
      {
        driver: {
          name: "Sara Nilsen",
          vin: "aaaaaaaa",
          available: true 
        }
      }
    }
    it "can update an existing driver with valid information accurately, and redirect" do
      new_driver.save
      id = new_driver.id 
      expect { 
        patch driver_path(id), params: update_driver_hash
      }.wont_change "Driver.count"
      must_redirect_to driver_path
      
      driver = Driver.find_by(id: id)
      expect(driver.name).must_equal update_driver_hash[:driver][:name]
      expect(driver.vin).must_equal update_driver_hash[:driver][:vin]
      expect(driver.available).must_equal update_driver_hash[:driver][:available]
    end
    
    it "does not update any driver if given an invalid id, and responds with a not_found" do
      id = -1
      expect { 
        patch driver_path(id), params: update_driver_hash
      }.wont_change "Driver.count"
      
      must_respond_with :not_found
    end
    
    it "does not update a driver if the form data violates Driver validations, and responds with a redirect" do
      
    end
  end
  
  describe "destroy" do 
    it "destroys the driver instance in db when driver exists, then redirects" do
      
      new_driver.save
      
      id = new_driver.id 
      
      expect { 
        delete driver_path(id)
      }.must_change "Driver.count", -1
      
      find_driver = Driver.find_by(id: id)
      expect(find_driver).must_be_nil 
      
      must_redirect_to drivers_path
      
    end
    
    it "does not change the db when the driver does not exist, then responds with not_found " do
      id = -1
      expect { 
        delete driver_path(id)
      }.wont_change "Driver.count"
      must_respond_with :not_found
    end
  end
end
