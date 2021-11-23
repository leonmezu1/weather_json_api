# frozen_string_literal: true

class Temperature < ApplicationRecord
  validates :temperatures, presence: true

  belongs_to :location
end
