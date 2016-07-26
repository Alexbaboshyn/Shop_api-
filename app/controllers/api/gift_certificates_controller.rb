class Api::GiftCertificatesController < ApplicationController


  def build_resource
    @gift_certificate = GiftCertificate.new (resource_params)
  end



  # def generate
  #   GiftCertificateHandler.new(params.merge(resource_params)).generate
  #   render 'orders/index.json.erb'
  # end


  private

  def resource
    @gift_certificate
    #  =  GiftCertificate.find params[:id]
  end

  def collection
    @collection ||= GiftCertificate.unused
    # .page(params[:page]).per(5)
  end

  def resource_params
    params.require(:gift_certificate).permit(:amount)
  end


end
