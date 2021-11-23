# frozen_string_literal: true

class ChangeDataTypeForNumberOnTemperatures < ActiveRecord::Migration[6.1]
  def change
    change_column :temperatures, :weather_id, :integer, using: 'weather_id::integer'
  end
end
