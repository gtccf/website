class EventDecorator < Draper::Decorator
  delegate_all

  def pretty_description
    return "" unless object.description
    require 'redcarpet'
    renderer = Redcarpet::Render::HTML.new
    redcarpet = Redcarpet::Markdown.new(renderer)
    out = redcarpet.render object.description
    out.html_safe
  end

  def pretty_time
    if object.next_occurrence
      object.next_occurrence.to_formatted_s(:long_ordinal)
    else
      "Past"
    end
  end

  def pretty_end_time
    return unless object.end_time
    next_time = object.next_occurrence
    delta = object.end_time - object.time
    next_end_time = next_time + delta
    if next_end_time.day == next_time.day and next_end_time.year == next_time.year
      next_end_time.strftime("%H:%M")
    else
      next_end_time.to_formatted_s(:long_ordinal)
    end
  end


  def pretty_recurring
    value = object.recurring
    value = "never" unless value
    value
  end

  def tag_list
    tag_names = object.tags.pluck(:name)
    tag_names.join ','
  end

  def to_ics
    event = Icalendar::Event.new
    event.start = object.time.to_datetime
    if object.end_time
      event.end = object.end_time.to_datetime
    end
    event.summary = object.title
    event.description = object.description
    event.location = '767 Techwood Dr, Atlanta, GA'
    event.klass = "PUBLIC"
    event.created = object.created_at.to_datetime
    event.last_modified = object.updated_at.to_datetime
    event.uid = event.url = "http://gtccf.org/events/#{object.id}"
    if object.recurring
      event.recurrence_rules = object.recurring.recurrence_rules.to_ical
    end
    event
  end

end
