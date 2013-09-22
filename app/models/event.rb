class Event < ActiveRecord::Base
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags

  def self.tagged_with(name)
    EventDecorator.decorate_collection(Tag.find_by_name!(name).events)
  end

  def self.next(i)
    EventDecorator.decorate_collection(Event.order(:time).limit(i))
  end
end
