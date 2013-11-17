class Event < ActiveRecord::Base
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags

  scope :future, -> { where('time >= ?', Time.now) }
  scope :next, ->(i) { future.order(:time).limit(i) }
  scope :tagged, ->(name) { joins(:tags).where('tags.name = ?', name) }
end
