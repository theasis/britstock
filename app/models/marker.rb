class Marker < ActiveRecord::Base
  geocoded_by :position
  after_validation :geocode
  validates :label, :position, presence: true
end
