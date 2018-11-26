class Preference < ApplicationRecord
  belongs_to :user
  belongs_to :city
  validates :weekday, :duration, :city, presence: true
end
