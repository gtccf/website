class StaffDecorator < Draper::Decorator
  delegate_all

  def pretty_about
    return "" unless source.about
    require 'redcarpet'
    renderer = Redcarpet::Render::HTML.new
    redcarpet = Redcarpet::Markdown.new(renderer)
    out = redcarpet.render source.about
    out.html_safe
  end
end
