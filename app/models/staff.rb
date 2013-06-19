class Staff < ActiveRecord::Base
  validate :name, :presence
  validate :email, uniqueness: true
end
