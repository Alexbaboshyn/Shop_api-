class UserDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
      name: name,
      email: email,
      balance: balance,
      bonus_points: bonus_points
    }
  end
end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end
