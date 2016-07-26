class Api::PurchasesController < ApplicationController
# skip_before_action :authenticate

  def index
      render 'purchases/index.json.erb'
  end

  def create

    super

    render 'purchases/index.json.erb'
  end


  def drop
    PurchaseHandler.new(resource_params.merge(user_id: current_user.id)).reduce

    render 'purchases/index.json.erb'
  end


  def build_resource
    @purchase  = PurchaseHandler.new(resource_params.merge(user_id: current_user.id)).build
  end

  def resource
    @purchase
  end

  def resource_params
    params.require(:purchase).permit(:product_id, :quantity)
  end

  def collection
    @purchases ||= current_user.purchases.unordered.page(params[:page]).per(5)
  end

  # def create
  #  @purchase = current_user.purchases.find_or_create_by(product_id: params["purchase"]["product_id"]).increment(:quantity, params["purchase"]["quantity"].to_i)
  #  @purchase.save!
  #  render "purchases/index.json.erb"
  # end
  #
  # def destroy
  #   @purchase = current_user.purchases.find_by!( product_id: params["purchase"]["product_id"] )
  #   unless @purchase.quantity == params["purchase"]["quantity"].to_i
  #     @purchase.decrement(:quantity, params["purchase"]["quantity"].to_i).save!
  #     # @purchase.save!
  #   else
  #     @purchase.destroy!
  #   end
  #     render "purchases/index.json.erb"
  # end

end
