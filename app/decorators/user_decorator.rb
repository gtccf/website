class UserDecorator < Draper::Decorator
  delegate_all

  def name
    [object.first_name, object.last_name].join(' ')
  end
end
