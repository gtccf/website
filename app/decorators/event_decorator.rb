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
      if object.end_time == nil || object.duration < 1.hour
        object.next_occurrence.to_formatted_s(:long_ordinal)
      elsif object.duration <  24.hours
        object.next_occurrence.to_formatted_s(:long_ordinal) + " - " + object.next_occurrence.end_time.strftime("%H:%M")
      else
        object.next_occurrence.to_formatted_s(:long_ordinal) + " - " + object.next_occurrence.end_time.to_formatted_s(:long_ordinal)
      end
    else
      "Past"
    end
  end

  def pretty_recurring
    value = object.schedule
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
    if object.recurs?
      event.recurrence_rules = object.schedule.recurrence_rules.to_ical
    end
    event
  end

end
