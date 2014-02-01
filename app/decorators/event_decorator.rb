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
    event.start = object.time.strftime("%Y%m%dT%H%M%S")
    if object.end_time
      event.end = object.end_time.strftime("%Y%m%dT%H%M%S")
    end
    event.summary = object.title
    event.description = object.description
    event.location = '767 Techwood Dr, Atlanta, GA'
    event.klass = "PUBLIC"
    event.created = object.created_at
    event.last_modified = object.updated_at
    event.uid = event.url = "http://gtccf.org/events/#{object.id}"
    if object.recurring
      event.add_recurrence_rule object.recurring.to_ical
    end
    event
  end

end
