class Payment
  include ActiveModel::Validations

  attr_reader :pay_with_bonuses, :order, :current_user, :token, :gift_certificate

  def initialize params = {}
    params = params.symbolize_keys

    @pay_with_bonuses = ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include?(params[:pay_with_bonuses])

    @order = Order.find_by!(id: params[:order_id], status: 0)

    @token = params[:token]

    @current_user = params[:current_user]
  end


  validate do

    if gift_certificate
      errors.add :token, 'used gift_certificate' unless gift_certificate.order_id == nil
    end

  end


  def pay
    raise ActiveModel::StrictValidationFailed unless valid?

    @amount_to_pay = order.amount

    if gift_certificate

      if gift_certificate.amount >= @amount_to_pay
        order.update_attribute(:status, 1)
        @amount_to_pay = 0

      else
        @amount_to_pay -=  gift_certificate.amount
      end

        gift_certificate.update_attribute(:order_id, order.id)
    end


    if pay_with_bonuses

      used_bonuses = 0

      if @amount_to_pay*0.2 >= current_user.bonus_points
        used_bonuses = current_user.bonus_points

      else
        used_bonuses = @amount_to_pay*0.2
      end

      current_user.decrement(:bonus_points, used_bonuses)
      @amount_to_pay -= used_bonuses
    end

      if  current_user.balance >= @amount_to_pay
        current_user.decrement(:balance, @amount_to_pay)
        current_user.increment(:bonus_points, @amount_to_pay*0.04)
        @order.update_attribute(:status, 0)
        # gift_certificate.update_attribute(:order_id, order.id)
        current_user.save!

      else
        errors.add(:amount, 'insuficient funds')
        raise ActiveModel::StrictValidationFailed
      end




  def gift_certificate
    if token.present?
      @gift_certificate ||= GiftCertificate.find_by!(token: token)
    end
  end

  def decorate
    order
  end
end

end
