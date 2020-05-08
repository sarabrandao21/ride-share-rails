class CreateTrips < ActiveRecord::Migration[6.0]
  def change
    create_table :trips do |t|
      t.datetime :date
      t.integer :rating
      t.float :cost

      # TODO timestamps should have a trip completed?
      t.timestamps
    end
  end
end
