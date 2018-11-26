class City < ApplicationRecord
  has_many :deals
  has_many :preferences
end
