# frozen_string_literal: true

class CreateLocations < ActiveRecord::Migration[6.1]
  def change
    create_table :locations do |t|
      # t.jsonb :location, null: false, default: {
      #  lat: nil,
      #  lon: nil,
      #  city: nil,
      #  state: nil
      # }
      t.float :lat, null: false
      t.float :lon, null: false
      t.string :city, null: false
      t.string :state, null: false
      t.timestamps
    end
  end
end
