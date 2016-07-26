class Api::GeneratesController < ApplicationController

  def create
    # GiftCertificateHandler.new(params.merge(resource_params)).generate
    # render 'orders/index.json.erb'
    resource.generate
  end


  def resource
   @gift_certificate ||= GiftCertificateHandler.new(params.merge(resource_params))
  end


private
  def resource_params
    params.require(:gift_certificate).permit(:amount, :quantity)
  end
end
