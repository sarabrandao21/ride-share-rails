class CreatePassengers < ActiveRecord::Migration[6.0]
  def change
    create_table :passengers do |t|
      t.string :name
      t.string :phone_number

      # TODO do we need timestamps here?
      t.timestamps
    end
  end
end
