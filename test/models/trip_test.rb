require "test_helper"

xdescribe Trip do
  let (:new_trip) {
    Trip.new(date: Date.today, rating: 5, cost: 5.0)
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
    # Your tests go here
    it "can have an instance of passenger" do 
      #
      new_trip.save 
      # new_passenger = Passenger.create(name: "Kari", phone_num: "111-111-1211")
      # new_driver = Driver.create(name: "Kari", vin: "123", available: true)
      new_trip.
    end 
    
    it "can have an instance of driver"
    
  end
  
  describe "validations" do
    # Your tests go here
  end
  
  # Tests for methods you create should go here
  describe "custom methods" do
    # Your tests here
  end
end
