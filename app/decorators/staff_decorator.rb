class StaffDecorator < Draper::Decorator
  delegate_all

  def about
    Redcarpet.new(object.about).to_html
  end
end
