class Event < ActiveRecord::Base
  has_and_belongs_to_many :tags
  accepts_nested_attributes_for :tags
  before_save :sync_schedule

  scope :enabled, -> { where(enabled: true) }
  scope :future, -> { enabled.where("time >=  ? OR recurring IS NOT NULL", Time.now) }
  scope :onetime, -> { where("recurring IS NULL") }
  scope :recurring, -> { where("recurring IS NOT NULL")}
  scope :next, ->(i) { future.order(:time).limit(i) }
  scope :tagged, ->(name) { joins(:tags).where('tags.name = ?', name) }

  def sync_schedule
    if recurs?
      schedule = self.recurring
      schedule.start_time = time
      schedule.end_time = end_time
      self.recurring = schedule
    end
  end

  def recurs?
    read_attribute(:recurring) != nil
  end

  def recurring
    value = read_attribute(:recurring)
    value = IceCube::Schedule.from_yaml value if value
    value
  end

  def recurring= schedule
    write_attribute(:recurring, schedule.to_yaml)
  end

  def next_occurrence
    if recurring
      recurring.next_occurrence
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
