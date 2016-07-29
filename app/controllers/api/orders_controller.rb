class Api::OrdersController < ApplicationController

  def index
    render 'orders/index.json.erb'
  end
  # def build_resource
  #   @order = @current_user.orders.new
  # end

  # def resource_params
  #   params.require(:order).permit(:user_id, :amount, :status)
  # end

  def resource
    @order
    # = @current_user.orders.find params[:id]
  end


  def create

    @order = @current_user.orders.new
    @order.save!
    render 'orders/index.json.erb'
  end

  def collection
    @orders ||= @current_user.orders.page(params[:page]).per(50)
  end


end
