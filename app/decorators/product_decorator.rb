class ProductDecorator < Draper::Decorator
  delegate_all

  def as_json *args
    {
      id: id,
      name: name,
      price: price,
      description: description
    }
  end

  # Define presentation-specific methods here. Helpers are accessed through
  # `helpers` (aka `h`). You can override attributes, for example:
  #
  #   def created_at
  #     helpers.content_tag :span, class: 'time' do
  #       object.created_at.strftime("%a %m/%d/%y")
  #     end
  #   end

end
