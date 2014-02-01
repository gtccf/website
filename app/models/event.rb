class Event < ActiveRecord::Base
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags

  scope :enabled, -> { where(enabled: true) }
  scope :future, -> { enabled.where("time >=  ? OR recurring IS NOT NULL", Time.now) }
  scope :onetime, -> { where("recurring IS NULL") }
  scope :recurring, -> { where("recurring IS NOT NULL")}
  scope :next, ->(i) { future.order(:time).limit(i) }
  scope :tagged, ->(name) { joins(:tags).where('tags.name = ?', name) }

  def recurring
    value = read_attribute(:recurring)
    value = IceCube::Schedule.from_yaml value if value
    value
  end

  def recurring= schedule
    write_attribute(:recurring, schedule.to_yaml)
  end

  def recurring_rules= arr
    schedule = IceCube::Schedule.new(time)
    arr.each do |r|
      schedule.add_recurrence_rule r
    end
    self.recurring = schedule
  end

  def next_occurrence
    if recurring
      recurring.next_occurrence
    elsif time >= Time.now
      time
    else
      nil
    end
  end
end
