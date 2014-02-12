class Cache < ActiveRecord::Base
  belongs_to :lightbox
  serialize :filelist
end
