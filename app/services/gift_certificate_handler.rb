class GiftCertificateHandler
  include ActiveModel::Model

  attr_reader :quantity, :amount

  validates :quantity, :amount,  numericality: {greater_than: 0}

  def initialize params = {}

    params = params.symbolize_keys

    @quantity = params[:quantity].to_i

    @amount   = params[:amount]

  end

  def generate
    raise ActiveModel::StrictValidationFailed unless valid?
    quantity.times do
      gift_certificate = GiftCertificate.create amount: amount
      gift_certificate.save!

    end
  end

  def decorate
   @collection ||= GiftCertificate.unused
 end


end
