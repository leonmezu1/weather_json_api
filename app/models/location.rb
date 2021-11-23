# frozen_string_literal: true

# class LocationRules
#  include StoreModel::Model
# include ActiveModel::Validations

# attribute  :lat, :float
#  attribute :lon, :float
#  attribute :city, :string
#  attribute :state, :string

#  validates :lat, presence: true
#  validates :lon, presence: true
#  validates :city, presence: true
#  validates :state, presence: true
#  validate :verify_unique_city, on: :create

#  def verify_unique_city(record)
#    existing_record = Location.where('location @> ?', "{'city': #{record.location.city}")
#    errors.add :location, 'City already exists' if existing_record.length.zero?
#  end
# end

class Location < ApplicationRecord
  validates :city, presence: true, uniqueness: true
  validates :lon, presence: true
  validates :lon, presence: true
  validates :lat, presence: true

  has_many  :temperatures, dependent: :destroy
end
