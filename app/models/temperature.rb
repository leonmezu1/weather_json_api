# frozen_string_literal: true

class Temperature < ApplicationRecord
  validates :temperatures, presence: true
end
