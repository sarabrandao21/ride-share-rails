require "test_helper"

describe TripsController do
  
  let (:new_passenger) {
    Passenger.create(name: "Kari", phone_num: "111-111-1211")
  }
  let (:new_driver) {
    Driver.create(name: "Kari", vin: "123", available: true)
  }
  let (:new_trip) {
    Trip.new(passenger_id: new_passenger.id, driver_id: new_driver.id, date: Date.today, rating: nil, cost: 3000)
  }
  
  describe "show" do
    it "responds with success when showing an existing valid trip" do
      
      new_trip.save
      get trip_path(new_trip.id)
      must_respond_with :success 
      
    end
    
    it "responds with not_found with an invalid trip id" do
      
      get trip_path(-1)
      must_respond_with :not_found
      
    end
    
  end
  
  describe "create" do
    it "can create trip" do 
      
      
      trip_hash = {
        trip: {
          driver_id: new_driver.id,
          passenger_id: new_passenger.id,
          date: Date.today,
          rating: nil,
          cost: 10
        }
      }
      expect {
        post passenger_trips_path(new_passenger), params: trip_hash
      }.must_change "Trip.count", 1
      
    end 
  end
  
  describe "edit" do
    it "responds with success when getting the edit page for an existing, valid trip" do
      new_trip.save
      
      get edit_trip_path(new_trip.id)
      must_respond_with :success 
      
    end
    
    it "responds with redirect when getting the edit page for a non-existing trip" do
      get edit_trip_path(-2)
      must_respond_with :not_found
      
    end
  end
  
  describe "update" do
    let (:update_trip_hash) {
      {
        trip: {
          driver_id: new_driver.id,
          passenger_id: new_passenger.id,
          date: Date.today,
          rating: nil,
          cost: 10
        }
      }
    }
    it "can update an existing trip with valid information accurately, and redirect" do
      
      new_trip.save
      
      id = new_trip.id 
      
      expect { 
        patch trip_path(id), params: update_trip_hash
      }.wont_change "Trip.count"
      
      must_redirect_to trip_path
      
      trip = Trip.find_by(id: id)
      expect(trip.driver_id).must_equal update_trip_hash[:trip][:driver_id]
      expect(trip.passenger_id).must_equal update_trip_hash[:trip][:passenger_id]
      expect(trip.date).must_equal update_trip_hash[:trip][:date]
      expect(trip.rating).must_equal update_trip_hash[:trip][:rating]
      expect(trip.cost).must_equal update_trip_hash[:trip][:cost]
    end
    
    it "does not update any trip if given an invalid id, and responds with a not_found" do
      id = -1
      expect { 
        patch trip_path(id), params: update_trip_hash
      }.wont_change "Trip.count"
      
      must_respond_with :not_found
      
      
    end
    
  end 
  
  describe "destroy" do
    it "destroys the trip instance in db when trip exists, then redirects" do
      
      new_trip.save
      
      id = new_trip.id 
      
      expect { 
        delete trip_path(id)
      }.must_change "Trip.count", -1
      
      find_trip = Trip.find_by(id: id)
      expect(find_trip).must_be_nil 
      
      must_redirect_to passengers_path
      
      
    end
    
    it "does not change the db when the trip does not exist, then responds with not_found " do
      id = -1
      
      expect { 
        delete trip_path(id)
      }.wont_change "Trip.count"
      
      
      
      must_respond_with :not_found
      
      
    end
  end
end
