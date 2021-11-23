# frozen_string_literal: true

class AlterWeatherTable < ActiveRecord::Migration[6.1]
  def change
    add_column :temperatures, :date, :datetime
    add_reference :temperatures, :location, index: true
    add_foreign_key :temperatures, :locations
  end
end
