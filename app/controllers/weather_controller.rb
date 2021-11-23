# frozen_string_literal: true

class WeatherController < ApplicationController
  def delete
    queries = [delete_params[:lat], delete_params[:lon], delete_params[:start], delete_params[:end]]
    if queries.compact.empty?
      Temperature.delete_all
      render json: { message: 'All weather entries were deleted successfully' }, status: 200
    elsif queries.any?(&:nil?)
      render json: { message: 'Bad request' }, status: 400
    else
      temperatures = Location
                     .where(
                       lat: delete_params[:lat].to_f,
                       lon: delete_params[:lon].to_f
                     ).take
                     .temperatures
                     .where(date:
                                delete_params[:start].to_date.beginning_of_day..delete_params[:end].to_date.end_of_day)
      if temperatures.count.zero?
        render json: { message: 'Params configuration retrieved no results' }, status: 200
      else
        render json: {
          message: "Deleted #{temperatures.count} temperature entries from provided location"
        }, status: 200
        temperatures.delete_all
      end
    end
  end

  def index
    queries = [index_params[:lat], index_params[:lon], index_params[:date]]
    locations = if queries.compact.empty?
                  Location.joins(:temperatures).distinct
                elsif index_params[:date]
                  Location.joins(:temperatures).where(temperatures: { date: index_params[:date].to_date })
                else
                  Location.where(lat: index_params[:lat], lon: index_params[:lon]).joins(:temperatures).distinct
                end
    if locations.nil? || locations.empty?
      render json: { message: 'Configuration retrieved no results' }, status: 404
    else
      results = []
      locations.each do |location|
        location_json(location, results)
      end
      render json: results.sort_by { |element| element[:id] }.to_json, status: 200
    end
  end

  def create
    location = Location.find_by(city: create_params[:location][:city])
    unless location
      location = Location.new(create_params[:location])
      unless location.save
        render json: {
          message: 'Location data errors prohibited this request to save',
          details: location.errors.full_messages.to_sentence
        }, status: 400
        return
      end
    end

    if Temperature.find_by(weather_id: create_params[:id])
      render json: { message: 'Weather data with the same ID already exists' }, status: 400
    else
      @temperatures = Temperature.new(
        location: location,
        temperatures: create_params[:temperature],
        date: create_params[:date],
        weather_id: create_params[:id]
      )

      if @temperatures.save
        render json: { message: 'New weather data added successfully' }, status: 201
      else
        render json: { message: 'Weather data errors prohibited this request to save' }, status: 400
      end
    end
  end

  private

  def location_json(location, results)
    location.temperatures.each do |registry|
      results << {
        id: registry.weather_id,
        date: registry.date,
        location: {
          lat: location.lat,
          lon: location.lon,
          city: location.city,
          state: location.state
        },
        temperature: registry.temperatures
      }
    end
  end

  def index_params
    params.permit(:lon, :lat, :date)
  end

  def create_params
    params.require(:weather).permit(:id, :date, location: %i[lat lon city state], temperature: [])
  end

  def delete_params
    params.permit(:start, :end, :lat, :lon)
  end
end
