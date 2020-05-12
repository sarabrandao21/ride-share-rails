require "test_helper"

describe Trip do
  let (:driver) {
    Driver.create(name: "Nora", vin: "ALWSS52P9NEYLVDE8", available: true )
  }
  let (:passenger) {
    Passenger.create(name: "Kari", phone_num: "111-111-1211")
  }
  let (:new_trip) {
    Trip.create(passenger_id: passenger.id, driver_id: driver.id, date: Date.today, rating: nil, cost: 3000)
  }

  it "can be instantiated" do
    # Your code here

    expect(new_trip.valid?).must_equal true 
  end

  it "will have the required fields" do
    # Your code here
    new_trip.save
    trip = Trip.first
    [:date, :rating, :cost].each do |field|

      expect(trip).must_respond_to field 
    end 
  end

  describe "relationships" do
    it "has driver id" do 
      new_driver = Driver.create(name: "Waldo", vin: "ALWSS52P9NEYLVDE9")
      trip_1 = Trip.create(driver_id: new_driver.id, date: Date.today, rating: 5, cost: 1234)
      expect(trip_1.driver_id).must_be_kind_of Integer 
    end 

    it "has passenger id" do 
      new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
      trip_1 = Trip.create(passenger_id: new_passenger.id, date: Date.today, rating: 5, cost: 1234)
      expect(trip_1.passenger_id).must_be_kind_of Integer  

    end 

  end

  describe "validations" do
    # Your tests go here
    it "should have a date" do 
      new_trip.date = nil 

      expect(new_trip.valid?).must_equal false 
      expect(new_trip.errors.messages).must_include :date
      expect(new_trip.errors.messages[:date]).must_equal ["can't be blank"]
    end 

    # it "should have rating" do 
    #   skip
    #   # TODO - Should every trip have a rating? Or can a trip not have a rating?
    #   new_trip.rating = nil 

    #   expect(new_trip.valid?).must_equal false 
    #   expect(new_trip.errors.messages).must_include :rating
    #   expect(new_trip.errors.messages[:rating]).must_equal ["can't be blank"]

    # end 
    it "should have a cost" do 
      new_trip.cost = nil 

      expect(new_trip.valid?).must_equal false 
      expect(new_trip.errors.messages).must_include :cost
      expect(new_trip.errors.messages[:cost]).must_equal ["can't be blank"]
    end
  end 
end

# Tests for methods you create should go here
# describe "custom methods" do
#   skip
#   # TODO
#   # Your tests here
# end

