class ChangeDataTypeForFloatOnTemperatures < ActiveRecord::Migration[6.1]
  def change
    change_column :temperatures, :temperatures, :float, array: true, null: false, default: []
  end
end
