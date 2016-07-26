class Api::PaymentsController < ApplicationController

  def create
    resource.pay
  end


  private

  def collection
    @collection ||= current_user.orders.page(params[:page]).per(5)
  end

  def resource
    @payment ||= Payment.new(resource_params.merge(current_user: current_user))
  end

  def resource_params
    params.permit(:order_id, :pay_with_bonuses, :token)
  end

end
