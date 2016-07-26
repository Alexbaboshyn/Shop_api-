class Api::PaymentsController < ApplicationController


  def create
    pay_with_bonuses = ActiveRecord::ConnectionAdapters::Column::TRUE_VALUES.include?(params[:pay_with_bonuses])

    @order = current_user.orders.find params[:order_id]
    # @order = Order.find_by!(id: params[:order_id], status: "Pending")
#     #

#
#       else order.update_attribute(:status, 0)

# if params[:pay_with_bonuses] =='true'

    if pay_with_bonuses

      used_bonuses = 0
      amount_left_to_pay = 0

      if @order.amount*0.2 >= current_user.bonus_points
        used_bonuses = current_user.bonus_points
      else
        used_bonuses = @order.amount*0.2
      end

      amount_left_to_pay = @order.amount - used_bonuses

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

    end

  end

def resource
  @order = @current_user.orders.find params[:order_id]
end


end
