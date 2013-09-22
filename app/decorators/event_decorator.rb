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
    object.time.to_formatted_s(:long_ordinal)
  end

  def tag_list
    tag_names = object.tags.pluck(:name)
    tag_names.join ','
  end
end
