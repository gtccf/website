class Event < ActiveRecord::Base
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags

  scope :enabled, -> { where(enabled: true) }
  scope :future, -> { enabled.where("time >=  ? OR (recurring IS NOT NULL AND recurring = 'null')", Time.now) }
  scope :onetime, -> { where("recurring IS NULL OR recurring = 'null'") }
  scope :recurring, -> { where("recurring IS NOT NULL AND recurring != 'null'")}
  scope :next, ->(i) { future.order(:time).limit(i) }
  scope :tagged, ->(name) { joins(:tags).where('tags.name = ?', name) }

  def recurs?
    recurring != nil && recurring != "null"
  end

  def schedule
    return nil unless recurs?
    schedule = IceCube::Schedule.new(time, end_time: end_time)
    schedule.add_recurrence_rule IceCube::Rule.from_hash(JSON.parse self.recurring)
    schedule
  end

  def next_occurrence
    if recurs? && schedule.occurs_between?(Time.now, Time.now + 99.years)
      schedule.next_occurrence
    elsif time >= Time.now
      IceCube::Occurrence.new(time, end_time)
    else
      nil
    end
  end

  def duration
    return 1.hour unless end_time
    end_time - time
  end
end
