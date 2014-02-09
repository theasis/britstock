class Photographer < ActiveRecord::Base
  geocoded_by :address
  after_validation :geocode
  has_many :lightboxes
  validates :name, :description, :email, :istock_name, :istock_userid, :city, :country, :locationspecifier, presence: true
  validates :email, :istock_name, :istock_userid, uniqueness: true
  validates :email, format: {
    with: %r{\w\S*@\S*\w\S*\.\S},
    message: 'must be a valid email address.'
  }
  def address
    city+", "+country
  end
  def specificAddress
    city+"("+locationspecifier+"), "+country
  end
end
