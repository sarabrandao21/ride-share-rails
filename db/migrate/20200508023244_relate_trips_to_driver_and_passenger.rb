class RelateTripsToDriverAndPassenger < ActiveRecord::Migration[6.0]
  def change
    add_reference :trips, :passenger, index: true #plural or singular?
    add_reference :trips, :driver, index: true 
  end
end
