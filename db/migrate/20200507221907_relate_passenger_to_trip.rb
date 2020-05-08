class RelatePassengerToTrip < ActiveRecord::Migration[6.0]
  def change
    add_reference :trips, :passenger, index: true 
    # TODO I don't think we need these, I think index should be on passenger and drivers
  end
end
