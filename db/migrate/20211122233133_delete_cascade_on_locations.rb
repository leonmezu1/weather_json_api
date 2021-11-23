# frozen_string_literal: true

class DeleteCascadeOnLocations < ActiveRecord::Migration[6.1]
  def change
    remove_foreign_key :temperatures, :locations
    add_foreign_key :temperatures, :locations, on_delete: :cascade
  end
end
