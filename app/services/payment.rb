class Payment
  include ActiveModel::Validations

  attr_reader :pay_with_bonuses, :order, :current_user, :token, :gift_certificate

  def initialize params = {}
    params = params.symbolize_keys

    @pay_with_bonuses = ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include?(params[:pay_with_bonuses])
    @order = Order.find_by!(id: params[:order_id], status: 1)
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
      if gift_certificate.amount > @amount_to_pay
        gift_certificate.update_attribute(:order_id, order.id)
        order.update_attribute(:status, 1)
        @amount_to_pay = 0
      else
        @amount_to_pay -=  gift_certificate.amount
      end
    end

    if pay_with_bonuses
      used_bonuses = 0

      if order.amount*0.2 >= current_user.bonus_points
        used_bonuses = current_user.bonus_points
      else
        used_bonuses = order.amount*0.2
      end

      @amount_to_pay = order.amount - used_bonuses

      current_user.decrement(:balance, amount_left_to_pay)
      current_user.decrement(:bonus_points, used_bonuses)

      if current_user.balance < 0
        render :exception
      else
        current_user.increment(:bonus_points, amount_left_to_pay*0.04)
        current_user.save!
        @order.update_attribute(:status, 1)
      end

    else
      current_user.decrement(:balance, @order.amount)
      if current_user.balance < 0
        render :exception
      else
        current_user.increment(:bonus_points, @order.amount*0.04)
        current_user.save!
        @order.update_attribute(:status, 1)
      end




      #  @order.update_attribute(:status, 0)

     else
       @order.update_attribute(:status, 1)
     end











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



#   validate do
#     if gift_certificate
#       errors.add :order_id, 'is used' unless gift_certificate.order_id.blank?
#     else
#       errors.add :token, 'not found'
#     end
#     errors.add :amount, 'insuficient funds' unless current_user.balance >= 0
#   end
#
#
#   def payment_realization
#
#
#
#     if token.present?
#       use_gift_certificate
#     if pay_with_bonuses == true
#
#
#     end
#
#
#
#
#
#
#
#
#
#
#       def use_gift_certificate
#         if gift_certificate.amount > @amount_to_pay
#           gift_certificate.update_attribute(:order_id, order.id)
#           order.update_attribute(:status, 1)
#         else
#           @amount_to_pay -=  gift_certificate.amount
#         end
#       end
#
#
#
#
#
#   def bonuses
#    order.update_attribute(:status, 1)
#   end
#
#
#   def real_money
#
#   end
#
#   private
#   def gift_certificate
#     @gift_certificate ||= GiftCetrificate.find_by token: token
#   end
#
#
# end
