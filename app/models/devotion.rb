class Devotion < ActiveRecord::Base
  def self.latest
    self.where(['release_date > ?', Date.today]).order(:release_date)
  end

  def self.today
    self.where(release_date: Date.today).first
  end
end
