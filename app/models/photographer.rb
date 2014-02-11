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
  has_attached_file :avatar, {
    :styles => { :thumb => "100x128>" },
    :default_url => "/assets/britstock-logo1.png"
  }
  validates_attachment_content_type :avatar, :content_type => /image/
#  validates :avatar, :attachment_presence => true,
#    :content_type => { :content_type => [ "image/jpeg", "image/gif", "image/png" ] }
#  validates_with AttachmentPresenceValidator, :attributes => :avatar
  def address
    city+", "+country
  end
  def specificAddress
    city+"("+locationspecifier+"), "+country
  end
end
