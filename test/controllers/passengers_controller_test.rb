require "test_helper"

describe PassengersController do
  let (:new_passenger) {
    Passenger.new(name: "Kari", phone_num: "111-111-1211")
  }
  describe "index" do
    it "responds with success when there are many passengers saved" do
      
      new_passenger.save
      get passengers_path
      must_respond_with :success 
      
    end 
    it "responds with success when there are no passengers saved" do
      
      get passengers_path
      must_respond_with :success
      
    end
  end
  
  describe "show" do
    it "responds with success when showing an existing valid passenger" do
      
      new_passenger.save
      get passenger_path(new_passenger.id)
      must_respond_with :success 
      
    end
    
    it "responds with not_found with an invalid passenger id" do
      
      get passenger_path(-1)
      must_respond_with :not_found
      
    end
  end
  
  describe "new" do
    it "responds with success" do
      
      get new_passenger_path
      
      must_respond_with :success
    end
    
  end
  
  describe "create" do
    it "can create a new passenger with valid information accurately, and redirect" do
      
      new_passenger.save
      
      passenger_hash = {
        passenger: {
          name: "new passenger",
          phone_num: "2064376785", # TODO should also test non valid phone number
        },
      }
      expect {
        post passengers_path, params: passenger_hash
      }.must_change "Passenger.count", 1
      
      
      passenger_info = Passenger.find_by(name: passenger_hash[:passenger][:name])
      expect(passenger_info.phone_num).must_equal passenger_hash[:passenger][:phone_num]
      
      must_respond_with :redirect
      must_redirect_to passenger_path(passenger_info.id)
      
    end
    it "does not create a passenger if the form data violates Passenger validations, and responds with a redirect" do
      skip
      # TODO
      # Note: This will not pass until ActiveRecord Validations lesson
      
    end
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid passenger" do
      
      new_passenger.save
      
      get edit_passenger_path(new_passenger.id)
      must_respond_with :success 
      
    end
    
    it "responds with redirect when getting the edit page for a non-existing passenger" do
      get edit_passenger_path(-2)
      must_respond_with :not_found
      
    end
  end
  
  describe "update" do
    let (:update_passenger_hash) {
      {
        passenger: {
          name: "Sara Nilsen",
          phone_num: "206584584"
        }
      }
    }
    it "can update an existing passenger with valid information accurately, and redirect" do
      
      new_passenger.save
      
      id = new_passenger.id 
      
      expect { 
        patch passenger_path(id), params: update_passenger_hash
      }.wont_change "Passenger.count"
      
      must_redirect_to passenger_path
      
      passenger = Passenger.find_by(id: id)
      expect(passenger.name).must_equal update_passenger_hash[:passenger][:name]
      expect(passenger.phone_num).must_equal update_passenger_hash[:passenger][:phone_num]
      
    end
    
    it "does not update any passenger if given an invalid id, and responds with a not_found" do
      id = -1
      expect { 
        patch passenger_path(id), params: update_passenger_hash
      }.wont_change "Passenger.count"
      
      must_respond_with :not_found
      
      
    end
    
    # it "does not create a passenger if the form data violates passenger validations, and responds with a redirect" do
    #   skip
    #   # TODO
    #   # Note: This will not pass until ActiveRecord Validations lesson 
    # end
  end
  
  describe "destroy" do
    it "destroys the passenger instance in db when passenger exists, then redirects" do
      
      new_passenger.save
      
      id = new_passenger.id 
      
      expect { 
        delete passenger_path(id)
      }.must_change "Passenger.count", -1
      
      find_passenger = Passenger.find_by(id: id)
      expect(find_passenger).must_be_nil 
      
      must_redirect_to passengers_path
      
      
    end
    
    it "does not change the db when the passenger does not exist, then responds with not_found " do
      id = -1
      
      expect { 
        delete passenger_path(id)
      }.wont_change "Passenger.count"
      
      
      
      must_respond_with :not_found
      
      
    end
  end
end
