class DevotionDecorator < Draper::Decorator
  delegate_all
  def pretty_body
    return "" unless source.body
    require 'redcarpet'
    renderer = Redcarpet::Render::HTML.new
    redcarpet = Redcarpet::Markdown.new(renderer)
    out = redcarpet.render source.body
    out.html_safe
  end
end
