# frozen_string_literal: true

class CreateTemperatures < ActiveRecord::Migration[6.1]
  def change
    create_table :temperatures do |t|
      t.integer :temperatures, array: true, null: false, default: []
      t.timestamps
    end
  end
end
