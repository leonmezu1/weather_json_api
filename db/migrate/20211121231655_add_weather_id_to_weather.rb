class AddWeatherIdToWeather < ActiveRecord::Migration[6.1]
  def change
    add_column :temperatures, :weather_id, :string
  end
end
