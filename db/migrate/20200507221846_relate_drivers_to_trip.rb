class RelateDriversToTrip < ActiveRecord::Migration[6.0]
  def change
    add_reference :trips, :driver, index: true
    # TODO I don't think we need these, I think index should be on passenger and drivers
  end
end
