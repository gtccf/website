class Staff < ActiveRecord::Base
  validate :name, :presence
  validate :email, uniqueness: true
  mount_uploader :portrait, PortraitUploader

  default_scope { order(:weight) }
end
